Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E06537132
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 15:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiE2N57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiE2N54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 09:57:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD93532C1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 06:57:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y13so16522614eje.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eZS9UwARNMHi8CDwz38QW9WqI4Zqjp8cd1vGJxSzRYM=;
        b=TSejUXmwsS07coKwxeAqckTl6pKplkYub35Kq6sVIs7M8sUt3Pi9D0DBY6LeUr7ORw
         7eyuQNEtrhYCn9mO/Ur4mCcxA33SUWUrsqm6C959/lC6AWYIYZHkyfcTbXHgxXMNaEIa
         fZJoVMZb3tc0IjSGBOj8NHGM8sPJfxcEC5Ml1orbu+TfQikHquGdErKFPNVofCSrnqJ7
         83eifGfLD8I4oX2xZD7OaGp+NiGIWAhZhtRX6wyFP92Y6BIkYvWs2aQz6KuJ1yyc/B9n
         4bstwzcB5Q4BmLIhvFOpCYzWG5DOueNHtKetWbQgEeijSGJjn2eofhJQt+pSWrijXxzV
         AihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eZS9UwARNMHi8CDwz38QW9WqI4Zqjp8cd1vGJxSzRYM=;
        b=uNrqttEYgG6RKV+g2IVZIbrgP5PfJzMZx3ic+wJSQgxl/lLp6ESH2G0X+taqp8IUDN
         TmKhssyBgtkzm1nEUeVS9pyShlfViEEL3ts/6L2D4diPlK9MC8Ksn8WxDoryh+/fQxLZ
         VMaYUAr0aFeyUMjVGYFRIZVpapaOSGWYXskSqf3p+5c9Ixj+tIxNcy2627DiiS29cYMc
         tAowx0JwBhRase1vh6CmVH+nBasH7DBWBncgVhao71SK5g7979qVSRWlxTqlzDMCyb74
         b0PEo+XZ6uCO5dwuwkT4Kx1sD4Md9SMRh7nzbI+U4fuK1m1eQbnB49G5Lew1OyHOkkB5
         lauw==
X-Gm-Message-State: AOAM530C9aytn+AlYrlHMDRS+Q3TsKm86kIFi9K5auUHhCJWQ5EsS9ns
        nnQ2tKi3jBFoK8kTEIcbCJ5PXQ==
X-Google-Smtp-Source: ABdhPJwwfO5EE8QvoiUxj1D+HPEfPx52kDXQhWDzkLPTgGoNb3TK9jxmEWk2jTr/oOqqgImuh6y7/A==
X-Received: by 2002:a17:907:2cf4:b0:6fe:9f6e:5a46 with SMTP id hz20-20020a1709072cf400b006fe9f6e5a46mr42546098ejc.321.1653832673215;
        Sun, 29 May 2022 06:57:53 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o25-20020a509b19000000b0042617ba63a7sm5005081edi.49.2022.05.29.06.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 06:57:52 -0700 (PDT)
Message-ID: <ca2ff3fa-fefd-76f1-acef-bfdda8f8edbc@linaro.org>
Date:   Sun, 29 May 2022 15:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: arm64: add bcm4912 SoC to binding
 document
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     florian.fainelli@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, philippe.reynes@softathome.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, anand.gore@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220528005654.13809-1-william.zhang@broadcom.com>
 <20220528005654.13809-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220528005654.13809-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2022 02:56, William Zhang wrote:
> Add BCM4912 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
