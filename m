Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706E95797A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiGSK1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiGSK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:27:35 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C365CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:27:33 -0700 (PDT)
Received: from [192.168.1.101] (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D87F73F695;
        Tue, 19 Jul 2022 12:27:30 +0200 (CEST)
Message-ID: <d9bb2466-9f81-9b6c-c374-7f84b8c3e154@somainline.org>
Date:   Tue, 19 Jul 2022 12:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <62d686c0.1c69fb81.4a957.bf03@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.07.2022 10:19, Christian Marangi wrote:
> On Tue, Jul 19, 2022 at 12:22:24PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 19.07.2022 12:16, Krzysztof Kozlowski wrote:
>>> On 19/07/2022 11:59, Dmitry Baryshkov wrote:
>>>> On Tue, 19 Jul 2022 at 12:56, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> On 18/07/2022 17:38, Christian Marangi wrote:
>>>>>> Reorganize node order and sort them by address.
>>>>>>
>>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>>> ---
>>>>>>
>>>>>> This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
>>>>>>
>>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
>>>>>
>>>>> If this is picked by qcom branch, no need to resend it.
>>>>>
>>>>> I don't see value in such reshuffle. Reviewing is not possible and you
>>>>> did not mention tests (results should be equal).
>>>>
>>>> The value is usual for all the cleanups: make it follow the
>>>> established practice.
>>>
>>> Are you sure this is established practice?
>> Yes.
>>
>>  New DTSI files (see SC8280XP,
>>> sm8450 although sc7280 looked ordered) do not always follow it, so why
>>> imposing it for existing code?
>> Perhaps it slipped through review.. Partially my bad.
>>
>>
>> Such reshuffle can cause conflicts thus
>>> stops parallel development. Review is close to impossible...
>> Almost any addition or removal also causes conflicts, because git is
>> not as smart as we would like it to be. If the commit is structured
>> properly (i.e. it *only* changes the order and nothing else),
>> decompiling the dtbs before and after applying it and using a tool
>> like meld that can find similar chunks of text at different offsets
>> review is definitely possible, though not very pleasant (you can't
>> just diff them, as order is preserved & phandles change due to that)
>> as you have to look at it manually and can't tell much by just taking
>> a look at the email.
>>
> 
> Can you give me an example of such tool? So I can put these data in the
> commit description. I have to rebase this anyway as more changes got
> merged so it might be a good idea to add more info about how this won't
> make actualy changes.
dtc -I dtb filename.dtb -O dts > outfile.dts

meld old.dts new.dts

Then you have to look at them side by side.

Alternatively, python has libfdt and one could make a tool for that
particular usecase..

Konrad
> 
>> Konrad
>>>
>>> Best regards,
>>> Krzysztof
> 
