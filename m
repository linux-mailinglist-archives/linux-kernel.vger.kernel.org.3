Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489E52EF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350810AbiETPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350854AbiETPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:24:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E1178575
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:24:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso2263831wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/x7HzvCombkVqeP8X1mXMfu7spv9X8WdOUuS9zwdEmE=;
        b=fc6CBWl9RqSOk1lu2dMMw50J6y8k7XvpawmGylhgXjTpnG47Gv75Lh3gKC15ykE0mS
         unh3K0F5hUOTdJ9jJaVl734rVZpTH1UncPq2x/btp30t2iXdH9E5aRmB1r153a10idKZ
         OUXME3NiLT9QR6ZZGcIhJTO9qbWFbYB5ACOaN2xItVGSuQnBjdMZj8yWjOeAkHegJJtM
         ArwpZUEZN9yuM4X8V6UZFRxq7z5Tvov3mRsR6W4d4ZAgGp1ZgAv0kf/HP4uJgWtCnHQW
         RNPx3+jVxftEY0gsvCKBtiv5RXdsUO495hOedp2de39gOjue1NuIPGiwHOOwq4zSkN88
         uhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/x7HzvCombkVqeP8X1mXMfu7spv9X8WdOUuS9zwdEmE=;
        b=cnUUtA+5SBGZofk6bn0aSLQp2EsvKCzp9E7hcE17cIo80tI3poAa2C4b/yhj57Dccp
         V4LaH22RH2p8AWpofe+J5w0SS80Z67BDTTvWKLvd35dG0cd03F7afZKeVMdBQFUy4zSe
         CGyr6lppe65IOoH6hrwmjsf3j1ACxlcAU82MCg7/3kPXx3XG4RQm7lKS9id5dcdWSndn
         v5blHliGCZdZ9b8OY6DO8xPHxm+sckduA95LBCqZfpHv+xg3+TQMrxIIkyR+5F3AGsk6
         xzCQvaKKz4N7X4VA/wJty+/OAIn71+wnoBgBnIZnPmFWAxLnqwez0ODPXsbOUE8N28w/
         pQ8Q==
X-Gm-Message-State: AOAM533GWKGSDX+0d0u3a2SqrLd6UOtx424dw2pjgvKLLlz4FAcob/b6
        Bxf7zOdeDXXO/Xncig1+R3kQGw==
X-Google-Smtp-Source: ABdhPJxswYN+QYEvZ2RcoFkVNRNx+QLplVtRNFE3GwaNwQwisUDxZOB8JB6q7GIXYtltx8Gu4hDnUA==
X-Received: by 2002:a05:600c:3c8b:b0:397:2db3:97a8 with SMTP id bg11-20020a05600c3c8b00b003972db397a8mr7686344wmb.132.1653060254695;
        Fri, 20 May 2022 08:24:14 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:b8:a290:ff05:e4c4? ([2a01:e34:ed2f:f020:b8:a290:ff05:e4c4])
        by smtp.googlemail.com with ESMTPSA id ay28-20020a05600c1e1c00b003973c4bb19bsm1219838wmb.16.2022.05.20.08.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:24:13 -0700 (PDT)
Message-ID: <bda6fded-e925-6969-b6cb-f5f840460a90@linaro.org>
Date:   Fri, 20 May 2022 17:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map()
 return value
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io
References: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
 <c173a336-1f57-0712-fce4-d6885e343d2f@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c173a336-1f57-0712-fce4-d6885e343d2f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 16:52, Krzysztof Kozlowski wrote:
> On 22/04/2022 12:41, Krzysztof Kozlowski wrote:
>> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
>>
>> Fixes: 89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> This was sent a month ago and it is a fix. It also received a review.
> Any comments from maintainers? Is it going to be picked up?


Applied


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
