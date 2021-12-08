Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7946D081
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhLHKId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:08:33 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:50189 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhLHKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:08:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J8CT24xWHz4xYy;
        Wed,  8 Dec 2021 21:04:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638957897;
        bh=WP/HDrV+4Fnnm+5F1yiZ6HtkMtlww3xtnEUvgZ6C5gA=;
        h=Date:From:To:Cc:Subject:From;
        b=SI3O8wa+nNGJIIw13NsBn3l1/nbHbDidAEuO8hvitMTVCNxsmKjMSly2KpeY5lL6F
         CN0217SThSAUJ9JyfC1ZhmQSFgU43UE9Bh6ZUNPMFZ45m4w4gc4D3446bQWMrHId8i
         GM2ClKPx94LcJ6yBzF0NIymfiDCZ/D/ByUFkASMyNncois8WUiLMNwsgaWl8frc2qC
         PPWXGTfLYJZcIaVXYa9MLXYd7+ci2tt6fuQai100QDfKIbaGFt8uDRk7imeEs6Busp
         Y1WdhK33eXZBKw3sHe80POPcdGstfe1qNJPw8C6DJRHMrOGW8ole+RJVyNzcVxsWSp
         MwRkSnPFsCbuA==
Date:   Wed, 8 Dec 2021 21:04:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Wudi Wang <wangwudi@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the irqchip-fixes tree
Message-ID: <20211208210453.021ac89c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A7CPjH3RLpO0wktDO.Dxw5f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A7CPjH3RLpO0wktDO.Dxw5f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d094b4332232 ("irqchip/irq-gic-v3-its.c: Force synchronisation when issui=
ng INVALL")

Fixes tag

  Fixes: cc2d3216f53 ("irqchip: GICv3: ITS command queue")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/A7CPjH3RLpO0wktDO.Dxw5f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGwg0UACgkQAVBC80lX
0GwNGAf/eiMlGnkFr426CEyJC+MZrok9OR85L/HQW2Ss9RO6hZhRSr3OP7/0jiWR
lE4iDKCRKV92+hexMh/ZTJqEoAAtzxOAUdeb/Xxc2VRaAEZtuT9ELolZnhobAUo+
uQjwtVIs1Cm8382AhhBdt81XK6Z8M+HnN5wip0QhwBpWxvk9iFbbANckWfdQtBeV
3At4Ge4myEnkMeBIujKN37VCUq9wkDYQiRW+R/eM4/Xtrt5WG8xQDmwnOWFc/UaF
XTIEPg6FHs3V1ZA0bnmLUQwlcGYaXjJLO0jmkR5q6bimpvy68LleHrIbvSPLTp0C
3NaVGo5PGeJmLa2xeUX83Ix432vxRA==
=B+Th
-----END PGP SIGNATURE-----

--Sig_/A7CPjH3RLpO0wktDO.Dxw5f--
