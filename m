Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9A46BEFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhLGPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:17:39 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37537 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhLGPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:17:36 -0500
Received: by mail-oi1-f172.google.com with SMTP id bj13so28281552oib.4;
        Tue, 07 Dec 2021 07:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gHLh/twxwqdkYak+CGLf6Up0AGsQd0DPoFCh/1guPoU=;
        b=3+Xqc5oKBF2irowKGOlUommx+RVj8F0C5YAjCHz85trAG4F9ORXzjVPu8FYhVn9zxr
         uDngpyjOvhK3dzcz4iVHk8FNW+GKGTgqw/jr2dFStp2LvgO5U/hbUcO/PT3vGC9PWOUb
         fl2Jq8qSF/mzvsDliQ7p0OnXm7sRh91zB0MOzLfgBCAjdPBBWwltm5hGsOdH9Mav5rcm
         9evQblu9DidPgPdd9uqdEPQkOWYGNoKZuMzcfrlmB/9POVCnjh4t2WKZ5loQTkr7MuAZ
         X0Wq01m9lqqUUTaILESrZrlQsRAxP1VmwHgVerB0HefJTted4FocjmJFIENxm1dURIlG
         Od4A==
X-Gm-Message-State: AOAM533Ml31iCzR90UUcJaxLg5zy0Hak6lAM3Ww8SOhPcoei2RyVUe/N
        811aJF3mHrBVfB+yqplECAnZPW47QA==
X-Google-Smtp-Source: ABdhPJxIOWxApR2yPnoWn9mY/qhX8SpsrfoNf6wadNvZU6y0quA1Gbdi2DDCY4nBeHPW8uEW3WuDhA==
X-Received: by 2002:a54:438d:: with SMTP id u13mr5649541oiv.156.1638890045676;
        Tue, 07 Dec 2021 07:14:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 184sm3297341oih.58.2021.12.07.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 07:14:04 -0800 (PST)
Received: (nullmailer pid 59673 invoked by uid 1000);
        Tue, 07 Dec 2021 15:14:03 -0000
Date:   Tue, 7 Dec 2021 09:14:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, cphealy@gmail.com,
        benjamin.gaignard@collabora.com, hverkuil@xs4all.nl,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [RFC V2 3/6] dt-bindings: media: nxp,imx8mq-vpu: Update the
 bindings for G2 support
Message-ID: <Ya96O6VXuIDdcM8p@robh.at.kernel.org>
References: <20211207015446.1250854-1-aford173@gmail.com>
 <20211207015446.1250854-4-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207015446.1250854-4-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 07:54:42PM -0600, Adam Ford wrote:
> From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> 
> Introducing the G2 hevc video decoder requires modifications of the bindings to allow
> one node per VPU.

Why? It looks like the G2 part was already described. If you are 
changing this because you want 2 drivers for G1 and G2, then NAK. DT 
nodes and drivers don't have to be 1:1. This change is breaking 
compatibility.

> 
> VPUs share one hardware control block which is provided as a phandle on
> a syscon.

That's not really ideal. Is this really a separate block?

> Each node has now one reg and one interrupt.
> Add a compatible for G2 hardware block: nxp,imx8mq-vpu-g2.
> 
> To be compatible with older DT the driver is still capable to use the 'ctrl'
> reg-name even if it is deprecated now.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> index 762be3f96ce9..eaeba4ce262a 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> @@ -15,37 +15,36 @@ description:
>  
>  properties:
>    compatible:
> -    const: nxp,imx8mq-vpu
> +    oneOf:
> +      - const: nxp,imx8mq-vpu-g1
> +      - const: nxp,imx8mq-vpu-g2
>  
>    reg:
> -    maxItems: 3
> -
> -  reg-names:
> -    items:
> -      - const: g1
> -      - const: g2
> -      - const: ctrl
> +    maxItems: 1
>  
>    interrupts:
> -    maxItems: 2
> +    maxItems: 1
>  
>    interrupt-names:
> -    items:
> +    oneOf:
>        - const: g1
>        - const: g2
>  
>    clocks:
> -    maxItems: 3
> +    maxItems: 1
>  
>    clock-names:
> -    items:
> +    oneOf:
>        - const: g1
>        - const: g2
> -      - const: bus
>  
>    power-domains:
>      maxItems: 1
>  
> +  nxp,imx8m-vpu-ctrl:
> +    description: Specifies a phandle to syscon VPU hardware control block
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

This is optional?

> +
>  required:
>    - compatible
>    - reg
> @@ -60,20 +59,27 @@ additionalProperties: false
>  examples:
>    - |
>          #include <dt-bindings/clock/imx8mq-clock.h>
> +        #include <dt-bindings/power/imx8mq-power.h>
>          #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> -        vpu: video-codec@38300000 {
> +        vpu_g1: video-codec@38300000 {
>                  compatible = "nxp,imx8mq-vpu";
> -                reg = <0x38300000 0x10000>,
> -                      <0x38310000 0x10000>,
> -                      <0x38320000 0x10000>;
> -                reg-names = "g1", "g2", "ctrl";
> -                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                             <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -                interrupt-names = "g1", "g2";
> -                clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
> -                         <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
> -                         <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
> -                clock-names = "g1", "g2", "bus";
> -                power-domains = <&pgc_vpu>;
> +                reg = <0x38300000 0x10000>;
> +                reg-names "g1";
> +                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +                interrupt-names = "g1";
> +                clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> +                clock-names = "g1";
> +                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
> +        };
> +
> +        vpu_g2: video-codec@38310000 {
> +                compatible = "nxp,imx8mq-vpu-g2";
> +                reg = <0x38300000 0x10000>;
> +                reg-names "g2";
> +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +                interrupt-names = "g2";
> +                clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> +                clock-names = "g2";
> +                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
>          };
> -- 
> 2.32.0
> 
> 
