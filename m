Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DCB530618
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351611AbiEVVOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347064AbiEVVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:14:02 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384AB3A187;
        Sun, 22 May 2022 14:13:57 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e5e433d66dso16201143fac.5;
        Sun, 22 May 2022 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61p8i3NsimJ1HV1RHfK4tCSZxyBvA6MRfZ//eTBWGAU=;
        b=ksbqOLLJ/VrQM7HjcFH/QhfGAnU6MyZ9UTQz4ohLJksxV+fweCnwLUSsEVA57PQzqb
         DgDeHQzHYrtkWSV7kP4wkOrs2wpPqx/cs3DsX6WfrlQG16YRqmQLBsUK4mqNJkVHq4kB
         jAQuR6UNl+XJlUT0E9DJVFb2+2tfLCHykJP+Wdynu0FWgzH3ceFE3Mu+VySA6/0XIomo
         rtKZFmN02TvQjP931R9Q/tAtRMsj4NFecRS8QBnmI/pDhDZwr0lfzBew9rchf86qXSYO
         WxBkcGnUWzbg5dqiiKcz653Wa7XeaQp7uNRVNcnPchWm4hoPKIj+8Ivlc7WNtA35PqSW
         w6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=61p8i3NsimJ1HV1RHfK4tCSZxyBvA6MRfZ//eTBWGAU=;
        b=cWbzwgxik9NSFVGugITD8Cra+/7gjUtN0QWPxw1XGccykvEmGwzIagLimHhagHNa9G
         uRpcifypk9s9m3Jh6FFJuDnwenZ4Mp4OLZOsGnMlZGV6pixVCbgQJ5/hx7R80sPoN0vN
         goPKdyTHQ5V9uRpEmBayMw2GWXnoIBzHZdz8ixbPTmloLdqKW3nRmCAW2Y2KZHZxtosC
         26YhyofNDKbcl2WfuTdLg1bsok9P2c9Ka/y2Q0hWBhGWI5lYcyT6PRHrgSb0ZunuLhSV
         ZF5J8GJQ6+QOp/vu3W3fm1y6uvxZDomauVSof1Lud2IA7HSwICCSEuSnlkhNtT3SMWQy
         HNJw==
X-Gm-Message-State: AOAM532JIBxU2EgI1ESPldFNVRMiQD09wavAt/wuHJ94oKVadFMAKY5b
        X+1qlyrn0x4MX8XMjkG0vt22/nedBv8t+w==
X-Google-Smtp-Source: ABdhPJyZMvu69oooScnVYWH0t6ssjLNtA+1DIK7Yo7Oo3XkSjKi2m8dUtNzywBzfloh2YJ4Gf9W+VQ==
X-Received: by 2002:a05:6871:10b:b0:f1:8d84:e59c with SMTP id y11-20020a056871010b00b000f18d84e59cmr10507122oab.29.1653254036387;
        Sun, 22 May 2022 14:13:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y2-20020a056870e50200b000e686d13890sm3066897oag.42.2022.05.22.14.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 14:13:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon patches for v5.19-rc1
Date:   Sun, 22 May 2022 14:13:53 -0700
Message-Id: <20220522211353.1003672-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon patches for Linux v5.19-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.19-rc1

Thanks,
Guenter
------

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.19-rc1

for you to fetch changes up to 8877ecb0fc8d7662218a8e7ebb0650f320467935:

  hwmon: (aquacomputer_d5next) Fix an error handling path in aqc_probe() (2022-05-22 12:25:55 -0700)

----------------------------------------------------------------
hwmon updates for v5.19-rc1

- New drivers

  - Driver for the Microchip LAN966x SoC

  - PMBus driver for Infineon Digital Multi-phase xdp152 family controllers

