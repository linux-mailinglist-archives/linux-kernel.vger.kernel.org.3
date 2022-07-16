Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B579E57724B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiGPXYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiGPXYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:24:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5502411A06;
        Sat, 16 Jul 2022 16:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC25AB80D1D;
        Sat, 16 Jul 2022 23:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB36C34114;
        Sat, 16 Jul 2022 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658013889;
        bh=4yqvWxo08w1CoF1L0ShkzH6OzldtRf0WYqEarUJQhtE=;
        h=Date:From:To:Cc:Subject:From;
        b=eeh7cBPyjmXQsIoA24KohGqqjFabVdHbrGcfwCs5GUfduhzGvicc+iwF1G8EttVRS
         7sR8lisUvFVm9+Hq4T96oU0RGKuqQ14QZP4/IR017oDGXWAMCMtaRXUtU2Q+ia5k3z
         /UbcNt3LD1lt5eNuxjnhBFMmz6U+m/68oIh86/MQFpjLRAWyrBxWYrXnCjP/XFKQ35
         pn/huT4buFJHuIN1Iqkxz0Ztp1ekGORaBB/4/S9SxHbL31FPECgMcyy5vDEuiQWpi0
         UOX3bnb4uVXyhp3PzbsRGX1477ZRbQejytLl8tyVsuLdl8dKljbgx4EMkofX9fLRov
         73HUk2DYpqYsg==
Received: by mercury (Postfix, from userid 1000)
        id ABBF71060428; Sun, 17 Jul 2022 01:24:46 +0200 (CEST)
Date:   Sun, 17 Jul 2022 01:24:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.19-rc
Message-ID: <20220716232446.ndivv2hcrufezcz6@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jbylxks2ur7n5ftu"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jbylxks2ur7n5ftu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.19-rc

for you to fetch changes up to 093d27bb6f2d1963f927ef59c9a2d37059175426:

  power: supply: core: Fix boundary conditions in interpolation (2022-06-09 21:08:38 +0200)

----------------------------------------------------------------
Power Supply Fixes for 5.19 cycle

Fixes for the 5.19 cycle:
 * power-supply core temperature interpolation regression fix for
   incorrect boundaries
 * ab8500 needs to destroy it's work queues in error paths
 * Fix old DT refcount leak in arm-versatile

----------------------------------------------------------------
Dorian Rudolph (1):
      power: supply: core: Fix boundary conditions in interpolation

Gao Chao (1):
      power: supply: ab8500_fg: add missing destroy_workqueue in ab8500_fg_probe

Miaoqian Lin (1):
      power/reset: arm-versatile: Fix refcount leak in versatile_reboot_probe

 drivers/power/reset/arm-versatile-reboot.c |  1 +
 drivers/power/supply/ab8500_fg.c           |  9 ++++++++-
 drivers/power/supply/power_supply_core.c   | 24 ++++++++++++------------
 3 files changed, 21 insertions(+), 13 deletions(-)

--jbylxks2ur7n5ftu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTSL4ACgkQ2O7X88g7
+prH4Q/+KdirbMJiMXWRwrTmqA22Jg8miyOHfWaSUCieC48dTeptiasFdxcWdDTw
CZ921RuFKXWyMzOV5/OyGaD2fVB6pK1CF7QwgAwhXpGOOc1f+gs4v1GjPLmjtJbl
zYFQCHx+vZ6CUoz9G7Dgw8Z3K8TOm6lC2VInANX8VrUmeHwDzjdFufjMYMPDMVz/
7bQlyKrai3e2tTRhFB7g6Yd2FHiDTp9PKCp3oWudTNEAfRk2Pdax0Wib86hr9UF2
db83xlPV41JjP+S+9D2c7cHPnI/6eg4i6EPwEVskWXLLcRjC+8V1GMhm1tlGwQxV
6iKCsMWghchnjaO3Z3ddRWyaRACcXPkqJIqp4kCSdXcXTU+y68sWz+Idg/rWtQ0p
kt/mOnux8VD1A118G4/dRHnOBcO2fO6KG65q9ZsIblovobTb+2NgSyDzSojPKdp7
ww0QNN5Len1kakyij1vewe/em8S+ZmtuYiJnPrjVjtettlJNxVIcyc4IR6isFnFi
+jLE6pYp+IoX5AF90FRAnguxykjEfmbYYBkikvV2sy94VV6tgC/zfUYO5Il0/ahV
sOV77E8NWV7WqqqnjieGc+CqMIdJCaG57/v6uqQNcN9HLS8GMacIa5AzC9X0wcG2
qKkWx2k35mtrK3+SDSmaLbdy2cDsqPQm9U+2yAsNivCXCoyGYDM=
=3pr5
-----END PGP SIGNATURE-----

--jbylxks2ur7n5ftu--
