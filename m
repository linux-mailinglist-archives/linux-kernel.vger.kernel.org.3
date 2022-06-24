Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE48559D98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiFXPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiFXPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:44:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53D48314
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:44:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q6so5435895eji.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uNpK+mBBTUHQ7WDb+nB+qBpNmtp+L0qJueskM+LbU9U=;
        b=colwbZfShIhrPFPWp9hacqTOa/0vOIMn9OMChd3IGNCNQ2WFNvUOTQP+DH01Wch4wA
         N5R8jaUi3Q4a5zzW7+YW03PC78z4RTz9NUftsGrx8vLDpC1e0htx5aNz6grMXok5tQZZ
         JeHVemmLy+OQxQnoHI8Maqk/Kh8XUVkL09DBJXSQouCNPJ1rJPUjEsBOi/PLPI/lVxEN
         iN22TymTfg/SUBu9IxFgInrnXfZz1PDvC8R23PKcdtTqlo21bbbDp/+0LU7c1idcyuQb
         kAQqwtda4WESfmPkAuDDlfpueW0qdQoBx25KS9twW34kvTe8vN2t7hU/r+uakWLwhWUv
         XOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uNpK+mBBTUHQ7WDb+nB+qBpNmtp+L0qJueskM+LbU9U=;
        b=le5Qqo2iNM++/bE/4W9kqVKaLOobDwn6quwtJpIcmVYJvektNjrmSyJATMCkXYkU/x
         79NaG0B/RPQFAf3VG30ukEnRz+Fg23iIVSh0WFenm8xzSHLFO2XZRXjnLBR017H1zljK
         LeLFgKLzVDqGxCyc5X2S4KTwTx1ZdAxPuUeUgjAIvUKnimvumwk/Bw5U106CXwGfehVh
         subre8i5FmaogVeh25aguwVO8ur4co++aaOzLYhseH7MoTLexuhAT1JHdMCpQvL2GeOR
         ptnn8bw2txflJULyac/ZMUPslAzOZVVxjFh1QYo9nk7ND8oH9oxtLWbS5nV5DrMgbzGf
         BpCg==
X-Gm-Message-State: AJIora8WYtrMLR0szcX/lFYaU8zaIta2WxsCqaVVHnjBPSRVRV6ZDL0n
        mgEn2qV9/hziPLRTPxqbaG6kUA==
X-Google-Smtp-Source: AGRyM1tBon2mhw6kEmJOKmZ7zCt1VvMwGTP8W4a8ouVhnioZMJrYrw2HJ/ZF/csjXzw5h52+oMeodA==
X-Received: by 2002:a17:907:1b14:b0:6ef:a5c8:afbd with SMTP id mp20-20020a1709071b1400b006efa5c8afbdmr14034942ejc.151.1656085477728;
        Fri, 24 Jun 2022 08:44:37 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709063a5200b006fe8b456672sm1305804ejf.3.2022.06.24.08.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 08:44:37 -0700 (PDT)
Message-ID: <f7506312-b6da-7b16-bed2-370a9c8e9049@linaro.org>
Date:   Fri, 24 Jun 2022 17:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/4] dt-bindings: gpio: Add AXP221/AXP223/AXP809
 compatibles
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
References: <20220621034224.38995-1-samuel@sholland.org>
 <20220621034224.38995-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220621034224.38995-2-samuel@sholland.org>
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

On 21/06/2022 05:42, Samuel Holland wrote:
> These PMICs each have 2 GPIOs with the same register layout as AXP813,
> but without an ADC function.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Combine multiple "const"s in the binding into an "enum"
> 
>  .../devicetree/bindings/gpio/x-powers,axp209-gpio.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
