Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35BD5A3645
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiH0JWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiH0JW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:22:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352A2A73C
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:22:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y10so480264ljq.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=poqSmM+AeoTfp1g4HUHnRawOxryRZkBqc2YyEx97xHw=;
        b=c183QsYPa/ht/WxKdij7ABL6NpZMgaWfZLdKAAZjw0y7OOrTL1MwrDY2r5xoyZRirl
         +0Uslq+R6GV/kPzwsqCbBJ/cYBDblXUlGrcThWxcbWV3m/DYeJEoL3M8rgV2uKyDzKIt
         U9eVRI/m0k5M1blN2D789VaTb4CJa2lAve/OhDTKwPsFV7nvjLJRO3ATsSCI3JtfU459
         0CIwI1MdjA89RhO5cZ7m13jzpRKQpCKyh9XBDAFr/tUYVyFYm9UgIxeIUZlIXN27IYMe
         oVNVheL+4alHMQUCss/DtEqYqmjMRehE3eurMcgApOTnrKswa+L+rM3Xt+BFWkm1S+1J
         Q53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=poqSmM+AeoTfp1g4HUHnRawOxryRZkBqc2YyEx97xHw=;
        b=s+boVOVKc2zTjBlN/Ysxo+5R2Cvm8rYG+1uHuWssFGGCbqqA7Hw2ZJIhvHJw7wVpDF
         3ugOIeIOZzErlDRW8ls0BaZa89m1NtwwCAfrUxCyp1KwYfqI0I71Q1fenYiXtrzZAMFM
         Vwu6To0MeKmgaScLgMNx7h+OrxE0KUc9ijc23I3WoXmT5uWkDl8HXlJiVs2hVTl7uL40
         LrPOKWUv5sa7b3JgNdFocOHAotGLNfjPrmh6Gxn7SuGL6+5a2bmYpI+Q7J89frkXs84r
         2kHTTakMKQw+QII1uy7mOissSF2Jcx6UGjTxHYr9BYlqo30LivIHz5+7edJNFDEJkeWt
         xAog==
X-Gm-Message-State: ACgBeo2NyX8h+1/lL4xlf2G2MD93FbF56kOW5upuTRg1V4CCeEcu12QH
        nmMj8kwNhZlqLYRWYqj05Vo8lQ==
X-Google-Smtp-Source: AA6agR4VlP2DKSztiz5AJ521nKAFgaDJqM4XDcYtZ5oq2eD4Q95BAi4FjdQifM4U82KUR4L25Rzggw==
X-Received: by 2002:a2e:a887:0:b0:25e:3174:fb67 with SMTP id m7-20020a2ea887000000b0025e3174fb67mr3062275ljq.337.1661592143434;
        Sat, 27 Aug 2022 02:22:23 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b0048aa9d67483sm38762lfg.160.2022.08.27.02.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:22:22 -0700 (PDT)
Message-ID: <643651ab-cca2-28f8-beca-44ad7630affe@linaro.org>
Date:   Sat, 27 Aug 2022 12:22:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220826142806.3658434-1-conor.dooley@microchip.com>
 <20220826142806.3658434-3-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826142806.3658434-3-conor.dooley@microchip.com>
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

On 26/08/2022 17:28, Conor Dooley wrote:
> Add compatibles for both configurations of the Aries Embedded
> M100PFSEVP SOM + EVK platform.
> 
> Link: https://www.aries-embedded.com/polarfire-soc-fpga-microsemi-m100pfs-som-mpfs025t-pcie-serdes
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/microchip.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
> index 7cfc96c21ab0..04ebd48caaa7 100644
> --- a/Documentation/devicetree/bindings/riscv/microchip.yaml
> +++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
> @@ -26,9 +26,13 @@ properties:
>            - const: microchip,mpfs
>  
>        - items:
> -          - const: sundance,polarberry
> +          - enum:

Make it an enum already in your first patch, so you won't need to change
same lines.


Best regards,
Krzysztof
