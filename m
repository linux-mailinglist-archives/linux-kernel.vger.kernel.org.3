Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB0853ADF4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiFAUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiFAUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE321D502C;
        Wed,  1 Jun 2022 13:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A399615DA;
        Wed,  1 Jun 2022 20:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27E5C385A5;
        Wed,  1 Jun 2022 20:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654114446;
        bh=ANEZGcC38fks5Sbmq7hFARmRKNzmPSYj5weqOHWaC7U=;
        h=Date:From:To:Cc:Subject:From;
        b=DbLxkgWvqnFalgNPxRu92f7qC3o0VDMSTwCtOBSrBwYpHvfO+xmIlTIKOzoBah1/I
         R6OmGReJRlya0AwJRjpnGNK8+lgax09VuHPcSvcrOr3L9EmiKm9+zcevuK2w8qQhI6
         vw/B8bBoj0l+8mfK081S8ap4iuH2ZpkhujIEmVshyvcDpb5Hi9FHghkDDXA3Iv0YRb
         biXGU1Ni9rr4CY7uHL1tF8CSCAzMjGytrxmumik2chknBoiO33bhHSJlgy4gvACcXK
         +uvbJMNrVsNppsns+N19pU2CVEpzqsM76KaQVg5uv1bGTZfi/SEhKZ46jv3S6WjgOY
         f7po3Ozi14pnw==
Received: by mercury (Postfix, from userid 1000)
        id 28E8B106043A; Wed,  1 Jun 2022 22:14:04 +0200 (CEST)
Date:   Wed, 1 Jun 2022 22:14:04 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.19
Message-ID: <20220601201404.nc66eejtt4tuvre6@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lpdghi3maawhqvbc"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lpdghi3maawhqvbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Not much from the power-supply subsystem this time around, since I
was busy most of the cycle. The pull request also contains some
fixes, that I originally planned to send for 5.18. Apart from this
there is nothing noteworthy.

Thanks,

-- Sebastian

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.19

for you to fetch changes up to da50aad6d86716aa48a2b8463c85caea77c0355f:

  Merge power-supply 'fixes' branch (2022-05-22 23:03:29 +0200)

----------------------------------------------------------------
power supply and reset changes for the v5.19 series

power-supply core:
 - init power_supply_info struct to zero

drivers:
 - bq27xxx: expose data for uncalibrated battery
 - bq24190-charger: use pm_runtime_resume_and_get
 - ab8500_fg: allocate wq in probe
 - axp288_fuel_gauge: drop BIOS version from "T3 MRD" quirk
 - axp288_fuel_gauge: modify "T3 MRD" quirk to also fix "One Mix 1"

----------------------------------------------------------------
Hans de Goede (2):
      power: supply: axp288_fuel_gauge: Fix battery reporting on the One Mix 1
      power: supply: axp288_fuel_gauge: Drop BIOS version check from "T3 MRD" DMI quirk

Linus Walleij (2):
      power: supply: core: Initialize struct to zero
      power: supply: ab8500_fg: Allocate wq in probe

Minghao Chi (1):
      power: supply: bq24190_charger: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Sebastian Reichel (1):
      Merge power-supply 'fixes' branch

Sicelo A. Mhlongo (1):
      power: supply: bq27xxx: expose battery data when CI=1

 drivers/power/supply/ab8500_fg.c         | 19 +++++-----
 drivers/power/supply/axp288_fuel_gauge.c | 41 ++++++++++++++++++---
 drivers/power/supply/bq24190_charger.c   | 63 +++++++++++---------------------
 drivers/power/supply/bq27xxx_battery.c   | 60 ++++++++++++++----------------
 drivers/power/supply/power_supply_core.c |  2 +-
 5 files changed, 95 insertions(+), 90 deletions(-)

--lpdghi3maawhqvbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKXyIgACgkQ2O7X88g7
+po7pw/7B6fLcS5QfB5FPJaZ5e83qYO4zDsyJNqM7b3S6NTflIWkczFcMDcDm3ee
cb6LKD9vLYaZGktAHWDcl2Wr4Br9V8bTuUe/ODfJsDdP8PL0XTnS02cfpgFxgMUx
YxuYxXPsVWFLg5OfBN0e04Pw+qG1yJAKJN7FMMMOutNWGXcm+3T4dvvUNhTGjXYf
gomAMAjRec6ZImV3eroa36hNcDAfoPo72JKMMQOuGKAa3Al/lK5iZQchqIpvT0BH
Aw0oAdV5Evuf8RPq8Lvpg5ngLPcgNThwvBT+Vm9KSv7U1QA7BFN3WaInefKVyvDH
zXPfOrBoUtFz59MtN8wHHaFOYnwMY118SONbYloUr17n6Yn+olzlYsuzbPwVfQaf
AfJOHfHIffzyRBA8O6e4SAkT2xLjJ/XbyD9qglj3icHEtJRj3EE7w3QTLD9u0VXN
kl2/e6/uz4OFkTNn6PXSvogdOuaQ6fkMMElvHU+netVCSJ2sMC65/OIAsdtcNaCg
JW4ltSC3CQKwlJLv+umaD/UZkduPCkXWbOVfSzoL0JVtt5Qxe0xZzDwAMFEX1biW
tFsaaOCHGE8TT7mcTcLaVdrmGvertzoqwQZQy8JRyLzZ+kriA3+Jh15tegOSHoQq
HXS6MFE/K+oSOyku21DCIvT0yodYi/Dm/8R8uaKwpZp4dcTZRIE=
=0syY
-----END PGP SIGNATURE-----

--lpdghi3maawhqvbc--
