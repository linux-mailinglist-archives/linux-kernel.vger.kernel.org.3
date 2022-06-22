Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34147554D03
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358029AbiFVO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358158AbiFVO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223621C93B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:28:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cf14so14405891edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KF2rN6or5HKqUuQgEplVYVKSFo8eqgnFjZPNJQPN7DY=;
        b=wHtAo5TFotLBbcElJtBbyRlvW3Fh6/jVwjWcRSfL74sxvd7rCWnn9WKriUvEaGefY9
         NAoYhzEoSrAAXIVCQ8ubyBS5nW8rY/NzPQQOygi1LLqnhZ9YfrThXn4yeqxAcS/btKXE
         iTOpWZvsCeW+Il067F706l+8m99tSltHYDpniSuZNIRE2orW1WZCAHFD2C3RvhUAZ7I2
         88hhfHDMeN0ORI+QmtZ+EyUM2kr5gguenwyxas9XZrNfWGhKxaJBHQT0/WWU1WhJPQ5a
         nHXis3h+j4Gbh4Ste8bEmc5JRPP7xqX5Uss0t6wJtjksbQI/eBQoLoFnPYaLBrO9gx0K
         2XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KF2rN6or5HKqUuQgEplVYVKSFo8eqgnFjZPNJQPN7DY=;
        b=kEIbNke1JnY8KGt+iDgeumJPlh61jwf8OO7Lubxh6Q5PaepsLUdUEmUTfNFkPfE9yx
         X4X/4fsXnqg35TbYd7lFGYIeSYTOBJKQ914J3mkO3dZbk35650bQLqJgG6lJZYfBY0kI
         dKiVJEyPB/8sE56kttRV3FrC6piQ4j8L3HDL6VxpU1qGyGv+ImBhv6LcfoULAl5iOlCS
         X4cZqAV3u+MuuJyF0WD3bEShHxyB2JunJjj/HqvbXEtgHef7yqCn6Y3Ag8d7oXDb9ly6
         JLziLH9L2k9hR9O5ewsDLkqk4LKIZDVvOz26nzbjSgLRBogtegMLstzrBBC9ZlJSJuXB
         relw==
X-Gm-Message-State: AJIora+5i5RlbqeaRFwbMckjtTM2ZLQnNAlg2AyRKVEDLZ25XmmeKlCg
        I3IzFvmEwLjncn2PFYWNXH1VGgYFR/kN8A==
X-Google-Smtp-Source: AGRyM1v26ha318CN8KJM3KWSrdhQTfAp/GKOeRT0mkhtPFB53FRQRyFwPmVys9k8fqLFOlUe6dJ4xg==
X-Received: by 2002:aa7:c542:0:b0:435:75e:8a7b with SMTP id s2-20020aa7c542000000b00435075e8a7bmr4498560edr.108.1655908094665;
        Wed, 22 Jun 2022 07:28:14 -0700 (PDT)
Received: from [192.168.0.225] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g36-20020a056402322400b004357f88fcdcsm8130733eda.11.2022.06.22.07.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:28:14 -0700 (PDT)
Message-ID: <767ffc9d-bc36-c627-8245-e46a46e6974d@linaro.org>
Date:   Wed, 22 Jun 2022 16:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 01/13] dt-bindings: Add bindings for Tegra234 Host1x
 and VIC
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220622113733.1710471-1-cyndis@kapsi.fi>
 <20220622113733.1710471-2-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622113733.1710471-2-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 13:37, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Update VIC and Host1x bindings for changes in Tegra234.
