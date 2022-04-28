Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FDC51311C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiD1KSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiD1KSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:18:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FE0B53D5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:09:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kq17so8550907ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/dDr0fTGGl5BBgPYwPAZZ1pd+XtgWaczMpJtn23ntK0=;
        b=ymmMVBWBQ8MpJSP4dXpx+Rq6OcKDzx8o92K2jOhgIxhtPTueaKNlqNV5b1+7OJodPs
         nJ9xGKyW1KGLybKI+fvqgTX+VxkPz8uG3BEhkW5I1jxsR2cywsmsC4fS3CEEi+behj7t
         hiQFekQ7PD5qsPm7FLhI0otlwLPjeekCPbmZ+HFju5Qr/hOapIWoIhtGlZk+Ab9fn8+r
         3bUAldogPJq5VDqJJOXZIt3B8uU2Cr/jFJzMrKiPlGluhKMIafYJdaDkvN51MYsaMnsp
         0Q89ZkoiQoZ8KLRlo4SBsyigrbJ9nhJmd8SmNu5SZaFHc/eG6XR07tI6tLuQUKZuXMJp
         de5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/dDr0fTGGl5BBgPYwPAZZ1pd+XtgWaczMpJtn23ntK0=;
        b=CJ5l7ZwBF8+xONKBWvNSVRomoGSbXSB9hiVz3WlNFo35HKpv2ia56wvkEc+e3anKnQ
         1rZInm+sIsmQPTOwBK6/LoDQKb3A0l4up+Sxr5qA01LUOeFOID8XG+i4deS/+B+5hI94
         ZHjBt+cvC2RGbQeLMMWCwiykRlD4Xs/Y/pd0VJ1cKONAilLf+nLStA0mgvyuaQbVrgQk
         02feSPI1wBUWE4G5zIPcsPDBw5JUntYCLBHzlBg9dJZWlkGviJsY9Y/XzvgWhxagTFP1
         Fyo4GOiBrwZgx1HhZxe7ITwwvW6CkZkPDoJ6L6JlhS39xTZUv3B5Ca2s1cAmcP0sY7SS
         LT8A==
X-Gm-Message-State: AOAM531IrDtiWM8miiZghbEBvdE8LIZN9lSMtuYcSy8YyU1aTvWgcYVA
        iWTrbzMOyfLBzg2NWFmy6UGi5g==
X-Google-Smtp-Source: ABdhPJyNl5aIeZaRe9OFQCAELtXNB7EAqHtq9JW4dgze3nveM4HBPQAYbmdni/LNySj3t3hVuS4AwQ==
X-Received: by 2002:a17:907:3d91:b0:6df:a01c:f7cd with SMTP id he17-20020a1709073d9100b006dfa01cf7cdmr30990612ejc.255.1651140543621;
        Thu, 28 Apr 2022 03:09:03 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm8220151ejb.179.2022.04.28.03.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:09:03 -0700 (PDT)
Message-ID: <813bd5f2-38b6-9642-6993-94ad78f5c08a@linaro.org>
Date:   Thu, 28 Apr 2022 12:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 08/10] ARM: dts: exynos: use proper
 'dma-channels/requests' properties
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liviu Dudau <liviu.dudau@arm.com>, Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
 <CGME20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28@eucas1p2.samsung.com>
 <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
 <5eeac2a0-4293-675e-9dc2-25ed8ab3fb8f@samsung.com>
 <6981f93a-ef01-6ba0-4451-26526372d666@linaro.org>
 <05c908ce-217f-6938-6745-7405ac39d8ea@samsung.com>
 <1399774c-f188-81f1-4d15-367b9d0e4a59@linaro.org>
 <99c80fb6-c6cc-9370-b93d-ed736c7f2192@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <99c80fb6-c6cc-9370-b93d-ed736c7f2192@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 12:05, Marek Szyprowski wrote:
>>>>> I also don't see any code that would read those properties. IMHO they
>>>>> should be simply removed at all, at least for the PL330 related nodes.
>>>> In current Linux implementation they indeed are not used. Nothing parses
>>>> them. However:
>>>> 1. They describe (hopefully correct) the hardware.
>>>> 2. They might be used by other implementations of pl330 driver.
>>>>
>>>> I would not remove them from existing sources, but indeed maybe there is
>>>> no need to add for new files.
>>> What's the point in having dt properties duplicating data that might be
>>> read from the driver registers?
>> Hm, indeed, there is no point in this. Since they are read from
>> registers, what was the idea behind in commit 42cf20980cde?
> 
> #dma-cells is indeed required, but the rest seems to be the cargo-cult 
> of some kind.

Rob,

Any guidance from your side? Is there any benefit in describing the
hadrware (dma-channels/dma-requests) if the same value can be read from
registers?


Best regards,
Krzysztof
