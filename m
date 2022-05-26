Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA5534AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244643AbiEZHQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiEZHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:16:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB1E37BF1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:16:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i40so741618eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vemDBZDCnhpAK2uXIq2WrkheYMWxwrmu5Ee771X7p5k=;
        b=us3L1pxoQlXucRLuOrHLCMJADLuv6kfsD5XMhrvhSTVYYm4xfsAm+5+cY9YTR39vy5
         nhby1fQuzH8KdqPSCn2aWeOzCMoTk0a3QzZIuMDZ7pXKVeNSRQ6d6A9QUZ9ZHJK6c0CW
         K84q1Fq3qVOZlmL4LtpNB66UCbeCe/kG68h0RN1+uUhi47q5zIYlWS7S0V8A0OBfGiW5
         6Z8AOavjOarpZPPzMrm/coG11ipPMz8fxT8L/Y5Vrbr0M4pE3KsuejP+MTwQES0VdMM+
         dRTYsXbqb2ffqg6g5kRaozLF+tAsxS36mQeqVkmMP5T7uz9dFWgpJSeujstPyDvHoSjG
         5t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vemDBZDCnhpAK2uXIq2WrkheYMWxwrmu5Ee771X7p5k=;
        b=bG+8DccRxrCXReKLfimM8sY4EDzKV9Oea0n3P9XqRx3fOEC36G6zoMKav/AyIinmAt
         BbC81tWXyN2aNitoh5s+3M0lF+qwSkui48TR9b7XD2YMmve49AfAqHwA8xRE9mr4u8fT
         nNodKBEaBy43VJpcaMcg1kv8ustXlw0PskDhrUzyCkHDnCxrIdrb1IJvHRpJXOAR70LS
         PvS/F1oBZF7I5gGNfIXGrniu/S+BB+wc1XzFiDm2T+qNbqY+XB+lsvPWyGQJU/dkEjZR
         6KCtgelgWYNm185vwJG/if6ovPFvN7AUwjq3KwtS5sIaNP5lB/sEOq6Vv3yKSnwOJJuf
         DkGQ==
X-Gm-Message-State: AOAM530xgKGTlGJiX2RmC7k7eqgo1etcBLugi/gOr33Z9QYoRdvdsoHq
        eBU7dBNFYMiSxlUUH3YHABc/7g==
X-Google-Smtp-Source: ABdhPJyKhk21/nQY9A/VVQJDajElTIqAvYmnxdQHegM5RNLrV2nLJPVTJA7zb0PcEHPcMbBE3j4ejQ==
X-Received: by 2002:a05:6402:1cc1:b0:428:a06e:a30f with SMTP id ds1-20020a0564021cc100b00428a06ea30fmr37677711edb.377.1653549364396;
        Thu, 26 May 2022 00:16:04 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b12-20020a50cccc000000b0042ab87ea713sm415510edj.22.2022.05.26.00.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 00:16:03 -0700 (PDT)
Message-ID: <7e019e53-c449-6520-009e-11a45e30df10@linaro.org>
Date:   Thu, 26 May 2022 09:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>, agross@kernel.org,
        arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, robh@kernel.org, sboyd@kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
 <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
 <YowBtNkZ678ns4Ob@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YowBtNkZ678ns4Ob@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all (not only Bjorn here) for comments. These are nice
arguments to prepare a proper patch.

If I got correctly all your feedback, the preference is to document
board-id/msm-id boards. I can prepare a patch for this, unless someone
wants to revive old effort (from few years ago).

On 23/05/2022 23:50, Bjorn Andersson wrote:
> On Mon 23 May 02:21 CDT 2022, Krzysztof Kozlowski wrote:
> 
>> On 22/05/2022 21:51, Konrad Dybcio wrote:
>>> Hi,
>>>
>>> removing these properties will not bring almost any benefit (other than making
>>> some checks happy any saving some <200 LoC) and will make the lives of almost
>>> all people doing independent development for linux-on-msm harder. There are
>>> almost unironically like 3 people outside Linaro and QUIC who have
>>> non-vendor-fused development boards AND the sources to rebuild the
>>> bootloader on their own. Making it harder to boot is only going to
>>> discourage people from developing on these devices, which is already not
>>> that pleasant, especially with newer platforms where you have to fight with
>>> the oh-so-bright ideas of Android boot chain..
>>>
>>> This only concerns devices released before sm8350, as the new ones will not
>>> even boot with these properties present (or at least SONY Sagami, but I
>>> doubt it's an isolated case), so other than completing support for older
>>> devices, it won't be an issue going forward, anyway. But there are give
>>> or take 50 locked down devices in mainline right now, and many more waiting
>>> to be upstreamed in various downstream close-to-mainline trees that should
>>> not be disregarded just because Qualcomm is far from the best at making
>>> their BSP software stack clean.
>>
>> I actually wonder why do you need these properties for community work on
>> such boards? You ship kernel with one concatenated DTB and the
>> bootloader does not need the board-id/msm-id fields, doesn't it?
>>
> 
> During the last years all reference devices that I know of has allowed
> us to boot Image.gz+dtb concatenated kernels without
> qcom,{board-msm}-id.
> 
> There's however been several end-user devices that for some reason
> refuse to accept the concatenated dtb unless these values matches.

I think several recently upstreamed boards have board-id/msm-id
properties, so I wonder how can we judge whether these are needed or not.

> 
>> Not mentioning that in the past bootloader was actually not using these
>> properties at all, because it was the dtbTool who was parsing them. So
>> in any case either your device works fine without these properties or
>> you have to use dtbTool, right?
>>
> 
> Unfortunately not. There are the devices which accepts a single appended
> dtb without these properties, but beyond that it's been a large mix.
> 
> I've seen cases where dtbTool packs up a number of dtbs, but the loaded
> one still need to have these properties, and there are devices out there
> that supports multiple appended dtbs etc.
> 
> 
> Last but not least, forcing everyone to use dtbTool adds a
> non-standardized tool to everyone's workflow, a tool that has to be kept
> up to date with the compatible to msm/board-id mapping.

OK

> 
>>>
>>> One solution is to chainload another, (n+1)-stage bootloader, but this is
>>> not ideal, as:
>>>
>>> 1) the stock bootloader can boot Linux just fine on most devices (except
>>> for single exceptions, where beloved OEMs didn't implement arm64 booting or
>>> something)
>>>
>>> 2) the boot chain on MSM is already 3- or 4- stage and adding to that will
>>> only create an unnecessary mess
>>>
>>> 3) the job of kernel people is not to break userspace. If the
>>> device can not even exit bootloader after a kernel upgrade, it's a big
>>> failure.
>>
>> The job of kernel people is to follow bindings and since they were
>> introduced 7 years ago, I would say there was plenty of time for that.
>>
> 
> We're following the bindings and don't pick board-id or msm-id unless
> there's a particular reason for it - which typically is that the
> downstream bootloader requires it - we don't use the properties on the
> kernel side.

I meant to follow existing bindings for compatible:
"qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"

I think none of handsets (google, fairphone, lenovo, microsoft, sony,
xiaomi) follow it.

It seems only Qcom boards (with 'qcom' as vendor prefix) use such
pattern, but the bindings say "Each board must specify", not "Board for
such bootloader must specify"...

> 
>> If the dtbTool support for the bindings is there, then there is no
>> breakage, because you had to use dtbTool before so you have to use now.
>>
> 
> Among all the platforms I maintain, MSM8916 (db410c) is the only one
> where I use dtbTool - because it refuses to accept the concatenated
> dtb.


Best regards,
Krzysztof