- Chip support added to existing drivers

  - asus-ec-sensors

    - Support for ROG STRIX X570-E GAMING WIFI II, PRIME X470-PRO,
      and ProArt X570 Creator WIFI

    - External temperature sensor support for ASUS WS X570-ACE

  - nct6775

    - Support for I2C driver

    - Support for ASUS PRO H410T / PRIME H410M-R / ROG X570-E GAMING WIFI II

  - lm75

    - Support for - Atmel AT30TS74

  - pmbus/max16601

    - Support for MAX16602

  - aquacomputer_d5next

    - Support for Aquacomputer Farbwerk

    - Support for Aquacomputer Octo

  - jc42

    - Support for S-34TS04A

- Kernel API changes / clarifications

  - The chip parameter of with_info API is now mandatory

  - New hwmon_device_register_for_thermal API call for use by the thermal
    subsystem

- Improvements

  - PMBus and JC42 drivers now register with thermal subsystem

  - PMBus drivers now support get_voltage/set_voltage power operations

  - The adt7475 driver now supports pin configuration

  - The lm90 driver now supports setting extended range temperatures
    configuration with a devicetree property

  - The dell-smm driver now registers as cooling device

  - The OCC driver delays hwmon registration until requested by userspace

- Various other minor fixes and improvements

----------------------------------------------------------------
Adam Wujek (1):
      hwmon: (pmbus) Check PEC support before reading other registers

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo

Armin Wolf (5):
      hwmon: (dell-smm) Add cooling device support
      hwmon: (dell-smm) Update Documentation regarding firmware bugs
      hwmon: (dell-smm) Avoid unnecessary SMM calls during init
      hwmon: (dell-smm) Cleanup init code
      hwmon: (dell-smm) Warn if SMM call took a very long time to execute

Atif Ofluoglu (1):
      hwmon: (pmbus/max16601) Add MAX16602 support

Camel Guo (3):
      dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
      hwmon: (tmp401) Add support of three advanced features
      hwmon: (tmp401) Fix incorrect return value of tmp401_init_client

Chris Packham (3):
      dt-bindings: hwmon: Document adt7475 pin-function properties
      hwmon: (adt7475) Add support for pin configuration
      hwmon: (adt7475) Use enum chips when loading attenuator settings

Christophe JAILLET (2):
      hwmon: (peci) Use devm_delayed_work_autocancel() to simplify code
      hwmon: (aquacomputer_d5next) Fix an error handling path in aqc_probe()

Corentin Labbe (1):
      hwmon: (acpi_power_meter) Fix style issues

Debabrata Banerjee (1):
      hwmon: (asus-ec-sensors) add ROG STRIX X570-E GAMING WIFI II

Denis Pauk (1):
      hwmon: (nct6775) add ASUS PRO H410T / PRIME H410M-R / ROG X570-E GAMING WIFI II

Eddie James (1):
      hwmon: (occ) Delay hwmon registration until user request

Eduardo Valentin (2):
      hwmon: (jc42) add HWMON_C_TZ_REGISTER
      hwmon: (pmbus) Register with thermal for PSC_TEMPERATURE

Eugene Shalygin (7):
      hwmon: (asus-ec-sensors) add ProArt X570 Creator WIFI board
      hwmon: (asus-ec-sensors) introduce ec_board_info struct for board data
      hwmon: (asus-ec-sensors) implement locking via the ACPI global lock
      hwmon: (asus-ec-sensors) add support for board families
      hwmon: (asus-ec-sensors) add PRIME X470-PRO board
      hwmon: (asus-ec-sensors) add doc entry for PRIME X470-PRO
      hwmon: (asus-ec-sensors) fix Formula VIII definition

Greg.Schwendimann@infineon.com (2):
      hwmon: (pmbus) Add support for Infineon Digital Multi-phase xdp152 family controllers
      dt-bindings: trivial-devices: Add xdp152

