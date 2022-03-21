Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688954E5A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbiCWVTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbiCWVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3385644;
        Wed, 23 Mar 2022 14:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EFA6616E0;
        Wed, 23 Mar 2022 21:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9643FC340EE;
        Wed, 23 Mar 2022 21:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648070269;
        bh=IFzak4etS5b+TZUCLXmkFg0fNbP7CdQrVm5pDLCsKkc=;
        h=Date:From:To:Cc:Subject:From;
        b=q+qrQoYwYyK3fIL7uHv5AHHKNdnjT4xIQQst4KM9/AbQXVOUpJXH+gyqhfVk1BUCt
         4pIDybJYO2LN3HCC86JgXhblINWXYfmOJva1zMcZHh19Sf4CtFJRbq7n29gW0pYfwZ
         pRscui9wVBZmH3nMu39X9Z3qxjiYrbH65IeGsdVQ7tChj5RszFzbqCaWi8B+oidcng
         bjOj3iDRkZDQZq3IvodyZ/hVOSZb5fpkPmJImmn+ao0N5DvwHbFpmtjRdBAqYxH9uC
         mTB65w/fxZi9mlvYO955du+T4TwPlwSJWpspFpIk7GoFc9TEbziBFzqnpi0gwqgjPi
         fwGg0rIEYL80Q==
Received: by earth.universe (Postfix, from userid 1000)
        id 19D353C0CBC; Mon, 21 Mar 2022 19:03:24 +0100 (CET)
Date:   Mon, 21 Mar 2022 19:03:24 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.18
Message-ID: <20220321180324.aruy3fhiopzjkr32@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="arho6uem3puskgsi"
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--arho6uem3puskgsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This time two merge conflicts have been reported for my tree:

1. conflict between driver-core and power-supply. Solution is
to ignore the change from Greg as the modified code has been
deleted in my tree.

2. conflict between extcon and power-supply. That one should
also be obvious. The patch from extcon does and the patch in
my tree change different lines, but within the diff scope.

Otherwise things are business as usual, so please pull :)

Thanks,

-- Sebastian

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/for-v5.18

