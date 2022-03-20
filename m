Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D94E1E38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 00:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbiCTXOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 19:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbiCTXOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 19:14:46 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.46.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E426469
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:13:19 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 030C8400D457E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:13:19 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id W4jenE7lHdx86W4jen25vk; Sun, 20 Mar 2022 18:13:18 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0MMEfmc14YWYVDvY/sfE4vvUkO2E9+3GXLCm6WybRQ8=; b=TShFAedbSJmtxrJ31+Qx+DHHRf
        tUJZg6ABE2tN8rdXr0jN1CoGQQFuxywuZwT5xv0di21Eb4i9uEcvPwyDBxtiEx24lhsiNwUAcDPKp
        f6usGb5NnwE/BWcQrQJ6O6qZ4MmwB2Bg5KJYKyOkvGp94FCF1FZ8AaBnvyFbqUq5xBpWQrGwRcNaD
        Sjbl+A768F74VBR7HCctlEDqMRnPVFufYpO9KchCEgKGNbSNakJfUObD1xCGvqYSqY9BRIxPtD7Q5
        DxVWzIOtJRbiDFPKjmWe5la9N8uK52G9tR5bDr5AD40Wj51KAf4VHI5RfypHf6CT4zzk2zDfLTcbq
        6vLPUW7w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57578 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nW4je-002htO-F8; Sun, 20 Mar 2022 23:13:18 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.18
Date:   Sun, 20 Mar 2022 16:13:17 -0700
Message-Id: <20220320231317.2171300-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nW4je-002htO-F8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57578
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.18 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18

Thanks,
Guenter
------

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.18

for you to fetch changes up to 6ba463edccb978e3c0248c3a193b759436b51ac8:

  hwmon: (dell-smm) Add Inspiron 3505 to fan type blacklist (2022-03-18 15:12:22 -0700)

----------------------------------------------------------------
hwmon updates for v5.18

New drivers
- Driver for Texas Instruments TMP464 and TMP468
- Driver for Vicor PLI1209BC Digital Supervisor
- Driver for ASUS EC

Improvements to existing drivers:
- adt7x10: Convert to use regmap, convert to use with_info API,
  use hwmon_notify_event, and other cleanup
- aquacomputer_d5next: Add support for Aquacomputer Farbwerk 360
- asus_wmi_sensors: Add ASUS ROG STRIX B450-F GAMING II
- asus_wmi_ec_sensors: Support T_Sensor on Prime X570-Pro
  Deprecate driver (replaced by new driver)
- axi-fan-control: Use hwmon_notify_event
- dell-smm: Clean up CONFIG_I8K, disable fan type support for
  Inspiron 3505, various other cleanup
- hwmon core: Report attribute name with udev events,
  Add "label" attribute to ABI,
  Add support for pwm auto channels attribute
- max6639: Add regulator support
- lm70: Add support for TI TMP125
- lm83: Cleanup, convert to use with_info API
- mlxreg-fan: Use pwm attribute for setting fan speed low limit
- nct6775: Sdd ASUS ROG STRIX Z390/Z490/X570-* / PRIME X570-P,
  PRIME B550-PLUS, ASUS Pro B550M-C/PRIME B550M-A,
  and support for TSI temperature registers
- occ: Add various new sysfs attributes
- pmbus core: Handle VIN unit off status,
  Add regulator supply into macro,
  Add get_error_flags support to regulator ops
- pmbus/adm1275: Allow setting sample averaging
- pmbus/lm25066: Add regulator support
- pmbus/xdpe12284: Add support for xdpe11280 and register as regulator
- powr1220: Convert to with_info API,
  Add support for Lattice's POWR1014 power manager IC
- sch56xx: Cleanup and minor improvements
- sch5627: Add pwmX_auto_channels_temp support
- tc654: Add thermal_cooling device support

----------------------------------------------------------------
Agathe Porte (1):
      dt-bindings: hwmon: add tmp464.yaml

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer Farbwerk 360

Anthony DeRossi (1):
      hwmon: (asus_wmi_ec_sensors) Support T_Sensor on Prime X570-Pro

Armin Wolf (14):
      Documentation: admin-guide: Update i8k driver name
      Documentation: admin-guide: Add Documentation for undocumented dell_smm_hwmon parameters
      Documentation: ABI: Add ABI file for legacy /proc/i8k interface
      hwmon: (sch56xx) Autoload modules on platform device creation
      hwmon: (sch56xx-common) Add automatic module loading on supported devices
      hwmon: (sch56xx-common) Replace msleep() with usleep_range()
      hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING
      hwmon: (dell-smm) Reword and mark parameter "force" as unsafe
      hwmon: (dell-smm) Add SMM interface documentation
      hwmon: (dell-smm) Make fan/temp sensor number a u8
      hwmon: (dell-smm) Improve temperature sensors detection
      hwmon: (core) Add support for pwm auto channels attribute
      hwmon: (sch5627) Add pwmX_auto_channels_temp support
      hwmon: (dell-smm) Add Inspiron 3505 to fan type blacklist