> 
> Namely,
> - New compatible strings
> - Sharded syncpoint interrupts
> - Optional reset.
> 
> Also, fix the order of descriptions for VM/hypervisor
> register apertures -- while the reg-names specification
> was correct, the descriptions for these were switched.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> * Add back 'required' for resets/reset-names on older SoCs
> * Simplified reg descriptions
> * Updated commit message
> ---
>  .../display/tegra/nvidia,tegra124-vic.yaml    |   1 +
>  .../display/tegra/nvidia,tegra20-host1x.yaml  | 110 +++++++++++++++---
>  2 files changed, 95 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
> index 37bb5ddc1963..7200095ef19e 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
> @@ -21,6 +21,7 @@ properties:
>            - nvidia,tegra210-vic
>            - nvidia,tegra186-vic
>            - nvidia,tegra194-vic
> +          - nvidia,tegra234-vic
>  
>        - items:
>            - const: nvidia,tegra132-vic
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> index 0adeb03b9e3a..5fe25e0a8d48 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> @@ -24,6 +24,7 @@ properties:
>            - nvidia,tegra210-host1x
>            - nvidia,tegra186-host1x
>            - nvidia,tegra194-host1x
> +          - nvidia,tegra234-host1x
>  
>        - items:
>            - const: nvidia,tegra132-host1x
> @@ -31,23 +32,19 @@ properties:
>  
>    reg:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
>  
>    reg-names:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
>  
>    interrupts:
> -    items:
> -      - description: host1x syncpoint interrupt
> -      - description: host1x general interrupt
>      minItems: 1
> +    maxItems: 9
>  
>    interrupt-names:
> -    items:
> -      - const: syncpt
> -      - const: host1x
>      minItems: 1
> +    maxItems: 9
>  
>    '#address-cells':
>      description: The number of cells used to represent physical base addresses
> @@ -110,13 +107,35 @@ required:
>    - reg
>    - clocks
>    - clock-names
> -  - resets
> -  - reset-names
>  
>  additionalProperties:
>    type: object
>  
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra20-host1x
> +              - nvidia,tegra30-host1x
> +              - nvidia,tegra114-host1x
> +              - nvidia,tegra124-host1x
> +              - nvidia,tegra210-host1x
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: host1x syncpoint interrupt
> +            - description: host1x general interrupt
> +
> +        interrupt-names:
> +          items:
> +            - const: syncpt
> +            - const: host1x
> +      required:
> +        - resets
> +        - reset-names
>    - if:
>        properties:
>          compatible:
> @@ -133,10 +152,8 @@ allOf:
>  
>          reg:
>            items:
> -            - description: physical base address and length of the register
> -                region assigned to the VM
> -            - description: physical base address and length of the register
> -                region used by the hypervisor
> +            - description: region used by the hypervisor
> +            - description: region assigned to the virtual machine
>  
>          resets:
>            maxItems: 1
> @@ -144,6 +161,67 @@ allOf:
>          reset-names:
>            maxItems: 1
>  
> +        interrupts:
> +          items:
> +            - description: host1x syncpoint interrupt
> +            - description: host1x general interrupt
> +
> +        interrupt-names:
> +          items:
> +            - const: syncpt
> +            - const: host1x
> +
> +        iommu-map:
> +          description: Specification of stream IDs available for memory context device
> +            use. Should be a mapping of IDs 0..n to IOMMU entries corresponding to
> +            usable stream IDs.
> +
> +      required:
> +        - reg-names
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra234-host1x
> +    then:
> +      properties:
> +        reg-names:
> +          items:
> +            - const: common
> +            - const: hypervisor
> +            - const: vm
> +
> +        reg:
> +          items:
> +            - description: region used by host1x server
> +            - description: region used by the hypervisor
> +            - description: region assigned to the virtual machine
> +
> +        interrupts:
> +          items:
> +            - description: host1x syncpoint interrupt 0
> +            - description: host1x syncpoint interrupt 1
> +            - description: host1x syncpoint interrupt 2
> +            - description: host1x syncpoint interrupt 3
> +            - description: host1x syncpoint interrupt 4
> +            - description: host1x syncpoint interrupt 5
> +            - description: host1x syncpoint interrupt 6
> +            - description: host1x syncpoint interrupt 7
> +            - description: host1x general interrupt
> +
> +        interrupt-names:
> +          items:
> +            - const: syncpt0
> +            - const: syncpt1
> +            - const: syncpt2
> +            - const: syncpt3
> +            - const: syncpt4
> +            - const: syncpt5
> +            - const: syncpt6
> +            - const: syncpt7
> +            - const: host1x
> +
>          iommu-map:
>            description: Specification of stream IDs available for memory context device
>              use. Should be a mapping of IDs 0..n to IOMMU entries corresponding to
> @@ -160,8 +238,8 @@ examples:
>      host1x@50000000 {
>          compatible = "nvidia,tegra20-host1x";
>          reg = <0x50000000 0x00024000>;
> -        interrupts = <0 65 0x04   /* mpcore syncpt */
> -                      0 67 0x04>; /* mpcore general */
> +        interrupts = <0 65 0x04>, /* mpcore syncpt */
> +                     <0 67 0x04>; /* mpcore general */

Split this part to separate patch.

Rest looks good but because of dependency cannot be tested by automation.

>          interrupt-names = "syncpt", "host1x";
>          clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
>          clock-names = "host1x";


Best regards,
Krzysztof
