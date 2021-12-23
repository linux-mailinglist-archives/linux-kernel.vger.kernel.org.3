Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8B647E0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbhLWIzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:55:03 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60530 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhLWIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:55:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BN8svLR012320;
        Thu, 23 Dec 2021 02:54:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640249697;
        bh=MAexO+PYsxzMl0a2eYUCxmbuJwH0ZBBPTo7IPT6ob0A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kjzRQgQvaq68HQlxsT8cJkK76LVHVVnCK/ypVKuFRnHWwd1KzFUoOaPi5HOu+MP9v
         OvJ8z+0AKEPuCl9vt7vNZCAfnHyy3HF3FkmgMPxTJJ04KsPcsY/uxwnMNpEIarCJrU
         5aIVcxxpmG4YnFObSdAlpmxo8FvVI3vM7lijflF4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BN8svbY113123
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 02:54:57 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 02:54:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 02:54:57 -0600
Received: from uda0132425 (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BN8ssqJ076776;
        Thu, 23 Dec 2021 02:54:54 -0600
Date:   Thu, 23 Dec 2021 14:24:53 +0530
From:   Vignesh R <vigneshr@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] J721S2: Add initial support
Message-ID: <20211223085453.GD7862@uda0132425>
References: <20211207080904.14324-1-a-govindraju@ti.com>
 <163955230562.15251.10921015972649910083.b4-ty@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <163955230562.15251.10921015972649910083.b4-ty@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 02:08:04PM +0530, Vignesh Raghavendra wrote:
> Hi Aswath Govindraju,
> =20
> On Tue, 7 Dec 2021 13:38:59 +0530, Aswath Govindraju wrote:
> > The J721S2 SoC belongs to the K3 Multicore SoC architecture platform,
> > providing advanced system integration in automotive ADAS applications a=
nd
> > industrial applications requiring AI at the network edge. This SoC exte=
nds
> > the Jacinto 7 family of SoCs with focus on lowering system costs and po=
wer
> > while providing interfaces, memory architecture and compute performance=
 for
> > single and multi-sensor applications.
> >=20
> > [...]
> =20
> I have applied the following to branch ti-k3-dts-next on [1].
> Thank you!
> =20
> [1/5] dt-bindings: arm: ti: Add bindings for J721s2 SoC
>       commit: 6b1caf4dea3e0a961b7a11cff6757ff74c1c34ea
> [2/5] dt-bindings: pinctrl: k3: Introduce pinmux definitions for J721S2
>       commit: beba81faad86fc2bad567b1c029d6a000a43ca78
> [3/5] arm64: dts: ti: Add initial support for J721S2 SoC
>       commit: b8545f9d3a5426a5f76814c8aaebc5cb46a3213a
> [4/5] arm64: dts: ti: Add initial support for J721S2 System on Module
>       commit: d502f852d22af1ca33e7a2fedd7426831f6dbaef
> [5/5] arch: arm64: ti: Add support J721S2 Common Processor Board
>       commit: effb32e931dd4feb8aa3cee7b5b4ddda43c8b701
> =20

Dropped in favour of v4

--=20
Regards
Vignesh

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmHEOVMACgkQxEYeRXyR
FuMeCAf/XkqFZR/5h46LQQNhODf3Sgw+Y8WkqSV5QAyhjKlWUkQegVFjbzVI6nKY
+jmg5IoS/FCH+v98FcY3KawDl3IqnE8jhOZhzZYM5WPgIi2sLgv6cKImTL3TAUVb
C/7fjshpmhPTFIc05hfq0qNQKRWkysU8VGpzIfcdBR9VlwG7bbgq9UhmwjZYR/k9
ierJlrLs8Q/NCH19nJ3z9SaEXccdAuaJd+cDcPNrNVXKidg40QwWr686+hvqpdFx
F909IBSEuOhLaOT/eF2NECTeXPUoq5+a9zUEgsVbobI/Az05/wsKL5g4mpNUUGPb
em1nBDrCbwXl6st55H3Q+mU2JqgCCQ==
=nO1t
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
