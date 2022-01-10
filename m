Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDDD488F30
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiAJER1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiAJER0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:17:26 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7AC061748;
        Sun,  9 Jan 2022 20:17:25 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id j124so17522573oih.12;
        Sun, 09 Jan 2022 20:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eSdA6bINjLjaKOrkpfhrlhMSEKuXou97Qn0nIJSQFA=;
        b=hBlVhryIX6WEygLKBGvgrQ29EpSI0jmQ7o5qKRTlTSLjSzMwI2O585duyxvaSnqXHg
         DL8YPWj2XoJLhAcq/xBK6FVAqCMfiA/djvMlZ8yn16D0RZjD4COrlEvluCbMaViQ5kuA
         W6Uy+j+n5mM8XahGkvKr3dDa0jDHZA8TtF+iN2iCoHnFxTD4zY4o2lL+oh9o/C4hbttR
         CBFE0z08Ketq3w/M7qDpoveLSuc0pKlDOasApwkODb9adsxis1zqCTOAqCHpC+WQQSKO
         q7LAoGBj97WifaRHAtqA8X0ay0klej+NiD37CTsg1fz+Q3d5MTAmpb7EFU0r3dDw3aGm
         /0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2eSdA6bINjLjaKOrkpfhrlhMSEKuXou97Qn0nIJSQFA=;
        b=m368N5I8dytPhcdbOu/r1SiCqhBHVT6aslrEVHQ1YL6f4RJEbI066bcf5qdHwfrQXT
         O476B9Mz9VoQ3NaaX0hoK8IUP3Ayn28HqYqjyf+Syte75/GgjxNBitIXjXaU5FbtJSz/
         ppL6CV7VBMPrybGyEAoEimfdMToFlFWFdA13gSu6vDFcN3kYBXMjaErBz8H/c51sZVCX
         LaZA8pL0zndCecRRqQPpG7/Uxi2ZVYD0mL2Sos5gBNx/C56BFhg+3PVXrqBkLpMSZcvy
         ultYEutU9auPnCZiHv78qx0/DnDjCoQ0m4He+OzO04WEpI3eRv2lol90trPOs0/f/knM
         0MYQ==
X-Gm-Message-State: AOAM530NfbSN9NNxIjhW6dsqNb2iAxoWjRbYrhYBViJ4MO2eo1bg2ICm
        zR3lCuQkVUPJUsSwABt4tuVAYD1kU0w=
X-Google-Smtp-Source: ABdhPJw7Bhs0R5hiZv/i1mKXdPOKzCc219z1LMuJl0aTE2Ytbt0kAVjl0u8Y06zGg+D8p9grC1aagw==
X-Received: by 2002:aca:ebcb:: with SMTP id j194mr16942462oih.67.1641788244833;
        Sun, 09 Jan 2022 20:17:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o145sm1125916ooo.1.2022.01.09.20.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 20:17:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.17
Date:   Sun,  9 Jan 2022 20:17:22 -0800
Message-Id: <20220110041722.2095990-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.17 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17

You may see a trivial conflict in MAINTAINERSS (keep all changes)
when pulling this update. Also, if commit "proc: remove PDE_DATA()
completely" was already pulled, you'll need to update the dell-smm
driver to change PDE_DATA to pde_data.

Thanks,
Guenter
------

The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.17

for you to fetch changes up to 00f5117c5f785b95b13663e52dcdcf684a47d4e3:

  hwmon: (nzxt-smart2) make array detect_fans_report static const (2022-01-09 17:10:58 -0800)

----------------------------------------------------------------
hwmon updates for v5.17

New drivers:
- PMBus driver for MPS Multi-phase mp5023
- PMBus driver for Delta AHE-50DC fan control module
- Driver for NZXT RGB&Fan Controller/Smart Device v2
- Driver for Texas Instruments INA238
- Driver to support X370 Asus WMI
- Driver to support B550 Asus WMI

