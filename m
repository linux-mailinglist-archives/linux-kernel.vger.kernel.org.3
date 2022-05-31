Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247B8538E92
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245556AbiEaKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245421AbiEaKNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:13:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08D263A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:13:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x17so8927863wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iWvVonGaj99CPPHQeMvdX15FpeMw9uh/+VNnPQUgAC4=;
        b=P1DRWa9WWEYDwDhLkPx/UVzj3T80I04Pendr35Rtuojp/bLOO6u6IiwrFvxfsI5Gfj
         viMLSMiJMe1b5L9Hv7K3MOsJlXL0h7sBiQUwHde/HeqdlyHQ9rl1ai51NzrfetcnsW6m
         vJ22FAg1C09Dv28Lhsv4Jov1Q4s3/vHFJ4Vj+Mfd/SSDW+6+dg+gDnTddHQBJ2utLe2f
         IV4Lye1d5Zb3TTIjji3S8QzIGV51a9mdLuST08AEEoZQ8WBBOCWkiRU5En9WgabteEnc
         pnTnYmnux0jI5E9Waj70m0VzbTfxk3lsU5AV36Yjild15/aHW3Nzvlsc7h0udfUfAEQR
         6aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iWvVonGaj99CPPHQeMvdX15FpeMw9uh/+VNnPQUgAC4=;
        b=0xhr+7O7lBK8G4UPQlDebz+QOKq5fZJrwVqqT5ymlvaAeacPXWBvFUbGqjw6IjmKNc
         PiF0rhsYY3ngMLlRZ2/Oad+Hmv+9sdv7cvEgCWGhKnggHUk9DmLNpqalqqRI8UK2Xssc
         224D7/VFpmU81Bpf9a9Ekli+JaN8lFvd5NgUoff8loG2umhkL0VV2JBLLMBszPvyKsdH
         zaqHcvyMoRna2cklm1+KEa9PD/KCJef/Txw+fEt5hipxr9BgbwWeYX+cW7GE1MdZrnp1
         evBB1jUG85qojofEiLRH3FB2Jt1Q9h9wQ7qIVrPbbc6aW3yGEaOo0YU+uJnGNm+LK6iI
         +PEQ==
X-Gm-Message-State: AOAM532bEs4DizgkyZBfdUi7c2307bvxXJMkTNSICIG7q9PgregvIN7K
        BERYMenNJyfGY0dKpXU+sq6ClQ==
X-Google-Smtp-Source: ABdhPJzYTmuaAcYnlCwHwxECyJuDxzR/vCZhjqvS8gExIF8I7z0BnIxZh+GGvaGJdmvj0WpimgZNSQ==
X-Received: by 2002:a05:6000:38c:b0:20f:24f:24a with SMTP id u12-20020a056000038c00b0020f024f024amr44209212wrf.230.1653991988340;
        Tue, 31 May 2022 03:13:08 -0700 (PDT)
Received: from helium ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id o15-20020a056000010f00b0020d09f0b766sm10919718wrx.71.2022.05.31.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:13:07 -0700 (PDT)
Date:   Tue, 31 May 2022 12:13:03 +0200
From:   Fabien Parent <fparent@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <20220531101303.fj5hvc67qfld5ykj@helium>
References: <20220427104825.15a04680@canb.auug.org.au>
 <20220502121736.57b06150@canb.auug.org.au>
 <CAKdAkRQN48WjsW1BAztTn3-c0pf68tP9+G0028ZyXB4-8aCtKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eiyocpgkl2o64d4g"
Content-Disposition: inline
In-Reply-To: <CAKdAkRQN48WjsW1BAztTn3-c0pf68tP9+G0028ZyXB4-8aCtKQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eiyocpgkl2o64d4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Thu, May 05, 2022 at 05:25:39PM -0700, Dmitry Torokhov wrote:
> On Sun, May 1, 2022 at 7:17 PM Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> >
> > Hi all,
> >
> > On Wed, 27 Apr 2022 10:48:25 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > After merging the input tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > drivers/input/keyboard/mtk-pmic-keys.c:93:36: error: 'MT6359_TOPSTATU=
S' undeclared here (not in a function); did you mean 'MT6358_TOPSTATUS'?
> > >    93 |                 MTK_PMIC_KEYS_REGS(MT6359_TOPSTATUS,
> > >       |                                    ^~~~~~~~~~~~~~~~
> > > drivers/input/keyboard/mtk-pmic-keys.c:48:35: note: in definition of =
macro 'MTK_PMIC_KEYS_REGS'
> > >    48 |         .deb_reg                =3D _deb_reg,             \
> > >       |                                   ^~~~~~~~
> > > drivers/input/keyboard/mtk-pmic-keys.c:98:25: error: 'MT6359_TOP_RST_=
MISC' undeclared here (not in a function); did you mean 'MT6358_TOP_RST_MIS=
C'?
> > >    98 |         .pmic_rst_reg =3D MT6359_TOP_RST_MISC,
> > >       |                         ^~~~~~~~~~~~~~~~~~~
> > >       |                         MT6358_TOP_RST_MISC
> > >
> > > Caused by commit
> > >
> > >   0f97adf64314 ("Input: mtk-pmic-keys - add support for MT6359")
> > >
> > > I have used the input tree from next-20220426 for today.
> >
> > I am still getting this failure.
>=20
> Sorry for sitting on this. I dropped the patches from my tree, we can
> either push them through MFD, or retry after the merge window.

The MFD patches have been merged into linus tree. Now the Input patches can
be applied without breaking the build.

If you want me to resend them, please let me know.

Thanks,
Fabien

> Thanks.
>=20
> --=20
> Dmitry

--eiyocpgkl2o64d4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQyJHfU3UNW7IG61XVJKc6g3CeAAFAmKV6i8ACgkQVJKc6g3C
eACBgg/+P/r7DqM77Tefmr3DQBOwf/mu0UYcM2cyUjfQJK11LNfyQPI1PqzSzPb1
LTE+gs/V1eRYa2BtAIsZnYNFQqTevVSPaFb3EV8b+jsOc5PtCyaUJL7bfAeyhaCt
4Zg3LOG0QNC3sY5q9V3ex+b4NsNYwDssn+YkcC2/lPvq6VcJO0NqN5ALHrPrdgcV
ffFC2km/k7tBb75yVZNr//8vUZdEEPjO2Eo7xHAq4Y+OqkQYB/Rwl0diHKHV90Aw
gld3jhYKCClQeVDVLHndyq0Urj4UT9SQa27nz1uJdRHNFaNZT9MiQIkd/SkB4Ozb
zbg5fhWU4DilRh5eTEVsYZio/pUYSQEHirVTV0WPXMCW+HYd5X88kb9TV0+0eLVG
wZMWgX8c6B5qE4nDFEB0vz1GR+mjRhMeNXWjpt7M3S6B4Y3Syxw+6M+6Y/8dCTir
vs7yYlOsg+cseJviIis42mqOWgDt11Rrgwiw00MmtZVbbJgBj894jAndQMunMxA6
ZNJCqjGomQNaegyVpuCQFpQoj7hPcT1MvAArDveQ7sNrf+uQlMr3cpT/T2EGFA9j
+WgbgebFHH8sVTvGOfoJR5QKEVujFfeDXp6NVuePTVN2ddLhJ8HVzgm5IbGO1DoO
/SWsAzW9tQuh9GfjOm9smN29YM67Z5tcsuYg0kR7mNU147g3drE=
=zJmX
-----END PGP SIGNATURE-----

--eiyocpgkl2o64d4g--
