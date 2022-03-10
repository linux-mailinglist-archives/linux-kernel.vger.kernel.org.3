Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7774D46FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbiCJMam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbiCJMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:30:37 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D9B818A5;
        Thu, 10 Mar 2022 04:29:36 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p15so11698819ejc.7;
        Thu, 10 Mar 2022 04:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvM9bpVqadFGT6cTj1FgeTbHx/untvfyWRFVU5A7JsI=;
        b=SrcrDgBhBKn4+VnFUMlAEETG43sIlaSqOgAHopzDVTrptjvyakX8mQdXxW99D7Cadp
         uRjTTytvfVQ9+vjrrvmMI1Pud2XIytkDFyt8JxDpnuOgMLp1BjClFjlIeQ8mqv0OSNNh
         lCTYmoGDqb6IwjPPP0Sfuv/n6nkZl1qvMc7DiViPcxx9l7s4CjlVAzxPDXc1hCaT4Gx8
         LuJ1l5J4CGaiLwZ+tdk+PMTsvTPk37GwP5G/i/DqRjnBg3DuQS2S+DxWriW2Kv1gujZP
         BhZmwOoz0EQSed0flzuxhxqqP4fTNxIcwiWgPtjRyO1iU7Mv4dS+jEoRxpJWLTnli2oT
         W0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvM9bpVqadFGT6cTj1FgeTbHx/untvfyWRFVU5A7JsI=;
        b=TGbB7eWih1K4FAZ6PtnhpOVYLwSZwl4ZYw6z1xLfbNJ+21Nf/8Ndp1dd1Rsl0EUn3F
         s4SjJGsOI7m+Rbr0L4HjaPLn3pcSjQCiLNWlAW2UYCID9YTnAmCr7zhittXf/9bgnp/g
         dzvY72Xxzp4D7/OdEs2+SPwu09pqDk0BvO+CGtaKqzI9jsCJ6K6WK4lALCG0jhRzdBgr
         Q38qlOL6azoLnjonkB9IeUbL04jyoUS1OIZkC1S9fEyd50G7jyJ32XYvDzm92RjhGeNa
         gvxQkKW6SpHDEuvAuvsTzx3KjWX2XTDaa6rb4FN0oMR4NS9OXIMJ7/L2Slz1QTB1qIKJ
         8jEw==
X-Gm-Message-State: AOAM532Cn7z74rBDLbOB5nqP8RVKgqyETgBxzvUAfP2ub5ZX2y9m+HGJ
        5Yy57rlJsbAs0+Ogk6I+L4bCQnTaqlxjRnz8w/U=
X-Google-Smtp-Source: ABdhPJwbtiAMQz9G/jYe3ISah8jTsiGU5IhD7/7DVnW8LV+hNJXY6XvlTpAK2teBoBh7TYw/ra5mYNoltIFfd2cu8dA=
X-Received: by 2002:a17:907:7f06:b0:6d6:f8f7:2655 with SMTP id
 qf6-20020a1709077f0600b006d6f8f72655mr4010142ejc.658.1646915374966; Thu, 10
 Mar 2022 04:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20220210134049.32576-1-ariel.dalessandro@collabora.com> <20220210134049.32576-2-ariel.dalessandro@collabora.com>
In-Reply-To: <20220210134049.32576-2-ariel.dalessandro@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 10 Mar 2022 09:29:23 -0300
Message-ID: <CAOMZO5DuB4d1243H46d1=heiNiz+pQVkjrGU+zV_r3GFKRTZfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mn-bsh-smm-s2pro: Add
 tlv320aic31xx audio card node
To:     "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ariel,

On Thu, Feb 10, 2022 at 10:41 AM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:

> +&i2c2 {
> +       clock-frequency = <400000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c2>;
> +       status = "okay";
> +
> +       codec: tlv320dac3101@18 {
> +               #sound-dai-cells = <0>;
> +               compatible = "ti,tlv320dac3101";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_dac_rst>;
> +               reg = <0x18>;
> +
> +               ai31xx-micbias-vg = <MICBIAS_AVDDV>;
> +
> +               HPVDD-supply = <&buck4_reg>;
> +               SPRVDD-supply = <&vdd_input>;
> +               SPLVDD-supply = <&vdd_input>;
> +               AVDD-supply = <&buck4_reg>;
> +               IOVDD-supply = <&buck4_reg>;
> +               DVDD-supply = <&buck5_reg>;
> +               reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +
> +               clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
> +               clock-names = "mclk";

The clocks and clock-names properties are not documented in the codec bindings.

Also, the driver does not use call clk_get() on this mclk clock.

You should drop the clocks and clock-names properties.