Other notable changes:
- Cleanup of ntc_thermistor driver, and added support for Samsung 1404-001221 NTC
- Improve detection of LM84, MAX1617, and MAX1617A in adm1021 driver
- Clean up tmp401 driver, and convert to with_info API
- Add support for regulators and IR38060, IR38164 IR38263 to ir38064 PMBus driver
- Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh to k10temp driver
- Add support for F81966 to f71882fg driver
- Add support for ONSEMI N34TS04 to jc42 driver
- Clean up and simplify dell-smm driver
- Add support for ROG STRIX B550-A/X570-I GAMING to nct6775 driver

Various other minor improvements and fixes.

----------------------------------------------------------------
Aleksandr Mezin (2):
      hwmon: add driver for NZXT RGB&Fan Controller/Smart Device v2.
      hwmon: (nzxt-smart2) Fix "unused function" warning

Armin Wolf (4):
      hwmon: (raspberrypi) Exit immediately in case of error in init
      hwmon: (dell-smm) Simplify ioctl handler
      hwmon: (dell-smm) Unify i8k_ioctl() and i8k_ioctl_unlocked()
      hwmon: (dell-smm) Pack the whole smm_regs struct

Arseny Demidov (1):
      hwmon: (mr75203) fix wrong power-up delay value

Arthur Heymans (1):
      hwmon/pmbus: (ir38064) Add of_match_table

Babu Moger (3):
      hwmon: (k10temp) Remove unused definitions
      hwmon: (k10temp) Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh
      hwmon: (k10temp) Support up to 12 CCDs on AMD Family of processors

Colin Ian King (3):
      hwmon: (adm1031) Remove redundant assignment to variable range
      hwmon/pmbus: (ir38064) Fix spelling mistake "comaptible" -> "compatible"
      hwmon: (nzxt-smart2) make array detect_fans_report static const

Dan Carpenter (3):
      hwmon: (asus_wmi_ec_sensors) fix array overflow
      hwmon: (asus_wmi_sensors) fix an array overflow
      hwmon: (nct6775) delete some extension lines

David Mosberger-Tang (1):
      hwmon: (sht4x) Add device tree match table

Denis Pauk (4):
      hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
      hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
      hwmon: (nct6775) add ROG STRIX B550-A/X570-I GAMING
      hwmon: (nct6775) Additional check for ChipID before ASUS WMI usage

Guenter Roeck (6):
      hwmon: (tmp401) Simplify temperature register arrays
      hwmon: (tmp401) Convert to _info API
      hwmon: (tmp401) Use regmap
      hwmon: (tmp401) Hide register write address differences in regmap code
      hwmon: (adm1021) Improve detection of LM84, MAX1617, and MAX1617A
      hwmon: (jc42) Add support for ONSEMI N34TS04

Howard.Chiu@quantatw.com (1):
      hwmon: (pmbus) Add support for MPS Multi-phase mp5023

Linus Walleij (9):
      hwmon: (ntc_thermistor) Merge platform data into driver
      hwmon: (ntc_thermistor) Drop get_ohm()
      hwmon: (ntc_thermistor) Drop read_uv() depend on OF and IIO
      hwmon: (ntc_thermistor) Merge platform data
      hwmon: (ntc_thermistor) Move and refactor DT parsing
      hwmon: (ntc_thermistor) Switch to generic firmware props
      hwmon: (ntc_thermistor) Move DT matches to the driver block
      hwmon: (ntc_thermistor) Drop OF dependency
      hwmon: (ntc_thermistor) Add Samsung 1404-001221 NTC

Lukas Bulwahn (1):
      hwmon: prefix kernel-doc comments for structs with struct

Menghui Wu (1):
      hwmon: (f71882fg) Add F81966 support

