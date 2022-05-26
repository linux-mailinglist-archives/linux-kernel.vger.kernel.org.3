Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A581B534F70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiEZMku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244712AbiEZMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:40:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4032F392
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:40:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h11so1652328eda.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9uRqqTZK1K24FaoG5BjsXAbsF5+uxDuumepdA/oq5iA=;
        b=TTJKSWCwHFGMqzLBpPFPdKtH5ZsBIvldnJXRNXWERLMex5ik+rM9NKIpDbSfDwJUk2
         372mXbZdCdBIi7ftffpeuaARSkJzIu0iZQkcm4aAWTUsFVYkHYvgmyFHVC0y8i5nKwT3
         mK61kCsA8rgvENq0gI+q3JGS3eL40eaMn4xB3ACjpenkMLA00gBWJSPxgC1nLGZQrjfT
         F9KxgzJ5PJ9aHwdtTig1UEEv2ytIkQwJfusAWBH9IEuacW+DhO0ejyVD52w9JaGIEwim
         fEoBJd4X5NZ6UOPK+X0zDZz7dNxTyLRWcF400uku6e5iPP2AKQevaDR0F8FeIif18vwV
         VAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9uRqqTZK1K24FaoG5BjsXAbsF5+uxDuumepdA/oq5iA=;
        b=VyWw3Pe//BQlXGBjfDmBIc8kaykiWAP/576RPRqPF57RgJ10i7RVI58v+Z3F7d6vAL
         zRXQ+AVCfqeFbWNXPqkXKPYsnun74LNU1fe3cRVDHqYeBIX4pH5WzU3ad+KiuF6mz32p
         LGWaCULKOriMh9VeeCrPHucRuBR30ai6lTrZJT3AoZJN4YfEOd6V3BmmV22AaDphQkEc
         QG0ZcvcCIejKGvU0Mu1dCWk58PjWP008+Hc/9mlmAOYISh38RIx2thbfPs4fdPolW4uR
         4kICcXER5w+PcRyV2StMkmjgga4R2nCUiwonK4BF7gAqmk+QDxqqsqHHqmBNEPac8V+1
         tBLw==
X-Gm-Message-State: AOAM530mEfK48jfqbAJ4Sx/kO9FKH6ljQzUkrmqCU9WXdXxUPWrceBIX
        KxBFKFMS2h5vsEsN0v++qhYXAYXwROT2xCvy
X-Google-Smtp-Source: ABdhPJxSErCq0WZZdltpzCJv4LJikks8u9+dUlhnlTUCQKYfr3/kh1QYv9HweMcoiNuuAwKuwTuKbQ==
X-Received: by 2002:a05:6402:e85:b0:41d:121b:f436 with SMTP id h5-20020a0564020e8500b0041d121bf436mr39763263eda.121.1653568838260;
        Thu, 26 May 2022 05:40:38 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m4-20020a509984000000b0042ac2b71078sm774378edb.55.2022.05.26.05.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:40:37 -0700 (PDT)
Message-ID: <25ec0ce6-ffae-4b5b-21d5-9703c9b6ad99@linaro.org>
Date:   Thu, 26 May 2022 14:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: Add lt7182s
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220525010717.4000736-1-linux@roeck-us.net>
 <20220525010717.4000736-2-linux@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525010717.4000736-2-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 03:07, Guenter Roeck wrote:
> Add Analog Devices LT7182S Dual Channel Step-Down Switcher.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
