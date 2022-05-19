Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811C952D0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiESKgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiESKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:36:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70173220F8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:36:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p22so8323921lfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=sy2/y6OgW1NgZ7/PdGhR7Fma4RE9LOWz1g6YWKekTR4=;
        b=ChCff4nRJjkCJSeKmXc7tPcaQer2xgkhAUqjk1Q1ARYSGKCLN2emGKuawzfW26VZ4b
         PQZxnUqYeaj2EImRC7U8dbJX9INqDNZak0lq5N8urtlr5Crp8QYONe3mdspXdWmHMbxa
         ZLx4oVRhiq2JzTfYL8Lg8kWuwkzjwRfsrkzpBNEF0GSQxTwLaov76COe65BI98svjaKG
         5qljFeJvf8Dz5Al2U6ae1yN4mpqMTthvdqA2Zgp5qTu454Xptp54nbrJotJTkM6XO3+1
         B/AP7W1Hx3PTk1/Ggzij4fiLjymFgyX0ZNezYW4icYXE5O+SuJMEZqWNRxltxx4fMxyn
         kNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=sy2/y6OgW1NgZ7/PdGhR7Fma4RE9LOWz1g6YWKekTR4=;
        b=ei+/HmLyBCTTz9JSErd7Xqbgrt6nisoZPsuAZqCr7FZlb7K65Fw2cmLE1XpxGfiw/d
         nsNkVgYGP0pf+OXDUPb0MDNjdkxW6EcoXO+cmxdgEjkQ87yjHPvjQA60VFVzBgKKY23p
         +YBfEzWvrnrjsrOF/Wc5dJ8CumlQraD4sGMgA6xNvA2xl0YrUDhVNlOtrnS+dIH2NxXg
         rteiPUfT/lFiHDUbrUKyHZJAFETEYPZkSjGVsXPLwezBRzgrm5pgNx6Gd+4LUszFIATQ
         aNcpEBSZxGTVu5FKW1s18Rkq8qlcsV5QcI78zyK+V0hUYXv9Pid6McgBQz6CBoMQVcuT
         /d/A==
X-Gm-Message-State: AOAM5315Xi6ZfehhTyRWHeGb2G030OY79amlfpS6bEAJ1NVcxrCVCbZX
        /9EhPFioGSnRXhSYgHS6C9Ka3x5wp2CRJ3CR
X-Google-Smtp-Source: ABdhPJwookZsCmvNd/+8Z5SuzDn88heC2mdYIuN2UlaW4HW8nilYRtc7s0a4vhmT3LiQlFotY0/Mkg==
X-Received: by 2002:a05:6512:ba5:b0:477:ab03:5fba with SMTP id b37-20020a0565120ba500b00477ab035fbamr2853316lfv.220.1652956569844;
        Thu, 19 May 2022 03:36:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d24-20020a056512369800b0047255d211fbsm240796lfs.298.2022.05.19.03.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 03:36:09 -0700 (PDT)
Message-ID: <db32d4b6-9a88-4f4a-2ab8-878b21d502ac@linaro.org>
Date:   Thu, 19 May 2022 12:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support
 for Xiaomi Mi 5s Plus
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     Alec Su <ae40515@yahoo.com.tw>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519074112.25600-1-ae40515@yahoo.com.tw>
 <20220519074112.25600-2-ae40515@yahoo.com.tw>
 <3644ad8a-d5d8-8ea2-b659-029619c64f1f@linaro.org>
 <NqQY5WA6i6jOhK8lZ-YD4kWA57qJCSIGJE6_xAQmOiFJ4a-msHcn7oakouduiLhODYlfWVvgr-E5S6m43Ab6EUFa0ZPYV0kPGeYbVV7zpUI=@protonmail.com>
 <3bb95350-01cc-b15b-3589-16019e3e9105@linaro.org>
 <b459bbd2-26c6-1af1-b1ee-d4cf5f49cdaa@linaro.org>
In-Reply-To: <b459bbd2-26c6-1af1-b1ee-d4cf5f49cdaa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 12:06, Krzysztof Kozlowski wrote:
> On 19/05/2022 12:01, Krzysztof Kozlowski wrote:
>> On 19/05/2022 11:57, Yassine Oudjana wrote:
>>>>
>>>> There is no such property documented. Either add bindings, or drop.
>>>>
>>>>> + qcom,board-id = <47 0>;
>>>>
>>>>
>>>> The same.
>>>
>>> These properties are already used in many device trees; they are
>>> needed to let the bootloader pick a DTB, but yes they aren't
>>> documented currently. devicetree/bindings/arm/qcom.yaml would
>>> probably be a good place to put them.
>>
>> Which means each person is using them and not caring about
>> documenting... they need to be documented. I am not even sure if they
>> should be accepted.
>>
>> The DTS describes hardware, not bootloader specific details. The
>> hardware - board - is defined by compatible and bootloader should use
>> it. Adding new properties because someone decided "I don't like
>> compatibles" is not appropriate.
> 
> There is prior art:
> https://lkml.org/lkml/2015/10/26/651
> https://lore.kernel.org/all/CAL_JsqJAOEvs08Jydn9wWtM7-Oxd=MmmDER48VRF7z3Gkzt0CQ@mail.gmail.com/

I found the discussions and I see it stalled. No objection from my side
on this one here. We should solve it on other level.,


Best regards,
Krzysztof
