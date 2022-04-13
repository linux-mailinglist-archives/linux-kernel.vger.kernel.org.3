Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D254FF6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiDMM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiDMM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:27:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD75B3DE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:25:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ks6so3627898ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IPvL+x9UQrwXvR+utNinpI9NAsoIPUuR7BzTYCnsPmc=;
        b=I6HtBB7uA/yx0vq72axTx9u/3uqWUB99OEtYm5nNLXwI17sSjJos+fifoXsLy57+yP
         U2KtYRXjs8SZyZrd18o5WhlGMNXFxtIHEtB/xgrqGaR5ByLqNRGLW/HENfnLQA9Jl7Vt
         bmjosDfmIT0dJiuKMt6iWAKp4XXe3SIeM5KosBgRqvOO9+HVaE60mjmO1qJHsF0vh6xQ
         VtKnlsgh4C7fu/UxA6Lp3YLM2Hx/mvxP8VK3vMK/Kb+Ow576CmJ8GesR/EQc+Ck0Hmft
         oLrpUOG8TAzDRXOE21VAtyJ7a6MR1YL15APvvYvfwfhUKYVC71LEK0TtuFpRvmS4wmCs
         kSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IPvL+x9UQrwXvR+utNinpI9NAsoIPUuR7BzTYCnsPmc=;
        b=WSgoDpHeDv5MmZ3CDPccdOhfP1QWEwYSaXrWflmL4ld0vhkOryqSLmZ84xTo+NOfUq
         eNfrWTjG2BoJjh9bMaOOqhdzBgZ76XUvC3WXqeRp/M9elLnCpK4qRuOSJM4arNE/zwt2
         lRmnms4JKaxaLzoUl8sWV7mNP4wCwNNMJ5swrgal0wMKihUDs5gBSTXQ7T3JDGz7vkpp
         7bCJfVtaA9Ju0ZwmiNYDsG/Xq4xVJMPd9XYTr8qMgN6Ww7zHISzUukVU5U7eyvbJc6mK
         I8mhl8TFx+Lc+TtgtTL8e9QL2nbQhxpvBWfyF7d+rNUFrI+UMo9eeKyVkNHJNylcXswO
         sZiw==
X-Gm-Message-State: AOAM532pMIFkYZDUAVxsa2qkoLxvx8mPlcZYrs4DiBEjj6yUwD6NO6Yw
        jbMa2m/71IYAihWunoHNoJxfpA==
X-Google-Smtp-Source: ABdhPJz31ZrmQcG0YyMsnYKKIybMJUwfMZzrUtJTz4S+3vdABkkqHUaU2YMflXKJ/VRzTNNjPk62NQ==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id 4-20020a170906310400b006ce6b85ecc9mr37638157ejx.339.1649852706904;
        Wed, 13 Apr 2022 05:25:06 -0700 (PDT)
Received: from [192.168.0.204] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id fu13-20020a170907b00d00b006e8ae97f91asm1987512ejc.64.2022.04.13.05.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:25:06 -0700 (PDT)
Message-ID: <a01f58d5-b42b-e870-1f10-4945d3b6fba6@linaro.org>
Date:   Wed, 13 Apr 2022 14:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     "J, KEERTHY" <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-2-j-keerthy@ti.com>
 <17474b72-d823-e1ff-9831-c5f9f887fccd@linaro.org>
 <54d597e9-5cad-fc44-954d-7de45018fdcf@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <54d597e9-5cad-fc44-954d-7de45018fdcf@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 14:04, J, KEERTHY wrote:
> Apologies. Some issues with my mailbox. Rob's response didn't reach me 
> for some reason.
> 
> I am now seeing them on the web: 
> https://lore.kernel.org/lkml/YY7HvCyJ90Ge8mr7@robh.at.kernel.org/
> 
> It wasn't deliberate to ignore comments. Apologies.
> 
> I will fix them in v6.

Sure :)


Best regards,
Krzysztof
