Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8418350FB70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbiDZKwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiDZKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:52:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D3A66AC4;
        Tue, 26 Apr 2022 03:49:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KndtG0zFHz4xLS;
        Tue, 26 Apr 2022 20:49:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650970166;
        bh=DMH3ySr9iYba3uZ+6v+2cv3OUMkWXAYZ8BqhGvxLsw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B7BFrB8rj4bZPsuN/XuBfRipy+U0EU2TColA84cuQEZV7pb10732mph46ExKdfA76
         22gTFCfUrQwn70pA9PBoRbPdr0sSJodmW/iJVoQf9Ypl17Tw04wFJuSWrXuqvBZpf8
         tg+uKBT2c7wXzuTYAUNWSkCRAUVruNVQgjCsdh5vKvDNlcHmJd1/qf1f7DpEkiWpja
         Wyl2HYv/F4ZvMoDuAXZeXl679/Th3bxbi530dreLG7qKJvkYJHxRBW53ohHiq/H0TD
         qd3pgBhp4eqwV9HqCfztUsn1wEsRDWqJDMml0Hk4Dd8/wQKqgOW8ZVc47XcMUv5r45
         +D76VLWnXFHcw==
Date:   Tue, 26 Apr 2022 20:49:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20220426204924.173c3f65@canb.auug.org.au>
In-Reply-To: <9a1299a4-873c-b3f8-c7c7-6f3fcfee0d5f@linux.intel.com>
References: <20220426183048.5f1cb899@canb.auug.org.au>
        <9a1299a4-873c-b3f8-c7c7-6f3fcfee0d5f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NrfTiBqVu3EJNw25ARI_x4z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NrfTiBqVu3EJNw25ARI_x4z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Amadeusz,

On Tue, 26 Apr 2022 11:01:18 +0200 Amadeusz S=C5=82awi=C5=84ski         <am=
adeuszx.slawinski@linux.intel.com> wrote:
>
> > I have applied the following patch for today:
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 26 Apr 2022 17:49:37 +1000
> > Subject: [PATCH] fixup for "ASoC: Intel: avs: Configure modules accordi=
ng to their type"
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >   sound/soc/intel/avs/path.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
> > index 3d46dd5e5bc4..6f47ac44de87 100644
> > --- a/sound/soc/intel/avs/path.c
> > +++ b/sound/soc/intel/avs/path.c
> > @@ -9,6 +9,7 @@
> >   #include <sound/intel-nhlt.h>
> >   #include <sound/pcm_params.h>
> >   #include <sound/soc.h>
> > +#include <sound/intel-nhlt.h> =20
>=20
> This fix seems weird, as same include is 3 lines earlier?

Right.  I applied this at the same time as the previous fix which
probably stopped this file from being built.  The real problem is that
the structure is not defined for !CONFIG_ACPI.

So this fix is not needed.

Sorry for the noise.
--=20
Cheers,
Stephen Rothwell

--Sig_/NrfTiBqVu3EJNw25ARI_x4z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnzjUACgkQAVBC80lX
0GxPOwf+Lt+DwgO/MQW/6p3nZMvoGr6V9DecsGKZc6JeBa2Z5Db6v+AauaKY2mzX
3Bwa+6AYHz9oMs99J1OI2ABKjK7Ye4E6nRQe32tcdS8wD63HlN89A6L/G6pqtN8w
/ZxE6AyFo/pVAz8abrkIyJir0002Xmm78qAKHSnuiCF7vf81rlkEcuAqW8SS3od+
5SPXdTYls7qbG0SMOm7YEdZeM1w/PcPBaPWGCbnPi10uC0qcka6gvBXRst1M03Be
x4ChLunuzUKhSWtfDSVBUXbiHGxOC1s8zxlbNciMHS3QrNtlNdmPX1QEoqEzMgtA
3gbL2OQw9VfTDVcSvk0K68FaPWGRmQ==
=TVa1
-----END PGP SIGNATURE-----

--Sig_/NrfTiBqVu3EJNw25ARI_x4z--
