Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99552D2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiESMrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiESMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:47:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7DA59965
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:46:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p4so7523615lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vJNbUJe0I9bP1Pb8oaCFC6Y74eStu1CcrBu2o8mA4K8=;
        b=Jy3PNajkRCtSCyOwWUvByidPiRuaczMd5h0dLGUVGPGr3KW8M6wBBLf/mjcAZnhmlk
         +xDXwbgkzAWKFHNGEQEkRG/Fhifw3WPj86qUi15EShfXfq5Ygzjjb2TEJqiO9sQ1vnWt
         G3THZOByZqygoZh+XurzGpZtIx+C9ZUSrFaJ44WX6M14jI/Ko4EAbr2XH29uO95VYdSm
         6URnK2wsma+OaargCHDf4/yBHC3+kZNL78uGaVmy/p3dkjZE2NdW2E7Pq9ASypGMrXPY
         w0eBNrOOGZYaBua2ngP0TlmElTPmFe+cEAlDE8VgUFfz9RSudIKyjRZ1WK0Yu41wf+tO
         WVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vJNbUJe0I9bP1Pb8oaCFC6Y74eStu1CcrBu2o8mA4K8=;
        b=NnV5cVKIRJWqv3uwrV07d4+9j2aMj5T/DBKwGuAII8Hgbrht4uM3luu81riWBTngDq
         OLqWo0jn6FD+7LTGhxACcYZKwu2TPulFYb9F8FRhDa/Xb6SvYFg0fOJJ1hW3R33nuvnM
         oQFfAURZC/6Q76H2o56+y8RFWdt3GWobgUV6BoIBpr6t45oznTZDeGMQDfcm0b32/m2o
         lPDIZ+2cfwJBRWxLfjwvPJOSJrP+RwUBF3mmKmfO6GHWFr6Ca3COAjbXEPR60frTe+81
         SAIoKo/hO5tSEHTHuGbnp/Abaube0DwKrV7qSNEjjTSpmuuATbULSxnoAPD3rS2otArK
         tHWQ==
X-Gm-Message-State: AOAM530PcrwcbHEQ/LsM960EFpZOoCS4F9gcrAdsfKJB12k9LscB0s/F
        bEJk+Fuoym02gHTnDtq1LXx/cg==
X-Google-Smtp-Source: ABdhPJycTA4+DGk4OsEDZYKf1XzCRbMtOTP4sw0tmlEGpAE+f2HTPwuH4+0TRq43pvsMZGWNjVCvsA==
X-Received: by 2002:a05:6512:3195:b0:473:a219:1b0f with SMTP id i21-20020a056512319500b00473a2191b0fmr3258272lfe.439.1652964414752;
        Thu, 19 May 2022 05:46:54 -0700 (PDT)
Received: from ?IPV6:2001:470:dd84:abc0::8a5? ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id d23-20020a2e3317000000b0024f3d1daebdsm563370ljc.69.2022.05.19.05.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:46:54 -0700 (PDT)
Message-ID: <40f29157-52c0-001f-6c14-fb90b351756a@linaro.org>
Date:   Thu, 19 May 2022 15:46:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <35051bec-98ea-b4c5-f734-06b3f22f3562@linaro.org>
 <8a90ffbc-b376-9115-fb91-0b46d98873b7@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8a90ffbc-b376-9115-fb91-0b46d98873b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 19/05/2022 14:53, Krzysztof Kozlowski wrote:
> On 19/05/2022 13:39, Dmitry Baryshkov wrote:
>> On 19/05/2022 13:44, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> There was an old effort of removal of qcom,board-id and qcom,msm-id
>>> properties from Qualcomm SoC-based boards like [1].
>>>
>>> First approach was to document them, which (obviously) was not well
>>> received [2] [3] [4].
>>>
>>> The solution from Stephen was to encode these in the board compatible,
>>> so bootloader can extract that information. That seemed to receive
>>> positive comments, at least from Rob. [5]
>>>
>>> It was 2015... ~7 years later we are still things doing the same way,
>>> still with undocumented properties: qcom,board-id and qcom,msm-id.
>>>
>>>
>>> I would like to revive that topic, but before I start doing something
>>> pointless - any guidance on last patch from Stephen [5]? Was it ok? Some
>>> early NAKs?
>>
>> I do not quite fancy the idea of using extra tools to process dtb files.
>> At this moment it is possible to concatenate several kernel-generated
>> dtb files together. AOSP developers use this to have an image that boots
>> on both RB3 and RB5 boards.
>>
>> I think that changing compat strings only makes sense if Qualcomm would
>> use such compat strings in future. Otherwise we end up in a position
>> where we have custom bootloaders for the RB3/RB5/etc, but the majority
>> of the board requires extra processing steps.
> 
> This was discussed in [2] [3] and [4] (previous links) and did not pass.
> 
> Do you have any new arguments for above objections from Arnd, Olof and
> Rob? I don't think patch will get accepted if previous concerns during
> review are not addressed...

I'm not sure if the patches to the dtbTool have landed or not.
Anyway, as I said, I don't think post-processing the dtb is good way to 
go. It makes extremely hard to check that the dtb, used by the kernel or 
being a part of the boot.img, corresponds to this or that compiled dtb.

> 
>>
>> So, I think, we should drop the unspecified usid aliases, document the
>> board-id/msm-id/pmic-id properties and stick with them.
> 
> The existing properties need anyway documenting, probably as deprecated
> so the schema can pass, because we cannot fix the bootloaders easly.
> 
>> They might be
>> ugly, but they are expected/processed by the majority of devices present
>> in the wild.
> 
> Any change in DTS affects only future devices, so not in the wild...

It affects existing devices that have deployed bootloaders. So far we 
could workaround thus by enforcing a single dtb attached to the kernel 
image. However this doesn't play well for the distro (or AOSP) kernels, 
where we'd like to have multiple dtb image attached.

> 
>>
>>> [1]
>>> https://elixir.bootlin.com/linux/v5.18-rc7/source/arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts#L14
>>>
>>> [2] https://lore.kernel.org/all/7229476.C4So9noUlf@wuerfel/
>>> [3]
>>> https://lore.kernel.org/all/1450371534-10923-20-git-send-email-mtitinger+renesas@baylibre.com/
>>> [4] https://lore.kernel.org/all/20151119153640.GC893@linaro.org/
>>> [5]
>>> https://lore.kernel.org/all/1448062280-15406-1-git-send-email-sboyd@codeaurora.org/


-- 
With best wishes
Dmitry
