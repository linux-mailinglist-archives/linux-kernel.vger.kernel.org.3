Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE94ECAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349304AbiC3Rbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349300AbiC3Rbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:31:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD3B79
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:30:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lr4so34510993ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8RYwAvBPCF9XywmD5fq7tSXm3lAPT2CAJaEKfYpH8zw=;
        b=LG/yMpN6NpgF4fravYALNyn8Z5WGt53sXTuV1PC+ngbiN/7ipmlqZ57lAquQSdkcIM
         uZPy4yJYSr65rs4n3AOH+xViW19g+HOydHiY67zDD0VXYCEO3M+WOomhAYyWQQfepSp8
         JqdeM1eF4oynMiKUeKFN7+1UoO+9fWwFb2Wrr/40W8zfuok9D/YZQ1nwxkgr1yobZYmb
         7Q+G7uMcYavkas+kglUE3rr8cXUAF7ZIXsN2+n+aR5mr9Zo9sBQDiqJ3Lplyv0fjxfJN
         67KHJFm4dXJFT3V4A3W8ot6EmAK+9Vuz1LhAppf5gyxJsAmx96GRsgYmYYtq9HCf9pRu
         /cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8RYwAvBPCF9XywmD5fq7tSXm3lAPT2CAJaEKfYpH8zw=;
        b=vw5EU8ZV0iJ6Yjfuk5sy73FONO+wXFzi7ObTC7qjUcVaUZ2drr57nGOBzVEy7YMAgS
         tLlVY7n05hYlUWqenV1TrQnA65fwDd8e9P3J3/cpVIQS572NdoPbo7GNYjgLsZnrYy2s
         64BRnVUr9HxhPHScOH5QADj/uULYKNmwPR5ZRy+X87RpvLFzfgVJ9WlfwN1hrZxO2UOl
         Rs3FllTKxrJ4mYJGvBXICl6g+XwcoqXtSkE5RTgYtxSyq+tQp1c7SVprMLjwnEhMCBj9
         P0xt1z0VAwedSkpxSqD8F+xed7CBYo7SzOKpTKMKaxmjQJGF1/gde0mRjW8pG1206fgL
         oeUA==
X-Gm-Message-State: AOAM533mGOr78HU28XKOvPsARj5kE+MD8VLlqBjBT5w20knsWl8iTkZl
        r2yTAOtWe1o+qeWMNQXln8ENfoxs6QljEoRL
X-Google-Smtp-Source: ABdhPJzhS6l1JJpOIoK7pFJfry86N833UfxNZtRsxE3AFXcn0vHARsduaous2MKRJDLZHrwE7lnd4Q==
X-Received: by 2002:a17:907:c0c:b0:6d1:8c46:6415 with SMTP id ga12-20020a1709070c0c00b006d18c466415mr727138ejc.326.1648661398642;
        Wed, 30 Mar 2022 10:29:58 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm9809537edt.92.2022.03.30.10.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:29:58 -0700 (PDT)
Message-ID: <3ad8621e-7a67-d586-5ae7-020be4d35f7a@linaro.org>
Date:   Wed, 30 Mar 2022 19:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 3/3] ARM: dts: rockchip: rk3036: use generic node name
 for dma
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220330114847.18633-1-jbx6244@gmail.com>
 <20220330114847.18633-3-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330114847.18633-3-jbx6244@gmail.com>
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

On 30/03/2022 13:48, Johan Jonker wrote:
> The node names should be generic, so fix this for the rk3036 dma node
> and rename it to "dma-controller".
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/boot/dts/rk3036.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
