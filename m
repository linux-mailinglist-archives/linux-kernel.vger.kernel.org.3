Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C514BBA19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiBRNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:25:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiBRNZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:25:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4A6284213;
        Fri, 18 Feb 2022 05:25:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u2so13448140wrw.1;
        Fri, 18 Feb 2022 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0+R8f+FpWdVZsXC3JORiW96PDrtpa5Q+9MhYbuvNLCA=;
        b=NspUSG2MzoWykLe1gT+VBXfNPirrN5xihqH+oh1f9MdkCNY8oeJvF4Aa0AFVKXRqDD
         1HMakMkjkmP77pgl0dsR4b4e2z9RymheMwR6YD3T3PyWAnu74inWtCa5KZ4vFtGiFwjt
         /GGK7sRqpwbCMcSHzpUM3xkDmt4ou1QRPLUHnluU/E2No+MHjs188noFMG9ZBmH8OQMw
         H2oyO60awq8PAWT3MJWja3gBAk6G0r6miN3VKgNA0t226xLDfTXqGWuXYlRVoVrOO34J
         7hZ2CgKPBdwJ7Anm8pDkmKcYVJQHlkPwtGRAZ5aJOvJWt+NlsQB+EFbyWXiFdEb07iQ/
         DrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0+R8f+FpWdVZsXC3JORiW96PDrtpa5Q+9MhYbuvNLCA=;
        b=avFaHPyM1ht+CrtQ0KcJrY6GiwOTLYX3erDmSfpWlm+Yr2tY3MCfWcqlo8dZ0rzsmG
         3umAhnB6CEQMTBkMsetXZUJB7VvfuS6joVF4ceI5V/OAWLDvNpVHaA1bQrbqS8Qmd0xL
         H5MvjdIzJLsufeBwZ7Qpau5dgRj0VF8x7F7karhLYW1L8BxmrLV9RNNy1LYurI8np4IM
         mwMrs0ofnRV28Pt5G9c8odY02b3lV0uoMwg4XquL9/x9l67aL3+yj7cpA4Fe78TMpx/t
         LZYdSXpVZ3GgGdz4dGJbaFUhCtDpSJSyhYacLAAjBeb5Ow/mHmdtsRmpUYViG01Z9hXp
         jpZw==
X-Gm-Message-State: AOAM531mBT7q9JlyKS8x5P6nyoddn4GIecOcCymzmES1+pz9H7FQIn2H
        /kl/ig0IKrlfvzUpXlafZ6s=
X-Google-Smtp-Source: ABdhPJyczukn/8AkfYdykkOt1pezwFEOwk60IxxwLY3jFkHxtFCbrspatY44fmxkmGx8RWJThO8AMA==
X-Received: by 2002:a5d:6ac6:0:b0:1e3:3a96:fa27 with SMTP id u6-20020a5d6ac6000000b001e33a96fa27mr6459061wrw.285.1645190728912;
        Fri, 18 Feb 2022 05:25:28 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id i15sm5736155wmq.23.2022.02.18.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:25:27 -0800 (PST)
Date:   Fri, 18 Feb 2022 14:25:21 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sameer Pujar <spujar@nvidia.com>, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Add APE memory clients for Tegra234
Message-ID: <Yg+eQT4P3UTe+D5R@orome>
References: <1645186589-25118-1-git-send-email-spujar@nvidia.com>
 <028f766d-e5ba-fc12-665c-8f65d6bdf817@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lBQDofXHql3wr2x9"
Content-Disposition: inline
In-Reply-To: <028f766d-e5ba-fc12-665c-8f65d6bdf817@canonical.com>
User-Agent: Mutt/2.2 (7160e05a) (2022-02-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lBQDofXHql3wr2x9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 18, 2022 at 02:04:46PM +0100, Krzysztof Kozlowski wrote:
> On 18/02/2022 13:16, Sameer Pujar wrote:
> > Add the memory clients on Tegra234 which are needed for APE
> > DMA to properly use the SMMU.
> >=20
> > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > ---
> >  Please note that this patch depends on the DT binding patches of series
> >  https://patchwork.kernel.org/project/alsa-devel/list/?series=3D609494&=
state=3D*.
> >  So please consider this patch once Thierry picks up DT binding patches=
 and
> >  provides ACK on this.
>=20
> I was not Cced on that patchset. Could you use
> scripts/get_maintainers.pl for obtaining list of people and lists to Cc?
>=20
> If Thierry picks up dt-bindings patch and I take this one, does it
> compile? No, I don't think so. The order is screwed. This should be sent
> together to make such dependencies obvious.
>=20
> Anyway, I cannot take it so:
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

This is my fault. I suggested Sameer send this out separately because we
noticed the absence of this only after all the other patches had already
been merged.

I'll pick this up into the Tegra tree and will send a PR sometime next
week for your tree that contains all the dependencies needed for this to
build.

Thierry

--lBQDofXHql3wr2x9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIPnj4ACgkQ3SOs138+
s6GzhxAAu6fp6UsJR7IdYYZ6FkRqvzSwGKuIyZLdOjDzT7NfFwkHDyd06W1HTmSQ
CyDtp9CsVvzUqwmyfToG0BgXbgDA75ARy3UPBVKovybcKXb/0EmK/S/t4LeweTvf
aBT5PP8iV3hS79SkX2avMfctmKQv09LEf11ZAyHQSau1EjpUXnpbV0W68IMtLuYU
E7KiBInNE3YmvUYVSmZ/N3npi/HZtzKahTfj5H+vXq2cEe5R8wMgta9lJWc+clmd
FvCwS5Vw71KONRTqv1NV2H9MSPoe8ANGf0VlAktSiKjvzwEefpdJZvHTspJUmkDG
Osfu4vZggDHY+IOChJ+ZvbUU/NnfmkK3VF3p7cPHURQNEwwxIwvuA7eXB6uuGhen
+y7d9s/ApC3CJATFGE+Psiv4oWTlWOpw/5L2V+DAHS3KG2fU6YPEgycl7V4Ntbls
8bJaiLiaae1bE7tDK8VE541qzILTTeWySMBLNhPxir1hdXKjJ5DuP37zgl7Trmgc
JWulfts10xIgUqCgnhoU8lFD7gzAD1NQspWhbrrCACYF02BMtaZXQNlPK0j3UqLs
VeYilmLDoJPc6aXULYr3pkCwT4EH3I5QbbvouRoQsQWJpGG9tXkhLS3ezskf7rpv
GP7ZiqGWzJKz7YEp7THxch+bFWCri/Mpuk+zJkjYGHbDuxnaaKI=
=yoXn
-----END PGP SIGNATURE-----

--lBQDofXHql3wr2x9--
