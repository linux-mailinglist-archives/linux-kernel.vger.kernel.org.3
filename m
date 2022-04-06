Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7E4F6429
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiDFQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiDFQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:02:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F0F348A67;
        Wed,  6 Apr 2022 06:32:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id yy13so4343466ejb.2;
        Wed, 06 Apr 2022 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=niunOJ3MaXUFHbr4lbaS6D1TbU9QBsWRT6UXQMa2ITQ=;
        b=nkXV47q3wTX2IKhRobhX9k0wlO78UWo3Pu1cGioH8EzA5XNkKBINxeIcA6qNduJWCa
         fdcbIZE2tAhplyS7K4DkNZc7pXz+ba22d/7OPtvHVcO8ha3afT9O8+Nb6qYgNVkUO9xS
         Sr5MmOo8w1shDyK/prx9VliBS+wbmCPkNdjRgf04BlemlcmS5jDoyBQh6Olfqwe8lsLL
         pz3NQHK4TIYz9T6ArCbIxNJjrEdEFKuf66ctnNgOGxwEkJUXAwencqQi4OZr0Pju/o51
         YZy5feqpqgIeSXJhtsL/inBW/VXSW6jDf6pOZDA0vX0ceDeyH/ok5EHxGQO2lYte+COn
         8glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=niunOJ3MaXUFHbr4lbaS6D1TbU9QBsWRT6UXQMa2ITQ=;
        b=LOZusQmECm8lRpSieExeNFBvPVLziJ1ZHlwSh4VyN1Uni/1Vd/fdVRRTdOnFkdQIvV
         zgI5aIkotgUTT73zYoGcrQagLLNBwAl7iqpDIYOeQ/3/YsuQgXjY/RFu9rHQqDsTfyhj
         mn0IqE3qkGNhF8VNN1fsnawJjVb3tsYUZ+RoL9+y/iDO+Ul88JESKz7Vz/x4QmbTceqK
         PeNA3H3OsuvAclpUXsDlCuSbTYMTHve8OlbkFpAfk2zC9XJYubLcJ6c2OQKtZ8IK2IbD
         ViYvSVj4g/ea3JQbvXRjoSdIdk0M3fji9rPmonVOMo4plRJGUjJ2Il1nci5jxJxZQ78m
         O1Ng==
X-Gm-Message-State: AOAM53180/iBi4Haci3uZWhgAKtMoh093x21GXsHVmVL0UIKm2LGRUTI
        ltqyoW6jslhAvbhMm1N0iig=
X-Google-Smtp-Source: ABdhPJyg/OBIlUh7EMNy4f0TXHsNiCHCCBnWiWJ/r6XOCH2Fjigs+ZL4f8/vPP3nFsOzBdCi0E1d+A==
X-Received: by 2002:a17:907:7206:b0:6e6:d0b7:fd88 with SMTP id dr6-20020a170907720600b006e6d0b7fd88mr8074540ejc.121.1649251938297;
        Wed, 06 Apr 2022 06:32:18 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id jt8-20020a170906ca0800b006df9b29eaf1sm6535874ejb.8.2022.04.06.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:32:16 -0700 (PDT)
Date:   Wed, 6 Apr 2022 15:32:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Russell King <linux@armlinux.org.uk>,
        kernel-janitors@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: tegra: fix typos in comments
Message-ID: <Yk2WXutks478t7MJ@orome>
References: <20220318103729.157574-8-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yd0gt/eyj0AUzh/G"
Content-Disposition: inline
In-Reply-To: <20220318103729.157574-8-Julia.Lawall@inria.fr>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yd0gt/eyj0AUzh/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2022 at 11:37:03AM +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---
>  arch/arm/mach-tegra/platsmp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--Yd0gt/eyj0AUzh/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJNll4ACgkQ3SOs138+
s6H3AA/8ChdHj0sdYCc2sTyKoZSt78iMAJsOzE65Xmc7eeU51exdcOjPG6EysgRb
Lgp/iu4ViEw4u6P9pvsA/buET898qfi96cHeoCESqrDza4NEqSwL6+8vr+I3l+ZV
YySgT6FbybCt6jmxo0BTg5Lw9Q/ytHl3RUtsS+CJCbmHd6jjzbXOoKdwCsyZZ/jh
dz4Ht6iW9k+1xg2kgr1KCPiVN5INHBSfqKuS1l9OYSUme3vfjEPt+XlqkKms9L4c
KNk1J5QQ/tujKhvUNNtjNstuVPAbNSue/FyTRPsoMH0ha8esJ9kZmA3UCEP/n3mY
gYzaRpk1CNrUxdIhmry6evmKnmnybcKtYZaLnc3VAJaSPrUu3ewuF1bm9Qdpi8XH
Ks4UsSDkrjUuPs+blRz5XKt/+AlQj9mnkAT4cUf/No9edP6oza0qyJXYcWRcYVRx
bxthehCUCeJLtb5nnKZ0I7jTBPN/vBlS7rZkzbUtyKJRp0Kspamgy/aNqDu0ynjR
IUaqFbe3r507xZP0za5BVEbOmdXy/+QwP3YvIdpj5/8i1JqBfRkeCMGDtWdu7/zC
t0f5rRfJswHx1DtYxbzWI8ULphiYrV4bHFVklhmduOAYWwJ1uLgYFgLzb/MlcgK7
quS3WEWN11kTWHlwm+BHv+3PCvxzIuiiNH5LbcKA1toTRlMWEwo=
=Cw0h
-----END PGP SIGNATURE-----

--Yd0gt/eyj0AUzh/G--
