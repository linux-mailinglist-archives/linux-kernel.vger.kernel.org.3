Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1232957F894
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 06:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiGYEVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 00:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiGYEVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 00:21:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3363EBF67
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 21:21:50 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id a82so12467749ybb.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 21:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRIMLhNzniGmJDLr8hgDHMMmDqECr4wHUSe1ln5hTXc=;
        b=LHtwlJ3eJ6pjY+AynHuB4CDUtC3Qp3Qkh41InQCw2XREHd6Ffh+ONhZQFQ1fZVAd6c
         ASZsDRB0J1GNNLMyGemQUUp4iKn+AjzsIU1eOHoSezrukvqJR25JC9SB8nwaTKWFpSc6
         vq+jcN0BqUFvZ1LLW8gk6cRJtXAczlJO9PY3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRIMLhNzniGmJDLr8hgDHMMmDqECr4wHUSe1ln5hTXc=;
        b=YZ8Ympp8ysLZHEGlF4/82a+aM6rSA6DgBAbbrDS8nD1xd34ErWSwsTZ0mZ9Bs7bVZa
         8IG8IEawHHUZRgJXTB0+1+mdmsgUT8lpdPVJbU7zxcnNOSfsqj5I8fOMuGrNrGz5vnGH
         Mq4LYAx04ZmNbgfgtmFn9DixrHVaY0x8TVX9ait+d+UfuCBCQc70hgZXmKVVTzeKKUi+
         hxI11IjpL7Ke1j/1gK1b8zzst+LzMBXtQzdGxAd02gtaH2LwNKfWVf67iZ/Ud3GLSiXz
         egzNnBwrdASZZ6ZNLdeM3Uu9UOdUtPSyqCKoqfmsT3bOPhai0br+8nh1kyK82ImvvyO+
         XTfw==
X-Gm-Message-State: AJIora9bwBAZAyFYx4ohM7nQuE4xMK/zQkE7UaPPn6tox/2nFde9uR+Z
        gX9ICYA8FJcIcYVCCyw727lVqD/99hxfO/71MTkjXQ==
X-Google-Smtp-Source: AGRyM1v35hu3rl303nhQ3bWU0cZJvL9HOCZggvpIMDexKusxxOIzAzbt0gFlEdWmAHpTdC7Oyyrh1kSabGi4UCNkr3M=
X-Received: by 2002:a25:cc11:0:b0:670:851a:7e5e with SMTP id
 l17-20020a25cc11000000b00670851a7e5emr7555299ybf.501.1658722909063; Sun, 24
 Jul 2022 21:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com> <20220721145017.918102-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721145017.918102-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Jul 2022 12:21:38 +0800
Message-ID: <CAGXv+5Ekk_ndyPGVmWWRFkE3uveDHSczyf2OsdhOtqfSHxvnMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: mediatek: cherry: Enable the System
 Companion Processor
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:50 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MT8195 features a SCP like some other older SoCs, and Cherry uses it
> for various tasks. Add the required pin configuration and DMA pool
> and enable the node.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index fcc600674339..feebbe367e93 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -104,6 +104,18 @@ usb_vbus: regulator-5v0-usb-vbus {
>                 enable-active-high;
>                 regulator-always-on;
>         };
> +
> +       reserved_memory: reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               scp_mem: memory@50000000 {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x50000000 0 0x2900000>;
> +                       no-map;
> +               };
> +       };
>  };
>
>  &i2c0 {
> @@ -600,6 +612,14 @@ pins-low-power-pupd {
>                 };
>         };
>
> +       scp_pins: scp-default-pins {
> +               pins-vreq {
> +                       pinmux = <PINMUX_GPIO76__FUNC_SCP_VREQ_VAO>;
> +                       bias-disable;
> +                       input-enable;
> +               };
> +       };
> +
>         spi0_pins: spi0-default-pins {
>                 pins-cs-mosi-clk {
>                         pinmux = <PINMUX_GPIO132__FUNC_SPIM0_CSB>,
> @@ -643,6 +663,14 @@ &pmic {
>         interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>  };
>
> +&scp {
> +       status = "okay";
> +
> +       memory-region = <&scp_mem>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&scp_pins>;

firmware-name = "mediatek/mt8195/scp.img";

Or maybe this should be added to the base mt8195.dtsi?

The entry for mt8192 was added to mt8192-asurada.dtsi though.

Tinghan, could you ask internally whether the SCP firmware should be
tied to the SoC or the projects involving the SoC?

Thanks
ChenYu

> +};
> +
>  &spi0 {
>         status = "okay";
>
> --
> 2.35.1
>
>
