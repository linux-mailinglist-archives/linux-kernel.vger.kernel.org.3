Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EC8479053
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhLQPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:49:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36064 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLQPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:49:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BHFnM6s029708;
        Fri, 17 Dec 2021 09:49:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639756162;
        bh=4pYxJxhBHMq/73kWjs9EjhmqLVPAy3cyIv6wEjlp744=;
        h=Date:From:To:CC:Subject;
        b=Sv5NrtQb4FX5qBsZa0K2D3VS4o8TGOOg1iFOZEhqrKHN75IpDnWzvpLf3yq64zkba
         xgUdH70C+qNgR+oyPW3rmNLkaXCXazPgNf/gCmGlPhKejZ8z/N4ijQz8Aq3hXtUOof
         HmwLfUvWf54baKk2ctDJA+AwUPL8eavObuyAmn4U=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BHFnMqv104578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Dec 2021 09:49:22 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Dec 2021 09:49:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Dec 2021 09:49:21 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BHFnLjX056068;
        Fri, 17 Dec 2021 09:49:21 -0600
Date:   Fri, 17 Dec 2021 09:49:21 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC:     <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] soc: Keystone driver update for v5.17
Message-ID: <20211217154921.cagzppcensxx6wm4@pension>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z3i67kzdfkksd6bv"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--z3i67kzdfkksd6bv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driver=
-soc-fixes-for-v5.17

for you to fetch changes up to 1bb0b8b195d821d009bae61248da14f2b17bd44a:

  soc: ti: knav_dma: Fix NULL vs IS_ERR() checking in dma_init (2021-12-16 =
06:34:07 -0600)

----------------------------------------------------------------
SoC: Keystone driver update for v5.17

* k3-socinfo: Add entry for J721S2 SoC family
* Misc fixups for tisci, pruss, knav_dma

----------------------------------------------------------------
Aswath Govindraju (1):
      soc: ti: k3-socinfo: Add entry for J721S2 SoC family

Jan Kiszka (1):
      soc: ti: pruss: fix referenced node in error message

Jason Wang (1):
      firmware: ti_sci: rm: remove unneeded semicolon

Miaoqian Lin (1):
      soc: ti: knav_dma: Fix NULL vs IS_ERR() checking in dma_init

 drivers/firmware/ti_sci.c   |  2 +-
 drivers/soc/ti/k3-socinfo.c |  3 ++-
 drivers/soc/ti/knav_dma.c   | 20 ++++++++++----------
 drivers/soc/ti/pruss.c      |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 8=
49D 1736 249D

--z3i67kzdfkksd6bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmG8sXkACgkQ3bWEnRc2
JJ2WIA//aPoshbTaIgUcszTmDDShJVZeJRWRQFPPdDPM/KoHCXlvm+ZvMpvyVQVN
Lf6fM3r4AwJlp35VXTLCPoJdgfGO3MFhD5HcVgXQRzFZt6YSJF5Bg/9PSyK5pUEG
r/V4T6xRSbbOgpxrLXtxKPfevPiM0lV36XEO/ay/a1OveCiCT6G0oXnkeKWfI+VT
85hBOi7YKTsKHzH79Rm7MIfNknAuRpfroZH0qwOXiWpgeQejOB+gjD8li64le1ZG
4hFpuKdZlzRRk6wzCv9rb+uAX+0LcSSFmhw1eNIvIG1Xz0TVIqsDcKUy4ALtsTwO
cNabW5YWrdvS8vFRmc0beb5PQqYxyhUAsCxeR7bl0HIqrMlmvWL4JKedf2wSj7rY
pWTBuOUPaldxyuMfEcIGWrYaO3RvQwkWBkOnakQ428nGjllP5vQWr1GvrCHlnNrO
ayxBn97KYvIgZZJ9PcNh+yw/LHBVfSX9ycrxGY45Af501RHSbNs4qPPQ847Z2qF/
C95bOeyP+R6NjDHxcQ1rg8hRpjXhO2zzg5fAQQZKXJqjzHnQHtOJtbPcLxFqzLIz
ATpJ6ZCGGQ5X+KYfHmGtl68N1jJoPU/j4FP/IuOnUlkhGSOpV0QramRQ0AizFFOJ
oJG7pVmvNBNBftZFW0k83PoqIBhBn35s9MJoqDKbutzzMfoOoZo=
=V2TL
-----END PGP SIGNATURE-----

--z3i67kzdfkksd6bv--
