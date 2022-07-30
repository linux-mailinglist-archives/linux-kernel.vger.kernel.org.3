Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCD55857FD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 04:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbiG3CZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 22:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbiG3CZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 22:25:35 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4378218E07;
        Fri, 29 Jul 2022 19:25:34 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10bd4812c29so7751671fac.11;
        Fri, 29 Jul 2022 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=1Dk/sOXh30TUb+lKC4VpE3qFUQLLp1IrEeaVN9xrndc=;
        b=coGMn4LzDv8vrSoDfMLK8d++7zJoMfD//cR+s4XtH59FNUNydoWahiO5MmoZmRoXN3
         WCXDFNXpVjeWoYusq4xyoMsgefdS6JtVPdMZF52/oguttq46G8WGJLjX1k3Q3rGRYnq6
         VbkxZtD3Qsn0c1efTUzDWapzKC5tlz8Lb5uVcvQxvcBC+7PHmI+eCOCMaKtCdC1Ed3bS
         44UUDvjKS7ejsHpSUTtw0G+IqdUUPrGHzjKMWKd8750zBYNFNzzYiCvGWv3BIbPz0x5/
         ZjzdUaSSDrVB5kVU7wNq6ovBL0HA8LA8TbocIpyZQymSEy5m6fh5Gh+LpkI1QJEEslI0
         /M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=1Dk/sOXh30TUb+lKC4VpE3qFUQLLp1IrEeaVN9xrndc=;
        b=k3N8ZIpYSZQEDS0LHgn6usum6sdhRrybGTLC4exavgdVdremxeJfyNnAL35Ptc5HQf
         QVLkgx+DglXmkK4udGEglszWPvw66YgpA6Hw4yg5wk+m77bp6mHQy3utfNXEA3ZBYCQS
         LB3jtsUIqzoBhJrUoZSoVVR/ilm6L/FbEUcM0T9s3RXVPMcfCNJPO521DGROXz5hE1dL
         ulFXJx8VW9brEQdWiR9BU462PFO9icuRFeeJTTt05UEx3O2fq8zlBzIfqjKX1Emdke7H
         Dtb1L7w5C5m+hIqGfpACpz2eLsDymLVVB0jzhNDFCkKV9KLZHgI7oGO3BiqNIrCJj6+2
         /Hcg==
X-Gm-Message-State: AJIora9m8j2ehBtxVjBcGviK0i5I6n9tzuXBeD9egKDzgMhgCD9moGG7
        sVjc3EQH3CI283vNxAsHJC3xcCRxQX34Fw==
X-Google-Smtp-Source: AGRyM1tQcfVXAfaAU8vUOW8b/o4sldnM2v595XxWTIrrvOHLuZx+wFWUC//9+fniBHU8V4w9SUqirw==
X-Received: by 2002:a05:6870:c0c1:b0:10d:96:737f with SMTP id e1-20020a056870c0c100b0010d0096737fmr3485192oad.101.1659147932818;
        Fri, 29 Jul 2022 19:25:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a46-20020a4a98b1000000b00425806a20f5sm1433144ooj.3.2022.07.29.19.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 19:25:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.20
Date:   Fri, 29 Jul 2022 19:25:29 -0700
Message-Id: <20220730022529.497941-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'll be traveling next week, so I am sending this pull request early,
in the hope that there won't be a v5.19-rc9.

Please pull hwmon updates for Linux v5.20 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.20

Thanks,
Guenter
------

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.20

for you to fetch changes up to cdbe34da01e32024e56fff5c6854a263a012d7ff:

  hwmon: (aquacomputer_d5next) Add support for Aquacomputer Quadro fan controller (2022-07-27 06:00:24 -0700)

----------------------------------------------------------------
hwmon updates for v5.20

- Substantial rewrite of lm90 driver to support several
  additional chips and improve support for existing chips.

- Add support of ROG ZENITH II EXTREME, Maximus XI Hero,
  Strix Z690-a D4 to asus-ec-sensors driver

- Add support of F71858AD to f71882fg driver

- Add support of Aquacomputer Quadro to aquacomputer_d5next
  driver

- Improved assembler code and add support for Dell G5 5590
  as well as XPS 13 7390 in dell-smm driver

- Add support for ASUS TUF GAMING B550-PLUS WIFI II to nct775 driver

- Add support for IEEE 754 half precision to PMBus core.
  Also support for Analog Devices LT7182S, improve
  regulator support, and report various MFR register
  values in debugfs.

