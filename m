Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8948959E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiAJJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:48:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52326 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243256AbiAJJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:48:15 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 182CA61230;
        Mon, 10 Jan 2022 09:48:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 462A260E9C;
        Mon, 10 Jan 2022 09:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641808094;
        bh=U/jYykCwrdRALpOYDLDxmcZRWhrau4yen2V9+zz1eaY=;
        h=Date:From:To:Cc:Subject:From;
        b=WgT/Y4vy/KdsI9TRDwQIe92xblAs+f6kWEp5R0/uV4UI727/10wQX7Hq8V5t+wRwJ
         SvKHON1RYgQz3S3DrKuzhttS8vh9WQjWAFaZs7YBFONpJiicojppE5Kglg3qAcy45n
         jVQ6PCcIl5f5RfjK72u2X4ac5GXiD4euoGdcx3tcqDBkrAOAyewRUNx3kp+Em1nYNq
         dViuh3O9ceBk/yGVWu9Gv41QOn3oEh8kzrMFTCBFzxvTxKTwlXdNdyf7fZjIIiUkct
         74/GC8arGPpAyDHwol46+4i82xMfFHPk9s6AD1nBE+odSHQyO7HwYOow4fOewk0cmI
         4fWpwQZkdKl8A==
Received: by earth.universe (Postfix, from userid 1000)
        id 49CCF3C0CB7; Mon, 10 Jan 2022 10:48:12 +0100 (CET)
Date:   Mon, 10 Jan 2022 10:48:12 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] power-supply changes for 5.17
Message-ID: <20220110094812.4rtl2ltyaow7hgla@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wieyd2kpie6pevce"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wieyd2kpie6pevce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

In addition to these changes some power-supply core changes will be
part of the X86 platform drivers pull-request, which contains
changes to the thinkpad ACPI driver. No merge conflicts have been
detected in linux-next.

-- Sebastian

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.17

for you to fetch changes up to 25fd330370ac40653671f323acc7fb6db27ef6fe:

  power: supply_core: Pass pointer to battery info (2022-01-03 18:53:10 +0100)

----------------------------------------------------------------
power supply and reset changes for the v5.17 series

power-supply core:
 - introduce "No Battery" health status
 - use library interpolation
 - add power_supply_battery_info documentation
 - migrate power_supply_battery_info to be fully heap allocated
   making it more obvious that it needs to be free'd manually

Drivers:
 - max77976-charger: new driver
 - qcom-smbb: add pm8226 charger support
 - bq25890-charger: support battery temperature readings
 - ab8500: continue migrating towards using standard core APIs

----------------------------------------------------------------
Angus Ainslie (1):
      power: bq25890: add POWER_SUPPLY_PROP_TEMP

Christophe JAILLET (1):
      power: supply: ab8500: Fix the error handling path of ab8500_charger_probe()

David Heidelberg (1):
      dt-bindings: power: reset: gpio-poweroff: Convert txt bindings to yaml

Jiasheng Jiang (1):
      power: reset: mt6397: Check for null res pointer

Linus Walleij (19):
      power: supply: core: Use library interpolation
      power: supply: core: Add kerneldoc to battery struct
      power: supply: ab8500: Use core battery parser
      power: supply: ab8500: Sink current tables into charger code
      power: supply: ab8500: Standardize operating temperature
      power: supply: ab8500: Drop unused battery types
      power: supply: ab8500: Use only one battery type
      power: supply: ab8500: Standardize design capacity
      power: supply: ab8500: Standardize technology
      power: supply: ab8500: Standardize voltages
      power: supply: ab8500_fg: Init battery data in bind()
      power: supply: ab8500: Standardize internal resistance
      power: supply: ab8500: Standardize termination current
      power: supply: ab8500: Make recharge capacity a constant
      power: supply: ab8500: Standardize CC current
      power: supply: ab8500: Standardize CV voltage
      power: supply: ab8500: Standardize temp res lookup
      power: supply: ab8500: Standardize capacity lookup
      power: supply_core: Pass pointer to battery info

Luca Ceresoli (3):
      dt-bindings: power: supply: add Maxim MAX77976 battery charger
      power: supply: core: add POWER_SUPPLY_HEALTH_NO_BATTERY
      power: supply: max77976: add Maxim MAX77976 charger driver

