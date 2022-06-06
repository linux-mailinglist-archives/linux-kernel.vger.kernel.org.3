Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802453E798
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiFFM6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiFFM6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:58:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83C21AC64;
        Mon,  6 Jun 2022 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654520311;
        bh=ZVKaO4pxHclqnySYO4A/cs/oINIor54RsEyTmpsCsfg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=N/H+KZLMIL73pEKnIkEbMl61gD1g0DBQOeU018iUoa57vRqwoPVukTY9gKxlJjqL+
         LqayCA0sBSikXFpdB7MLOJFNBAAAsEOUPXjPr+8Njd+Fwq5ZpOATl3cKKLvdOlVy+e
         kFlRlGyNtz23ESmHi3nraNgo1yAoaGGIfssYYgmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1oFjAE38sa-00HhuI; Mon, 06
 Jun 2022 14:58:30 +0200
Date:   Mon, 6 Jun 2022 14:57:22 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] ARM: dts: nuvoton: wpcm450: Add missing
 aliases for serial0/serial1
Message-ID: <Yp35sl5WPnLxZNiE@latitude>
References: <20220606123529.1738542-1-j.neuschaefer@gmx.net>
 <fc350cfd-e9c1-e29e-392b-ede4fe7fb265@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g37Y/w1vok8Y1ZFx"
Content-Disposition: inline
In-Reply-To: <fc350cfd-e9c1-e29e-392b-ede4fe7fb265@linaro.org>
X-Provags-ID: V03:K1:u2pColPCmNln/DBYE/sKdlTLQFN0eghzzPnVBKH8gjjPHiFphe5
 Cs/iSr71BZIAiFAZgXuTSGsa1eTDV+ICWQ+VJ74Ll71Dv9c5qyKZw0FgBRldAU9mgAisTSx
 SUmYuoMfjJD3VCTBNJFtleE8C/C6UVFwR8HdnAbBd4A07lXjqnkO0IEE5OWXMbPBnjAt4sF
 hTKfnJ47cUXz2/N/E8dBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q93iPs3qD00=:EiNpUkkhXyT+z2RrDZRkSA
 aeAMnQJMYEA6MIRszjgG8eLGT7XxLrNhvjQRZWeXI3yFfWwv3CKrgTVl0X13BvXBAE3QSW2vn
 VFz3EH2VCO+g+KuGekAv7TOzBcJP4jegDVvAMiE/s8lQdolmjtkV8RhFspoqrQXJyiH1JxBRu
 uXPJr4CGd/I0L92KA4UtHGywIOCb1J/IOxHqfGcwSPcOL1FcrLaMtC7IFM4G/2f5DGPM3W+ya
 GdMD1hf4aF7m5haxt6IMi4Uj8yA5wokntfNLkAwPxrfcSG1CtJyQql7V47xq/gLKzVgqxLvs/
 YR10jQ6Psh/nB05gY8LHVwr9X+55Rk5THHo7B9ujh3jjY/lCiRnNMeQgP+WU8XvWfqg/XQsMW
 irGgmsc5FED/JBn56knIZstF21aNCvczcRwOfoXTKcQx5Mp5CWZL1vK/spT+49vt53bBz3DNI
 1aNWHtqTmYTFR76Pg6xTS/FgknvUAEgCbU3X5js2+lBe0mjK9CtbN31aRMgM5f1u02YXWD8sL
 YhLFpybj82rA3Qtpi3ZBafHGACHsqJgPC1XByVco6kIictVtCOLvtZK1cLwSn9Ds14asrNtb1
 L0G+8GblE/Epdso4gKH1dbh3akgrC+QjUv0xljytWHQk5JkxxDR7cGl+cn0qpXgtlMH6/Zn7N
 myA9KA1KLiMnDeVYVgCOsj1ZUkbSZsMupddzEmkD8I7OyGQldNQM6Ya8Mc5A3pNPXpJj46zvE
 SIJXCrZJ5VCOt/XzRSL+2pTedQIWguBC3G/ckI2kmGv4/Dr5yAlf0Hv09Ixf9L2ZRavw7zVwD
 Q2QsIxaE5Zq0u3LbC6B/wscdMeeyRCoLETjkJD6k6qYMw+xZBnhoUG+/ztNqgXnIl+3/UEWgh
 TSsVTRpZQuLzMaf+He5wkihefp9TPKJNUCRAn43bDNdlxOU7zDgcxi/359p8jIBeRN/7HBCiD
 SbRYIgE0DMQvSyaEqQad7CrgLYBi/6N8u02aArHBJoB2n8oQdJJ0ssRJxLJWNqUJihbnung8I
 esAh4NdKqs3nF1rvOoO2A/9zk8soU+tdbWjSp75hSP3D46Z2p30wxE4S8FG2p41KUBkbD0WVO
 nDQzO9NdX0XoGuNQTqAiPL7KwCh0mDP/7neZ7dqMbKdbrWvOQivjUJ75Q==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g37Y/w1vok8Y1ZFx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 02:54:21PM +0200, Krzysztof Kozlowski wrote:
