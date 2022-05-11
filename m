Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6A5237F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbiEKQAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243128AbiEKQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:00:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929F215E760
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:00:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so4935892eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eFymRECNSN5ye7k5OChXPswBlwaVnIJWXD7MjpienjQ=;
        b=F8pFd7IGqv380dhqtK0KUi/veBULkaOkmVT6fq87+YWimx0KDIrCzrcCX8IYQKF/e2
         oifPmC+J49ba6koD7ggfZOyGFUhIjC2N+16S6Grd6DDdO60jDtNJ02G4RaGXPqY1N6uF
         RAJX0qkM4aeq3FAX3HSSC4FdYlg494N45ZRXgjh3MBE2G5mA1qADr3Z3HX5PrnfAKsE+
         3qAF2nttDit3HJJA3df5v3MsyBoApdNtXGFtcvI+NrNFU5H4aNtop8fpoKoYE0tamXnY
         epxaeiEPpwQ3xxKm3aJ/LyLPCYh3aaXRXwiV6gV7AifLUaDZlElN6m9ZtJ0RNh42fQ/U
         D4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eFymRECNSN5ye7k5OChXPswBlwaVnIJWXD7MjpienjQ=;
        b=PWYDq5bc2EqEGQbO3FbYk4Nu+yHtwQE4y43oKO1O33fTR7ODOroFLUC00bnZlmd8qn
         V1yINx8bLVLQRLvvalSEbY2av4yeiEZG5TMA0PxzGlAf3IGUcEjII7HtD8P3Xz0+t7Pl
         nPFd42WSVeaq4TUJfXfg1VhhPFCIAdODw23sL6lgmRNMIbK8fnvFOPkL/3frkDGdgxrc
         BPTlU8HU2KP/hSNvMTliCqOFOmofChuREWpXA0xDWUin9ExoHBbq3nUrzpg60USELjxR
         1POzEuxHXmT2FD/BtBYEBG89Nmcv3XyBdGgjWEZjlMs862/Ou0FW6uAs92vmJhIPeNrL
         ZO+Q==
X-Gm-Message-State: AOAM532A/73ob8K/mhgkjesYOmDUy7vSa4NGLYPGpbiREpyN6WMF+5Wd
        6uker8mIvvbTXn0/QeBt3tVILw==
X-Google-Smtp-Source: ABdhPJysoqA/nzZ30scYkBwjFxjUK+dAiYf2mo8FGsNQSfR4U30SbuOWRSjFXYoH1g9Yg334VcVh6g==
X-Received: by 2002:a17:907:9690:b0:6f5:160a:25b8 with SMTP id hd16-20020a170907969000b006f5160a25b8mr25654920ejc.504.1652284811118;
        Wed, 11 May 2022 09:00:11 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z12-20020a50e68c000000b0042617ba63b7sm1513122edm.65.2022.05.11.09.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:00:10 -0700 (PDT)
Message-ID: <bc4c395d-4e21-1d15-96be-00a5cad1d6f7@linaro.org>
Date:   Wed, 11 May 2022 18:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 VEPU
 compatible
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220511155309.2637-1-frattaroli.nicolas@gmail.com>
 <20220511155309.2637-2-frattaroli.nicolas@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511155309.2637-2-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 17:53, Nicolas Frattaroli wrote:
> The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
> encoding. This patch adds a compatible for it, and also allows
> the bindings to only come with a vepu interrupt.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  .../devicetree/bindings/media/rockchip-vpu.yaml | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> index bacb60a34989..965ca80b5cea 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> @@ -22,6 +22,7 @@ properties:
>            - rockchip,rk3288-vpu
>            - rockchip,rk3328-vpu
>            - rockchip,rk3399-vpu
> +          - rockchip,rk3568-vepu
>            - rockchip,px30-vpu
>        - items:
>            - const: rockchip,rk3188-vpu
> @@ -39,7 +40,9 @@ properties:
>  
>    interrupt-names:
>      oneOf:
> -      - const: vdpu
> +      - enum:
> +          - vdpu
> +          - vepu
>        - items:
>            - const: vepu
>            - const: vdpu
> @@ -76,6 +79,18 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  # compatibles that end in -vepu should only have the vepu interrupt
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: "^[a-zA-Z0-9\\-,_.]+\\-vepu$"

Why not listing the compatible how I asked? This is the common way of
handling allOf:if:then per variant.

https://lore.kernel.org/all/ea94f18d-3172-98bb-0892-a98236a08018@linaro.org/

Your patches do not apply on next, so the set might not have been tested
by Rob's bot.

Best regards,
Krzysztof
