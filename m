Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB75769F5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiGOWgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiGOWf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:35:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579A78BA9D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:35:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b6so3072456wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HBF1B79IIedCwHvdJGS8cmm6JrlM62/nduTPrlZmdLw=;
        b=bjN5fNMS6fCYWu85LBfhtS4Sjd/k1/GGBAs8w2uHuDTycThBQx0r9wYTWJWT6aBEqq
         uyT5wlQZNCJENpaMiYiuTv/nq1SFssqkn3q7xz8Qqn8URzApz5iUOMYRzX9lW8zrhhTh
         xG9v/66bqHZ06qr53dRDqtJZYX3u6ALibf9X0eHvywsTGelo27cpSyQnmWHGhadAA33a
         JNqXXg0otU3s8/Vs6EWKYSGayCK75OXfP8taE7f+xVKLItIAUskp1a6E3FKOHtMiYzkM
         dOCwEVUwf8eC567/UxTaXpdHigdq12fDJ44C4KhhR45eez2GZfkKx6zdbmFNpUYuxIGs
         eWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HBF1B79IIedCwHvdJGS8cmm6JrlM62/nduTPrlZmdLw=;
        b=n6G9FSkQd4LPbah7s1rE3/dAoKi/er1zYbPOwJhAt8/vi4GUyFCnLzfarDIa2DkYVm
         RpZ6V0JheQNIjzmT9d26K1ZM1SsMAXWcfmBcDRWuInT6BQiEVZPfp3nvBFazHfjdqaZz
         4PJfbH/KYHeINpGlMsugBaqkJahCoWJuonqihkbU1HgNTScd/7kx69dFZC8uBKXuv185
         7l1sXSZ4GFVRn/IOCYTJsvTE91SnypEEQIQ+SuKIaNxFI96CczHYjduGcj7ldsZXGfXi
         RJ5mxjZhGKxSvatOtixUEnV9Rt+x6BZoEqPdTNIhnPznugqCIlHbnvpfaDXJ/PGrGWIE
         XQag==
X-Gm-Message-State: AJIora/KqzEgta/Bvw99EpX66LT4VF5JV13ysqOYaZbsvjGUJ7C+ZCjy
        3ykt3N5gJ+s7qlnlxIOJDRQOBQ==
X-Google-Smtp-Source: AGRyM1sEXVpXQpUbjt1Vmt9jF2dZkzMOh7zuOjiy2TAojBvfakWnhxBJBIzW4HlnZcGpWrZYXl4RFw==
X-Received: by 2002:a05:600c:1992:b0:3a1:9252:c373 with SMTP id t18-20020a05600c199200b003a19252c373mr21652210wmq.140.1657924547835;
        Fri, 15 Jul 2022 15:35:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a223:f4b3:40c9:43fa? ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.googlemail.com with ESMTPSA id y18-20020a05600c365200b003a2c67aa6c0sm7755297wmq.23.2022.07.15.15.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 15:35:47 -0700 (PDT)
Message-ID: <62b1f1bd-c15d-662c-027e-1cdeff5eb580@linaro.org>
Date:   Sat, 16 Jul 2022 00:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: timer: renesas,cmt: Add r8a779f0 and
 generic Gen4 CMT support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
 <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 12:06, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Krzysztof ?

> ---
>   .../devicetree/bindings/timer/renesas,cmt.yaml         | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> index 53dd6d9f518f..7cc1ec4b4e38 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
> @@ -83,6 +83,11 @@ properties:
>                 - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
>             - const: renesas,rcar-gen3-cmt0 # 32-bit CMT0 on R-Car Gen3 and RZ/G2
>   
> +      - items:
> +          - enum:
> +              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
> +          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
> +
>         - items:
>             - enum:
>                 - renesas,r8a774a1-cmt1     # 48-bit CMT on RZ/G2M
> @@ -100,6 +105,11 @@ properties:
>                 - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
>             - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/G2
>   
> +      - items:
> +          - enum:
> +              - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
> +          - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
> +
>     reg:
>       maxItems: 1
>   


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
