Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD9E579803
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiGSK41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiGSK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:56:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DDB28722
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:56:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u13so24114924lfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yvwWC/1xI0PKc7UydaS3qZ6eoT7HDp85IkqzAsVAV0g=;
        b=R0YL4IkpCMp8oBg5NAxSeO3KHGdPg647wnxW2Y2dHtElW58bG7xo4SZyc3ju9OB/nO
         5Y4VLAIKPlH+wIv1nbxeKomW4w4Y1wd8dw8e3cGAG8Veq/NtQZtdLLjX28lsK01n8L4v
         ACdW44xj9oTS8EVBOE83RJN49nmvRVPOQNEnp5nLh7IFQNUSBkATDRypIZgizK3dOYV1
         q5l64uxLnufyw8y+dxGcXZZ+vOHF7DSaA8wQ+aNlZ/A/kheuiXpsl8tjywrUlIE/2bfG
         CAgh9tLo21eXgpUazwdEhtidtxbDLaD/quxyc8/zCUCMdBWVpfVrMeytNpHa8Uod3lAu
         V/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yvwWC/1xI0PKc7UydaS3qZ6eoT7HDp85IkqzAsVAV0g=;
        b=x+BNFaNnQGO2ka15VUj2zy7+wPqzPORfP+mk0D9HtHguV+G2agh+eSXL5WaFBQtbTj
         96Yhx5vjMrm4wyqaCcr6tvvtAS7c2jOJ/5U50iWGbVsT8ee/NlgJFhYDJ1CEIjfo8LAI
         Vg94tB0QD/E4pJ7RRNwTDDZRGMHBvovo9qutSnIyQIAPcwGoxniGYezDte+Fkm5sDS0E
         BpPtQWlCaJBy+l2gDdq2ycDUy+HwjfRn5chxuZ1h4egQ66JI4Ue/wMyA989GtQdbFm6U
         CuSqA0S02tCk1pQuTDw/PdiuMT4X6QYv2SDhsLrG+U9EUNi0IgYhiA6QbwsDMydzDpWn
         EvJQ==
X-Gm-Message-State: AJIora8856F9iIjmj1bsop7Qt2Z2RkzaEeKhl8X+neDFXGerslEDThl3
        c+S63KVAy9FqTonXYHrQ79FfaQ==
X-Google-Smtp-Source: AGRyM1vwh2JlxuSjHJHU+c5df5vHUluFLzBwNMqhJCoM0g/mo433drcSZjNw8y2L536TzSKQ5mC9Hw==
X-Received: by 2002:a05:6512:1587:b0:481:1946:8e1c with SMTP id bp7-20020a056512158700b0048119468e1cmr18106372lfb.163.1658228180332;
        Tue, 19 Jul 2022 03:56:20 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id r11-20020a2e80cb000000b0025d5a9e4f77sm2606551ljg.72.2022.07.19.03.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 03:56:19 -0700 (PDT)
Message-ID: <26b43f6d-2b35-aab7-f906-31458c1b824b@linaro.org>
Date:   Tue, 19 Jul 2022 12:56:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62d686c0.1c69fb81.4a957.bf03@mx.google.com>
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

On 19/07/2022 10:19, Christian Marangi wrote:
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
> 

scripts/dtc/dtx_diff
fdtdump + diff

There should be an empty diff from at least one of methods above. If you
have a difference, I am not sure how can we verify this.


Best regards,
Krzysztof
