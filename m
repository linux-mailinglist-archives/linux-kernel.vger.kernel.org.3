Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B04ECAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349414AbiC3Rmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349416AbiC3Rmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:42:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE731F47CF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:40:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x34so25292016ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YGgEuO2+JFPK80wetBysVATEfSSmmFQ7dKqnJvZ/yF0=;
        b=C7EjKku7df+a8GqKhOPDfYj3kb3TEpo3DG3jdawgzS//JNHlN1EDttotGPuPwtZJqM
         13D87HXLQB1i5Zu593BdRvAHvXU2KZCBghKr5ZLWbUc7+SnOCwc7yxNTP8xQIkWECbwj
         x3r/HJ2H/u+PriS72aSR3Sf0AHoqNESldgoSj3jfUU6xdgfLQNatOWx4Dk2HIwMKZG/t
         ru4+bBvbX1eqRI6dJS/5SpPN7MQ78ioWLTa1Nz4k4fHbBJb5Gby0TFttUbzYcSaLKJ94
         GF23IZVQM50w9cL6RAnZA1kWRyAhc9QLJWfy1QFRG4lo6DIv/M5nk7ILGeU+nNs2QPjm
         9qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YGgEuO2+JFPK80wetBysVATEfSSmmFQ7dKqnJvZ/yF0=;
        b=kVI4vyFfe7ZKBy98vGxX5/V7Sm2WyHlxCdVK2nKHe6uZShGd9CucAixFcw2IVXaJYR
         zF8lVgHHurGkDrIYMMon+L4tpfx3sctvaeyUp/xaVsKGJHDDSkiXmAR1/I+fkUlu8MP9
         uiyzLp90pgrtqX0NCONVG4NHNFFa6lJnV4XUlb5hCgKTYdzAh+7w2FC3x/TDml7QMd1n
         /jyyGozUpmv7HzN6GX24DNUj7PW0mMLr7T2BRue7EJ6LtFszxBmcXxcNiAs2HcSKmpD5
         wtqeGplau0bTMWfat5BUT6XrZa1vad/PpOZLypwu3N5ThJdETWTFh5PYsAtnIAuE0huW
         2E9g==
X-Gm-Message-State: AOAM531CHWSbRfWgcRZ9KxxvMm8dY5VrWtoLP06uuGyviU1/5DFsrq3c
        l7/aruBW5qvUckD6C22m6G4Iag==
X-Google-Smtp-Source: ABdhPJxFwTarbPZKAhjXkXZlx0EdUDAVJlJ4obq31ATerLLtSuoVnaN+CJoSs2qJYnnkd0lo+8HTEg==
X-Received: by 2002:a50:fd04:0:b0:419:9c4a:7d79 with SMTP id i4-20020a50fd04000000b004199c4a7d79mr12268837eds.99.1648662035149;
        Wed, 30 Mar 2022 10:40:35 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id dk21-20020a0564021d9500b0041b501eab8csm2718953edb.57.2022.03.30.10.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:40:34 -0700 (PDT)
Message-ID: <a784ed61-965a-5c68-c2dd-3340cf18c7b5@linaro.org>
Date:   Wed, 30 Mar 2022 19:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 5/5] dt-bindings: phy: uniphier: Clean up clocks,
 resets, and their names using compatible string
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648637715-19262-6-git-send-email-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648637715-19262-6-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 12:55, Kunihiko Hayashi wrote:
> Instead of "oneOf:" choices, use "allOf:" and "if:" to define clocks,
> clock-names, resets, and reset-names that can be taken by the compatible
> string.
> 
> The order of clock-names and reset-names doesn't change here.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../phy/socionext,uniphier-ahci-phy.yaml      | 90 +++++++++++++-----
>  .../phy/socionext,uniphier-pcie-phy.yaml      | 47 ++++++---
>  .../phy/socionext,uniphier-usb3hs-phy.yaml    | 93 ++++++++++++++----
>  .../phy/socionext,uniphier-usb3ss-phy.yaml    | 95 +++++++++++++++----
>  4 files changed, 251 insertions(+), 74 deletions(-)
> 

(...)

> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> index 1bbd164f2527..21e4414eea60 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> @@ -34,30 +34,12 @@ properties:
>      minItems: 2
>      maxItems: 3
>  
> -  clock-names:
> -    oneOf:
> -      - items:               # for Pro5
> -          - const: gio
> -          - const: link
> -      - items:               # for PXs3 with phy-ext
> -          - const: link
> -          - const: phy
> -          - const: phy-ext
> -      - items:               # for others
> -          - const: link
> -          - const: phy
> +  clock-names: true
>  
>    resets:
>      maxItems: 2
>  
> -  reset-names:
> -    oneOf:
> -      - items:               # for Pro5
> -          - const: gio
> -          - const: link
> -      - items:               # for others
> -          - const: link
> -          - const: phy
> +  reset-names: true
>  
>    vbus-supply:
>      description: A phandle to the regulator for USB VBUS
> @@ -80,6 +62,77 @@ properties:
>        required for each port, if any one is omitted, the trimming data
>        of the port will not be set at all.
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: socionext,uniphier-pro5-usb3-hsphy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: gio
> +            - const: link
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: gio
> +            - const: link
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - socionext,uniphier-pxs2-usb3-hsphy
> +              - socionext,uniphier-ld20-usb3-hsphy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: link
> +            - const: phy
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: link
> +            - const: phy
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - socionext,uniphier-pxs3-usb3-hsphy
> +              - socionext,uniphier-nx1-usb3-hsphy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2

Why minItems:2? Is the last phy-ext clock optional?

> +          maxItems: 3
> +        clock-names:
> +          minItems: 2
> +          items:
> +            - const: link
> +            - const: phy
> +            - const: phy-ext
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: link
> +            - const: phy
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
> index 06c957d52d23..4c26d2d2303d 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
> @@ -35,34 +35,89 @@ properties:
>      minItems: 2
>      maxItems: 3
>  
> -  clock-names:
> -    oneOf:
> -      - items:             # for Pro4, Pro5
> -          - const: gio
> -          - const: link
> -      - items:             # for PXs3 with phy-ext
> -          - const: link
> -          - const: phy
> -          - const: phy-ext
> -      - items:             # for others
> -          - const: link
> -          - const: phy
> +  clock-names: true
>  
>    resets:
>      maxItems: 2
>  
> -  reset-names:
> -    oneOf:
> -      - items:              # for Pro4,Pro5
> -          - const: gio
> -          - const: link
> -      - items:              # for others
> -          - const: link
> -          - const: phy
> +  reset-names: true
>  
>    vbus-supply:
>      description: A phandle to the regulator for USB VBUS, only for USB host
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - socionext,uniphier-pro4-usb3-ssphy
> +              - socionext,uniphier-pro5-usb3-ssphy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: gio
> +            - const: link
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: gio
> +            - const: link
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - socionext,uniphier-pxs2-usb3-ssphy
> +              - socionext,uniphier-ld20-usb3-ssphy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: link
> +            - const: phy
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: link
> +            - const: phy
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - socionext,uniphier-pxs3-usb3-ssphy
> +              - socionext,uniphier-nx1-usb3-ssphy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2

Same question as above.

> +          maxItems: 3
> +        clock-names:
> +          minItems: 2
> +          items:
> +            - const: link
> +            - const: phy
> +            - const: phy-ext
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: link
> +            - const: phy
> +
>  required:
>    - compatible
>    - reg


Best regards,
Krzysztof
