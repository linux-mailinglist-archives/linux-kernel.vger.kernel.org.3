Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE99951E8B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386434AbiEGRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiEGRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:08:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07501A806
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:04:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i19so19630460eja.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lwpxPEc/qAOut1rsLlLVEixk6aV+q5P8g2o44/7tBWU=;
        b=hzDfCTXEzXCF8HEY4rk18UbzbaY08fbqWhedXjN6W7tlWX/Av1LXsp1d3ji3U3sdKW
         nmdjCoedC078cUYNfik7TUpcdlw89WgAYGv0eruUwAgJ6E7ei7kd6ZANzp4ZYDaUOIia
         Jj4YhKnzz26l5mv5i/X8I133uguvVAkMS772eR5Qj2SmvAFk7oifyT/ZBaJa64BLEAwm
         asbdvTBMIwBvfV6+t4vtg8/q/wUI5WWEyNRnw15MJfvPcXJh929mSKPX92yqAqHxLu9/
         Q2A/WIIRbDeFOtnPJrZ31WjO2Z2KVqBkEDC0RX+VSf3V+XbuoSbPYuO1dyFCBYzA5Of8
         jvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lwpxPEc/qAOut1rsLlLVEixk6aV+q5P8g2o44/7tBWU=;
        b=FlDONF8a4vxvjpV2v4YWB2RkPtVmZOzBUcfO+rdr0UAY0UUs422GJPlfacK41YpBtK
         Ptj/EWbfdofcUSMvBRe7YCu2GkPnyFKCjF59YTcuK0FeTxaRW8VEECSgwEW1fqDqJqyo
         FTO9cY88EHOj/v9kJhoV2cmLHnZkZAmELLU0e3BRSjYbAlHerS8LVPCcyddRn/brigmp
         KubV1w4/HDBDTRMfbq/hrjCRkmKT6IOgvENVjNgorcOP6pRc/ThGG67u7wP3abUfXcuT
         gcHWvhSCzwHv3G/EQ7MQKTrRohe3jfHU73qom2BCMiwpExy9LQ1AF+UVvv6qawtYoujc
         ID/A==
X-Gm-Message-State: AOAM531t5Y6lzPA/i1FTrmZLKwMucSy4ZwKN/Sn7Ww+GCZhe8Gq1WTES
        uA5AwMyrhuCN3AJVI77EHu4jjcG/4169ABa3
X-Google-Smtp-Source: ABdhPJxechdF7kOzNsR+z4fFmVlYw+d4SYplkIVXmb2dJppCj6xtjfomh3JD/H2+r6qOsoncJZadUQ==
X-Received: by 2002:a17:906:f857:b0:6f3:a331:c043 with SMTP id ks23-20020a170906f85700b006f3a331c043mr7616353ejb.246.1651943056251;
        Sat, 07 May 2022 10:04:16 -0700 (PDT)
Received: from [192.168.0.233] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7dc4a000000b0042617ba63basm3697642edu.68.2022.05.07.10.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 10:04:15 -0700 (PDT)
Message-ID: <ce2ea308-b63d-ad27-4cea-7353268f8ebb@linaro.org>
Date:   Sat, 7 May 2022 19:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski.k@gmail.com>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org>
 <CAD=FV=UjyLofXZqnj=bL89fza5JS6O5Np9W-A4V4WK+na0hdrw@mail.gmail.com>
 <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org>
 <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
 <606cc762-a0c2-49a4-3e5d-d2dbd4595bc7@linaro.org>
 <CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com>
 <CAJKOXPdt5WTg4VU-TEW3dmPHR76dKg63XVxRQfa7ZSKc_jz6Ag@mail.gmail.com>
 <CAD=FV=XQqQSQDNh-zXqEQkwsrax5Qb3OtfKZoQLkncJj_4mcQw@mail.gmail.com>
 <daf66d41-42ac-50dc-3f8d-c261da8e452d@linaro.org>
 <CAD=FV=WhA=n_=Ys6NfedPtNPddL81HnG6Qws_R+vq9w8Nrsn5A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WhA=n_=Ys6NfedPtNPddL81HnG6Qws_R+vq9w8Nrsn5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 23:33, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 4, 2022 at 12:04 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>>>>>> The most specific compatible identifies or, like recently Rob confirmed
>>>>>> in case of Renesas, the list of compatibles:
>>>>>> https://lore.kernel.org/linux-devicetree/Yk2%2F0Jf151gLuCGz@robh.at.kernel.org/
>>>>>
>>>>> I'm confused. If the device tree contains the compatibles:
>>>>>
>>>>> "google,lazor-rev4", "google,lazor-rev3", "google,lazor", "qualcomm,sc7180"
>>>>>
>>>>> You want to know what board you're on and you look at the compatible,
>>>>> right? You'll decide that you're on a "google,lazor-rev4" which is the
>>>>> most specific compatible. ...but you could have booted a
>>>>> "google,lazor-rev3". How do you know?
>>>>
>>>> Applying the wrong DTB on the wrong device will always give you the
>>>> wrong answer. You can try too boot google,lazor-rev3 on x86 PC and it
>>>> does not make it a google,lazor-rev3...
>>>
>>> I don't understand what you're saying here. If a device tree has the compatible:
>>>
>>> "google,lazor-rev4", "google,lazor-rev3", "google,lazor", "qualcomm,sc7180"
>>>
>>> You wouldn't expect to boot it on an x86 PC, but you would expect to
>>> boot it on either a "google,lazor-rev4" _or_ a "google,lazor-rev3".
>>
>> Yes, but booting it does not mean that the hardware is rev3 or rev4.
>> Booting it means only that we are running DTB on a compatible hardware.
>> The DTB determines what is accessible to user-space, not what *really*
>> the hardware is. The user-space (since we are going now to original
>> question) reads it and can understand that it is running on hardware
>> compatible with rev3 - either rev3 or rev4 - and act accordingly.
>>
>>> Correct? Now, after we've booted software wants to look at the
>>> compatible of the device tree that was booted. The most specific entry
>>> in that device tree is "google,lazor-rev4". ...but we could have
>>> booted it on a "google,lazor-rev3". How can you know?
>>
>> No, providing and loading a rev4 DTB on a rev3 board is not correct and
>> does not make any sense. rev3 boards are not compatible with rev4, it's
>> the other way. Not every fruit is an apple, but every apple is a fruit.
>> This is why I used that example - if you load rev4 DTB on rev3 hardware
>> then you have totally wrong booting process.
> 
> I think this is the crux of the difference in opinion and there's no
> reasonable way I'm aware of to do what you're asking. If -rev3 and
> -rev4 are identical from a software point of view it would be silly
> not to share a device tree for the two of them. The number of device
> trees we'd have to land in the kernel tree would be multiplied by
> several times and we'd have many that are identical except for this
> compatible string. I see no benefit here and lots of downside.

Wait, we agreed that you don't consider them identical, didn't we? If
they are identical, you do not need rev4 at all. So they are not
identical...

If they are identical, just use rev3 and problem is gone.
If they are not identical or you need to assume there will be difference
(for future), then just go with rev3 without fallback to rev3 and also
problem is gone.

Right now it's not possible to validate QCOM DTSes against DT bindings
because they throw big fat warnings about undocumented top compatibles.
This is a downside for us.

Remember, you do not have to use Devicetree or Linux at all if it causes
you some downsides... No one is forced. :) If you choose to use it,
sorry, it comes with some requirements like being following Devicetree
specification or the binding guidelines.

Best regards,
Krzysztof