Brandon Wyman (1):
      hwmon: (pmbus) Add Vin unit off handling

Christian Lamparter (3):
      hwmon: (tc654) Add thermal_cooling device support
      dt-bindings: Add ti,tmp125 temperature sensor binding
      hwmon: (lm70) Add ti,tmp125 support

Cosmin Tanislav (5):
      hwmon: (adt7x10) Add device managed action for restoring config
      hwmon: (adt7x10) Use devm_hwmon_device_register_with_info
      hwmon: (adt7x10) Use devm_request_threaded_irq
      hwmon: (adt7x10) Remove empty driver removal callback
      hwmon: (adt7x10) Use hwmon_notify_event

Dan Carpenter (1):
      hwmon: (asus-ec-sensors) fix a typo in asus_ec_probe()

Denis Pauk (3):
      hwmon: (nct6775) add ASUS Pro B550M-C/PRIME B550M-A
      hwmon: (asus_wmi_sensors) add ASUS ROG STRIX B450-F GAMING II
      hwmon: (nct6775) add ASUS ROG STRIX Z390/Z490/X570-* / PRIME X570-P

Dmitry Baryshkov (1):
      hwmon: (nct6775) add PRIME B550-PLUS motherboard to whitelist

Eddie James (4):
      hwmon: (occ) Add sysfs entry for IPS (Idle Power Saver) status
      hwmon: (occ) Add sysfs entry for OCC mode
      hwmon: (occ) Add sysfs entries for additional extended status bits
      hwmon: (occ) Add soft minimum power cap attribute

Eugene Shalygin (10):
      hwmon: (asus-ec-sensors) add driver for ASUS EC
      hwmon: (asus-ec-sensors) update documentation
      hwmon: deprecate asis_wmi_ec_sensors driver
      hwmon: (asus-ec-sensors) Add Crosshair VIII Hero WiFi
      hwmon: (asus-ec-sensors) read sensors as signed ints
      hwmon: (asus-ec-sensors) add CPU core voltage
      hwmon: (asus-ec-sensors) deduce sensor signedness from its type
      hwmon: (asus-ec-sensors) merge setup functions
      hwmon: (asus-ec-sensors) depend on X86 in KConfig
      hwmon: (asus-ec-sensors) do not print from .probe()

Guenter Roeck (11):
      hwmon: Report attribute name with udev events
      hwmon: (lm83) Reorder include files to be in alphabetic order
      hwmon: (lm83) Move lm83_id to avoid forward declaration
      hwmon: (lm83) Replace new_client with client
      hwmon: (lm83) Use regmap
      hwmon: (lm83) Replace temperature conversion macros with standard functions
      hwmon: (lm83) Demote log message if chip identification fails
      hwmon: (lm83) Explain why LM82 may be misdetected as LM83
      hwmon: (lm83) Convert to use with_info API
      hwmon: (adt7x10) Convert to use regmap
      hwmon: Add driver for Texas Instruments TMP464 and TMP468

Marcello Sylvester Bauer (11):
      hwmon: (pmbus) Remove trailing whitespaces from Kconfig file
      hwmon: (max6639) Update Datasheet URL
      hwmon: (max6639) Add regulator support
      hwmon: (pmbus) Add regulator supply into macro
      dt-bindings: vendor-prefixes: add Vicor Corporation
      dt-bindings:trivial-devices: Add pli1209bc
      hwmon: (pmbus) Add support for pli1209bc
      hwmon: (pmbus/pli1209bc) Add regulator support
      dt-bindings: trivial-devices: Add xdpe11280
      hwmon: (xdpe12284) Add support for xdpe11280
      hwmon: (xdpe12284) Add regulator support

Mateusz Jończyk (2):
      x86/Kconfig: move and modify CONFIG_I8K
      hwmon: (dell-smm) rewrite CONFIG_I8K description

Michael Shych (3):
      hwmon: (powr1220) Cosmetic changes
      hwmon: (powr1220) Upgrade driver to support hwmon info infrastructure
      hwmon: (powr1220) Add support for Lattice's POWR1014 power manager IC

Minghao Chi (1):
      hwmon: (scpi-hwmon): Use of_device_get_match_data()

Minghao Chi (CGEL ZTE) (1):
      hwmon: (vexpress-hwmon) Use of_device_get_match_data()

Nuno Sá (1):
      hwmon: (axi-fan-control) Use hwmon_notify_event

Patrick Rudolph (1):
      hwmon: (pmbus) Add mutex to regulator ops

Paul Cercueil (3):
      ABI: hwmon: Document "label" sysfs attribute
      hwmon: Add "label" attribute
      hwmon: Fix possible NULL pointer

Potin Lai (2):
      hwmon: (adm1275) Allow setting sample averaging
      dt-bindings: hwmon: Add sample averaging properties for ADM1275

