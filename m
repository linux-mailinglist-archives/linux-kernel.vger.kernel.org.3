Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E2A5798C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiGSLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGSLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:52:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0505237E1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:52:21 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m9so14425596ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tWcruw9eRvvmbRP8IquaWzxGj9Fq2cYbW3H30aOciT0=;
        b=Nv+2BSqdZA7hwKzGWq/E5xtSFwXZmz9YiFTVdJ488gYOA4qUGrNNupE+qJYkjoOmiP
         TM0UwNFpF0jrV/T5oKcS0KQ80KD43E1lvylbf3pzMDbo55ZBZ3nBg65vc/coBK0tD/L+
         MKvJxh5bntkrNQ2yqovME91/ArJV426KJuV3PPLD921Wu/JwfajY9hJONYb1/EKndJ07
         AyTA6REBk+96dOghPCugnwQkLRXUAMg5QLK4KYvwMBPyBZlM6Dl6Ptx/zApKBhOs4ZAA
         PXq5s9jyd75Bib+JTGLcE66lOyt3JtxURLDzwKO/n9l7miOIPsTw639epridxs5ibsur
         wq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tWcruw9eRvvmbRP8IquaWzxGj9Fq2cYbW3H30aOciT0=;
        b=2EyyEkgKUrogGXhQo/AuCUu61sHTmy7qpOivB5px0RDEv0M/GBR6gdtj7sRYQHHDI5
         Iq/ScX7acC3Thdj5BMdEXvPHKQ4cr3q6Xeq+/FAGmzJIyyO1YE4m+QHJFz06EDUbPKvr
         sqFZwTYzpGOkF8ZHpvz905Mwytyl1/5mrOhu8Btk2Zgy8/zV9ylPwG51Rcb4TIf48Mh0
         7hVm2J7CUv1hc4lNjbp4m7phsda65ZghgBRPbNMAIYziolDw0oyOshjDonsl29rEqKYP
         Ov/C1JT8O6g4futBjPg0Zyq3SrmrLu4MgIexxevN86+3GTl7m8b+MQEvVpl/D5aDl4SA
         uBGg==
X-Gm-Message-State: AJIora/cPD47cnBYDQmqlBbWJwaEeGwDAXRkrB0sN9KOSu3nSMfqigl4
        FVU7zdKcoaG5r+DJAhQPBL8bsXgbF2qdkEeg
X-Google-Smtp-Source: AGRyM1s9F/TDe3iQtldBfXxy+KN8vt0cV80Q7c+anR1VA0nWSzeNglTD7pHZRl1DuwQ86aoLRJAI4Q==
X-Received: by 2002:a05:651c:1581:b0:255:48d1:fdae with SMTP id h1-20020a05651c158100b0025548d1fdaemr14711522ljq.286.1658231540064;
        Tue, 19 Jul 2022 04:52:20 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id a4-20020ac25e64000000b00489e5ba2e26sm3170412lfr.63.2022.07.19.04.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 04:52:19 -0700 (PDT)
Message-ID: <ea4a0f77-1b26-682b-89c3-1824d3f4d6e7@linaro.org>
Date:   Tue, 19 Jul 2022 13:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220718153815.29414-1-ansuelsmth@gmail.com>
 <7f2a4f21-5e07-9320-8f7b-573ccc562f43@linaro.org>
 <CAA8EJppCxrcQOtCDZvUX-CThGV7aZXYv__gz3KRBf28TCRTBEg@mail.gmail.com>
 <78230095-6b45-4536-f41d-12bb23308d34@linaro.org>
 <f625ccde-8ecd-c06d-e8b2-ecb51c9ac9b8@somainline.org>
 <62d686c0.1c69fb81.4a957.bf03@mx.google.com>
 <26b43f6d-2b35-aab7-f906-31458c1b824b@linaro.org>
 <343bd10e-bdcb-d097-e40b-a93dde586d14@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <343bd10e-bdcb-d097-e40b-a93dde586d14@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 13:15, Konrad Dybcio wrote:
> 
> 
> On 19.07.2022 12:56, Krzysztof Kozlowski wrote:
>> On 19/07/2022 10:19, Christian Marangi wrote:
>>> On Tue, Jul 19, 2022 at 12:22:24PM +0200, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 19.07.2022 12:16, Krzysztof Kozlowski wrote:
>>>>> On 19/07/2022 11:59, Dmitry Baryshkov wrote:
>>>>>> On Tue, 19 Jul 2022 at 12:56, Krzysztof Kozlowski
>>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>>
>>>>>>> On 18/07/2022 17:38, Christian Marangi wrote:
>>>>>>>> Reorganize node order and sort them by address.
>>>>>>>>
>>>>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
>>>>>>>>
>>>>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
>>>>>>>
>>>>>>> If this is picked by qcom branch, no need to resend it.
>>>>>>>
>>>>>>> I don't see value in such reshuffle. Reviewing is not possible and you
>>>>>>> did not mention tests (results should be equal).
>>>>>>
>>>>>> The value is usual for all the cleanups: make it follow the
>>>>>> established practice.
>>>>>
>>>>> Are you sure this is established practice?
>>>> Yes.
>>>>
>>>>  New DTSI files (see SC8280XP,
>>>>> sm8450 although sc7280 looked ordered) do not always follow it, so why
>>>>> imposing it for existing code?
>>>> Perhaps it slipped through review.. Partially my bad.
>>>>
>>>>
>>>> Such reshuffle can cause conflicts thus
>>>>> stops parallel development. Review is close to impossible...
>>>> Almost any addition or removal also causes conflicts, because git is
>>>> not as smart as we would like it to be. If the commit is structured
>>>> properly (i.e. it *only* changes the order and nothing else),
>>>> decompiling the dtbs before and after applying it and using a tool
>>>> like meld that can find similar chunks of text at different offsets
>>>> review is definitely possible, though not very pleasant (you can't
>>>> just diff them, as order is preserved & phandles change due to that)
>>>> as you have to look at it manually and can't tell much by just taking
>>>> a look at the email.
>>>>
>>>
>>> Can you give me an example of such tool? So I can put these data in the
>>> commit description. I have to rebase this anyway as more changes got
>>> merged so it might be a good idea to add more info about how this won't
>>> make actualy changes.
>>>
>>
>> scripts/dtc/dtx_diff
>> fdtdump + diff
> Thanks for sharing this.. way better than my crude method..
> 

For wide-tree cleanups I run (crosc64 is shortcut for proper env settings):

rm -fr dts-old; cp -r out/arch/arm64/boot/dts/ dts-old
crosc64 make -j8 dtbs
<make the changes / git stash pop / etc>
rm -fr dts-new; cp -r out/arch/arm64/boot/dts/ dts-new
crosc64 make -j8 dtbs
for i in dts-old/*/*dtb dts-old/*/*/*dtb; do echo $i; crosc64 scripts/dtc/dtx_diff ${i} dts-new/${i#dts-old/} ; done

Second method gives sometimes less false-positives:

for i in dts-old/*/*dtb dts-old/*/*/*dtb; do echo $i; crosc64 fdtdump ${i} > ${i}.fdt ; crosc64 fdtdump dts-new/${i#dts-old/} > dts-new/${i#dts-old/}.fdt ; diff -ubB ${i}.fdt dts-new/${i#dts-old/}.fdt ; done


Best regards,
Krzysztof
