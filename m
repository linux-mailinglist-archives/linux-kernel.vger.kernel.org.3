Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE858C952
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbiHHNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243302AbiHHNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:24:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FF85FC8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:24:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so2680332wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/9tQ7uEY5Z8pbFwi6SIpdyCeGRig7VEPT/0C3Du8FpQ=;
        b=shy5ZdIVs1IbXiYHLYxdjerjC0zrWDPTOEMMfKMmPG+FC6xPvhtweOp9Q60OvHidAQ
         OYt+pZZcuPsz+YkoQ6F8V4KrPDr+oR1UiGvmElYFQkPgMUecpDlIF5Zvne2qzAc6srtL
         PtSIkA4JpiG4hLYRN+52Aro1cDtvmYLiTBCwX0MlX9xm7FF88DWnFUBi4NpwUZaUWTC4
         roITeVGn4zzg56HM8p6e0Yz46SBPVkPrvO1D50MFNXwkz7uRwVdl7PHEKpoaD15kGUix
         HCaz9bqNjjCkinkMq1Qck4QsqTnJv6ju8txjUcgK+lAvy/82Lu9Sso5BNsoHB9LBkTQ6
         1T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/9tQ7uEY5Z8pbFwi6SIpdyCeGRig7VEPT/0C3Du8FpQ=;
        b=BgByF97Ktj1mj4wgk0tk1hIf6qcKIbamPnWMsxO0uVgid44Lti6t4PfX9o4w9ssXj7
         xNVST2k1Tj+bV3kLmV66eR5GOkbRdN0z9iSR6GykquXlA7UX3D8J15QHjAZwxttJ6qQD
         XhFBkrVtD/s0Kql6qwx+8RjrUJ7QTcdib2y8Vfiuqbdd2kMEWAX1v34NJqkmEYX5oJqa
         1nmEKuHJbyM9vWjZ5s1CK6oZZp6b7rOllosJTwoST7yV30qFVP1Ha+LVWT6vgSmv4RAN
         L8VbPEB1F0ac+ICc2xzRY2dyOaoi5ZqmjFKqFXlqIZqCSVh3uoX/oAz/eCSgAOTqkGeO
         VX+w==
X-Gm-Message-State: ACgBeo1in9B6k2y5BJ/x/imG0dim9LQMlXgzJyEXQDPo2dZ2wMIOPpGA
        dYrPUh0A8F5HnqtEwFbOsJ/DlA==
X-Google-Smtp-Source: AA6agR4xRaklyOa845xMRnZJAEhUAhq86KTeK6IcRW5RKhgLv7hY5763BR7cbMHy0iHuUsIkldl20w==
X-Received: by 2002:a05:600c:384e:b0:3a4:f9e9:3407 with SMTP id s14-20020a05600c384e00b003a4f9e93407mr12231522wmr.177.1659965054121;
        Mon, 08 Aug 2022 06:24:14 -0700 (PDT)
Received: from [192.168.1.12] ([81.178.197.238])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003a327b98c0asm13794826wme.22.2022.08.08.06.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 06:24:13 -0700 (PDT)
Message-ID: <f16afc86-520a-f0b1-a7ea-f02cfb1c21ed@linaro.org>
Date:   Mon, 8 Aug 2022 14:24:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/8] power: supply: Add driver for Qualcomm SMBCHG
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
 <a233730b-6ac3-2cb9-cc5c-21ca6289fadc@linaro.org>
 <BUIAGR.NIMOFVJH9GVZ1@gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <BUIAGR.NIMOFVJH9GVZ1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2022 10:39, Yassine Oudjana wrote:
> 
> On Mon, Aug 8 2022 at 11:41:26 +03:00:00, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 08/08/2022 10:34, Yassine Oudjana wrote:
>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>>  This series adds a driver for the switch-mode battery charger found on PMICs
>>>  such as PMI8994, and referred to in the vendor kernel[1] as smbcharger or
>>>  SMBCHG. More details on this block can be found in the last patch message.
>>>
>>>  This driver currently supports the charger blocks of PMI8994 and PMI8996.
>>>  PMI8950 was also to be supported, but it was dropped due to some last minute
>>>  issues, to be brought back at a later time once ready.
>>>
>>>  The OTG regulator remains unused on devices where the charger is enabled in
>>>  this series due to lack of a consumer. Applying a patch[2] adding vbus-supply
>>>  to DWC3 allows it to enable the OTG regulator making USB host without
>>>  external power possible.
>>>
>>>  [1] 
>>> https://github.com/android-linux-stable/msm-3.18/blob/kernel.lnx.3.18.r34-rel/drivers/power/qpnp-smbcharger.c 
>>>
>>>  [2] 
>>> https://lore.kernel.org/linux-usb/20200805061744.20404-1-mike.looijmans@topic.nl/ 
>>>
>>
>> How is it different from PMI8998? I expect not that much, so this should
>> be based on existing work:
>> https://lore.kernel.org/linux-arm-msm/20220706194125.1861256-1-caleb.connolly@linaro.org/ 
>>
>>
>> Unless they are different, but then please create common parts and
>> explain the differences.
>>
>> Best regards,
>> Krzysztof
> 
> This driver has been in slow developement for a long time before that one 
> existed, which was why no initial attempt at a common driver was made. With that 
> said however, I've been watching its development even before it was sent for 
> review, and It seems that the hardware is actually quite different. For example, 
> the original charger entirely lacks the type-c functionality that exists on the 
> second gen one. There are a couple of similar registers like CMD_APSD (same 
> address and function) CHGR_CFG2 (same/similar function, different address), but 
> other than that there don't seem to be any major similarities. While I guess it 
> would technically be possible to force them into one driver with multiple 
> register tables and separate functions for most tasks, I think it would just 
> unnecessarily complicate things. One thing that is common however is the secure 
> register unlock sequence, which I have separated in patch 6 to allow for its use 
> in other drivers (the fuel gauge block has secure registers too so it will also 
> be used in an upcoming fuel gauge driver).

Yes, we took the shared approach for the still work in progress fuel gauge 
driver, and whilst there are more similarities in that block for basic 
functionality at least, more complicated components differ quite a lot as far as 
I'm aware.

Even for the fuel gauge, separate handlers are needed for a lot of things still:
https://gitlab.com/sdm845-mainline/linux/-/blob/sdm845/5.19-release/drivers/power/supply/qcom_fg.c#L792
So I don't think trying to create a common driver here is the right approach.

Perhaps some abstraction is possible for the overall similarities like handling 
the APSD, dealing with current limiting, cable detection etc, perhaps some of 
this common code could be pulled out into a shared "helper"?

Maybe this is something worth reconsidering as and when we look at adding 
support for some of the more complicated features this hardware supports.
> 
> 

-- 
Kind Regards,
Caleb (they/he)
