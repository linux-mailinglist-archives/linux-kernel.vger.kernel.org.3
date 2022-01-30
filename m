Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F574A3571
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354485AbiA3Jqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:46:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:50969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346817AbiA3Jqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643535992;
        bh=t0Fmwqq/LQtSqEl4t628e1+TOcX3as2dSNiCW+wfxVQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dR/taU17eBuZHTQJKecu6K/mymJjWP7DXZ/XGsrID4N2kI71YZi96l/sBtg+UZkJ+
         uIdVu+9bbk6bSORk5joix68PdaBy2Q2ykOdrkfyv/pkaoQDiClB3dewj1BvrDzYKrd
         rkVjBwFg25vQFLAkqyLEb6bsei2axJNgyJxlX8cU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1mOkBp0577-00ubZr; Sun, 30
 Jan 2022 10:46:32 +0100
Date:   Sun, 30 Jan 2022 10:46:31 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        openbmc@lists.ozlabs.org, Nancy Yuen <yuenn@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: nuvoton,npcm7xx-timer: Convert to
 YAML
Message-ID: <YfZed9vpbYbBgNtG@latitude>
References: <20220128214427.1990183-1-j.neuschaefer@gmx.net>
 <1643502137.246273.416950.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IyshlSIlqO9/9BI7"
Content-Disposition: inline
In-Reply-To: <1643502137.246273.416950.nullmailer@robh.at.kernel.org>
X-Provags-ID: V03:K1:Gs9Qmebjugknx+OrVMlmxI+sHqSpUzjOM2/k57bQ+AVncAJvIbq
 BB3n6TrSvCU4SQcfmaELSmaurppvtOzBeQxcjDzLDMrVfH4b+Keh8BFqQghrtf87o/R7nnr
 7/tkoh0ltqAvDyxKuERuQ0lzjdPPdwHaeTXN3ECHP9AEqmIFZvkKhzxd/yn2/qQV4OvcfL4
 RvtYMR5ObrJM1Yc35HSMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Swn7wvYuJLk=:HW9lAEDbW8VDhYsldAvJ25
 fopWX1O9tbYGIK9eH+MEL210332oOnLAAYMI+k4ZXRz4QtXvtIDjy87quTLmBeYlGirlyiXWJ
 5rCgKtR09qQ8oMSQp8LOWDOCM2kB/if2UN7KH7m9ka4jR29MmO/PBy6bXNdR6nehf0EyJesM+
 59Lgjkw1Nm1I7pPMe4RhKJ6rw31TpXOeO98655lS6fqHG5nobC0cD1hFlwo+K2bzjhTVg0z6C
 +QTVGboQKCWrixY8U8dwKFgoeOZ9QaA8g7iDmAB8iJfloebWMGeARVUfGwlBA1Bt12W2J82xc
 HXYMcy8IghK6Vgnq/2IyZct5/6QMdTxLMZhdix8dQ/Z4fekBuU1IC3+oJ7DqMVxt2/PozJFUV
 LpQKY1HcfeAApLgtFVI8r1h1b9C4bHivtF89RXTPiMOeeJ2jQmvDiig978RIqqrW5tLVNgtFm
 THxIOttcUWvIsHea2W5F9emOF31et8cRNzZ0r6+Y3OKU9MCUFl1yKX9XOXV6fp81yl/O6HhWW
 iNSbYVoUjk7M5ak79OO32omqHhyK1UdCrkS/do8w+jQHp6uQgiGQhtzAc+JTg9XRGhOTVaaVC
 nGfz13XmAHXx89/gfdhChdTgIs/UnpRb2FsSOJh1fiNGkCRwIVkuFFIVA2qPA0NImYUdgU+BQ
 1X31gSGZsUMLQ17QAlJus71cJ0MS2j+PZK4iDcBq3wzIQlOa5Fpd8/1n8amylGAVtH5PuXI6t
 VHpoNeZEbC2EBslfUWuBX0Qrk98cyaTBWcmFHIlqPoCVaJGROPiOTmcrulIV1gyZfU8exUs3P
 FLXdJBmpZfLRtG2ctIvkxPn4YmGaMoP+rfLVV3LQOxjAkVkH27T4KzSA4PtoR6ipPNCL6lSkH
 zoBboAWdChUhqxihujhXbC1acpgKdcl03MyZmc0Iud1E59TJeDnmW0H+ojy4VtBuTip8jn+ah
 MqoaRbDDqXGBshf5Wnt8jE8eWZvziQAwSQGyJe7l9YlEuYSGAjUpEnUSfIl7QI2Qvub+RCD/b
 wQ9tND3baweY3t34AZmws/3xztsrVQYH1B2QI5nL1S2RnhRYcBfa2N0FS5g1ILy2o5VFpvFvz
 uqiyXMFrkHSdrA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IyshlSIlqO9/9BI7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 29, 2022 at 06:22:17PM -0600, Rob Herring wrote:
> On Fri, 28 Jan 2022 22:44:26 +0100, Jonathan Neusch=C3=A4fer wrote:
> > Let's convert this devicetree binding to YAML, to make it easier to
> > extend later.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  .../bindings/timer/nuvoton,npcm7xx-timer.txt  | 21 ---------
> >  .../bindings/timer/nuvoton,npcm7xx-timer.yaml | 46 +++++++++++++++++++
> >  2 files changed, 46 insertions(+), 21 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npc=
m7xx-timer.txt
> >  create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npc=
m7xx-timer.yaml
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.example.dt.=
yaml:0:0: /example-0/timer@f0008000: failed to match any schema with compat=
ible: ['nuvoton,npcm750-timer']

Oops, I missed the error somehow. I'll fix it for v2.


Jonathan

--IyshlSIlqO9/9BI7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH2XlMACgkQCDBEmo7z
X9uyzRAAkNm7lrXY3TTzF675cyl8/kEoq7VYoEh8aLEAAaHeUd3SWw/x2gXIqMh/
y3fhAY5Vn/pFBgGsC4nJs+9kdi4LPsMIJVVgcoqmEjJDHkYb/70ajT3NS3u/iUDg
+FE5VOe26x0vfLG7waDI57RxgwJTM9ww9d9tqs6D1Sy5/bFpFcBet/RnQ7m9S60i
CTb69KR+oF9RoW6oC8yRqhuCLy5QSxMfBPbF4SNZmF0048ln9G9e86HjPVveF/Rl
HLSYh5RqxCML2Xc7/M+OWw9PJUdQss7TJDofn5wtmV4gr1zpHFvdY62xMbahkA9B
K7/wh2NXAV3QfFWtq/l9SLB6rxAAddZovOMWudAffRUUgxudM0QTNMYQ/RZNk5e2
1/NXsFLl/0wWghB776C3zUio7DuStidMwfY+dx8jZtP929UmTlmB0J8EmmkSfmPU
T1qNTvm0eh68D/M+Un9JQNSAVaIROhF/3wrtKDn5u1xXFoyDu3XOjJ3itErwRT9G
7fOWpZOVgghiMim1+6Qsn5qbt6IxAZocAZGVGks1Bx2R3Sfwg/YPlEclWP8i4Cg/
d5sYPrQwmvstdK/JZwBMHNWdf1zrYTy1LAuBJ1/iW+gUjsffgDkZkor1vZ8B2who
H1fbTcqiW1pzyTkTkK7CWOiVxfiNsr8u5p+n8jdagzx5GP/Mtik=
=lDWE
-----END PGP SIGNATURE-----

--IyshlSIlqO9/9BI7--
