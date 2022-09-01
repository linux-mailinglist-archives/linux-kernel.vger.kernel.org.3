Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D55A94A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiIAKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiIAKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:30:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18C1D8E27
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:30:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q16so17394062ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Hq/wXphQ4CQCWqFQUckeg7mpeUY2opCgFidU5GlYS/M=;
        b=wMrHD5kd1sjRAGwDOMxCLd5TmCSprc0l8Nf3sWx1dXuMRw6mfEP63hWBtvHNhJ801W
         QEkV7vymXEa/aXbYqGX4R5yiFQnl8uzfQEIiMjxXJxpx8itKZweitlkO/FPuZmia0adE
         M6WddBo1NBOeeg5/1y/DaNd3wmc3E/n8vDRwKSngkHvNCgF5wx2WcPhrlyIoBIJtnDOC
         DWPdhzxfLoAUMhVxP5tYYJk6X9aNydarTKdgb5IBaD2c6MQAxCPQWDlMkv2YMw6j0jj3
         N/UvpNU9lhbiLUy9Hr6JHYnM5DzYIpAwh8rG0p8VNvFxLcn+dEak3SolRfU50q23CH6t
         W37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Hq/wXphQ4CQCWqFQUckeg7mpeUY2opCgFidU5GlYS/M=;
        b=iDNpYzcEdYmjghQYQc8ZXENexq+J7p3Ev9QK5VUGAta2i+CvZctKEYTy7Tcab/1iG2
         LzJ4WJsIwROo0/E0DGYobSg+TkxGDR9rk1cSS7nWqEUWNq9T6052bStfdAJsrUdeXW98
         Y3F94zMUIigLeynysP8/XRGWpu7Ly2LoKllxkSsP7sDHWQT7LhEcgvZUVHgywg/Pp8OX
         GQH2lqpBwl2nEqGsLW9A2xv/7CfZwM6tNUss4QzIrWD/M9oEaZYhVJcZOPUj6jysNXbn
         ndI4Zs0kOJZsC3emZQ7puvweju4nIAFp/2HY5Db/KiqyRqXGK3qFWYvRZLtFT0GHrBaA
         oSIQ==
X-Gm-Message-State: ACgBeo0f355spehiTTpRimSPPqyLeWaR1Rs6NeyTEHS7uXRNturI6w0C
        RM4fkc+Ky6qmI38iccj+3kyWOw==
X-Google-Smtp-Source: AA6agR6rVg//wgHti5p5gLXR9YIZj3y2n/9kU9errMO9J/QeGYwVMsfd2wxCYlqzONqcnaXPvhV2VA==
X-Received: by 2002:a2e:9018:0:b0:266:6871:cdc1 with SMTP id h24-20020a2e9018000000b002666871cdc1mr4524850ljg.244.1662028232455;
        Thu, 01 Sep 2022 03:30:32 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f48000000b00492f84befffsm1567689lfz.192.2022.09.01.03.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 03:30:31 -0700 (PDT)
Message-ID: <93d5de8e-31b2-4412-3348-7ba1903cde84@linaro.org>
Date:   Thu, 1 Sep 2022 13:30:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
 <20220831124850.7748-3-johnson.wang@mediatek.com>
 <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
 <1fae0c47-fff9-89e9-c849-536d167d741d@collabora.com>
 <38910de5-89ad-e7a1-261f-18b51c8e7877@linaro.org>
 <955f7200-9d08-0d21-2d1a-5ccbd0f3a8af@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <955f7200-9d08-0d21-2d1a-5ccbd0f3a8af@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 13:22, AngeloGioacchino Del Regno wrote:
>> That's simply not a proper
>> hardware description, so again:
>>
>> 1. If this is separate device (as you indicated), then it needs
>> expressing the dependencies and uses of other device resources.
> 
> Agreed. In this case, what about...
> 
> mediatek,hopping-ssc-percents = <&provider CLK_SOMEPLL 3>;
> 
> or would it be better to specify the clocks in a separated property?
> 
> clocks = <&provider CLK_SOMEPLL>, <&provider CLK_SOME_OTHER_PLL>;
> mediatek,hopping-ssc-percents = <3>, <5>;
> 

I propose the last one - using standard clocks property and a matching
table.

Best regards,
Krzysztof
