Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6B758F9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiHKJP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiHKJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:15:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AA4402D4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:15:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u6so13324788ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=eWYdVQgTkSshr+LnqPUerx5UBYrvRFihiIrrHfJRObk=;
        b=V7SzdIVQUah6XvBKizvA1mVgIky9pI9QACts5UE/xHSbnXlzv5qvmt06tCaJpfdMEp
         8LVG9IdKWBoImtN747jLTjxZsqEQ3SS/svIo8rGmJ/oEiKFkPfEhGmqErGXM58Zmaa3U
         QgDqrWPMumitFhDxY4nqBRzTUmIUcSJnPGQoXXrYfpa+OvCbBU+5lbHFUthxydyGFpb4
         wtkR+UzFC43D/+M/57s9tDYzX9kYGHpnFadSkFEFqkBFBkIpsa8vn8ngxL5OU9QgljRO
         l2JghWSevhNV7NWvHiuF2PdGHxD2BVmk3WYK8lMj8nPIqWFkmNR/66LgmlSScYfjUelZ
         YxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eWYdVQgTkSshr+LnqPUerx5UBYrvRFihiIrrHfJRObk=;
        b=LSTYPtHYyuITpKL/jGUI1jai4zzwElIrAEGvZoYb3B9o/8EBo47n2P0/67lt1om5Dx
         0SVWJGKS5yKJGmck7oSCizzpZl9D/aZrpCUeAdI0fmHFhUn3Jq2HPeLnqLvLh300TYGD
         sFRlQ8rPAZIXhlATmtSN5R0Oz21N6IyU68Vif1jFiPhNHJ3eGx4IQntJSRU/8fLfXC7g
         K2K9Ydh3sGrCHCC4hQlf7RcBRjBM8zjSWDe1xPCgIBMldKJTsqOd8m0DJIfpX6tku1qC
         v3MeY3MF5HKr/Fa3104KNjTQ9igNhn1sq1rZ+qDf5moXmKGYcUtx3cdyv/N0e3IZbki2
         +yDw==
X-Gm-Message-State: ACgBeo3gmkERVu6sDgdacogezv7TSrMzAAmvFTDAkdUePVyZZMGMIVT0
        t6dp0iWTvcip/vaGY3NrI11I5g==
X-Google-Smtp-Source: AA6agR53XfRpjtqJX/e2qIzfPhAibPRJPgQbeXyD0yMC1ANb0zWWn7gz9PDlDZC9gFwqwtlCvsKCCQ==
X-Received: by 2002:a2e:2ac1:0:b0:25e:4b39:e3cb with SMTP id q184-20020a2e2ac1000000b0025e4b39e3cbmr10344846ljq.458.1660209352649;
        Thu, 11 Aug 2022 02:15:52 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id j15-20020a056512028f00b0048b2be5320csm641183lfp.118.2022.08.11.02.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 02:15:51 -0700 (PDT)
Message-ID: <a063d48a-2096-ba5b-7f65-d55fec49d534@linaro.org>
Date:   Thu, 11 Aug 2022 12:15:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] pmic: add mt6366 regulator document
Content-Language: en-US
To:     "zhiyong.tao" <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        zhiyong tao <zhiyong.tao@mediatk.com>
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
 <20220728062749.18701-2-zhiyong.tao@mediatek.com>
 <03a13ed4-e7cd-6f7d-f8f7-9b1e6193e202@linaro.org>
 <111e1073e1ce689e289e52c645a1be2e7dc7fe12.camel@mediatek.com>
 <86ab77f5-8beb-7237-d6e2-734f52ca176b@linaro.org>
 <3d120fdb5d26d1211f797e5a26e8af3f34439424.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3d120fdb5d26d1211f797e5a26e8af3f34439424.camel@mediatek.com>
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

On 11/08/2022 12:14, zhiyong.tao wrote:
> On Thu, 2022-08-11 at 11:58 +0300, Krzysztof Kozlowski wrote:
>> On 11/08/2022 11:42, zhiyong.tao wrote:
>>>>
>>>>>
>>>>> Signed-off-by: zhiyong tao <zhiyong.tao@mediatk.com>
>>>>> ---
>>>>>  .../regulator/mediatek,mt6366-regulator.yaml  | 375
>>>>> ++++++++++++++++++
>>>>>  1 file changed, 375 insertions(+)
>>>>
>>>> Subject does not match subsystem.
>>>
>>> Hi Krzysztof,
>>>
>>> Do you mean that we should change the title like this:
>>> regulator: dt-bindings: mediatek: add mt6366 regulator document
>>> is it right?
>>
>> Yes. And remove redundant pieces so for example:
>>
>> regulator: dt-bindings: mediatek: add mt6366
>> or:
>> regulator: dt-bindings: add mediatek,mt6366
> ==>
> Thanks for your suggestion, we will fix it in next verison.
>>
>>
>> (...)
>>
>>>>> +    patternProperties:
>>>>> +      "^buck-
>>>>> v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
>>>>> +        type: object
>>>>> +        $ref: "regulator.yaml#"
>>>>
>>>> No need for quotes.
>>>
>>> ==>
>>> We will remove the line "$ref: "regulator.yaml#"" in next verison,
>>> is
>>> it right?
>>
>> No, it is not. Why do you want to remove it?
> ==>
> We don't understand "No need for quotes."which means.
> Do you mean that we should remove the quotation marks.
> We will change it like this:$ref: regulator.yaml#
> is it right?

Yes, remove the quotation marks. You wanted to remove entire line which
is not correct. $ref should stay.

Best regards,
Krzysztof
