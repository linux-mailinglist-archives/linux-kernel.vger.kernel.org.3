Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C626553736
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353675AbiFUQDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353555AbiFUQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:02:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED752DAA7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:02:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fu3so28474776ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ajIufaZS31L5JGgBZ3aj5H5ZSklCRI8PNMvHL2oafFw=;
        b=TbjJf5zpVMUIhuON7L5caOsWN1RSMkNH4eTucjnQ+TOGgUGSs/J9dl7n8G9Z3uOLsS
         go4x+wTu3yJfXNZGli7paJzK232anQdm/Vgn99gPxnrBXve8mMhkbq79K0OgMxmAVz3R
         MHiXrUBpOS82MmyxyTzEqrcy+yhbH4RBMk6nlbwaJw3RnverxVBR8BLnfoYeFYhLo75/
         jcnBZOLdzu+ZhL6IGsw7BG8uXxBU0JVyi4YsanybY5+GXzqihbZhZ7CzlyWdH9ZKBU3Z
         50f2wP4+jn2U4ey4kK3rqtzKsh/8Igz38hUURZVF2Dzph0sojs1K/lmbQDpLVQzEyXyl
         B3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ajIufaZS31L5JGgBZ3aj5H5ZSklCRI8PNMvHL2oafFw=;
        b=1gl/T15FoOSmu1BPs3eeFoW2D9q5hSdj8rT9linVX7t/TobPyZfVLha6+BohGZZmp9
         eEVkCKGWSGpdrW1gnwVCN+XsNPBDQCBkfUV0UiEFsRFtss9V/ExDpPDQPINhBBOJMcuW
         pCwwC+cM0shiYKj2MHwKTrDWztCVl/HOPPZeOOHDX71wmqAw1kuCREAN+HVJiD9x2U9r
         LTIh4xSFiZwWNzQXVB3RkyVZosKflfC3J/1pZI5YxJGsp8oihPSOa1TrqeQ/PDFY6Lb4
         7ZZHcrCablSaUvrLjvyNdcScXLseWrXPNh1N6J879Lm1d8GEIdemKzhDlH0FowhQjxE5
         IAqw==
X-Gm-Message-State: AJIora/GRtjlTJrDdSvWKSyRDw67q8eeMK1larLydw7gpT5Qe0Dt0dpI
        76/FtOYRXz3N2q8ah58P9t8gaw==
X-Google-Smtp-Source: AGRyM1tJ7negbS1AH/+t/TmQDM/W7Td5eE5Db99BDGFKcNAC3cPdeq3N/XH0C1NPOygluBZ3K/vcSQ==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr26930081ejc.287.1655827332290;
        Tue, 21 Jun 2022 09:02:12 -0700 (PDT)
Received: from [192.168.0.221] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709060f0f00b006ff19354f9fsm7821657eji.215.2022.06.21.09.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 09:02:11 -0700 (PDT)
Message-ID: <94152e7d-184a-6b7a-6468-2678de410883@linaro.org>
Date:   Tue, 21 Jun 2022 18:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/9] dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3
 compatibles
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
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

On 20/05/2022 14:32, Krzysztof Kozlowski wrote:
> The MSM8916 Alcatel OneTouch Idol 3 does not use MTP fallbacks in
> compatibles:
> 
>   msm8916-alcatel-idol347.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['alcatel,idol347', 'qcom,msm8916'] is too short
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: e9dd2f7204ed ("dt-bindings: arm: qcom: Document alcatel,idol347 board")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

I pinged about the patchset two weeks ago. There were no responses, but
this one here is actually a fix.  Others document missing stuff, which
although is not a fix, but still necessary to reduce amount of dtbs
check warnings.

Shall I treat the silence as this won't be picked up? I can take it
instead, but it will create some conflicts because several people are
doing similar as here...

Best regards,
Krzysztof