Guenter Roeck (11):
      hwmon: Introduce hwmon_device_register_for_thermal
      thermal/drivers/thermal_hwmon: Use hwmon_device_register_for_thermal()
      hwmon: Make chip parameter for with_info API mandatory
      hwmon: (as370-hwmon) Use HWMON_CHANNEL_INFO macro
      hwmon: (ltc2992) Use HWMON_CHANNEL_INFO macro
      hwmon: (mr75203) Use HWMON_CHANNEL_INFO macro
      hwmon: (peci/cputemp) Use HWMON_CHANNEL_INFO macro
      hwmon: (peci/dimmtemp) Use HWMON_CHANNEL_INFO macro
      hwmon: (pwm-fan) Use HWMON_CHANNEL_INFO macro
      hwmon: (sl28cpld-hwmon) Use HWMON_CHANNEL_INFO macro
      hwmon: (dimmtemp) Fix bitmap handling

Holger Brunck (3):
      dt-bindings: hwmon: lm90: add missing ti,tmp461
      dt-bindings: hwmon: lm90: add ti,extended-range-enable property
      hwmon: (lm90) enable extended range according to DTS node

Jack Doan (1):
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer Farbwerk

Julia Lawall (1):
      hwmon: (sl28cpld) Fix typo in comment

Karl Mehltretter (1):
      hwmon: (lm83) Remove unused include directives

Michael Walle (6):
      hwmon: introduce hwmon_sanitize_name()
      hwmon: (intel-m10-bmc-hwmon) use devm_hwmon_sanitize_name()
      lib: add generic polynomial calculation
      hwmon: (bt1-pvt) use generic polynomial functions
      dt-bindings: hwmon: add Microchip LAN966x bindings
      hwmon: add driver for the Microchip LAN966x SoC

Mårten Lindahl (4):
      hwmon: (pmbus) Introduce and use write_byte_data callback
      hwmon: (pmbus) Use _pmbus_read_byte_data with callback
      hwmon: (pmbus/ltc2978) Add chip specific write_byte_data
      hwmon: (pmbus) Add get_voltage/set_voltage ops

Oleksandr Shamray (1):
      hwmon: (jc42) Add support for S-34TS04A

Peter Rosin (2):
      dt-bindings: hwmon: Add Atmel AT30TS74
      hwmon: (lm75) Add Atmel AT30TS74 support

Wei Shuyu (1):
      hwmon: (asus-ec-sensors) Add T_Sensor for ASUS WS X570-ACE

Zev Weiss (7):
      hwmon: (nct6775) Convert register access to regmap API
      hwmon: (nct6775) Rearrange attr-group initialization
      hwmon: (nct6775) Add read-only mode
      hwmon: (nct6775) Convert S_I* permissions macros to octal
      hwmon: (nct6775) Split core and platform driver
      dt-bindings: hwmon: Add nuvoton,nct6775
      hwmon: (nct6775) Add i2c driver