> On 06/06/2022 14:35, Jonathan Neusch=C3=A4fer wrote:
> > Without these, /chosen/stdout-path =3D "serial0:115200n8", as done in
> > nuvoton-wpcm450-supermicro-x9sci-ln4f.dts, does not work.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >=20
> > v2:
> > - mention WPCM450 in the summary
> > ---
> >  arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts=
/nuvoton-wpcm450.dtsi
> > index 93595850a4c3c..57943bf5aa4a9 100644
> > --- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> > +++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> > @@ -17,6 +17,8 @@ aliases {
> >  		gpio5 =3D &gpio5;
> >  		gpio6 =3D &gpio6;
> >  		gpio7 =3D &gpio7;
> > +		serial0 =3D &serial0;
> > +		serial1 =3D &serial1;
>=20
> Serial aliases might be wired differently per board, so this should go
> to board DTS instead.

Ok, I'll do that.


Jonathan

--g37Y/w1vok8Y1ZFx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmKd+ZAACgkQCDBEmo7z
X9uCPA/+OwujkFECqueUAvo5d+T/SBa+2E3zrOPtWQint1Jmz4N5+AJJuAmEPbht
/Wwdh3ib1NCjGAcGEPxXVoGkzU0DIlx0huUEN6KdcmrZLoaVazZeONR7b6B9wVF2
cVrQ2Lw1+CIYcxET9D0UWwKYiT+vnTslTzo7SBC7fEt8sQkMp3opGyouS11Kpx+r
1ngwBGZSooz6RFG7pt0+8Cssd44gn7X6pvHD1kOJNfIdY7HdtiRmrVMDXg3Kt+VL
+/rhNxNVhnN3L41KjXdf/BjbtP7TfQPXpADWXa5Oir/X7InbOkirv/GUJPCZZBvr
Rrt1fflFPFa977jtTJI5kiORjnfmdh3stTuszgYlZbQMJqkHlzOgfiKVNi/gEGjS
cPU/JWD8MDierIjwmFvavJQsraZBTpNWruJ7GlbZDRqFEYE9cCzB9Y3ySgp11eMk
ip1h0rMhsGfFnjthW+JMWs6if1+3wYs/tMlr0Dni5IuKON7iiqbTylr2fot3ZFNe
4qi4QuI3ZL8cXR1TUhja/StmaWOAEsUeVI+bT+ZMG/XeCp4nsMaIq26TPfIdIIcE
wz8NlKIDcoDbmnv65xktvEdHkJyF/YIX5LwYPmeZlEIKPLSDFI8F75uIjMymoVpK
ruej0z4rPRt+kvXNQ4s1J0uc6Xg322TW1YHUsjkMrFd9ekn5rFQ=
=Nv4x
-----END PGP SIGNATURE-----

--g37Y/w1vok8Y1ZFx--
