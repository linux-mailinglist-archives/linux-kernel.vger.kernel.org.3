Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD9C4B814F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiBPHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:22:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiBPHWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:22:01 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8886919282;
        Tue, 15 Feb 2022 23:21:45 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z15so1260874qtx.13;
        Tue, 15 Feb 2022 23:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0OJpzZG2s6Ox5c2MteDuzD1t6oUEsSxi/uYhG05ln+o=;
        b=XIlpY2CijHAufToCwE90Tw8Ji+c/jA0OZ+YYf3jN6xLY8wO4iqaaamGGULGGLcTUFH
         fEnBSXHyCWr5aMej08c+2Dr5c86wncICv1QmdjgAx6q+aYC506EzL/BNvEg6ceMvjGRa
         sKK4r39DL5tMTLBU/D5j9z9yaWYERTG15IWI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0OJpzZG2s6Ox5c2MteDuzD1t6oUEsSxi/uYhG05ln+o=;
        b=MFrO7rJMF5DyimDWmGcO418KWtq6ILwbM8C98SJZEmRxNRrb9o9BYT8kaoeytOTCH/
         mzZbzM0degHpkjipZOLssP6oYhSkYxuvcTXM5SiYfmch+gYCJhTZTBwDWptVFECOXUuH
         oA68opGNHFUgMaE7PE6jhC6iY2morGsWUg3oqsaC5YXvYdtvX5Upeam587jrOgX/Rizq
         kQ6B/qGzMCIaEall5yQwgH+x2TSqvFBZdR7CilNEhWfRlGVuPS4UDVC+DCW6WColOzTe
         MDLyK+upIfOyI2lwHnI7SDCcVBoPFYtsRW7HptlkfL1ggR2G+kfnPeEyuqhtzDlVr+mD
         AwQg==
X-Gm-Message-State: AOAM531eCZGMtd1QWm2iJI/6QRCJo0TBlAz7X5UdQQn55MZTf2Cu+QYn
        MZqKmgb6gDCdUVdMysl4fB/xe5bK+JsoIanqSjI=
X-Google-Smtp-Source: ABdhPJzA6l0C3w5nIyZqmUOGDNvMpQfSG2jJhyTSmE/2H0f84Ix2EkssFZZW204yIEa9skj6uTX2l/o+YpyukE86AmI=
X-Received: by 2002:ac8:5b82:0:b0:2cf:232d:b1f8 with SMTP id
 a2-20020ac85b82000000b002cf232db1f8mr1115201qta.58.1644996102080; Tue, 15 Feb
 2022 23:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20220214094231.3753686-1-clg@kaod.org> <20220214094231.3753686-10-clg@kaod.org>
In-Reply-To: <20220214094231.3753686-10-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Feb 2022 07:21:29 +0000
Message-ID: <CACPK8Xd5peBdJ2MYH6OcT+vWyjdmKaOpNFw=eHKp6=RPjc6X=g@mail.gmail.com>
Subject: Re: [PATCH 09/10] ARM: dts: aspeed: Enable Dual SPI RX transfers
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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
        Rob Herring <robh+dt@kernel.org>,
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

On Mon, 14 Feb 2022 at 09:43, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> All these controllers support at least Dual SPI. Update the DTs.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-=
g4.dtsi
> index f14dace34c5a..da211fbd8658 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -65,27 +65,32 @@ fmc: spi@1e620000 {
>                         flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
> +                               spi-rx-bus-width =3D <2>;
>                                 spi-max-frequency =3D <50000000>;
>                                 status =3D "disabled";
>                         };
>                         flash@1 {
>                                 reg =3D < 1 >;
>                                 compatible =3D "jedec,spi-nor";
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@2 {
>                                 reg =3D < 2 >;
>                                 compatible =3D "jedec,spi-nor";
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@3 {
>                                 reg =3D < 3 >;
>                                 compatible =3D "jedec,spi-nor";
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@4 {
>                                 reg =3D < 4 >;
>                                 compatible =3D "jedec,spi-nor";
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> @@ -102,6 +107,7 @@ flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-=
g5.dtsi
> index 7495f93c5069..804b66d32127 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -67,18 +67,21 @@ flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@1 {
>                                 reg =3D < 1 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@2 {
>                                 reg =3D < 2 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> @@ -95,12 +98,14 @@ flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@1 {
>                                 reg =3D < 1 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> @@ -117,12 +122,14 @@ flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@1 {
>                                 reg =3D < 1 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-=
g6.dtsi
> index c32e87fad4dc..542714c61a85 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -107,18 +107,21 @@ flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@1 {
>                                 reg =3D < 1 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@2 {
>                                 reg =3D < 2 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> @@ -135,12 +138,14 @@ flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@1 {
>                                 reg =3D < 1 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> @@ -157,18 +162,21 @@ flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@1 {
>                                 reg =3D < 1 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                         flash@2 {
>                                 reg =3D < 2 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> --
> 2.34.1
>
