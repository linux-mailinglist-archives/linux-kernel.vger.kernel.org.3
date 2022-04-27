Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0010A5112B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358978AbiD0Hoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358983AbiD0Hov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:44:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED835DE8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:41:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d5so1244123wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hAOpr2vHMZPq9vV3wUU+p6Jg7ePhuVYETqOSxcMAmAA=;
        b=LM0soHQoqCDa7r3YJDU5GHVRQbVh07SoCmNnrwgzwguZV4KyYUSS9DuEYua2ihyxU1
         y0dM76Uuh2MOM53XrHvL3Vu6mqhTs4J8KKxvjHbBgxV2IseN34PbuXjiAQndjpSNk+UV
         NBwXwMaoA3D4Gih1/W/nqg/BX+0yjt3sEjWHSpW4uTTS/ageQDy6qR5KSTurdbBifbFH
         uMI8nDPgkwE1UizI6QNmP8ebLvALK/mXUM35IHQFaaI7GL28QyFU0qWmKBNHtFsusAaU
         D3mwEWaX29MzttuJXhCGU93/bsZNsFpm+nxgg8zcuGkPcEcEQKgM9cP80O03334f1yvX
         2oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hAOpr2vHMZPq9vV3wUU+p6Jg7ePhuVYETqOSxcMAmAA=;
        b=TAJSxSCsKDwbug7TOaXXWHMOmwaX8RRiWN9R8IsTio2aDYnSJwKS9yc4MwZh3ZmHKX
         mVjegB0BQilmYwylAHnvRyYeYLCI0K7OWlE38BsMBFgji8BQSQuLb9Mf5CRG/rYiMRaw
         SNn5/OAWbFRrxdLYdX3ttU/WmvucoJnld0+UHmkLzrxdsGszS5dEgpLIKne+yXq/0aq3
         d2qPOKYqiPT5x8A6WWLr1UySImUzo4ozV0PublVslG+BlZmuJnv6dXlU5i9iuR5x9gEc
         zOoQ9dO2T7/45zk0aaT6Z37P30eibXVvSpOH31BBWkzMpTHKhyh3aEwrA2fwPD7rOi7F
         BHfg==
X-Gm-Message-State: AOAM532rX3Alnyh6QN0ZBixqdsH4IAGjfiwIaGWwi/O2CHIV3JaeDvs+
        DV/oP6BwRWLpgmaEaxvbV/D5+OH6XGBKZg==
X-Google-Smtp-Source: ABdhPJxdmIhUwVEY2Ro4loeFhr/NbIzs2cqywXhS/00OewUBUOxRT057Y9ha/5rL9X66NQdkPfAE0w==
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr20504460wrp.299.1651045298731;
        Wed, 27 Apr 2022 00:41:38 -0700 (PDT)
Received: from radium ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm14755284wrg.70.2022.04.27.00.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:41:38 -0700 (PDT)
Date:   Wed, 27 Apr 2022 09:41:34 +0200
From:   Fabien Parent <fparent@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <20220427074134.loyovm6xpbfw6y7d@radium>
References: <20220427104825.15a04680@canb.auug.org.au>
 <20220427065318.bdn5h6rdcvdpxdd2@radium>
 <YmjyPSliv+WncweU@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="taso3s65nxq7k6nn"
Content-Disposition: inline
In-Reply-To: <YmjyPSliv+WncweU@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--taso3s65nxq7k6nn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 08:35:25AM +0100, Lee Jones wrote:
> On Wed, 27 Apr 2022, Fabien Parent wrote:
>=20
> > Hi,
> >=20
> > On Wed, Apr 27, 2022 at 10:48:25AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >=20
> > > After merging the input tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >=20
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
> > >=20
> > > Caused by commit
> > >=20
> > >   0f97adf64314 ("Input: mtk-pmic-keys - add support for MT6359")
> > >=20
> > > I have used the input tree from next-20220426 for today.
> >=20
> > The commit is depending on another commit from the same patch serie: [0=
]. That
> > patch has been merged in the tree of the MFD maintainer: [1].
> >=20
> > [0] https://lore.kernel.org/all/20220426135313.245466-3-fparent@baylibr=
e.com/
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=
=3Dfor-mfd-next
>=20
> Looks like you only sent me 2 of the 8 patches in the set.
>=20
> In future, if there are dependencies between patches, you must send
> all of the patches to everyone.  That way, we can organise a merge
> strategy that does not break -next, or worse Mainline during the
> merge-window.

Understood. Thanks for the info, I will make sure next time to include
everyone in such situation.

>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

--taso3s65nxq7k6nn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQyJHfU3UNW7IG61XVJKc6g3CeAAFAmJo860ACgkQVJKc6g3C
eACAahAAiytdrpAVLp7N5W1hRRK9/ZextQvSNvq1HM8qXXnM8LMP4+zD4/3MjYxX
v+zIcWz6uRewcjgoWkQN0AOQbgEUuE47HXUQUvqjAcD5CulW/Kg080acZ2eawe2Q
EvWHZJJjRW9Pklw9fYSraqJBBXmK8PcbMPE2QN7vy/roIwfzgW8A5rLUpsfAE4+d
crjoL5t8YJAOdP5oQxyUknzgASlLDF6YSny4k1QYyBoiiUeWWH+aEaf3nNGXdYK+
4zwHa12l3BEm7/u2nYaExXi71XLRp1CeWAw71JtpXKRHL7s9TtnLDbsJfHJn/FLp
UK8s5W4i1c19vehsMGoYooC7gdgi2mQ8hdl/65h/Mv71TJzFlhMaYAvPrjuKzq6x
F73oZ3QxVe8zXD7vB5VvNExbKuSSZsh8L+cNrVmhEQIJEeHOf3QY555Wz5RQXPRH
yiuLNO5MA6G3m52un2mlxBdQlYp1tyguB+b4uQtOP7U+mvhTuFwIEs+45jP+oK9Y
aAvf/O4y5TBsmu3UKVEZLre4bILBsiEjLRzy62qmAjvttfdKPx+jwqwKhVhRxeIZ
4RpmcwaiEORLwwmVeb6LZXsQly1hOP9cR8qMTy2GCLUj7W+5VuNZY+ghqQxoso2v
0K02vXMCZF3afU+S+Mc+riwEFXetry3Vt/j+r0ZsOKfw3EKtwU0=
=qeMZ
-----END PGP SIGNATURE-----

--taso3s65nxq7k6nn--