Rob Herring (1):
      dt-bindings: hwmon: lm90: Drop Tegra specifics from example

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Use pwm attribute for setting fan speed low limit

Zev Weiss (3):
      hwmon: (nct6775) add support for TSI temperature registers
      hwmon: (pmbus) Add get_error_flags support to regulator ops
      hwmon: (pmbus/lm25066) Add regulator support

 Documentation/ABI/obsolete/procfs-i8k              |  10 +
 Documentation/ABI/testing/sysfs-class-hwmon        |   8 +
 Documentation/admin-guide/kernel-parameters.txt    |  35 +-
 .../devicetree/bindings/hwmon/adi,adm1275.yaml     |  68 ++
 .../devicetree/bindings/hwmon/national,lm90.yaml   |   4 +-
 .../devicetree/bindings/hwmon/ti,tmp464.yaml       | 114 ++++
 .../devicetree/bindings/trivial-devices.yaml       |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/hwmon/aquacomputer_d5next.rst        |  49 +-
 Documentation/hwmon/asus_ec_sensors.rst            |  54 ++
 Documentation/hwmon/dell-smm-hwmon.rst             | 180 ++++++
 Documentation/hwmon/index.rst                      |   3 +
 Documentation/hwmon/lm70.rst                       |   7 +
 Documentation/hwmon/max6639.rst                    |   2 +-
 Documentation/hwmon/pli1209bc.rst                  |  75 +++
 Documentation/hwmon/sch5627.rst                    |   4 +
 Documentation/hwmon/sysfs-interface.rst            |   4 +
 Documentation/hwmon/tmp464.rst                     |  73 +++
 Documentation/hwmon/xdpe12284.rst                  |  12 +-
 MAINTAINERS                                        |  16 +
 arch/x86/Kconfig                                   |  17 -
 drivers/hwmon/Kconfig                              |  49 +-
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/adt7310.c                            |  95 ++-
 drivers/hwmon/adt7410.c                            |  82 ++-
 drivers/hwmon/adt7x10.c                            | 479 ++++++--------
 drivers/hwmon/adt7x10.h                            |  10 +-
 drivers/hwmon/aquacomputer_d5next.c                | 379 +++++++----
 drivers/hwmon/asus-ec-sensors.c                    | 716 +++++++++++++++++++++
 drivers/hwmon/asus_wmi_ec_sensors.c                |   3 +-
 drivers/hwmon/asus_wmi_sensors.c                   |   1 +
 drivers/hwmon/axi-fan-control.c                    |   3 +-
 drivers/hwmon/dell-smm-hwmon.c                     |  84 ++-
 drivers/hwmon/hwmon.c                              |  40 +-
 drivers/hwmon/lm70.c                               |  16 +
 drivers/hwmon/lm83.c                               | 476 ++++++++------
 drivers/hwmon/max6639.c                            |  62 +-
 drivers/hwmon/mlxreg-fan.c                         |  84 +--
 drivers/hwmon/nct6775.c                            | 146 ++++-
 drivers/hwmon/occ/common.c                         |  19 +-
 drivers/hwmon/occ/common.h                         |   2 +
 drivers/hwmon/occ/sysfs.c                          |  46 ++
 drivers/hwmon/pmbus/Kconfig                        |  33 +-
 drivers/hwmon/pmbus/Makefile                       |   1 +
 drivers/hwmon/pmbus/adm1275.c                      |  40 +-
 drivers/hwmon/pmbus/lm25066.c                      |  14 +
 drivers/hwmon/pmbus/pli1209bc.c                    | 146 +++++
 drivers/hwmon/pmbus/pmbus.h                        |   2 +
 drivers/hwmon/pmbus/pmbus_core.c                   | 132 +++-
 drivers/hwmon/pmbus/xdpe12284.c                    |  32 +-
 drivers/hwmon/powr1220.c                           | 235 ++++---
 drivers/hwmon/sch5627.c                            |  71 ++
 drivers/hwmon/sch5636.c                            |  10 +
 drivers/hwmon/sch56xx-common.c                     |  44 +-
 drivers/hwmon/scpi-hwmon.c                         |   6 +-
 drivers/hwmon/tc654.c                              | 104 ++-
 drivers/hwmon/tmp464.c                             | 712 ++++++++++++++++++++
 drivers/hwmon/vexpress-hwmon.c                     |   6 +-
 include/linux/hwmon.h                              |   2 +
 59 files changed, 4155 insertions(+), 971 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/procfs-i8k
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
 create mode 100644 Documentation/hwmon/asus_ec_sensors.rst
 create mode 100644 Documentation/hwmon/pli1209bc.rst
 create mode 100644 Documentation/hwmon/tmp464.rst
 create mode 100644 drivers/hwmon/asus-ec-sensors.c
 create mode 100644 drivers/hwmon/pmbus/pli1209bc.c
 create mode 100644 drivers/hwmon/tmp464.c
