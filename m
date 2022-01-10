Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7F4895AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243222AbiAJJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:50:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52916 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiAJJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:49:27 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFD1A611BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:49:26 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2378F60E76;
        Mon, 10 Jan 2022 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641808166;
        bh=uSHXY6zedzH8cNlswrAkR727GYB0CEqmB4IEIQdk2pA=;
        h=Date:From:To:Cc:Subject:From;
        b=K7ouA7RMtF6Ol6AKEdZ1i6aXKAx2mnmouSfGO8db4QFp5OWzNh5XmoEy+s7P/X+Z6
         hltcrr9yMvXa3px+cZDA/v9ayt8MegEBz0qCOLPiDO47t++2OGA5U+dupr8JGGzM6H
         p7q5Qfz66w9e5s1GIWk+cJiwiEEw9qXqOD3YEy58hGDuh2Zq6pUVClbV/CCwd1lC6K
         0GUGqLxi8RBoH7w6dOnn2gcM3livSMqB/pofeTFvL39NliF3Fox3eZrXf9J4OcL/nQ
         m3AH+K1JIGSnX3Ik/AMzXwVMqpswGAblXsGLA2tfr61DYs5n6Uyog25mR8SxGwiRWm
         Sv13O8nzLEzAA==
Received: by earth.universe (Postfix, from userid 1000)
        id 7BE493C0CB7; Mon, 10 Jan 2022 10:49:24 +0100 (CET)
Date:   Mon, 10 Jan 2022 10:49:24 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-5.17
Message-ID: <20220110094924.2s4tczld5jjroeu5@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j75kbuwu4g4kouva"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j75kbuwu4g4kouva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.17

for you to fetch changes up to a1ee1c08fcd5af03187dcd41dcab12fd5b379555:

  HSI: core: Fix return freed object in hsi_new_client (2021-11-26 00:27:06 +0100)

----------------------------------------------------------------
HSI changes for the 5.17 series

* avoid returning free'd object in hsi_new_client error path

----------------------------------------------------------------
Chengfeng Ye (1):
      HSI: core: Fix return freed object in hsi_new_client

 drivers/hsi/hsi_core.c | 1 +
 1 file changed, 1 insertion(+)

--j75kbuwu4g4kouva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHcASQACgkQ2O7X88g7
+prPaA/9Fgszpk96BQCmQM3vMXLpofx+DB+IA6Oo5azIEisfaqIvtOqL1ATXLzD1
jTaK0XYPjITM0uPfE6PQCzZCrmtwjmj82ERsvD3Dsjo5GKjlB30uRfvBPt+nt4Tk
uurX2/WDVDLOGt45lyiYH7k6D0h7CRoX/vgx2FrzNbkApl3wbkuMz6ZolUbidVMb
hTGQp32MV5cf22r0UbUhmeTPG5FYkcjQYSxQk9GJCq4iGJPKl4yRZVflfEVu2964
Qv4ka7wGe/5wRZZ5l2cassIKauLpMmNOzk0j+55IsTygaLYwf7wvf2EPnU3x6fdi
kAcNr48ff8iaoWOEwAmIW37IeA3JWyebmgf/7zGLg6c2tx/mwxFRYPs5GgsvYa7l
si56vOgT1uHMRxRi1Cihf0rq7d5rnDQYza/waPKQZxmLSI2CvTHxcNR5EBtB5jgX
YPVRsRKWiKPuHx/QkNIyp3VoqC7kI0WXRGgOaz3ltIIj/IPkgFpgmMCv2ALtcUET
aesPgSuIAyZTGPaHWMOSl+URMOeB6h7vaNLpGgYgcfE0+saYnWObTlbENLL3oRMa
J9Dd5fQfPELNWiIZp4IXtNYUA+6Ts0rUDgV1RilBvirOe4YYE9lKippoDrP2s2Ur
KMPBnmbEnPf9OQyF9lGkKgsEd9iPVINUGkXoRBqvTnvDXE/NtnA=
=cA4T
-----END PGP SIGNATURE-----

--j75kbuwu4g4kouva--