- Various other minor improvements and fixes

----------------------------------------------------------------
Adam Wujek (2):
      hwmon: (pmbus) add a function to check the presence of a block register
      hwmon: (pmbus) add MFR_* registers to debugfs

Aleksa Savic (4):
      hwmon: (aquacomputer_d5next) Move device-specific data into struct aqc_data
      hwmon: (aquacomputer_d5next) Add D5 Next fan control support
      hwmon: (aquacomputer_d5next) Add support for reading the +12V voltage sensor on D5 Next
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer Quadro fan controller

Aleksander Mazur (1):
      hwmon: (f71882fg) Add support for F71858AD (0x0903)

Alexandru Gagniuc (1):
      hwmon: (tps23861) fix byte order in current and voltage registers

Andy Shevchenko (2):
      hwmon: (nct6775) Drop duplicate NULL check in ->init() and ->exit()
      hwmon: (occ) Replace open-coded variant of %*phN specifier

Armin Wolf (5):
      hwmon: (sch56xx-common) Add DMI override table
      hwmon: (dell-smm) Add Dell XPS 13 7390 to fan control whitelist
      hwmon: (dell-smm) Add Dell G5 5590 to DMI table
      hwmon: (dell-smm) Improve assembly code
      hwmon: (dell-smm) Improve documentation

Christophe JAILLET (2):
      hwmon: (lm75) Replace kernel.h with the necessary inclusions
      hwmon: (asus_wmi_sensors) Save a few bytes of memory

Eugene Shalygin (1):
      hwmon: (asus-ec-sensors) add missing sensors for X570-I GAMING

Guenter Roeck (45):
      hwmon: (pmbus) Move pec attribute to I2C device
      hwmon: (lm90) Generate sysfs and udev events for all alarms
      hwmon: (lm90) Rework alarm/status handling
      hwmon: (lm90) Reorder include files in alphabetical order
      hwmon: (lm90) Reorder chip enumeration to be in alphabetical order
      hwmon: (lm90) Use BIT macro
      hwmon: (lm90) Move status register bit shifts to compile time
      hwmon: (lm90) Stop using R_/W_ register prefix
      hwmon: (lm90) Improve PEC support
      hwmon: (lm90) Add partial PEC support for ADT7461
      hwmon: (lm90) Enable full PEC support for ADT7461A
      hwmon: (lm90) Add support for unsigned and signed temperatures
      hwmon: (lm90) Only re-read registers if volatile
      hwmon: (lm90) Support multiple temperature resolutions
      hwmon: (lm90) Use single flag to indicate extended temperature support
      hwmon: (lm90) Rework detect function
      hwmon: (lm90) Add support for additional chip revision of NCT1008
      hwmon: (lm90) Fix/Add detection of G781-1
      hwmon: (lm90) Add flag to indicate 'alarms' attribute support
      hwmon: (lm90) Add explicit support for MAX6648/MAX6692
      hwmon: (lm90) Add support for ADT7481, ADT7482, and ADT7483
      hwmon: (lm90) Strengthen chip detection for ADM1032, ADT7461(A), and NCT1008
      hwmon: (lm90) Add support for MAX6690
      hwmon: (lm90) Add flag to indicate support for minimum temperature limits
      hwmon: (lm90) Add flag to indicate conversion rate support
      hwmon: (lm90) Add support for MAX6642
      hwmon: (lm90) Let lm90_read16() handle 8-bit read operations
      hwmon: (lm90) Introduce 16-bit register write function
      hwmon: (lm90) Support MAX1617 and LM84
      hwmon: (lm90) Add support for ADM1021, ADM1021A, and ADM1023
      hwmon: (lm90) Add remaining chips supported by adm1021 driver
      hwmon: (lm90) Combine lm86 and lm90 configuration
      hwmon: (lm90) Add explicit support for NCT210
      hwmon: (lm90) Add support for ON Semiconductor NCT214 and NCT72
      hwmon: (lm90) Add support for ON Semiconductor NCT218
      hwmon: (lm90) Add support for ADT7421
      hwmon: (lm90) Only disable alerts if not already disabled
      hwmon: (lm90) Add explicit support for ADM1020
      hwmon: (lm90) Add support and detection of Philips/NXP NE1618
      hwmon: (lm90) Add table with supported Analog/ONSEMI devices
      hwmon: (lm90) Support temp_samples attribute
      hwmon: (pmbus) Add IEEE 754 half precision support to PMBus core
      dt-bindings: trivial-devices: Add lt7182s
      hwmon: (pmbus) Add support for Analog Devices LT7182S
      hwmon: (lm90) Use worker for alarm notifications