Nathan Rossi (3):
      dt-bindings: hwmon: ti,ina2xx: Document ti,ina238 compatible string
      dt-bindings: hwmon: ti,ina2xx: Add ti,shunt-gain property
      hwmon: Driver for Texas Instruments INA238

Patrick Rudolph (2):
      hwmon/pmbus: (ir38064) Add support for IR38060, IR38164 IR38263
      hwmon/pmbus: (ir38064) Expose a regulator

Peiwei Hu (1):
      hwmon: (xgene-hwmon) Add free before exiting xgene_hwmon_probe

Yazen Ghannam (1):
      x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs

Zev Weiss (2):
      hwmon: (pmbus) Add Delta AHE-50DC fan control module driver
      dt-bindings: add Delta AHE-50DC fan control module

 .../devicetree/bindings/hwmon/ntc-thermistor.yaml  |   1 +
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |  22 +
 .../devicetree/bindings/trivial-devices.yaml       |   8 +
 Documentation/hwmon/asus_wmi_ec_sensors.rst        |  38 +
 Documentation/hwmon/asus_wmi_sensors.rst           |  78 ++
 Documentation/hwmon/ina238.rst                     |  56 ++
 Documentation/hwmon/index.rst                      |   5 +
 Documentation/hwmon/ir38064.rst                    |  28 +-
 Documentation/hwmon/mp5023.rst                     |  84 ++
 Documentation/hwmon/nzxt-smart2.rst                |  62 ++
 MAINTAINERS                                        |  27 +
 arch/x86/kernel/amd_nb.c                           |   5 +
 drivers/hwmon/Kconfig                              |  51 +-
 drivers/hwmon/Makefile                             |   4 +
 drivers/hwmon/adm1021.c                            |  23 +-
 drivers/hwmon/adm1031.c                            |   3 +-
 drivers/hwmon/asus_wmi_ec_sensors.c                | 621 +++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c                   | 664 ++++++++++++++++
 drivers/hwmon/dell-smm-hwmon.c                     |  70 +-
 drivers/hwmon/f71882fg.c                           |   2 +
 drivers/hwmon/ina238.c                             | 644 +++++++++++++++
 drivers/hwmon/jc42.c                               |   4 +
 drivers/hwmon/k10temp.c                            |  36 +-
 drivers/hwmon/mr75203.c                            |   2 +-
 drivers/hwmon/nct6775.c                            |  10 +-
 drivers/hwmon/ntc_thermistor.c                     | 299 ++++---
 drivers/hwmon/nzxt-smart2.c                        | 829 ++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig                        |  29 +-
 drivers/hwmon/pmbus/Makefile                       |   2 +
 drivers/hwmon/pmbus/delta-ahe50dc-fan.c            | 114 +++
 drivers/hwmon/pmbus/ir38064.c                      |  28 +-
 drivers/hwmon/pmbus/mp5023.c                       |  67 ++
 drivers/hwmon/raspberrypi-hwmon.c                  |   7 +-
 drivers/hwmon/sht4x.c                              |   7 +
 drivers/hwmon/tmp401.c                             | 863 ++++++++++-----------
 drivers/hwmon/xgene-hwmon.c                        |   6 +-
 include/linux/hwmon.h                              |   4 +-
 include/linux/pci_ids.h                            |   1 +
 include/linux/platform_data/ntc_thermistor.h       |  50 --
 39 files changed, 4118 insertions(+), 736 deletions(-)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 Documentation/hwmon/ina238.rst
 create mode 100644 Documentation/hwmon/mp5023.rst
 create mode 100644 Documentation/hwmon/nzxt-smart2.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c
 create mode 100644 drivers/hwmon/ina238.c
 create mode 100644 drivers/hwmon/nzxt-smart2.c
 create mode 100644 drivers/hwmon/pmbus/delta-ahe50dc-fan.c
 create mode 100644 drivers/hwmon/pmbus/mp5023.c
 delete mode 100644 include/linux/platform_data/ntc_thermistor.h
