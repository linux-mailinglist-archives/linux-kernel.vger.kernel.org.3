Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CBD522E17
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiEKIS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbiEKISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:18:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E34106366
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:18:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j6so2408568ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sBzTMsPXTZY1KLtSUK6HQvUzSLSuD/KbKK3fc7RKOi4=;
        b=q5x33+8w8V9FYh8m8Q3teVEWeIZiXCGzRtgElsINjmgdbV2jVCgFZAYVRfQ5wfPp/R
         WTwY+r0CLFIa/P1xIUhybrkXIlDfYRocw2+OCDhCqQOpem+1xb5xmCGlmz3WOgL1aaZY
         8KVyX0fDXL21nomBfaSjBNp5Q8uxlpcuNV374E5oU+RY263BBtfjHHhahfx2XVW2ydn+
         Q6rd9QM+Z0YNK+i9eXpZ+UiRyWnnDc9cgaHyQqz8QjcQlRECZjHZAw9bsmNHGD3/CdXn
         mW5i5uetq59A77bVvk3bx8dFRtOUUcuWNNNKDKlXclYnoveFyYUGluKSYsMU45ewcMzk
         qDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sBzTMsPXTZY1KLtSUK6HQvUzSLSuD/KbKK3fc7RKOi4=;
        b=gFMwLdgh9JsgT5eSInr3sWYPPo1Bcfx9GeMSHXqzIK6FrnP4G2H5vCnAR/mSjkYi68
         usycJZfiRszt08pAFAPHPQUnjFLVm4bGDQb5Uvl+tAYa3ZD23nQsISl1yWuVE1JtLrMq
         XmoZDMtXyHdoGzn6+f9+PIWs829jAyH6OeQWjfAewgq3oOldo7K/pMkvLRaRz9pNGt+D
         OzZFMY11KrvZm26TSMSC0KGnh+4p/JzgsOma3fyYOPVeUq4WRtHdFTqfvwkQFBOs7AX4
         +wamAO4yp7AMtB//YEdpxsgzBdYoLm0shUDXJUJWWIeNPXIypBH1gOGvJCx9T0spA6qz
         hUsg==
X-Gm-Message-State: AOAM533azyZY1Q6FERWlRmCCTj1YsUnwrWGRFf3k25VB/jiumciKEThY
        QVKEbH0ovN0oRVdDjMZo9Ku0IA==
X-Google-Smtp-Source: ABdhPJy+jjf91BnIdjIyJXY3kE+uApYxN3twMoWFjQ7XNd1YDsGZ7YSEO9GFwLy3LQwQvXg/WmvvdA==
X-Received: by 2002:a17:907:2da5:b0:6f4:7cd1:8cf5 with SMTP id gt37-20020a1709072da500b006f47cd18cf5mr23731800ejc.328.1652257128203;
        Wed, 11 May 2022 01:18:48 -0700 (PDT)
Received: from [192.168.0.254] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u8-20020a170906654800b006f3ef214dccsm684382ejn.50.2022.05.11.01.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 01:18:47 -0700 (PDT)
Message-ID: <ff26a15e-a9e6-5db6-992a-0a995da33f94@linaro.org>
Date:   Wed, 11 May 2022 10:18:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: arm: fix typos in compatible
Content-Language: en-US
To:     Ken Kurematsu <k.kurematsu@nskint.co.jp>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>
References: <OSBPR01MB32880CB4C49E50DAB7C6B664DBC89@OSBPR01MB3288.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OSBPR01MB32880CB4C49E50DAB7C6B664DBC89@OSBPR01MB3288.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 09:01, Ken Kurematsu wrote:
> Fix typo "cortex"

You could add:
"in the example DTS."

Because this is only example, not bindings.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
