Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9D477E71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhLPVIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:08:49 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43587 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbhLPVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:51 -0500
Received: by mail-ot1-f42.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so402567otu.10;
        Thu, 16 Dec 2021 13:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cx2O43LmNvC8GyZN+btCibCu9iyCGJB6KtMGjIeaSF8=;
        b=tAhxa82boYVfuFCdJl6a8kCpj1kuyWQMCpmqvq8uq4eh/4yOzCtNVEJYgWpjVwOSnN
         Bxpo37StKyciDfwwRecWCENb4L5lZ7J57Cdobhxbw/WXJ2pE9DBwhrw0+gRvRGWWyNq5
         fbQQ7vsnuOHzVeQG378Ew2V3EYfoeX4ziS06/zeZM3sDRNo8uGFYvSI+0z2K3WTbq8lt
         rWEnNPnOqpDLpKPpBRHV4D75H/OVpLMWSU+rcL9043kFH7HDGHDnNN6UpM2HH31F/kHl
         r1/ugTRQ6gI1VU534fhOMEbhl53itJs/jCtGwn1lJixTO+PlPQvW98Ysb3K3C/0QfALM
         HolA==
X-Gm-Message-State: AOAM531pKrVpEowE4AaMPICTOaI0xAcSMmpNIda1A2EcblLfsnobbEXX
        +MBpxNMW4xajHcuGIKMRPw==
X-Google-Smtp-Source: ABdhPJwpr9IO7zj4qWR3cuBfdUVvEAAstbCB8u01288B7/rYhH2qI+Lua/zGG9hBO0hoFbVeIQE+3w==
X-Received: by 2002:a9d:1ca9:: with SMTP id l41mr14278100ota.341.1639688870339;
        Thu, 16 Dec 2021 13:07:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 184sm1194863oih.58.2021.12.16.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:07:50 -0800 (PST)
Received: (nullmailer pid 764267 invoked by uid 1000);
        Thu, 16 Dec 2021 21:07:49 -0000
Date:   Thu, 16 Dec 2021 15:07:49 -0600
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
Subject: Re: [PATCH V2 08/10] dt-bindings: media: nxp,imx8mq-vpu: Add support
 for G1 and G2 on imx8mm
Message-ID: <YbuqpayfYVPp1dTe@robh.at.kernel.org>
References: <20211216111256.2362683-1-aford173@gmail.com>
 <20211216111256.2362683-9-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216111256.2362683-9-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:12:53AM -0600, Adam Ford wrote:
> The i.MX8M mini appears to have a similar G1 and G2 decoder but the
> post-procesing isn't present, so different compatible flags are requred.

post-processing

> Since all the other parameters are the same with imx8mq, just add
> the new compatible flags to nxp,imx8mq-vpu.yaml.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> index c1e157251de7..b1f24c48c73b 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> @@ -5,7 +5,7 @@
>  $id: "http://devicetree.org/schemas/media/nxp,imx8mq-vpu.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  
> -title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ SoCs
> +title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ/i.MX8MM SoCs

Just 'i.MX8' so we don't have to change this everytime?

>  
>  maintainers:
>    - Philipp Zabel <p.zabel@pengutronix.de>
> @@ -20,6 +20,8 @@ properties:
>          deprecated: true
>        - const: nxp,imx8mq-vpu-g1
>        - const: nxp,imx8mq-vpu-g2
> +      - const: nxp,imx8mm-vpu-g1
> +      - const: nxp,imx8mm-vpu-g2

Not compatible with the imx8mq variants?

>  
>    reg:
>      maxItems: 1
> @@ -66,3 +68,27 @@ examples:
>                  clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
>                  power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
>          };
> +  - |
> +        #include <dt-bindings/clock/imx8mm-clock.h>
> +        #include <dt-bindings/power/imx8mm-power.h>
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +        vpu_g1: video-codec@38300000 {
> +                compatible = "nxp,imx8mm-vpu-g1";
> +                reg = <0x38300000 0x10000>;
> +                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&clk IMX8MM_CLK_VPU_G1_ROOT>;
> +                power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G1>;
> +        };
> +  - |
> +        #include <dt-bindings/clock/imx8mm-clock.h>
> +        #include <dt-bindings/power/imx8mm-power.h>
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +        vpu_g2: video-codec@38300000 {
> +                compatible = "nxp,imx8mm-vpu-g2";
> +                reg = <0x38310000 0x10000>;
> +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&clk IMX8MM_CLK_VPU_G2_ROOT>;
> +                power-domains = <&vpu_blk_ctrl IMX8MM_VPUBLK_PD_G2>;
> +        };

No point in more examples just for a different compatible.

> -- 
> 2.32.0
> 
> 
