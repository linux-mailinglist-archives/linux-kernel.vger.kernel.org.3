Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480BD58C335
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiHHGRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiHHGRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:17:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882A63D2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:17:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r17so11169062lfm.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=T8rNmdfGQpLyT9LR1PlSucPj1KAkeGsYwmxlQxDnSLI=;
        b=n81MxZvnNSuI3qedxwTMbxCFELlr2YlwnyP2qLYqK1c/SiDxMXsTtUG3FtobrlPbYP
         MqpGRBS7hjPRvy5ZbJcmxV3y+h4X55ggJZGQsx1ZzRI19tyuNRIp0m3YrIyb9gFIdECT
         OwpOT7oR+kzjXXn1347GjVpsS9NpKCCLugjrkK8VCkbryi/Vg+dAD9nFbYB4y3yXoNEx
         Xl0qk28VL2+ndU05Pa/NdmtNyu07O0NewSgFCMOQUvyH9vS1nvVj4LpzYKfnVqm2XQXB
         EMZ+3RO9+IUyO7wZvyLdupA2MsUVmfwlaNY1ipTkBVGTW/AO6rlODxdELiXJM/y/Eoem
         BhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T8rNmdfGQpLyT9LR1PlSucPj1KAkeGsYwmxlQxDnSLI=;
        b=qoMellD9IvL7pzp6IVclTRV/dT0NvI5Ez7YUJDvS7wB1kCvlwfTeMT9Uyso+L0iRAT
         1lw8c2H+EKO8PREeNWum9N02dFs9obWh9lZzjWOIx8/KGiRCgvRyuyIOia3VsmHeDEkD
         A5xvT+P2CA8uEzI5aeG5JbpRUDUHZiuxYO0TBvJj5LFIjXJPYTJs0F8pr8QKLGGgrxcL
         DhrxbUYELjgwhpD9DMhsu05kdJflDS1/J6sz5oMr+hssnGlm+b0HTDhr5Ejgs5Rr9WPo
         b5XYEuyv5nSrafqRV6yYJsZ9U/9bOliJiPzM1LsseEEebjrOnwZPTdFHl9e6CZBaz27/
         l6Hw==
X-Gm-Message-State: ACgBeo026azQz8EEZ6kXhiLx+NXbyfd6IwTGs0WtqF9UQMYL4UEwxjdv
        btRlEYh2Bn7jnC/5nfU09QolFQ==
X-Google-Smtp-Source: AA6agR6wuDSwNpJO7sX9bE+MUbq7BFPZE72HpVs62s7NS6I5udUt1KcwXlyjOTAa/6+TRhKTd/fxMA==
X-Received: by 2002:ac2:43d4:0:b0:48a:f6bf:1185 with SMTP id u20-20020ac243d4000000b0048af6bf1185mr5938168lfl.197.1659939436119;
        Sun, 07 Aug 2022 23:17:16 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id f12-20020a056512360c00b0047f77eb8f0csm1310277lfs.36.2022.08.07.23.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:17:15 -0700 (PDT)
Message-ID: <fe04e8ab-f8de-2c03-17e8-8960e5b460af@linaro.org>
Date:   Mon, 8 Aug 2022 09:17:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 5/6] arm64: dts: meson: add S4 Soc Peripheral clock
 controller in DT
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-6-yu.tu@amlogic.com>
 <60f30470-ca14-1e12-3ed2-7b34c7a93f8a@linaro.org>
 <759c681e-ec03-4230-b34e-0b2ee67ac870@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <759c681e-ec03-4230-b34e-0b2ee67ac870@amlogic.com>
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

On 05/08/2022 11:36, Yu Tu wrote:
>>> @@ -100,6 +102,30 @@ clkc_pll: pll-clock-controller@8000 {
>>>   				#clock-cells = <1>;
>>>   			};
>>>   
>>> +			clkc_periphs: periphs-clock-controller {
>>
>> Node names should be generic, so "clock-controller"
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>> You miss here unit address. Test your DTS with dtbs check and with
>> regular compile with W=1.
> I will change to clkc_periphs: clock-controller@0 {.
> Is that okay?

I cut the context, so if "0" was the value in reg, then it is OK.

Best regards,
Krzysztof
