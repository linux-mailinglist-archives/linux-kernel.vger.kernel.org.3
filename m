Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82357983B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiGSLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiGSLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:14:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268DD33A3A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:14:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bf9so24133682lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2tmlRUOer+5uD8E7QKBbOsn8zb38YDFbOxptCSAWlTc=;
        b=BlXTXeEoo4FnvTv/A8kKIiWvTBxDAojagFcMFd8UHcHa8rjbeoXSoVVEYswSucmWUx
         gSG48UwFXn+/jgdviLDakFMQXREX311eNkWe2H7zNDC7rtcePp7TCW1C0M/jwMv6a5d8
         pyj9shfjD0x1mQTe6tnQKXl939xB0NItJXPjaIuArNlALu1Go68yNgE1pf2tT9ngqA7I
         jZ1ye4LSWTavExIQHE8FQzsYaxTl7lfQGHGE+WciUi8yAqwqsqeU8t2QGWRbG7cphXD5
         43+XGX9H1doxvFi097bcHXEE0bcmiZ1/xhWzbaWj9Uv+jtp7ivdZFEVOrmA9Xe0Zc4O3
         Nhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2tmlRUOer+5uD8E7QKBbOsn8zb38YDFbOxptCSAWlTc=;
        b=nykEZmVX/HsDVs2+MKsAEcfhipqaiSd4AW115QQHOFyNcGIfNIDFyf6xIQ9SrgAFau
         C/lFcwRBHoBrm3/6VsdppRXBWB8S71uOeAtdvwS2GIPyGGAx+dk5Q8PvhLe53Pelcxhz
         0IJ6zIyo7mr1FcqKTdJV9e/OxAhJZYJ4OH89qlno/InB7Hi99cJLcutVyJzJP8Gb/11B
         bBkr5TPwATEBgmySPXaCspf8cPlHIBv5IIozXQG4kHtL+i93w/u9yxbqiXyXDw/8gytr
         rSTlg7Ynv8VUO6QEpCMvSGFK+/xnnyyRqIBadQuwPvRVc7LNyBJnVZ1Docam5v0TmwQo
         fo8w==
X-Gm-Message-State: AJIora82MSy+B3lUi8S5hupnhcYlT7oDJxzpEsPX2WBX5ir1X9vjqlP7
        aFPcS5piMt0nhCiHMY4ohfgYAA==
X-Google-Smtp-Source: AGRyM1vMUqYGcARhAIve+Hi0JLXWKy1Vojq0VCr7pnTk+pl5uC/AtOLHRpMVdW9tjEo62ITuAmYrYw==
X-Received: by 2002:a05:6512:3b24:b0:489:e6b5:162f with SMTP id f36-20020a0565123b2400b00489e6b5162fmr15828649lfv.260.1658229249504;
        Tue, 19 Jul 2022 04:14:09 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id d25-20020a19e619000000b00489c7fb668dsm3139699lfh.182.2022.07.19.04.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 04:14:08 -0700 (PDT)
Message-ID: <a4c805c3-8d78-98bd-40be-204fe98e6153@linaro.org>
Date:   Tue, 19 Jul 2022 13:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
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
 <26b43f6d-2b35-aab7-f906-31458c1b824b@linaro.org>
 <62d68f9e.1c69fb81.985fb.30aa@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62d68f9e.1c69fb81.985fb.30aa@mx.google.com>
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

On 19/07/2022 10:57, Christian Marangi wrote:
> On Tue, Jul 19, 2022 at 12:56:18PM +0200, Krzysztof Kozlowski wrote:
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
>>
>> There should be an empty diff from at least one of methods above. If you
>> have a difference, I am not sure how can we verify this.
>>
>>
>> Best regards,
>> Krzysztof
> 
> This [1] is the output of dtx_diff.
> The file diff is just phanle change that are related to the node order.
> 
> Seems a nice way to verify if the shuffle didn't drop any node.

Therefore run the second method - fdtdump.

Best regards,
Krzysztof
