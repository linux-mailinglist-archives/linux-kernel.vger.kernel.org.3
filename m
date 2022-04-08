Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63F4F9876
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiDHOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiDHOqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:46:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CFFFABE4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:44:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d29so13161672wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4x/upSoWHiog4isXgyEOmPfG0ImFBqCVE6uW1bG0IPk=;
        b=EQ935yiFvjCehYb9frNX6P21JAaTBgnRMF4VC64YzYGDjyJmMoF7rk0IL/tLlp+vcZ
         galZCnkCYTKrz4vqZBOTVxxBa4Om1jSOiCo2jnDkD0nokKAMFaL0SXAIHijkkzVnGR2H
         Af5XQ8aJJ9+Yyj8q6kO8awGTXKZ2iI4VYvCO9U+u7YKzTIs8GSm44TjLXnr7CVIfl2RL
         BtMEGj/UNdeVhp6B8NSFaoQa4SUmguLqphfT2dHdDICAXbBHtvwkQWWHvksqbSfgl9xz
         UMY3A/67I9ZNPaKLbs7mSu4uS9xh51EFpNXCv2kx+mSN5c+OUHN4s4HKW6S6g79eKAeL
         Iwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4x/upSoWHiog4isXgyEOmPfG0ImFBqCVE6uW1bG0IPk=;
        b=dHNFcZJvAut18WM2zoBwKW/lnT8csJYcDcddNmc6SyaOaJqy+4j+xFd3CGTYQeoQQ3
         SZsHr5K6RMPDuVoYBi8cwdmUaqimr7mxbyFPoYUHbnErQL6iLsM1jA9FeXyNR2NQWznU
         FOvNq8zc2/8KvL5Sk8ITdBOAbl4qg0wecF9eAsBj1boba9KBS5TY6WxkPH3jKCs6CLa7
         1hnLYiBBGqg72lBA7Jrffsoz0XPNMsvt0nshIm5qnfm6f9pJ5Kav7IcR4vJEAXR4cDnF
         uBM4edlGW2XxkifukWe6Zh7Y4KqF1BRHSwY1ynBsHN1t09HBxkVvAgFPgrLftBnpO9iv
         VATA==
X-Gm-Message-State: AOAM531p34GAXKV8jNkWbDNpRYSS5GmBO94ICkVwZWsU8vnGBTwNUj7X
        bCXb0nc/3bgLAFaep28iXXiOJg==
X-Google-Smtp-Source: ABdhPJwAlPDRFgSScU2FS28hlbqjFhs06rEn6gMszy6CYMDp7CRzwGmxAoN5ZCZHh7cqWO0JQSLtTQ==
X-Received: by 2002:a05:6000:2cd:b0:204:1bf4:e4f8 with SMTP id o13-20020a05600002cd00b002041bf4e4f8mr15235444wry.682.1649429066390;
        Fri, 08 Apr 2022 07:44:26 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:3c94:dc25:f0c5:7ff7? ([2a01:e34:ed2f:f020:3c94:dc25:f0c5:7ff7])
        by smtp.googlemail.com with ESMTPSA id o19-20020a05600c511300b0038d0d8f67e5sm10533343wms.16.2022.04.08.07.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 07:44:23 -0700 (PDT)
Message-ID: <4035e567-7096-eda5-5a22-4c6e7a0f7514@linaro.org>
Date:   Fri, 8 Apr 2022 16:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/10] dt-bindings: thermal: tsens: Add SM6350 compatible
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-pm@vger.kernel.org, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-6-luca.weiss@fairphone.com>
 <YbpLqwFJI/nfvxd9@robh.at.kernel.org> <CJ4TKNHK955X.2YYNAV248UMK8@otso>
 <YlBGfqNex49CgXze@robh.at.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YlBGfqNex49CgXze@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 16:28, Rob Herring wrote:
> On Fri, Apr 08, 2022 at 01:25:26PM +0200, Luca Weiss wrote:
>> Hi all,
>>
>> On Wed Dec 15, 2021 at 9:10 PM CET, Rob Herring wrote:
>>> On Mon, 13 Dec 2021 09:26:06 +0100, Luca Weiss wrote:
>>>> Add devicetree compatible for tsens on SM6350 SoC.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> It looks like this patch hasn't been applied yet. Could the responsible
>> maintainer please pick it up?
> 
> Normally that should be the thermal maintainers, but I've applied this.

Right, I missed it, thanks for taking care of the patch.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