keliu (2):
      hwmon: Directly use ida_alloc()/free()
      hwmon: (ibmaem) Directly use ida_alloc()/free()

 .../devicetree/bindings/hwmon/adt7475.yaml         |   22 +
 Documentation/devicetree/bindings/hwmon/lm75.yaml  |    1 +
 .../bindings/hwmon/microchip,lan966x.yaml          |   53 +
 .../devicetree/bindings/hwmon/national,lm90.yaml   |   20 +
 .../devicetree/bindings/hwmon/nuvoton,nct6775.yaml |   57 +
 .../devicetree/bindings/hwmon/ti,tmp401.yaml       |  105 +
 .../devicetree/bindings/trivial-devices.yaml       |    4 +
 Documentation/hwmon/aquacomputer_d5next.rst        |    7 +-
 Documentation/hwmon/asus_ec_sensors.rst            |   25 +-
 Documentation/hwmon/dell-smm-hwmon.rst             |    9 +
 Documentation/hwmon/hwmon-kernel-api.rst           |   18 +-
 Documentation/hwmon/index.rst                      |    2 +
 Documentation/hwmon/lan966x.rst                    |   40 +
 Documentation/hwmon/max16601.rst                   |    8 +
 Documentation/hwmon/xdpe152c4.rst                  |  118 +
 MAINTAINERS                                        |   15 +-
 drivers/hwmon/Kconfig                              |   55 +-
 drivers/hwmon/Makefile                             |    4 +
 drivers/hwmon/acpi_power_meter.c                   |   17 +-
 drivers/hwmon/adt7475.c                            |  119 +-
 drivers/hwmon/aquacomputer_d5next.c                |  466 +++-
 drivers/hwmon/as370-hwmon.c                        |   12 +-
 drivers/hwmon/asus-ec-sensors.c                    |  414 +++-
 drivers/hwmon/bt1-pvt.c                            |   50 +-
 drivers/hwmon/dell-smm-hwmon.c                     |  147 +-
 drivers/hwmon/hwmon.c                              |  100 +-
 drivers/hwmon/ibmaem.c                             |   10 +-
 drivers/hwmon/intel-m10-bmc-hwmon.c                |   11 +-
 drivers/hwmon/jc42.c                               |    8 +
 drivers/hwmon/lan966x-hwmon.c                      |  418 ++++
 drivers/hwmon/lm75.c                               |   14 +
 drivers/hwmon/lm83.c                               |    2 -
 drivers/hwmon/lm90.c                               |    4 +
 drivers/hwmon/ltc2992.c                            |   86 +-
 drivers/hwmon/mr75203.c                            |   12 +-
 drivers/hwmon/{nct6775.c => nct6775-core.c}        | 2445 ++++++--------------
 drivers/hwmon/nct6775-i2c.c                        |  195 ++
 drivers/hwmon/nct6775-platform.c                   | 1229 ++++++++++
 drivers/hwmon/nct6775.h                            |  252 ++
 drivers/hwmon/occ/common.c                         |  100 +-
 drivers/hwmon/occ/common.h                         |    5 +-
 drivers/hwmon/occ/p8_i2c.c                         |    2 +-
 drivers/hwmon/occ/p9_sbe.c                         |    2 +-
 drivers/hwmon/occ/sysfs.c                          |  137 +-
 drivers/hwmon/peci/cputemp.c                       |   38 +-
 drivers/hwmon/peci/dimmtemp.c                      |   33 +-
 drivers/hwmon/pmbus/Kconfig                        |   13 +-
 drivers/hwmon/pmbus/Makefile                       |    1 +
 drivers/hwmon/pmbus/ltc2978.c                      |   12 +
 drivers/hwmon/pmbus/max16601.c                     |   13 +-
 drivers/hwmon/pmbus/pmbus.h                        |    2 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  233 +-
 drivers/hwmon/pmbus/xdpe152c4.c                    |   75 +
 drivers/hwmon/pwm-fan.c                            |   12 +-
 drivers/hwmon/sl28cpld-hwmon.c                     |   14 +-
 drivers/hwmon/tmp401.c                             |   46 +-
 drivers/thermal/thermal_hwmon.c                    |    6 +-
 include/linux/hwmon.h                              |    6 +
 include/linux/polynomial.h                         |   35 +
 lib/Kconfig                                        |    3 +
 lib/Makefile                                       |    2 +
 lib/polynomial.c                                   |  108 +
 62 files changed, 5118 insertions(+), 2354 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
 create mode 100644 Documentation/hwmon/lan966x.rst
 create mode 100644 Documentation/hwmon/xdpe152c4.rst
 create mode 100644 drivers/hwmon/lan966x-hwmon.c
 rename drivers/hwmon/{nct6775.c => nct6775-core.c} (66%)
 create mode 100644 drivers/hwmon/nct6775-i2c.c
 create mode 100644 drivers/hwmon/nct6775-platform.c
 create mode 100644 drivers/hwmon/nct6775.h
 create mode 100644 drivers/hwmon/pmbus/xdpe152c4.c
 create mode 100644 include/linux/polynomial.h
 create mode 100644 lib/polynomial.c
