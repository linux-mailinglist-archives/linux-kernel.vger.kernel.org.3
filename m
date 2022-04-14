Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBC501ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbiDNSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbiDNSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:05:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B0AE994D;
        Thu, 14 Apr 2022 11:03:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n17so2111846ljc.11;
        Thu, 14 Apr 2022 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kAsULcyFDYOOcncKyenYwJA/62360c0X8slk6jZuPw8=;
        b=k9KgEm4O/Gb3n5g5+GivmFNzLum7cNzINb/+FzxcZAMcIYhf3EgV5W1SrisnF6hgS8
         Ha+KwRhey9rCHwrDflbfIJuIZvOhYUGnihtC10n2CjtRGzV0FZ5feYLvtHMlIi1wnRbf
         A0rn4SHV/2Ado0nN3skHa1Vgt1jlEZRQtdcfteYx7bx2d+CZPxVZpgTDVE27NVto7ci7
         mt1H/r1cHas2/l+NQqX2DUvilvljqCmr5UEP9wSlxkXB901PI0d484ySe5UP5q1dKPRF
         ZMnl9Yj+ePFeeJmvyc3/DkFLbygCEAgFavl3p3pystVzXfAQGw4sBFkQFUvGEtLMaw4h
         B68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kAsULcyFDYOOcncKyenYwJA/62360c0X8slk6jZuPw8=;
        b=eCOFxTlEa0NsG/JFDvlJFaMmbGkD0DyUk3xKUrLeTdXJ1TjwIq/fAnkwiI7NbwLVbi
         eJ3nnrOrVzZdHOPeDp6MVyn6WagF00NuxSME3uY87mmJm1IvwH3Zs5vJOHl1HsL0bCO7
         AMn8gmMSSyCaVs2Wh8j4PKd80E4zajFU9jUCsl39SljdEfEswWaRyvOes37KCFdcLX5G
         0BA6EstzWRmiV/80ERBf9RtzlSXhp8lB4h5maKzGotrOW01mEXM8Tr+ghI3I5NSPCIE0
         p7rdIEiZRwaEiT7BwS+MFTXElprKUvsoRdkQsYzTXPnBXhTGHZbE9slfipyqiXuF5HW7
         77Wg==
X-Gm-Message-State: AOAM5320qQBIcvD4SWAVXLnZqmuT9dT+bnPGLzdoKMNfuRpTqbA7z2Z9
        3Sb90s43YKooSObqLbj+pQbE5pdCzUA=
X-Google-Smtp-Source: ABdhPJxKQKV/BEWQSLgwZ1HQxYFqeMN+mFpDZqAhcm5NETqJ9CknUCMTkdmI6B0Dp58+3QfbGxLE+w==
X-Received: by 2002:a05:651c:1544:b0:24c:8644:4046 with SMTP id y4-20020a05651c154400b0024c86444046mr2221156ljp.366.1649959378338;
        Thu, 14 Apr 2022 11:02:58 -0700 (PDT)
Received: from [192.168.0.122] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id v6-20020a2ea446000000b0024b0abb3984sm56334ljn.134.2022.04.14.11.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 11:02:57 -0700 (PDT)
Message-ID: <37fb7d5b-dbaa-0b8c-2ed6-6f1a462d7a62@gmail.com>
Date:   Thu, 14 Apr 2022 21:02:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] regulator: sm5703-regulator: Add regulators support
 for SM5703 MFD
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
References: <20220414170616.23319-1-markuss.broks@gmail.com>
 <20220414170616.23319-5-markuss.broks@gmail.com>
 <YlhfMkBqst87qvtD@sirena.org.uk>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <YlhfMkBqst87qvtD@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 4/14/22 20:51, Mark Brown wrote:
> On Thu, Apr 14, 2022 at 08:06:15PM +0300, Markuss Broks wrote:
>
>> +++ b/drivers/regulator/Makefile
>> @@ -173,5 +173,6 @@ obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
>>   obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
>>   obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>>   obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
>> +obj-$(CONFIG_REGULATOR_SM5703) += sm5703-regulator.o
>>   
> Please keep the Kconfig and Makefile sorted.
>
>> +static const int sm5703_buck_voltagemap[] = {
>> +	1000000, 1000000, 1000000, 1000000,
>> +	1000000, 1000000, 1000000, 1000000,
>> +	1000000, 1000000, 1000000, 1100000,
>> +	1200000, 1300000, 1400000, 1500000,
>> +	1600000, 1700000, 1800000, 1900000,
>> +	2000000, 2100000, 2200000, 2300000,
>> +	2400000, 2500000, 2600000, 2700000,
>> +	2800000, 2900000, 3000000, 3000000,
>> +};
> Are the repeated values at the ends of the array actually valid or do
> they indicate the part being driven out of spec?  If it's out of spec
> then it's better to exclude them since otherwise we might choose one of
> those values when configuring a voltage which may not actually work as
> desired.

I am pretty sure those values are valid. This voltage map is taken 
directly from the downstream driver (I wish I had actual 
documentation...) , which also backs it by saying 32 voltage levels are 
supported. However, I find it rather improper to have separate values 
which result in same voltage level. Still, I'm not sure something like 
selector offset exists in struct regulator_desc or elsewhere.

- Markuss

