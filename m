Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886964C8F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiCAPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiCAPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:43:11 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F64C798;
        Tue,  1 Mar 2022 07:42:29 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id k2so16570041oia.2;
        Tue, 01 Mar 2022 07:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBcp1dUn7B5lDlHW8pgYeTUcSNcQ5Zz+MDY5bkkCmd8=;
        b=HJlANK/nDvybNupVPUaZOI7BIYhTGa7c4HMN+h5oR2XQggS8gdZgVdf1gN6Bj2FdrX
         ib1yPRpo7TE+hc9dwblbRE9mMl8VXSp9b0YddyIKq4LYpcyfp94/kLvjXEckkXZHqIB6
         4jvcek82QGEeYpAt+zJ3/0wksGHcJSqY9IawV6aWcmj67ziMnX7a5vErVmuP2xEuLjcd
         n/yroi/mt8mxGcKnr85rDX3En9NNvm3eKvp2s05qlbrYOChI0Wjn9p9uwUwtmHKUxVgz
         Iz8amDB7Mhdc+1zZD+Srve3oilj/3Hux2XUdnygtUyyz7px096qqurvx/1jzDyIhmSqZ
         /KIQ==
X-Gm-Message-State: AOAM533hU5RN+xJqGeMRWcmRerkBzUWzfNe7f/Z/A6hyO47ZzmM5HwCP
        Qts6LNb/M8cEbYKwBFwV1A==
X-Google-Smtp-Source: ABdhPJxPB5vFDwS69zrVmm527ZhZ8VcpZx12y8+1SgvK8Td4nQGK41IrKuvhPUjgEn2lJog2IsFuPg==
X-Received: by 2002:a05:6808:e82:b0:2d4:1c37:d6ea with SMTP id k2-20020a0568080e8200b002d41c37d6eamr15299928oil.148.1646149348395;
        Tue, 01 Mar 2022 07:42:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w11-20020a056808140b00b002c0966d9521sm8279466oiv.10.2022.03.01.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:42:27 -0800 (PST)
Received: (nullmailer pid 1300489 invoked by uid 1000);
        Tue, 01 Mar 2022 15:42:26 -0000
Date:   Tue, 1 Mar 2022 09:42:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU
 support
Message-ID: <Yh4+4lK2Gb8SnHjA@robh.at.kernel.org>
References: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
 <20220228024013.2866386-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228024013.2866386-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:40:10AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
> between Sentinel and Cortex-A cores from hardware design, it could not be
> reused for other purpose.
> 
> However i.MX93 S4 MU use separate tx/rx interrupt, so update
> interrupts and add interrupt-names property.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> 
> Hi Rob,
>  For dual entries, I tested below with dt_binding_check and dtbs_check
>  "
>  +		s4muap: s4muap@47520000 {
>  +			compatible = "fsl,imx93-mu-s4";
>  +			reg = <0x47520000 0x10000>;
>  +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>  +			interrupt-names = "tx", "rx";
>  +			#mbox-cells = <2>;
>  +			status = "okay";
>  +		};
>  +
>  +		s4muap1: s4muap@48520000 {
>  +			compatible = "fsl,imx8ulp-mu-s4";
>  +			reg = <0x48520000 0x10000>;
>  +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  +			interrupt-names = "tx", "rx";

Well, that's wrong, but we don't check the length of 'foo-names' against 
'foo'.

>  +			#mbox-cells = <2>;
>  +			status = "okay";
>  +		};
>  "
> 
>  .../devicetree/bindings/mailbox/fsl,mu.yaml   | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index 6d056d5e16bf..82ce0280add9 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> @@ -29,6 +29,7 @@ properties:
>        - const: fsl,imx8ulp-mu
>        - const: fsl,imx8-mu-scu
>        - const: fsl,imx8-mu-seco
> +      - const: fsl,imx93-mu-s4
>        - const: fsl,imx8ulp-mu-s4
>        - items:
>            - const: fsl,imx93-mu
> @@ -55,7 +56,14 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: tx
> +      - const: rx
>  
>    "#mbox-cells":
>      description: |
> @@ -90,6 +98,24 @@ required:
>    - interrupts
>    - "#mbox-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx93-mu-s4
> +    then:
> +      properties:
> +        interrupt-names:
> +          minItems: 2
> +        interrupts:
> +          minItems: 2
> +
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1

You could add:

         not:
           required:
             - interrupt-names

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
