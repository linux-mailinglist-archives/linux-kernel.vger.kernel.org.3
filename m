Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016575805BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiGYUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiGYUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:33:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9FA22531
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:33:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id y1so3417754pja.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G5jYWH3hxREIRAZ8xNdidgICrjJheqmXGjb2G8FN6b8=;
        b=pHMpJ5bbRdXkUSMdQf34U5FJaTcIT5vq2m9zsL+qYLFi/LoMKXvQeXC/Pmg47dqiO2
         ZaUz76atfDMJ10DJ0+zUGJGyVQwd0kawSE13uhQYTko3cfNm/YQ75TdG01H9gykWRnTF
         cwncz3qMOR3ZPjPYnE0iYlvHN1xNTSTY5E53fqVUDa5SqdX5KJMZ7mEXtGW+KaL1mNPq
         8A6d1dB2vKV2NUcMurvhX9mPnK2R2StmKbirRFN5MLyqrCFGv6IelD4rFNTvHopj8kNL
         lDbmGUdjfBPL8AhkyZsmAF99ioOcQzEeh6Ew5ouUosX5QBfjLo89jYiRXZFoaChdCH8p
         D+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G5jYWH3hxREIRAZ8xNdidgICrjJheqmXGjb2G8FN6b8=;
        b=EEOthWiZgdiT/gfEnyN4oRv2WrktcPdwTW6ZSnK8t/NlF/OOD5hCVHvEe+F/cxSk1g
         YsGCM2aNH7RE7x+w5s9yJnjbwmzcdkMGmftCBB1QfRYyK9wv116IjToMzayIhpH197GG
         HbchlLcTT6GvdFCeYr4luFdUDAtcsmtlYjs2uM1Tt6CyJAaIoMnIm8L5DwcWdVsBB2O2
         8ovTCdqHP5t1nWXFbVKTbGn04tUTXbb5En8CsSP7bVIkB47QIvhTevCQPMg6CrgmgN6w
         Ws6k/1PIRoQDOjoK8LiUeV70R4pJsooMB3eWAZqH9wJtAcdhr6mrR/6H0rbKQnFkinhb
         9K/Q==
X-Gm-Message-State: AJIora/y0ZCxIjDtIbqye1cziBkyqbLeCqyMmGtbFHCKKu3tkv9/R3Ev
        vYxXoa5LXnktODQbnE9qP172Uw==
X-Google-Smtp-Source: AGRyM1uB8HPgkDJUFByliUB9fkkCz5dnUGW9tgJHiF+d1vbneXSJ66bbTruO1FX9I+boh7B6qELv9A==
X-Received: by 2002:a17:90b:3c86:b0:1f2:1fb9:ebd with SMTP id pv6-20020a17090b3c8600b001f21fb90ebdmr31488423pjb.151.1658781208299;
        Mon, 25 Jul 2022 13:33:28 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0? ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id s36-20020a17090a69a700b001f03287f704sm11501106pjj.57.2022.07.25.13.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:33:27 -0700 (PDT)
Message-ID: <863c3c60-fade-44d5-892a-c002883a044f@linaro.org>
Date:   Tue, 26 Jul 2022 02:03:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: mmc: Set maximum documented operating
 frequency as 384MHz
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220725180916.2850228-1-bhupesh.sharma@linaro.org>
 <CAL_Jsq+UaXgCFH5azZoHDSSqagEcRf9f6-ZucWAHuYZi0HaHgA@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <CAL_Jsq+UaXgCFH5azZoHDSSqagEcRf9f6-ZucWAHuYZi0HaHgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/26/22 1:59 AM, Rob Herring wrote:
> On Mon, Jul 25, 2022 at 12:09 PM Bhupesh Sharma
> <bhupesh.sharma@linaro.org> wrote:
>>
>> As Ulf noted in [1], the maximum operating frequency
>> documented in the mmc-controller device-tree bindings
>> should be updated to the maximum frequency supported
>> by the mmc controller(s).
> 
> Please send DT patches to the DT list so checks run and they are in
> the review queue.

Oops, will do.

>> Without this fix in place, the 'make dtbs_check' reports
>> issues with 'max-frequency' value for ipq8074 sdhci node:
>>
>>    arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
>>     max-frequency:0:0: 384000000 is greater than the maximum of 200000000
>>
>> [1]. https://www.spinics.net/lists/kernel/msg4442049.html
>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>> - Rebased on linux-next/master
>>
>>   .../devicetree/bindings/mmc/mmc-controller.yaml          | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> index ff5ce89e5111..c49f3060c24a 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> @@ -87,12 +87,19 @@ properties:
>>       enum: [1, 4, 8]
>>       default: 1
>>
>> +  # Maximum operating frequency:
>> +  # - for eMMC, the maximum supported frequency is 200MHz,
>> +  # - for SD/SDIO cards the SDR104 mode has a max supported
>> +  #   frequency of 208MHz,
>> +  # - some mmc host controllers do support a max frequency
>> +  #   upto 384MHz,
>> +  # so lets keep the maximum supported value here.
> 
> Add to the description instead of a comment.

Ok, will fix in v2.

Thanks,
Bhupesh
