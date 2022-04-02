Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539F14F0148
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbiDBL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiDBLzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:55:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC6E42A37
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:54:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4958764wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V52rlSjUBjX18q5ePyn3LpZBqOKHJkgta+5HwLHOMW0=;
        b=XnK5bAIIi3zv7T/ehR45S4jlZjPkJ3/qNvHnmVWibopnvsRSX4bQ+IXKBkxvYpvObo
         zkFccOHMwJZam2O2w9NUGl5eXq5f2qkDQGKJjNZiCRfZLKiPSCcb0t1e+x1wg5fQCOfZ
         5PjVSFI2HvTAgFYVgr+E5DuGbFmD2e09RTJfrLSRnmSbwnXLmSkfSjBzcmTOwPQNAzH1
         VsGUp/c8zQMvbc8wbfyQ5I9g9gxjDEGL1mbELrDq7DKFBitRQnHsbwbx/LD9KBugb5jx
         MAoi5cljy4BS0owsuIF2L8AR8t+jdmr/9d0AnFAnzbIDklNdTDaPiHA2jJGfefJj/q5k
         ek+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V52rlSjUBjX18q5ePyn3LpZBqOKHJkgta+5HwLHOMW0=;
        b=6C7oKsjdgGjo7lV5KKF5t9v/DKbVRXnxYPHvf7zisNuBaShjlKYD0FUZ5kw/PBX53y
         /Yvv2hvMZj6AZu7KR60wCOM3ymoXVGRqU9EbPc3ccHyVH1nGJYlfkcT2d97nEEVVHFgf
         TDzmr4ELyvCxTEk5k7bMry/aAvVYYt/l8owkL34ItMCapubxnzFLKRcYxrhS+9KGLUX3
         McLzIXHfFiFqJw07xlPc63w/2sbshPPGPwOqXLBcHh9jwJUm1jOx0DBhYLHwBAOja9Cx
         IybIKsFRY20cNDzDnYw0H9I3RdeuDFRGf3a4fuTx2siJrtm0eQL+cFB2NtqpejumpdcV
         RYKg==
X-Gm-Message-State: AOAM533M6iHJcrD4nVKyYmYaDWS7hcG7GCTh8c2rXCvtVZ4LfiZ+HWvJ
        gib4pvQygL3lVCnmPDQE8xpPUQ==
X-Google-Smtp-Source: ABdhPJzUxBryntMkO+ZJ8h+ZNSftDQhD4nc+rc5NkfcA9DVOV7UTv+TTeh6AFJbQTccTWOey+XICoA==
X-Received: by 2002:a7b:cb84:0:b0:382:a9b9:2339 with SMTP id m4-20020a7bcb84000000b00382a9b92339mr12503684wmi.91.1648900440042;
        Sat, 02 Apr 2022 04:54:00 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c414b00b0038e4b2f0478sm6504812wmm.1.2022.04.02.04.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 04:53:59 -0700 (PDT)
Message-ID: <30305936-4b69-e1ce-44c2-0d1d113b460e@linaro.org>
Date:   Sat, 2 Apr 2022 13:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 28/33] dt-bindings: crypto: rockchip: convert to new
 driver bindings
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzk+dt@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-29-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401201804.2867154-29-clabbe@baylibre.com>
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

On 01/04/2022 22:17, Corentin Labbe wrote:
> The latest addition to the rockchip crypto driver need to update the
> driver bindings.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 68 +++++++++++++++++--
>  1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> index 66db671118c3..e6c00bc8bebf 100644
> --- a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> @@ -11,8 +11,18 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - rockchip,rk3288-crypto
> +    oneOf:
> +      - description: crypto IP present on RK3288 SoCs
> +        items:
> +          - const: rockchip,rk3288-crypto
> +      - description: crypto IP present on RK3328 SoCs

These two comments are not helping, so this should be just enum.

> +        items:
> +          - const: rockchip,rk3328-crypto
> +      - description: crypto IPs present on RK3399. crypto0 is the first IP with
> +                     RSA support, crypto1 is the second IP without RSA.

The second part of this comment is helpful, first not. You have chosen
enum in your first patch, so just extend it with comments. Additionally
indexing does not scale. What if next generation reverses it and crypto0
does not have RSA and crypto1 has?

Something like:

properties:
  compatible:
    enum:
      - rockchip,rk3288-crypto
      - rockchip,rk3328-crypto
        # With RSA
      - rockchip,rk3399-crypto-rsa
        # Without RSA
      - rockchip,rk3399-crypto-norsa

> +        enum:
> +          - rockchip,rk3399-crypto0
> +          - rockchip,rk3399-crypto1
>  
>    reg:
>      maxItems: 1
> @@ -21,16 +31,65 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 3
>      maxItems: 4
>  
>    clock-names:
> +    minItems: 3
>      maxItems: 4
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
>  
>    reset-names:
> -    maxItems: 1
> +    deprecated: true

Why reset-names are being deprecated? Did we talk about this?

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3288-crypto
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: "aclk"
> +            - const: "hclk"
> +            - const: "sclk"
> +            - const: "apb_pclk"
> +          minItems: 4

minItems for clocks
max for resets and reset-names

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3328-crypto
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: "hclk_master"
> +            - const: "hclk_slave"
> +            - const: "sclk"
> +          maxItems: 3

min/max for clocks
max for resets and reset-names

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3399-crypto0
> +              - rockchip,rk3399-crypto1
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: "hclk_master"
> +            - const: "hclk_slave"
> +            - const: "sclk"
> +          maxItems: 3
> +        resets:
> +          minItems: 3

Similarly.


Best regards,
Krzysztof