for you to fetch changes up to c22fca40522e2be8af168f3087d87d85e404ea72:

  power: ab8500_chargalg: Use CLOCK_MONOTONIC (2022-03-14 17:24:52 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.18 series

power-supply core:
 - Introduce "Bypass" charging type used by USB PPS standard
 - Refactor power_supply_set_input_current_limit_from_supplier()
 - Add fwnode support to power_supply_get_battery_info()

Drivers:
 - ab8500: continue migrating towards using standard core APIs
 - axp288 fuel-gauge: refactor driver to be fully resource managed
 - battery-samsung-sdi: new in-kernel provider for (constant) Samsung batte=
ry info
 - bq24190: disable boost regulator on shutdown
 - bq24190: add support for battery-info on ACPI based systems
 - bq25890: prepare driver for usage on ACPI based systems
 - bq25890: add boost regulator support
 - cpcap-battery: add NVMEM based battery detection support
 - injoinic ip5xxx: new driver for power bank IC
 - upi ug3105: new battery driver
 - misc. small improvements and fixes

----------------------------------------------------------------
Andy Shevchenko (1):
      power: supply: core: Use device_property_string_array_count()

Carl Philipp Klemm (1):
      power: supply: cpcap-battery: Add battery type auto detection for map=
phone devices

Changcheng Deng (1):
      power: supply: ab8500: Remove unneeded variable

Christophe JAILLET (6):
      power: supply: core: Simplify hwmon memory allocation
      power: supply: max17042_battery: Use devm_work_autocancel()
      power: supply: sbs-charger: Don't cancel work that is not initialized
      power: supply: da9150-fg: Use devm_delayed_work_autocancel()
      power: supply: max14656: Use devm_work_autocancel()
      power: supply: max8997_charger: Use devm_work_autocancel()

Colin Ian King (2):
      power: supply: axp288_fuel_gauge: Fix spelling mistake "resisitor" ->=
 "resistor"
      power: supply: ab8500: fix a handful of spelling mistakes

Daisuke Nojiri (1):
      power: supply: PCHG: Use MKBP for device event handling

Evgeny Boger (1):
      power: supply: axp20x_battery: properly report current when dischargi=
ng

Gustavo A. R. Silva (1):
      power: supply: cros_usbpd: Use struct_size() helper in kzalloc()

Hans de Goede (37):
      power: supply: axp288_fuel_gauge: Add dev helper var to probe()
      power: supply: axp288_fuel_gauge: Add axp288_fuel_gauge_read_initial_=
regs()
      power: supply: axp288_fuel_gauge: Use devm_add_action_or_reset() for =
iio chan release
      power: supply: axp288_fuel_gauge: Use devm_power_supply_register()
      power: supply: axp288_fuel_gauge: Refactor IRQ initialization
      power: supply: axp288_fuel_gauge: Take lock before updating the valid=
 flag
      power: supply: axp288_fuel_gauge: Add a no_current_sense_res module_p=
aram
      power: supply: core: Refactor power_supply_set_input_current_limit_fr=
om_supplier()
      power: supply: bq25890: Add a bq25890_rw_init_data() helper
      power: supply: bq25890: Add support to skip reset at probe() / remove=
()
      power: supply: bq25890: Add support to read back the settings from th=
e chip
      power: supply: bq25890: Enable charging on boards where we skip reset
      power: supply: bq25890: Drop dev->platform_data =3D=3D NULL check
      power: supply: bq25890: Add bq25890_set_otg_cfg() helper
      power: supply: bq25890: Add support for registering the Vbus boost co=
nverter as a regulator
      power: supply: bq25890: On the bq25892 set the IINLIM based on extern=
al charger detection
      power: supply: bq25890: Use the devm_regmap_field_bulk_alloc() helper
      mfd: intel_soc_pmic_chtwc: Add cht_wc_model data to struct intel_soc_=
pmic
      i2c: cht-wc: Make charger i2c-client instantiation board/device-model=
 specific
      extcon: intel-cht-wc: Use new cht_wc_model intel_soc_pmic field
      extcon: intel-cht-wc: Support devs with Micro-B / USB-2 only Type-C c=
onnectors
      extcon: intel-cht-wc: Refactor cht_wc_extcon_get_charger()
      extcon: intel-cht-wc: Add support for registering a power_supply clas=
s-device
      extcon: intel-cht-wc: Report RID_A for ACA adapters
      power: supply: core: Use fwnode_property_*() in power_supply_get_batt=
ery_info()
      power: supply: core: Add support for generic fwnodes to power_supply_=
get_battery_info()
      power: supply: bq24190_charger: Turn off 5V boost regulator on shutdo=
wn
      power: supply: bq24190_charger: Always call power_supply_get_battery_=
info()
      power: supply: bq24190_charger: Store ichg-max and vreg-max in bq2419=
0_dev_info
      power: supply: bq24190_charger: Program charger with fwnode supplied =
ccc_ireg and cvc_vreg
      power: supply: bq24190_charger: Disallow ccc_ireg and cvc_vreg to be =
higher then the fwnode values
      power: supply: ug3105_battery: Add driver for uPI uG3105 battery moni=
tor
      power: supply: axp288-charger: Set Vhold to 4.4V
      power: supply: axp288_charger: Use acpi_quirk_skip_acpi_ac_and_batter=
y()
      power: supply: axp288_fuel_gauge: Use acpi_quirk_skip_acpi_ac_and_bat=
tery()
      power: supply: bq24190_charger: Fix bq24190_vbus_is_enabled() wrong f=
alse return
      power: supply: bq24190_charger: Delay applying charge_type changes wh=
en OTG 5V Vbus boost is on

Hong Peng (1):
      power: supply: ab8500_charger: Fix spelling typo

Jiasheng Jiang (2):
      power: supply: wm8350-power: Handle error for wm8350_register_irq
      power: supply: wm8350-power: Add missing free in free_charger_irq

Linus Walleij (20):
      power: supply: ab8500: Drop BATCTRL thermal mode
      power: supply: ab8500: Swap max and overvoltage
      power: supply: ab8500: Integrate thermal zone
      power: supply: ab8500_fg: Break loop for measurement
      power: supply: ab8500_fg: Break out load compensated voltage
      power: supply: ab8500_fg: Safeguard compensated voltage
      power: supply: ab8500_fg: Drop useless parameter
      power: supply: ab8500_chargalg: Drop charging step
      power: supply: ab8500_chargalg: Drop enable/disable sysfs
      power: supply: ab8500_charger: Restrict ADC retrieveal
      power: supply: ab8500_charger: Fix VBAT interval check
      power: supply: ab8500: Standardize maintenance charging
      power: supply: ab8500: Standardize alert mode charging
      power: supply: ab8500: Standardize BTI resistance
      power: supply: Support VBAT-to-Ri lookup tables
      power: supply: ab8500_fg: Use VBAT-to-Ri if possible
      power: supply: Static data for Samsung batteries
      dt-bindings: power: supply: ab8500_fg: Add line impedance
      power: supply: ab8500_fg: Account for line impedance
      power: ab8500_chargalg: Use CLOCK_MONOTONIC

Mark Brown (1):
      power: supply: Use an rbtree rather than flat register cache

Miaoqian Lin (2):
      power: reset: gemini-poweroff: Fix IRQ check in gemini_poweroff_probe
      power: supply: ab8500: Fix memory leak in ab8500_fg_sysfs_init

Micha=C5=82 Miros=C5=82aw (2):
      power: supply: ltc2941: simplify Qlsb calculation
      power: supply: ltc2941: clean up error messages

Ricardo Rivera-Matos (3):
      power: supply: Introduces bypass charging property
      power: supply: bq25980: Implements POWER_SUPPLY_CHARGE_TYPE_BYPASS
      ABI: testing: sysfs-class-power: Adds "Long Life" entry

Samuel Holland (3):
      dt-bindings: vendor-prefixes: Add Injoinic
      dt-bindings: trivial-devices: Add Injoinic power bank ICs
      power: supply: Add a driver for Injoinic power bank ICs

Sebastian Reichel (1):
      Merge tag 'psy-extcon-i2c-mfd-for-v5.18-signed' into psy-next

Sergey Shtylyov (1):
      power: supply: mp2629_charger: use platform_get_irq()

Souptick Joarder (HPE) (1):
      power: supply: ab8500: Remove unused variable

Uwe Kleine-K=C3=B6nig (1):
      power: supply: rt9455: Don't pass an error code in remove callback

Yang Li (1):
      power: supply: da9150-fg: Remove unnecessary print function dev_err()

Yauhen Kharuzhy (3):
      power: supply: bq25890: Rename IILIM field to IINLIM
      power: supply: bq25890: Reduce reported CONSTANT_CHARGE_CURRENT_MAX f=
or low temperatures
      power: supply: bq25890: Support higher charging voltages through Pump=
 Express+ protocol

Yihao Han (2):
      power: supply: axp20x_ac_power: fix platform_get_irq.cocci warning
      power: supply: axp20x_usb_power: fix platform_get_irq.cocci warnings

 Documentation/ABI/testing/sysfs-class-power        |   8 +-
 .../power/supply/stericsson,ab8500-fg.yaml         |   5 +
 .../devicetree/bindings/trivial-devices.yaml       |   8 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   5 +
 drivers/extcon/Kconfig                             |   2 +
 drivers/extcon/extcon-intel-cht-wc.c               | 240 +++++-
 drivers/i2c/busses/i2c-cht-wc.c                    | 120 ++-
 drivers/mfd/intel_soc_pmic_chtwc.c                 |  40 +
 drivers/power/reset/gemini-poweroff.c              |   4 +-
 drivers/power/supply/Kconfig                       |  35 +-
 drivers/power/supply/Makefile                      |   3 +
 drivers/power/supply/ab8500-bm.h                   |  79 --
 drivers/power/supply/ab8500_bmdata.c               |  86 +-
 drivers/power/supply/ab8500_btemp.c                | 342 +-------
 drivers/power/supply/ab8500_chargalg.c             | 418 ++--------
 drivers/power/supply/ab8500_charger.c              |  47 +-
 drivers/power/supply/ab8500_fg.c                   | 145 ++--
 drivers/power/supply/axp20x_ac_power.c             |   6 +-
 drivers/power/supply/axp20x_battery.c              |  13 +-
 drivers/power/supply/axp20x_usb_power.c            |   6 +-
 drivers/power/supply/axp288_charger.c              |  21 +-
 drivers/power/supply/axp288_fuel_gauge.c           | 273 +++---
 drivers/power/supply/bq24190_charger.c             | 158 +++-
 drivers/power/supply/bq25890_charger.c             | 396 +++++++--
 drivers/power/supply/bq25980_charger.c             |   2 +-
 drivers/power/supply/cpcap-battery.c               | 118 ++-
 drivers/power/supply/cros_peripheral_charger.c     |  37 +-
 drivers/power/supply/cros_usbpd-charger.c          |   2 +-
 drivers/power/supply/da9150-fg.c                   |  35 +-
 drivers/power/supply/ip5xxx_power.c                | 638 ++++++++++++++
 drivers/power/supply/ltc2941-battery-gauge.c       |  61 +-
 drivers/power/supply/max14656_charger_detector.c   |  15 +-
 drivers/power/supply/max17042_battery.c            |  12 +-
 drivers/power/supply/max8997_charger.c             |  12 +-
 drivers/power/supply/mp2629_charger.c              |   6 +-
 drivers/power/supply/power_supply_core.c           | 294 +++++--
 drivers/power/supply/power_supply_hwmon.c          |  15 +-
 drivers/power/supply/power_supply_sysfs.c          |   1 +
 drivers/power/supply/rt9455_charger.c              |   2 +-
 drivers/power/supply/samsung-sdi-battery.c         | 918 +++++++++++++++++=
++++
 drivers/power/supply/samsung-sdi-battery.h         |  13 +
 drivers/power/supply/sbs-charger.c                 |  18 +-
 drivers/power/supply/smb347-charger.c              |   3 +-
 drivers/power/supply/ug3105_battery.c              | 486 +++++++++++
 drivers/power/supply/wm8350_power.c                |  97 ++-
 include/linux/mfd/intel_soc_pmic.h                 |   8 +
 include/linux/platform_data/cros_ec_commands.h     |  64 ++
 include/linux/power/bq25890_charger.h              |  15 +
 include/linux/power_supply.h                       | 213 ++++-
 50 files changed, 4118 insertions(+), 1429 deletions(-)
 create mode 100644 drivers/power/supply/ip5xxx_power.c
 create mode 100644 drivers/power/supply/samsung-sdi-battery.c
 create mode 100644 drivers/power/supply/samsung-sdi-battery.h
 create mode 100644 drivers/power/supply/ug3105_battery.c
 create mode 100644 include/linux/power/bq25890_charger.h

--arho6uem3puskgsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmI4vegACgkQ2O7X88g7
+przmhAApksmbtMLb002Leqyu9msKgUYoTbQtHacaTNUE5bhck5TZmSYRsRXiZ1A
L+4Gb6ggO3tknN5SP8UyRKyBf0pH9hdEOWIVUmAFhPXQLOT4/IlS0tiNpOYkonmK
zvASN6+tWKIrVVfothsziENezoF2p942NyF5VZ8VbymUdRFUuMxuGSvB1sBCNbbJ
+84aLekX7lln2Jx0y/8b79Qj8TxaaUAG9uVkTGQhEtWLWKgeFNEhmzT4+0+T6wN8
QyMwKQzBZpRzLcmeIovzDG3DvReLZ5pZiBLWOLz1GpaSs31gJvQ7RKxaccbQLLbw
3eygefZgvons7XP+BVa2zc/OSBhk9z7j1NrAf4xNgj72tUK86vXTpDMmhfCdXgWY
uikjWrFcm7Hx0IJMc8okmF7IBxfiJPxD/er3WlHVwUYnnuQsRxcErUwfznnKXIcl
spiErpTAP6p9WtYqrR/FF28fpQ4EZPI9y6ek8WOjSn58Luul+JwZDbet9WZ8sxeJ
+BdRs9n75EOpvsrXtSzDlyxoF0loj490EaxyEr5dpicil2vrLZ4LgewPr0hV3Eok
X2SMsPXqiItJfG5IiF8qNs9p/7VISOVlnBZuVFc4iq7X7c0SIn3AnvSmMvGSwyAD
+G10um/NZAICPDrSI3+1+zZYKwOMQqbyNJrfJ99ZRo7bkpWLjUk=
=fq9Y
-----END PGP SIGNATURE-----

--arho6uem3puskgsi--
