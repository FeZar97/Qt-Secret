#
# Copyright (C) 2018-2019 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#

unix:exec = $$PWD/tests/build/release/Qt-SecretTest,$$PWD/src/Qt-AES/build/release/QAESEncryption
win32:exec = $$PWD/tests/build/release/Qt-SecretTest.exe,$$PWD/src/Qt-AES/build/release/QAESEncryption.exe


contains(QMAKE_HOST.os, Linux):{
    DEPLOYER=cqtdeployer
} else {
    DEPLOYER=%cqtdeployer%
}


deployTest.commands = $$DEPLOYER -bin $$exec clear -qmake $$QMAKE_QMAKE -targetDir $$PWD/deployTests -libDir $$PWD -recursiveDepth 5

unix:testRSA.commands = $$PWD/deployTests/Qt-SecretTest.sh
win32:testRSA.commands = $$PWD/deployTests/Qt-SecretTest.exe

unix:testAES.commands = $$PWD/deployTests/QAESEncryption.sh
win32:testAES.commands = $$PWD/deployTests/QAESEncryption.exe

contains(QMAKE_HOST.os, Linux):{
    DEPLOYER=cqtdeployer
    win32:testAES.commands = wine $$PWD/deployTests/QAESEncryption.exe
    win32:testRSA.commands = wine $$PWD/deployTests/Qt-SecretTest.exe

} else {
    DEPLOYER=%cqtdeployer%
}

test.depends += deployTest
test.depends += testRSA
test.depends += testAES

QMAKE_EXTRA_TARGETS += \
    deployTest \
    testAES \
    testRSA \
    test