Luca Weiss (2):
      dt-bindings: power: supply: pm8941-charger: add pm8226
      power: supply: qcom_smbb: support pm8226

 Documentation/ABI/testing/sysfs-class-power        |   2 +-
 .../bindings/power/reset/gpio-poweroff.txt         |  41 --
 .../bindings/power/reset/gpio-poweroff.yaml        |  59 +++
 .../bindings/power/supply/maxim,max77976.yaml      |  44 ++
 .../bindings/power/supply/qcom,pm8941-charger.yaml |   4 +-
 MAINTAINERS                                        |   6 +
 drivers/power/reset/mt6323-poweroff.c              |   3 +
 drivers/power/supply/Kconfig                       |  12 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ab8500-bm.h                   | 123 +----
 drivers/power/supply/ab8500-chargalg.h             |   8 +-
 drivers/power/supply/ab8500_bmdata.c               | 575 +++++----------------
 drivers/power/supply/ab8500_btemp.c                |  65 ++-
 drivers/power/supply/ab8500_chargalg.c             | 315 +++++------
 drivers/power/supply/ab8500_charger.c              | 544 ++++++++++---------
 drivers/power/supply/ab8500_fg.c                   | 373 +++++++------
 drivers/power/supply/axp20x_battery.c              |   6 +-
 drivers/power/supply/bd99954-charger.c             |  24 +-
 drivers/power/supply/bq24190_charger.c             |   6 +-
 drivers/power/supply/bq2515x_charger.c             |   8 +-
 drivers/power/supply/bq256xx_charger.c             |  24 +-
 drivers/power/supply/bq25890_charger.c             |  37 +-
 drivers/power/supply/bq25980_charger.c             |   6 +-
 drivers/power/supply/bq27xxx_battery.c             |  38 +-
 drivers/power/supply/cw2015_battery.c              |  20 +-
 drivers/power/supply/ingenic-battery.c             |  14 +-
 drivers/power/supply/max77976_charger.c            | 509 ++++++++++++++++++
 drivers/power/supply/power_supply_core.c           |  80 +--
 drivers/power/supply/power_supply_sysfs.c          |   1 +
 drivers/power/supply/qcom_smbb.c                   |   5 +-
 drivers/power/supply/sc2731_charger.c              |   8 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           |  22 +-
 drivers/power/supply/smb347-charger.c              |  34 +-
 include/linux/power_supply.h                       | 218 +++++++-
 34 files changed, 1847 insertions(+), 1388 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
 create mode 100644 drivers/power/supply/max77976_charger.c

--wieyd2kpie6pevce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHcANQACgkQ2O7X88g7
+ppciw//cC3ajHnCIxQ+x8belEgEbnIqXKSbUpUxO9mta+jI0V5pDKD7X172g5uo
+NqUgi5di98YVKvmRsC7BBclOxOwDDyUn7IUm1G3vHgiSHhxYtbO5+1+gWghYMMI
9etHnqKqu9JKaOsR7/Ay1KbMYA0dPSDMt2LIzIAtq61bgHYDyV5DPA0xxCOWL3mL
/0pXDUNJNmxzdJuFjtK51ENjG1/L5h4f3aZjYC+mfB36PmtZo7llPnffMmgKdWXK
bJAkvTOX7RGpx2wjemBANDJmsWO216LTrNGHQhSPZmgNzCYerOuOYcZNer7ll+O3
vsNPtX2qR2koc3Q/P565L5F5+R5k+cZ+DAFR/SBGTPBAkBmZDtFDtwVLVBrcUXER
BvrXUTFnJWAzOOAYdkBf3LcWKUIRAdaAoUPf85vz+xXTf187VHYjoPUsHoicViuP
DSmiuH1PDa2vWxHo+TP9Hinrf4tcFYYcxirsZ5SLVsQeTeIMD2gzQtDOV1bINdS5
itIW2yYPv9Lnl0HtoUInvS6LMgINU3csxfrGCl0d2iWuHoGa7QFH+BizUaUfGCEN
FwktUEcfm+ZP5Cx/yv+/QLCN/ibYqBAM7oTNc52md02N+C5L8QB8ewPCIaoZz13h
qe16zqcUBKU5FLYlJ6cNZdFNFCsOw6E+o4pup1UXI9GZTqeZdjk=
=eclG
-----END PGP SIGNATURE-----

--wieyd2kpie6pevce--
