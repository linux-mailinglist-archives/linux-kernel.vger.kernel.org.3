Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89C64CB27A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiCBWqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCBWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:46:34 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702CF41F91;
        Wed,  2 Mar 2022 14:45:45 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c4so3106527qtx.1;
        Wed, 02 Mar 2022 14:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wLxQSWkpzXF5tY/7dhFq7NegATh4JOWyJEkhfbTW4Mk=;
        b=JKKK4ZKr4cwCdWc1nw3VxKtFXOQrTDf6OBiW5+7nS3JjIQwwd0rolyMVPH5WA3VibD
         LaZc7QbqPQsaq3ayoK7I8Gf8inwR2aXZcEqDR7Pv4+fCNsQrOCH9KMlb1p/O3LO1zd8H
         klXo7j+oEJXwt7YaV/uVVDbo86vBVuvZfGdj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wLxQSWkpzXF5tY/7dhFq7NegATh4JOWyJEkhfbTW4Mk=;
        b=XsjeuWNbCrpLLzek2Ootvhli/OUtrx2g2YVJ11M20Dg4bshGueOJ6Ne9YEWq1cOsQa
         bq1N6dT/f/x5iaZ5apuLQoyeVkdics7EZlbbq0Oy9yYoL7b+2yRb/uFa+gRUQlX6gbhg
         0eYeAb4AbQkx/3YnlED+P8j08Q7GrFEFvfg9xxOxDzwKDvTQxfnO7EeWf11j+ulg+nCV
         SgnLyz9YaDOAXgI2TChEEfd+w+aXAHZlzGmZRQnmjzj6d09Q6ZCMXIwO/PesJD0JE1CO
         L2fEaIzGyShpc8aV1Xw17yR4ipI7UuAfUrTw7dZzCMTXYCswrroVZ1v56ZyWBi6l7D2q
         rfbg==
X-Gm-Message-State: AOAM531xfWww7XdklG0JJO2VcGOSQCkxpxg2KgFq6iKUPNcmWCEW0azK
        NUY+nkCSyBjhiEhyfOx4KmPtI0jCAByh43vw1AU=
X-Google-Smtp-Source: ABdhPJymvDCH6PF2srWw9pDWgGtnV5XoPV5xFh1ZDzmH6/M1lw30F42PT45weIxU8j+zOpLU9We9ISprqvrjqkeLYQ4=
X-Received: by 2002:a05:622a:283:b0:2de:b3a2:b52d with SMTP id
 z3-20020a05622a028300b002deb3a2b52dmr22291580qtw.625.1646261144434; Wed, 02
 Mar 2022 14:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-11-clg@kaod.org>
In-Reply-To: <20220302173114.927476-11-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:45:31 +0000
Message-ID: <CACPK8XeDBCMCEO4=w7qUQxsYiFUDKPAuBhXW5Sr6=UHM_GRsWA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: dts: aspeed: Enable Dual SPI RX transfers
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

On Wed, 2 Mar 2022 at 17:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> All these controllers support at least Dual SPI. Update the DTs.
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks. I'll apply this to the aspeed tree now.

Did you also have a patch to add a second flash chip to the AST2400 FMC?

> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
>  arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-=
g4.dtsi
> index 9ae67e83cf60..31e6569db97e 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -64,27 +64,32 @@ fmc: spi@1e620000 {
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
> @@ -100,6 +105,7 @@ flash@0 {
>                                 reg =3D < 0 >;
>                                 compatible =3D "jedec,spi-nor";
>                                 spi-max-frequency =3D <50000000>;
> +                               spi-rx-bus-width =3D <2>;
>                                 status =3D "disabled";
>                         };
>                 };
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-=
g5.dtsi
> index c3e0a8e13c8a..29bf017899b6 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -66,18 +66,21 @@ flash@0 {
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
> @@ -93,12 +96,14 @@ flash@0 {
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
> @@ -114,12 +119,14 @@ flash@0 {
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
> index 1ad05dde19d2..ce93c56a21a7 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -106,18 +106,21 @@ flash@0 {
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
> @@ -133,12 +136,14 @@ flash@0 {
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
> @@ -154,18 +159,21 @@ flash@0 {
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
