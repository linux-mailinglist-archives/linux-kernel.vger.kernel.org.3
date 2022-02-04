Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC84A99B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347190AbiBDNHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:07:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34768 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiBDNH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:07:28 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 214D7Hmp025937;
        Fri, 4 Feb 2022 07:07:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643980037;
        bh=5/8eElrg7h584eB+6f9UCi3BdtD9S6GuBldvdO8lgos=;
        h=Date:From:To:CC:Subject;
        b=murMdH+vh1P5MrBPahLaO+Di8oYXegTfghg2Yrig9Dbm4HeHUDKqKQ6EDnfPcScgI
         hNUuSbTQ1AzjeQTa5j9yZHHCzgs6ZfywZyQvskEXnrFO7KhQvmq8oTQVMzqiuFNayQ
         WXL/XkCphVrJeKJ6i8nKsRQM/kdJ3SDsXt5EvJes=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 214D7HZ3070983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Feb 2022 07:07:17 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 4
 Feb 2022 07:07:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 4 Feb 2022 07:07:17 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 214D7G1E073425;
        Fri, 4 Feb 2022 07:07:16 -0600
Date:   Fri, 4 Feb 2022 07:07:16 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL] arm64: dts: TI K3 fixes for v5.17
Message-ID: <20220204130716.fjlm4vvcbtzcwlwx@chalice>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c6vntr75n7ni5m22"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--c6vntr75n7ni5m22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd, Olof, ARM SoC Maintainers,

This PR is a retry of previous attempt at fixing up aliases way late in 5.17
merge cycle for J721S2[1].
  =20
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-dt-=
fixes-for-v5.17

for you to fetch changes up to aee744a37aaf277e74557e683cc524fbe6daeef7:

  arm64: dts: ti: k3-j721s2-common-proc-board: Alias console uart to serial=
2 (2022-01-24 13:40:32 -0600)

----------------------------------------------------------------
Device Tree fixes for TI K3 platform for v5.17 merge window

* Update J721S2 platform to switch serial aliases to ttyS2.

----------------------------------------------------------------
Aswath Govindraju (2):
      arm64: dts: ti: k3-j721s2: Move aliases to board dts
      arm64: dts: ti: k3-j721s2-common-proc-board: Alias console uart to se=
rial2

 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    | 14 ++++++++++++--
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi              | 22 ------------------=
----
 2 files changed, 12 insertions(+), 24 deletions(-)

[1] https://lore.kernel.org/lkml/60e9a3ef-f717-bd2a-b722-01942e184fd0@ti.co=
m/

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 8=
49D 1736 249D

--c6vntr75n7ni5m22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmH9JP4ACgkQ3bWEnRc2
JJ2rbw//VPgYkYxdpwUItvjTWi4k+1Gfdraedm9GPamPKsqQi42viwVq/R/3JuuO
YaQk++1GymYAk5XIQFiba1GhIiQUnyiH1KDUcjOnnJeAM7V5NPRGQ7rEUgGyEcSi
bRYvTdpVLFqW+uClGLubKIw59Z3l8P8+KZDoYmhl+1DoWkYAIPOXcBN5tEVzldOV
WrZWIYxVujX9TrNNhetEvKo1A7ZvWpD4bfleLTYLLUFaEiRycprJ/fbZ2xO0qwyF
XRSFIYF+Q+xucKH1tUy3RfjOSpXKHbps+/zfo3fIHEwKMlVXhOs8d6V8ehEc/qKC
0Tk/Vl8bqfImRDwqiaS0Mlh7IqhIYKfhWoAep2zYr6sKsCz9iN09vbRe3yDnGwLM
/tWo3Qne/t2mx88BXpvF0XgeDdFQG63Sh4jmXqkSd40TD8tsRN2NrzCcNuH1A4zW
InTz/54fIg+0wfGQPcxPYqRiQlYlT2wdmt/wjmSZDBEkIYVnZTDpj6XtKBXk4/Fw
N/pDaeRtmk3zx9P0ohQsuqz2tJRJOKpp8y4raH/cxRQf9zxcI7G8KWCOo3ApJ8hW
FD+2WodX1Z7Q2jEkEP/b7tlvDSWlC7K22Df5ug4ivzjwBgOiDEyyO02bonnIlSmG
eCpZ5TCINY/IFEFkMNCRgU23W4h/8CeXwgQCyNUvNDT1jQRtK2Q=
=jo4t
-----END PGP SIGNATURE-----

--c6vntr75n7ni5m22--
