Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25AA598137
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243958AbiHRKCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiHRKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:02:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209D98FD6C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:01:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m3so1020434ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EPxzHwYhFlft26MSmbXxer1pCM7eMFS2V0bDjoXyAJU=;
        b=eEyiXUfctANEiiWIrg9Y5EqIuZU09pRr7ZymPkvek4Ap91RbdKI7jw15XsDiehwsmK
         HnYwSQDCa/kUdgXXYdEwax3exEU5TXaQFQGgokYN+jlp8rKPFuBY00u+/52gfWnWSHJB
         XRHDi5P6qO3L3T3EmrLE8tlFymLjIxwLa/2W+InzaIVjmaHNlmVmlcGQgu+mOg9FNfIB
         CuqfKF+pWfgaZ+0cJywgNgJdl7LFHk5F8YfvFmzMcC1iezVCRj63UgfRF0ieftEAtVz9
         c0xRG2l0LPXmx/8VDfuna7mFKDRScPF9E/bdIZ3fomoS62togRzGjWCxBVGibXPC28+F
         RKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EPxzHwYhFlft26MSmbXxer1pCM7eMFS2V0bDjoXyAJU=;
        b=EuyiM3GvKbrVzGThwgjXctZHRAu+yHQ+jYOt0/qNuV/OsYQTojwHsmtGx+kxstGLiN
         uUFkFlY2OiyBC3kDq0fOudgSAlfFxjYEyWcZM10V4rDUOmZ5tUEXfgYZYSDTPfJE8Oqm
         vzTh6on/qzD3i28SI4vXDHxrnY18WJCykPz6d2QoElcfEfns1j8G/34H0A0hXnK09GxT
         u/7UKvhlyj3B/ZGOYlpyxYD3DNQoJ55kocLcQJ6keaaTEhJkiFpijmS9XB9+dqLPU+kn
         goSPAd45lT8eJYIwkHb9YDTmIBmzBTsb9HejjF2qHuNrLC1W2+USV+piX/FjA9+t5pt/
         7pQQ==
X-Gm-Message-State: ACgBeo2MPUl/nHoLaLemfLfEH0gmrHWmrgpvZ6gGjVmxdactowww3OE1
        XHCsxccrToqowXMfL1hRIJDtWA==
X-Google-Smtp-Source: AA6agR4Co2CPb5XN9X5svZynx70dgbm9JfH6RnGUadXts1hBLz65YPN73Tt641xJ42PHeMEA2pv3rw==
X-Received: by 2002:a2e:86cd:0:b0:260:55e:db13 with SMTP id n13-20020a2e86cd000000b00260055edb13mr629600ljj.146.1660816917505;
        Thu, 18 Aug 2022 03:01:57 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512070900b0048b37d29261sm165372lfs.67.2022.08.18.03.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 03:01:56 -0700 (PDT)
Message-ID: <f776de47-615e-d38d-8512-3e5391d6650a@linaro.org>
Date:   Thu, 18 Aug 2022 13:01:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add gru-scarlet sku{2,4}
 variants
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org
References: <20220817123350.1.Ibb15bab32dbfa0d89f86321c4eae7adbc8d7ad4a@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817123350.1.Ibb15bab32dbfa0d89f86321c4eae7adbc8d7ad4a@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 22:33, Brian Norris wrote:
> The Gru-Scarlet family includes a variety of SKU identifiers, using
> parts of a 3-bit space {0..7}. SKU2 and SKU4 devices (under a few
> different manufacturer names) also use the Innolux display.
> 
> For reference, the original vendor tree source:
> 
> CHROMIUM: arm64: dts: rockchip: add sku{0,2,4} compatibility
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f6ed665c9e2eb37fb2680debbb36ec9fb0e8fb97
> 
> CHROMIUM: arm64: dts: rockchip: scarlet: add SKU0 device tree
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/9987c8776f4b087d135d761e59f7fa6cc83fc7fc
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  .../devicetree/bindings/arm/rockchip.yaml     | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 7811ba64149c..dcae534e3971 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -363,30 +363,55 @@ properties:
>            - const: google,gru
>            - const: rockchip,rk3399
>  
> -      - description: Google Scarlet - Innolux display (Acer Chromebook Tab 10)
> +      - description: |
> +          Google Scarlet - Innolux display (Acer Chromebook Tab 10 and more)
>          items:
> +          - const: google,scarlet-rev15-sku2
> +          - const: google,scarlet-rev15-sku4

This does not match the sources you linked in commit msg, so I am
confused what the links are supposed to prove.

Is this matching at least your DTS (dtbs_check passes)?


Best regards,
Krzysztof