Liang He (1):
      hwmon: (gsc-hwmon) Add missing of_node_put()

Linus Walleij (1):
      hwmon: (drivetemp) Add module alias

Marc Ferland (1):
      hwmon: (mcp3021) improve driver support for newer hwmon interface

Michael Carns (1):
      hwmon: (asus-ec-sensors) add support for Maximus XI Hero

Mårten Lindahl (3):
      hwmon: (pmbus) Introduce and use cached vout margins
      hwmon: (pmbus) Add list_voltage to pmbus ops
      hwmon: (pmbus/ltc2978) Set voltage resolution

Paul Fertser (1):
      hwmon: (aspeed-pwm-tacho) increase fan tach period (again)

Ren Zhijie (1):
      hwmon: (pmbus) fix build error unused-function

Robert Schmidt (1):
      hwmon: (nct6775) add ASUS TUF GAMING B550-PLUS WIFI II

Shady Nawara (1):
      hwmon: (asus-ec-sensors) add support for Strix Z690-a D4

Slawomir Stepien (7):
      dt-bindings: hwmon: Add compatible string for ADT7481 in lm90
      dt-bindings: hwmon: Allow specifying channels for lm90
      hwmon: (lm90) Add compatible entry for adt7481
      hwmon: (lm90) Define maximum number of channels that are supported
      hwmon: (lm90) Read the channel's label from device-tree
      hwmon: (lm90) Add support for 2nd remote channel's offset register
      hwmon: (lm90) Read the channel's temperature offset from device-tree

Urs Schroffenegger (1):
      hwmon: (asus-ec-sensors) add definitions for ROG ZENITH II EXTREME

Uwe Kleine-König (2):
      hwmon: Allow to compile ASB100 and FSCHMD on !X86
      hwmon: (sht15) Fix wrong assumptions in device remove callback

Ziyang Xuan (1):
      hwmon: (occ) Delete unnecessary NULL check

 Documentation/ABI/testing/sysfs-class-hwmon        |    9 +
 .../devicetree/bindings/hwmon/national,lm90.yaml   |  131 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 Documentation/hwmon/aquacomputer_d5next.rst        |   17 +-
 Documentation/hwmon/asus_ec_sensors.rst            |    4 +
 Documentation/hwmon/dell-smm-hwmon.rst             |    3 +
 Documentation/hwmon/index.rst                      |    1 +
 Documentation/hwmon/lm90.rst                       |  233 +-
 Documentation/hwmon/lt7182s.rst                    |   92 +
 Documentation/hwmon/pmbus-core.rst                 |    9 +
 drivers/hwmon/Kconfig                              |   27 +-
 drivers/hwmon/aquacomputer_d5next.c                |  316 +--
 drivers/hwmon/aspeed-pwm-tacho.c                   |    2 +-
 drivers/hwmon/asus-ec-sensors.c                    |  108 +-
 drivers/hwmon/asus_wmi_sensors.c                   |   12 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   93 +-
 drivers/hwmon/drivetemp.c                          |    1 +
 drivers/hwmon/f71882fg.c                           |    2 +
 drivers/hwmon/gsc-hwmon.c                          |    3 +
 drivers/hwmon/lm75.h                               |    3 +-
 drivers/hwmon/lm90.c                               | 2556 +++++++++++++-------
 drivers/hwmon/mcp3021.c                            |   99 +-
 drivers/hwmon/nct6775-platform.c                   |   13 +-
 drivers/hwmon/occ/common.c                         |    8 +-
 drivers/hwmon/occ/p9_sbe.c                         |    6 +-
 drivers/hwmon/pmbus/Kconfig                        |    9 +
 drivers/hwmon/pmbus/Makefile                       |    1 +
 drivers/hwmon/pmbus/lt7182s.c                      |  195 ++
 drivers/hwmon/pmbus/ltc2978.c                      |   44 +-
 drivers/hwmon/pmbus/pmbus.h                        |   10 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |  446 +++-
 drivers/hwmon/sch56xx-common.c                     |   44 +-
 drivers/hwmon/sht15.c                              |   17 +-
 drivers/hwmon/tps23861.c                           |   14 +-
 34 files changed, 3309 insertions(+), 1221 deletions(-)
 create mode 100644 Documentation/hwmon/lt7182s.rst
 create mode 100644 drivers/hwmon/pmbus/lt7182s.c
