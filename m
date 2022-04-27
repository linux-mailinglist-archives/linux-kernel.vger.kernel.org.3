Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB05111BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358456AbiD0G5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358390AbiD0G4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:56:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2F15A438
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:53:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j15so1110157wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sywIeG2HiiTWZv6dh3lrACwyYZG/9USPPQqRRJss/TE=;
        b=DvSH0nPKb9aM98q9+fEQAqLrjxBAcJzGLcasafpsh3qomqG4I15sC20qPFuFYFNxF/
         RAakzMH+eO4jSr+1snlOji8jEeir0z2pJeL8krJ8SfJxAc4fpTW3pNMG7AnFuvMIhqR2
         mSM4oGe/GNnDnma0ho1soJUNlPkpIl4m0BoTm2SeKqOfl+MXHmKE0xZrTS5/KTc9DIdv
         HpM2M4ULJGzUtObLmdaTNAglnFIFup/zr5CHcZnhH894YLzFiydg0DWwpU72Ha1BeMbs
         fXUCWzSWdAEAQ1Hd0ZtFp7dcZsFZKKsd3evVKgwbWnSq2F1w2ThqDLO7IbIB9SdxAPNQ
         R10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sywIeG2HiiTWZv6dh3lrACwyYZG/9USPPQqRRJss/TE=;
        b=Hw3muAe1L2trW6DuyjfX4Rwgtm0cn98Pwmj685epSipD1/TYF5vgYj+DbfVa6rd8a4
         KAyHqWtTc/ugi4A4YA+URLSfckh4Lop16TsJ1pC+ZYZDVih/CioNMTcNSm3vFA2f1dIl
         zBo6O5sfO49DI/Pi+KHTWERklTrxOvc0zRiTJ8b6jnmZPha3N8a7GzMRq5CredIJqCv1
         m4VFfNi6+imdVH27FHGCOSzQjbLi9SFx0eFX0/td3RssW2o5iX8TLUu6UQHwwz5dauPu
         STFrX6dLFq5j/GTL7/rCY3xYYI2DtdV94y6GN9gEditRgFQqZsTWUVGDfKcuLphavHMd
         jDBw==
X-Gm-Message-State: AOAM532ggmLibJm78f83BSYHB9jLGtQx+Cwy1A6/DWV7ytGBOnKQW8zx
        MhgKLQJrBqNw0oXRM2hlJSpQXQ==
X-Google-Smtp-Source: ABdhPJweJ1wsocYd5uHXP0OXjVrnlCbkD8i4KnvVgqQkJEwOxyNjOI0ktncE+no4NH0K3sQ9l6WJqA==
X-Received: by 2002:a05:6000:144f:b0:20a:e51a:1f71 with SMTP id v15-20020a056000144f00b0020ae51a1f71mr5490547wrx.410.1651042410821;
        Tue, 26 Apr 2022 23:53:30 -0700 (PDT)
Received: from radium ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a7bc104000000b0038eba17a797sm859839wmi.31.2022.04.26.23.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:53:30 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:53:18 +0200
From:   Fabien Parent <fparent@baylibre.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <20220427065318.bdn5h6rdcvdpxdd2@radium>
References: <20220427104825.15a04680@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kxp3ossrzkuyes7u"
Content-Disposition: inline
In-Reply-To: <20220427104825.15a04680@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kxp3ossrzkuyes7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 27, 2022 at 10:48:25AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the input tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/input/keyboard/mtk-pmic-keys.c:93:36: error: 'MT6359_TOPSTATUS' u=
ndeclared here (not in a function); did you mean 'MT6358_TOPSTATUS'?
>    93 |                 MTK_PMIC_KEYS_REGS(MT6359_TOPSTATUS,
>       |                                    ^~~~~~~~~~~~~~~~
> drivers/input/keyboard/mtk-pmic-keys.c:48:35: note: in definition of macr=
o 'MTK_PMIC_KEYS_REGS'
>    48 |         .deb_reg                =3D _deb_reg,             \
>       |                                   ^~~~~~~~
> drivers/input/keyboard/mtk-pmic-keys.c:98:25: error: 'MT6359_TOP_RST_MISC=
' undeclared here (not in a function); did you mean 'MT6358_TOP_RST_MISC'?
>    98 |         .pmic_rst_reg =3D MT6359_TOP_RST_MISC,
>       |                         ^~~~~~~~~~~~~~~~~~~
>       |                         MT6358_TOP_RST_MISC
>=20
> Caused by commit
>=20
>   0f97adf64314 ("Input: mtk-pmic-keys - add support for MT6359")
>=20
> I have used the input tree from next-20220426 for today.

The commit is depending on another commit from the same patch serie: [0]. T=
hat
patch has been merged in the tree of the MFD maintainer: [1].

[0] https://lore.kernel.org/all/20220426135313.245466-3-fparent@baylibre.co=
m/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=3Dfo=
r-mfd-next

Fabien

>=20
> --=20
> Cheers,
> Stephen Rothwell



--kxp3ossrzkuyes7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQyJHfU3UNW7IG61XVJKc6g3CeAAFAmJo6FgACgkQVJKc6g3C
eADQ/xAAlzWDjGksWrnDRRkWRhJgtwqNsf5Hwa7QarXTGZjz0xyOsII1/dscXhuI
6chHhMQvDTUgIrzcmLnVg/2F4Bow/WUVv2hlyYZv8sPolhp1WBPM7B90TIBZctF0
xmyzzlD+tkDSjn6Roy2Zg/cPWFNuLSeSkijveptrp8e34hO8MBcwxdMXUTXpsC3I
qY3BybtG5VlbbZ8NkFw/wHghrlEMezrb1ivtyenaemrjn4yUu46kIb4PmFRP0Oco
p5SGqdl+3tv1pFBFJI4IeYjChBwHzADHQRrwYxD8uAvc3/1ZbPzSsyNAtTxNVueZ
mWQbB5iC9pVOgICCZxhkybVxkniOKKjHvEwUBjYCXq/foj3ZshJD3vrFeGGgEGMe
t4yGuJ+i+L4KHsS7dwu2SusEavvBFrFt5UKqt0qE3X8MHAichJk30HR3NWsOdy+u
ACf7CVLLUW1JtL9IGGzGqBZ4FfIzkaZzwmypVUUvfdNiTbfV8TEp2cO+ld4qF/9N
APaXpqGf085Jge9/XG7dwxAPuGjE5SQ70YfYlkjzMT/fpMg9EV2wTFMQlzmWMrYo
iP+9W2htw/6JpGd6HCHS30MXcixGKbVqB0w4M+kCZmBxii8J4i1MagWy8tXWg3hD
nA38erjOFrm/aYCigAfpzkO+LQ4KZpm4qIAl0BbvZdbtRvBsXZk=
=M5RR
-----END PGP SIGNATURE-----

--kxp3ossrzkuyes7u--
