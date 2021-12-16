Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9E477A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbhLPR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:29:15 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43945 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhLPR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:29:14 -0500
Received: by mail-oi1-f176.google.com with SMTP id w64so3479508oif.10;
        Thu, 16 Dec 2021 09:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGDKRwosuspfYWxZApqXKSNZ+F/8DLGm7NO/ffPXmr0=;
        b=LDERC2TzyuqcTGa6DhOCgTQYW5upMvrizhHTexUW3dJsQ2FgKBELIdmvdAUJ8yqZjn
         pUxsHoh0KJTCYomQ9qlpTb71DrqcHyURLUPxfBP0703koIPqM7qcs3O2YIIk81inAXlr
         1efDFNQKpIwmeJ42cA6Ujy1Jn1A/t+FLSq7dmw/WQ/OYCQ6Yz9C4qAvKwPBtZFgPgzG6
         UY1VG+ZsePnK9Rm+cJYvDBCIBD5AskiAocoLAbg7z/Dfw0FvNLmWEptzR1xb5pcxj12j
         EBoOza79JHyKb4cyefYR6SPpg69YbZeCjSP7I+XJCtSnWXDJ7xR/Io2GQHoqIRDNtLEB
         ORWg==
X-Gm-Message-State: AOAM530rmPSvXS6eI7MGHfFndt5say2lLGknvH32llGsYa0EOODjxxI1
        0S8Jm2zm9HZRa8O1JF56ew==
X-Google-Smtp-Source: ABdhPJzpIdbfDFxlf+VQ8oNO/3zvGLjwEQsh7u9aVYPQ0hfaH6c6G98GZZ3yZtc9iElIOJF/los3iw==
X-Received: by 2002:a05:6808:1a02:: with SMTP id bk2mr4936718oib.52.1639675754325;
        Thu, 16 Dec 2021 09:29:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e26sm1102831oog.46.2021.12.16.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:29:13 -0800 (PST)
Received: (nullmailer pid 430626 invoked by uid 1000);
        Thu, 16 Dec 2021 17:29:12 -0000
Date:   Thu, 16 Dec 2021 11:29:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, abel.vesa@nxp.com,
        aford@beaconembedded.com, benjamin.gaignard@collabora.com,
        hverkuil-cisco@xs4all.nl,
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
Subject: Re: [PATCH V2 04/10] dt-bindings: media: nxp,imx8mq-vpu: Split G1
 and G2 nodes
Message-ID: <Ybt3aHfscuKMM0ie@robh.at.kernel.org>
References: <20211216111256.2362683-1-aford173@gmail.com>
 <20211216111256.2362683-5-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216111256.2362683-5-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:12:49AM -0600, Adam Ford wrote:
> The G1 and G2 are separate decoder blocks that are enabled by the
> vpu-blk-ctrl power-domain controller, which now has a proper driver.
> Update the bindings to support separate nodes for the G1 and G2
> decoders with vpu-blk-ctrl power-domain support.

You could expand this a bit more with Lucas' explanation and being 
explicit on the compatibility implications.

Otherwise, with that and indentation fixed:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> index 762be3f96ce9..c1e157251de7 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> @@ -15,33 +15,20 @@ description:
>  
>  properties:
>    compatible:
> -    const: nxp,imx8mq-vpu
> +     oneOf:
> +      - const: nxp,imx8mq-vpu
> +        deprecated: true
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
> -
> -  interrupt-names:
> -    items:
> -      - const: g1
> -      - const: g2
> +    maxItems: 1
>  
>    clocks:
> -    maxItems: 3
> -
> -  clock-names:
> -    items:
> -      - const: g1
> -      - const: g2
> -      - const: bus
> +    maxItems: 1
>  
>    power-domains:
>      maxItems: 1
> @@ -49,31 +36,33 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - reg-names
>    - interrupts
> -  - interrupt-names
>    - clocks
> -  - clock-names
>  
>  additionalProperties: false
>  
>  examples:
>    - |
>          #include <dt-bindings/clock/imx8mq-clock.h>
> +        #include <dt-bindings/power/imx8mq-power.h>
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +        vpu_g1: video-codec@38300000 {
> +                compatible = "nxp,imx8mq-vpu-g1";
> +                reg = <0x38300000 0x10000>;
> +                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
> +                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
> +        };
> +  - |
> +        #include <dt-bindings/clock/imx8mq-clock.h>
> +        #include <dt-bindings/power/imx8mq-power.h>
>          #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> -        vpu: video-codec@38300000 {
> -                compatible = "nxp,imx8mq-vpu";
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
> +        vpu_g2: video-codec@38300000 {
> +                compatible = "nxp,imx8mq-vpu-g2";
> +                reg = <0x38310000 0x10000>;
> +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
> +                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
>          };
> -- 
> 2.32.0
> 
> 
