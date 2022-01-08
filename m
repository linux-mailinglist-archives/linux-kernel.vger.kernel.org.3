Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E820B488332
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiAHLWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiAHLWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:22:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414D1C061574;
        Sat,  8 Jan 2022 03:22:33 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C741560EC9;
        Sat,  8 Jan 2022 11:22:32 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07BD460F02;
        Sat,  8 Jan 2022 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641640952;
        bh=rRXvfFxR3p3YXRPs+6mfHzb/NOOpyh9Znem6mMhRwk0=;
        h=Date:From:To:Cc:Subject:From;
        b=pbybb7hPl1/zh2gWLasy0e0Z1jo0p997b3oPgm5lsrIHnMcFAkK9kJVhpCWbuTh/4
         vuS5cqjKlD1nlDoZGc61oXc8GmDe2nemhmF1jkLWwDZUDk4M5Xs3gl3hp1PGqiMAgU
         7/T1M6fPJGb2mrYAXsfGgJJzOaSyaxeXXvJAiaT+Rrt7le3To7HivzhoUESNzWekL3
         ANox8dzqWZYsSKc4Rp5juzn4Rnycwp0Al91quLGnecna7IFHLN+XfKtuYtm2+IWmIg
         FI4x8lL10boJLzkks6xVU4+OichAmxJJMvqyt0Lov0aR2gkZklM3tvmtpN26v87IlQ
         6Z4UUAHDJQLRQ==
Received: by earth.universe (Postfix, from userid 1000)
        id DCE3A3C0CB7; Sat,  8 Jan 2022 12:22:29 +0100 (CET)
Date:   Sat, 8 Jan 2022 12:22:29 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply fixes for 5.16
Message-ID: <20220108112229.v3d7enmuibypa5tm@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umpcgks4hy5n6npl"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--umpcgks4hy5n6npl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.16-rc

for you to fetch changes up to 644106cdb89844be2496b21175b7c0c2e0fab381:

  power: reset: ltc2952: Fix use of floating point literals (2021-11-16 15:22:39 +0100)

----------------------------------------------------------------
Power Supply Fixes for 5.16 cycle

Three fixes for the 5.16 cycle:

1. Avoid going beyond last capacity in the power-supply core
2. Replace 1E6L with NSEC_PER_MSEC to avoid floating point calculation
   in LLVM resulting in a build failure
3. Fix ADC measurements in bq25890 charger driver

----------------------------------------------------------------
Linus Walleij (1):
      power: supply: core: Break capacity loop

Nathan Chancellor (1):
      power: reset: ltc2952: Fix use of floating point literals

Yauhen Kharuzhy (1):
      power: bq25890: Enable continuous conversion for ADC at charging

 drivers/power/reset/ltc2952-poweroff.c   | 4 ++--
 drivers/power/supply/bq25890_charger.c   | 4 ++--
 drivers/power/supply/power_supply_core.c | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

--umpcgks4hy5n6npl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHZc/UACgkQ2O7X88g7
+pqPHg/+KVJi7sJTL0LeSRIejsqvvGts0bJRT0Q2ZJv4BvcZB/JLMSXX7sxfae2v
J4r+pbq/KiaRVEWQTdpsYuxPm/HRrUgGi+26y4QbyVDxXzQA3faSPaurWMkgH3F1
Jf7wXbWp96ZegX5Xy1EBCkZp1xrRFCvs7rm/0Arx9loKyrzO3FcbXDF/Wwm94huM
gpcJIuunIbD37nSuRsl/ok1ryTmhocupF7PzOr9Do3/xbkjp80ACIE1Ig8kyq1lp
1YSTzRk23PACDZD0diCgGKVazrIutc4/Vr4/mo1iXIJLbuh4cqK1SxociwGV8My9
cE0yCPnqAs9Yr31JA8vWrUqieXylck9P6zoX9p1+NaW33ME/PDfyPAxkM2D71RmT
rhmPseRSf1gBfOlChCR1ArVyajt5Jvwurz1p5OXuHS5jkNSTwekXi69RyHo6YNoO
h3AiuCtjjW7GTPiQKhj6/lyK3ZeoO4kcOXmEQIHjnwiqC+s24N/Mq8KStneGfk2F
usrpQBlBtNLlxkTfckfWMyDPud+sIjvD5n+rpTbhc0nli+yT+KcHrIs5NCY7qTJl
APf7+f9X/eyj4xejNaKoCPRGXC+8cMp+aYQUgVMQrlRqAPU/9ZwY1X948CrDTA4K
QikttW4+4UEMHPgyEzx3wc7w1dBdMiU6hOFuyMUsUTpAQ3qCz9k=
=tL27
-----END PGP SIGNATURE-----

--umpcgks4hy5n6npl--
