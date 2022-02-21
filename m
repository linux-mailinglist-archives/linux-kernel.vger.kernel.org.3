Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727954BDEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359259AbiBUNkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:40:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiBUNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:40:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BC13E22;
        Mon, 21 Feb 2022 05:39:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 125EC60AE8;
        Mon, 21 Feb 2022 13:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37809C340E9;
        Mon, 21 Feb 2022 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645450791;
        bh=OfzKE4RO72bJXlLVyV1wJI0i81I8/DbSdJeSzUUxZVw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=s9gVqXjkrTYBsZZ1Uu+UFsA4cCMaW0OwVLN/xIs3HwTZvmJ2jDd1A3xEc0gR8eoSW
         j+EaxQGuBJvxlt6AiMkS9DbhJYU2xdZ8m1KnvYomXxgysgCMevd2LYi606LCrOcoT6
         RcrxiQoDHZnoplu0AYiYPUOf0LducKiQMWrHmr5zocgeShCdmgQKyhy0qmbNu5LxP7
         3XJQ74sKhXI2mG7a2cbBHqqmLx9LB0Q9QQhY9obZdQ3770wLAmJnjt2fac4d+KjF/L
         FGeyFiK7uWnUqHLq9QF5iRwsaCETRD6+43IsfL+LdpeAjjlu/vYey80AiKCAAOKa4c
         2PVjRsDe07Fag==
Message-ID: <de4d010b-a271-4814-489e-fe357fc512b7@kernel.org>
Date:   Mon, 21 Feb 2022 15:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: update Roger Quadros email
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
References: <20220221100701.48593-1-krzysztof.kozlowski@canonical.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220221100701.48593-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/2022 12:07, Krzysztof Kozlowski wrote:
> Emails to Roger Quadros TI account bounce with:
>   550 Invalid recipient <rogerq@ti.com> (#5.1.1)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Roger Quadros <rogerq@kernel.org>


> 
> ---
> 
> Roger,
> You should also add a mailmap entry for your inactive emails.
> 
> Best regards,
> Krzysztof
> ---
>  .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml     | 2 +-
>  Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml         | 2 +-
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml         | 2 +-
>  Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 272832e9f8f2..fa86691ebf16 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -20,7 +20,7 @@ description: |
>  
>  maintainers:
>    - Kishon Vijay Abraham I <kishon@ti.com>
> -  - Roger Quadros <rogerq@ti.com
> +  - Roger Quadros <rogerq@kernel.org>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> index 51c8a36e61f0..8694b9eb52f9 100644
> --- a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> @@ -8,7 +8,7 @@ title: OMAP USB2 PHY
>  
>  maintainers:
>    - Kishon Vijay Abraham I <kishon@ti.com>
> -  - Roger Quadros <rogerq@ti.com>
> +  - Roger Quadros <rogerq@kernel.org>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index a634774c537c..eedde385d299 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -7,7 +7,7 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
>  title: Bindings for the TI wrapper module for the Cadence USBSS-DRD controller
>  
>  maintainers:
> -  - Roger Quadros <rogerq@ti.com>
> +  - Roger Quadros <rogerq@kernel.org>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> index f6e91a5fd8fe..4f7a212fddd3 100644
> --- a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: TI Keystone Soc USB Controller
>  
>  maintainers:
> -  - Roger Quadros <rogerq@ti.com>
> +  - Roger Quadros <rogerq@kernel.org>
>  
>  properties:
>    compatible:
