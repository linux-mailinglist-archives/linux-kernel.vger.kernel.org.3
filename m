Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5F4E702C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353170AbiCYJnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiCYJny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:43:54 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35BFCFB9F;
        Fri, 25 Mar 2022 02:42:20 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id w21so5512665wra.2;
        Fri, 25 Mar 2022 02:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mv/wktd0MiTPurZvNCq9/NVpUlYQaKwOEmwVOKawM1Q=;
        b=Vl0Bw2NL7e1rLaWINJTQmscFSqqhS2J7QFNdVOkqzQv6yfwZbfaFxsapI3FrQtr9bX
         gdI8ZWJjARQT/xvx15sHd9AnpR5+MklpTMKNVZFWDU3UZnYzSLaySMFfc5RF71Dei16t
         kAWE1P99ePFWnD9wPsEZa54gZYTmcS2KBHcjUC20wbo7PUeCMIHgedAi+ZnasQNEHvvu
         mX3DR98GbSbANS+ASSNf43s++xKV3nijTBhqFI1JshIlnT7eyYKNG2gHyFxS7y7Scwxh
         3w0ELv+fD0ZprU6Oh6R5CmXcyWCFWqwRYKG+IC8TY4LzQzwvFjXiQeX9rzwIKMgUg4L/
         trYg==
X-Gm-Message-State: AOAM530U6x6ogUrb97Y9i0CqYs3mYLEfSu00bZxeSZlIxc++LN1SHslq
        YZpvMN1jw/ilzsPEYXIVSSX/7GP1+GE=
X-Google-Smtp-Source: ABdhPJwDQWNbx8m6n5MIkKm8A6NiapcIqq1+P+KqRozpVOHCJGLoRiizS45ezbGVsjsgmIAdKqO2xw==
X-Received: by 2002:adf:f192:0:b0:203:e38f:afa1 with SMTP id h18-20020adff192000000b00203e38fafa1mr8495069wro.120.1648201339061;
        Fri, 25 Mar 2022 02:42:19 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id g10-20020adfe40a000000b00203eb3551f0sm6520028wrm.117.2022.03.25.02.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 02:42:18 -0700 (PDT)
Message-ID: <ca18fa50-f63b-8131-07a2-8c44daed9f26@kernel.org>
Date:   Fri, 25 Mar 2022 10:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701
Content-Language: en-US
To:     Mohan Kumar D <mkumard@nvidia.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
References: <20220325072141.28597-1-mkumard@nvidia.com>
 <f35537de-6352-e6db-b4a6-17b1ab96deda@kernel.org>
 <32e425be-5d78-e1e0-6ec4-70ea21895e15@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <32e425be-5d78-e1e0-6ec4-70ea21895e15@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 10:31, Mohan Kumar D wrote:
> 
> On 3/25/2022 12:56 PM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 25/03/2022 08:21, Mohan Kumar wrote:
>>> Add iommus property for hda and enable the node for P3737 + P3701
>>> platform.
>>>
>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>>> ---
>>>   arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
>>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi                      | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>> index 34d6a01ee1c6..156d5d95fde7 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>>> @@ -1751,6 +1751,7 @@
>>>
>>>                hda@3510000 {
>>>                        nvidia,model = "NVIDIA Jetson AGX Orin HDA";
>>> +                     status = "okay";
>> Nodes are enabled by default. Why do you need this?
> hda node status is set to "disabled" by default in soc dts file 
> tegra234.dtsi. The enable is controlled by platform specific dts files.

Oh, surprise... why do you override nodes with full path? This is
error-prone and makes any changes (like node name fixing) difficult.
This should be overridden by label.


Best regards,
Krzysztof
