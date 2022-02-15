Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67814B6315
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiBOFtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:49:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiBOFtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:49:00 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B83CA55;
        Mon, 14 Feb 2022 21:48:50 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id o12so16438413qke.5;
        Mon, 14 Feb 2022 21:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bieAi62cXnjDaF9+psLIoa3qnNdCxk47hpRhQbwd4wU=;
        b=IcAfk0jc1uGalEZyNKcu/DnhhORNIOmxpzX7ZDMzgsIdfu1L91dKVfT0TFxsmYkPwd
         mf2VfdVvDtCJNrcolCauEeoaH8aavJnzW19a3oD31qX0GpWYzKUBKgO2PyVgjY/95y4A
         rLKsi0/g2XXR1Nh6Z/2VojL6qmfmS3iNzZw84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bieAi62cXnjDaF9+psLIoa3qnNdCxk47hpRhQbwd4wU=;
        b=yBF2uIwPX58nMD44SoUQbnAN5/N/V1RQEJ34sf6VyrNutHBu6+l6Yrd3v/Kxu4myRk
         C9vGEQHxgX5l/88ILeoYPrGmOUWV2U8JTod9gIXfAVU3r4ahbB+tajViW9Et6GROe8xO
         ZRjVe9RcZP3MyGfm40AVSsX2HDPJAlntGWqOIT3ndyZ0EmZ2ORoYCO13yLqkXbp3dgbi
         RkSgR/GTI1zHwzpmyNERHC30+TQaHuSl2Q9Wa7PsNFtEJlE+DcTaex+AaO11ysQVVIZc
         I3VddzHB9XZCDL3W9heFX0er3s0MI8SsJgCELBvEjdh9u/xueuE9TAvECD8s+vBEwW3P
         rL+g==
X-Gm-Message-State: AOAM531RutdDLMPD1x4GJvjUaiCYW6yXIjPfPP6AWP7uJdxWKekPv+6V
        rgfu3+tZR+LGBXDNjUOJsQJO0Y3VR4IqYFWBp7eYcvJDcGI=
X-Google-Smtp-Source: ABdhPJy0ddCs9WvjiZC4lM/FmWkHalSgAFzYH2nlatPRqwypfGD87kBmI2t4pz4vDpeqbPGkslg0MS8a2lVsbnJXbNs=
X-Received: by 2002:a05:620a:44c7:: with SMTP id y7mr1245865qkp.347.1644904129664;
 Mon, 14 Feb 2022 21:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20220214042538.12132-1-potin.lai@quantatw.com> <20220214042538.12132-6-potin.lai@quantatw.com>
In-Reply-To: <20220214042538.12132-6-potin.lai@quantatw.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 15 Feb 2022 05:48:37 +0000
Message-ID: <CACPK8Xf5W4h=dcBg_Pe1zjXUK73h8YH1tfL4RvoxV3DVsCL90g@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] arch: arm: dts: bletchley: switch to spi-gpio
 for spi2
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Patrick Williams <patrick@stwcx.xyz>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 14 Feb 2022 at 04:26, Potin Lai <potin.lai@quantatw.com> wrote:
>
> Switch to spi-gpio driver to avoid unstable signal issue with EVT HW
>
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index b01f1e7adb81..3c54e4a892c9 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -227,8 +227,16 @@
>
>  &spi2 {
>         status = "okay";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&pinctrl_spi2_default>;
> +
> +       compatible = "spi-gpio";

This is a bit strange. You're effectively rewriting the node with a new one.

It would make more sense to leave spi2 disabled (the default), and add
a new node:

 spi {
   compatible = "spi-gpio";
   #address-cells = <1>;
   #size-cells = <0>;
   gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
   gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
   gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
   num-chipselects = <1>;
  cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;

   flash@0 {
       status = "okay";

etc.

Your new spi node doesn't need the pinctrl or clock properties.

> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +       gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +       gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +       num-chipselects = <1>;
> +       cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
>
>         flash@0 {
>                 status = "okay";
> --
> 2.17.1
>
