Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09D4CB227
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiCBWTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbiCBWS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:18:57 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD73585C;
        Wed,  2 Mar 2022 14:18:13 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e2so3000448qte.12;
        Wed, 02 Mar 2022 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2JRE6tbH9Jchu709JG4dssWGKFhyKl3gMsPnj2zX+PA=;
        b=kKssYOalX/FXhhqROEbcNxZ1Xddce0m3w13wsWFdcHHXL+HS5ZulI1OyHuKUp6bDlo
         Z/YGveSc8kPzpploW3uii7UvJwBRhXAO8FZR9fMfes3JHn0N6Q+he2swoS8YiW+Rchpo
         ocKtuGRvBEXB90CPMVjaIv0uBqWcVElO9/IuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2JRE6tbH9Jchu709JG4dssWGKFhyKl3gMsPnj2zX+PA=;
        b=24UiNq9lOQTCDaqb82Au7mQ0X6R3HKdZu8a8NCZ/c9liNV2XWdQ024/MbtFfH2AgNW
         C+Raakn0BkQfm/5E9VpF2l4TUUt0KSGVq+SdNr0+zNexgSAOCXOzzIK5M5yZBghx8p4R
         cO4s94aZq4mPxYzG04wG8zw5ZCNunp+71z/JGOLczLcI8vjWR07UQzfYx2WOVpREzmlf
         seMPw6e5lfBu7X6sJtHwdZTCpjTZGUweClVW/384Vsam8VJW5hQEh/GeveSQVHULa5dc
         oXfwrGysI1U8lpgpj89X4gFOj/tZX3+/0WwlTEH47StlB+Z0z7aPnpKjBeeUSyEayuG1
         vOpQ==
X-Gm-Message-State: AOAM533jxrQc1RbgLLa96OSbzT2S+jT178ba9G5swlbobNEHSwrYs5wU
        Bs6dezYeLXGxoS+eY/B4Ff0O7a4J3AYEQFQULL4=
X-Google-Smtp-Source: ABdhPJxRlFb0AT7SCyWwi+w7C/nNOeB3qsPtkPJA5AY8m0O88pSi5Hia8/814ex0IlxYX3s0CwkZASyT+/WE78Emhfs=
X-Received: by 2002:a05:622a:283:b0:2de:b3a2:b52d with SMTP id
 z3-20020a05622a028300b002deb3a2b52dmr22224392qtw.625.1646259492771; Wed, 02
 Mar 2022 14:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-3-clg@kaod.org>
In-Reply-To: <20220302173114.927476-3-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:18:00 +0000
Message-ID: <CACPK8XdqYJeRkGN3j0qKfSnbYHgAsogKhv7e1PGTY+MBy=N=Rg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] ARM: dts: aspeed: Adjust "reg" property of
 FMC/SPI controllers
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 17:32, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> This is compatible with the current driver and addresses issues when
> running 'make dt_binding_check'.

Hey Rob, why does the checking rule complain about this style of reg proper=
ty?

>
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++----
>  arch/arm/boot/dts/aspeed-g5.dtsi | 9 +++------
>  arch/arm/boot/dts/aspeed-g6.dtsi | 9 +++------
>  3 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-=
g4.dtsi
> index f14dace34c5a..9ae67e83cf60 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -54,8 +54,7 @@ ahb {
>                 ranges;
>
>                 fmc: spi@1e620000 {
> -                       reg =3D < 0x1e620000 0x94
> -                               0x20000000 0x10000000 >;
> +                       reg =3D <0x1e620000 0x94>, <0x20000000 0x10000000=
>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "aspeed,ast2400-fmc";
> @@ -91,8 +90,7 @@ flash@4 {
>                 };
>
>                 spi: spi@1e630000 {
> -                       reg =3D < 0x1e630000 0x18
> -                               0x30000000 0x10000000 >;
> +                       reg =3D <0x1e630000 0x18>, <0x30000000 0x10000000=
>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "aspeed,ast2400-spi";
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-=
g5.dtsi
> index 7495f93c5069..c3e0a8e13c8a 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -55,8 +55,7 @@ ahb {
>                 ranges;
>
>                 fmc: spi@1e620000 {
> -                       reg =3D < 0x1e620000 0xc4
> -                               0x20000000 0x10000000 >;
> +                       reg =3D <0x1e620000 0xc4>, <0x20000000 0x10000000=
>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "aspeed,ast2500-fmc";
> @@ -84,8 +83,7 @@ flash@2 {
>                 };
>
>                 spi1: spi@1e630000 {
> -                       reg =3D < 0x1e630000 0xc4
> -                               0x30000000 0x08000000 >;
> +                       reg =3D <0x1e630000 0xc4>, <0x30000000 0x08000000=
>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "aspeed,ast2500-spi";
> @@ -106,8 +104,7 @@ flash@1 {
>                 };
>
>                 spi2: spi@1e631000 {
> -                       reg =3D < 0x1e631000 0xc4
> -                               0x38000000 0x08000000 >;
> +                       reg =3D <0x1e631000 0xc4>, <0x38000000 0x08000000=
>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "aspeed,ast2500-spi";
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-=
g6.dtsi
> index c32e87fad4dc..1ad05dde19d2 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -95,8 +95,7 @@ gic: interrupt-controller@40461000 {
>                         };
>
>                 fmc: spi@1e620000 {
> -                       reg =3D < 0x1e620000 0xc4
> -                               0x20000000 0x10000000 >;
> +                       reg =3D <0x1e620000 0xc4>, <0x20000000 0x10000000=
>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "aspeed,ast2600-fmc";
> @@ -124,8 +123,7 @@ flash@2 {
>                 };
>
>                 spi1: spi@1e630000 {
> -                       reg =3D < 0x1e630000 0xc4
> -                               0x30000000 0x10000000 >;
> +                       reg =3D <0x1e630000 0xc4>, <0x30000000 0x10000000=
>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "aspeed,ast2600-spi";
> @@ -146,8 +144,7 @@ flash@1 {
>                 };
>
>                 spi2: spi@1e631000 {
> -                       reg =3D < 0x1e631000 0xc4
> -                               0x50000000 0x10000000 >;
> +                       reg =3D <0x1e631000 0xc4>, <0x50000000 0x10000000=
>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "aspeed,ast2600-spi";
> --
> 2.34.1
>
