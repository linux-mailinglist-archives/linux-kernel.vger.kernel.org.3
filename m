Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36251FF88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiEIOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiEIOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:21:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A320131D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:17:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gh6so27178168ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8+QqXVKL5wTk1USxhSJy91rHhDM1q+WdZU6lGP6JQ4=;
        b=Se5eMb8Ygo8+NTsu2WGGmLwSiZe3RssFpzMyc+7jXSDykSJnAVSZVnd/OngGPWZciL
         TqOhSSgSmDT040EiixkOlRjSjs+ukuyf54/dNj07uwd2adCU7iAHQeyZ6NPWcbIYVPwR
         pnseMj0cI03Ui9b5xM9w/yOlvf2/OlxlznUm1jexmSPMmaEiax93PQoJ/G6Q+n7fow9z
         IeuitDasdXBRSpB+6VIA+P3OanKlTTP+m6n8bakAwn+q9cJfZqwF1lR8LLdZPHpM+15i
         QZvAmWZBOy2/SBull0eHOksCzYbIomn1nr2T6ttdbSEDr1YAhsbO0VVKPlHOwot8XrnA
         S8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8+QqXVKL5wTk1USxhSJy91rHhDM1q+WdZU6lGP6JQ4=;
        b=zPS/1cFUbKZF2yUZG2zYwfeoBshwDaeCI4DjUxdu5zFkZRpAoHhImGqw//PsHMg1Pq
         VXcH4XoU0z9k5SjxTKiTsxxMBZ5wVCPDxL790K5YwjTDcRJz32v0NbsHC/6Hgy+4hAQt
         ampOY6LpXS8IdEB/PkdQW8/mtoxW2Crc94evougXKQkcB7C6+zMqjWqLShmdx8iMpcVz
         mO/3adkn21+SdVOCzDYyzXZczg7KsP0O1vTDcq4W7nRxLvtie6lccprdV5Iti5vL3FRh
         cdPu9lvm77aHchtzIfu0PjgIWRLloyhl0JW8qPHJnVAp9/ZcAUeAM1NA6qQqCQo3gcG4
         89uA==
X-Gm-Message-State: AOAM533hQBw93xtMHuB/oYVLpkzwLPU+yLmkPOL3uQ+H7sPyPEDOfU2o
        EOpa1qckpAOHMSXYHo+x2gUju60Z7s15SD00NfvM6w==
X-Google-Smtp-Source: ABdhPJz4oPKheaglIPZCKrUFsKejt51Mh50V9/DGs7u8F7syBlw3wHnbVvg9K8d9bl9luUK/vJye5kZrXA5cwi3Keig=
X-Received: by 2002:a17:907:a0c8:b0:6f7:492e:e74c with SMTP id
 hw8-20020a170907a0c800b006f7492ee74cmr11393092ejc.670.1652105834875; Mon, 09
 May 2022 07:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com> <20220508202544.501981-4-frattaroli.nicolas@gmail.com>
In-Reply-To: <20220508202544.501981-4-frattaroli.nicolas@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 9 May 2022 11:17:03 -0300
Message-ID: <CAAEAJfC5aoFmk7hKZ-CSv1=RhzO8YU38Abz8PhD26MvV+X0r-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add Hantro encoder node to rk356x
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Sun, May 8, 2022 at 5:26 PM Nicolas Frattaroli
<frattaroli.nicolas@gmail.com> wrote:
>
> The RK3566 and RK3568 come with a dedicated Hantro instance solely for
> encoding. This patch adds a node for this to the device tree, along with
> a node for its MMU.
>
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 7cdef800cb3c..2e3c9e1887e3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -508,6 +508,27 @@ gpu: gpu@fde60000 {
>                 status = "disabled";
>         };
>
> +       vepu: video-codec@fdee0000 {
> +               compatible = "rockchip,rk3568-vepu";
> +               reg = <0x0 0xfdee0000 0x0 0x800>;
> +               interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-names = "vepu";

It this block "encoder only" and if so, maybe we should remove the
"interrupt-names" [1]?

The driver is able to handle it. See:

https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/hantro/hantro_drv.c#L962

You might have to adjust the dt-bindings for this.

[1] https://lore.kernel.org/linux-media/20210324151715.GA3070006@robh.at.kernel.org/

Thanks,
Ezequiel

> +               clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> +               clock-names = "aclk", "hclk";
> +               iommus = <&vepu_mmu>;
> +               power-domains = <&power RK3568_PD_RGA>;
> +       };
> +
> +       vepu_mmu: iommu@fdee0800 {
> +               compatible = "rockchip,rk3568-iommu";
> +               reg = <0x0 0xfdee0800 0x0 0x40>;
> +               interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> +               clock-names = "aclk", "iface";
> +               power-domains = <&power RK3568_PD_RGA>;
> +               #iommu-cells = <0>;
> +       };
> +
>         sdmmc2: mmc@fe000000 {
>                 compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
>                 reg = <0x0 0xfe000000 0x0 0x4000>;
> --
> 2.36.0
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
