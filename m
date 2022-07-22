Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398557E667
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiGVSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGVSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:22:24 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C245528B0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:22:22 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j26so6395360lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pr7T8YmXgcjyBw/qQmjL0IBnyhjt5WfV1o0h0y0cqLo=;
        b=L7W8z1E+272iyr8qpCt5he+cg50qGQoDR32QNDd8rt0UMBgecUFFEWikptwG58Dond
         /ZxUWEL8W91YdaFAtrSVZGfxQRKq79fKMnnGHhy32SMZT3IZzR3OmJenh+Nu7lGKbxpW
         DSXH2ctaVPAk5lTDS+TssAkl6oRoZoe4wFtNa7KDE3iXlJ1MjoitgC26t7IlBFEmCL5Z
         dgiVtoM9gtJJnVL2zols4FC5BVyK1xHAG3ApGnqnXJQU9cve4Ann6RyN/sfU1kshFTJJ
         uvUrBULARm6/SpiHp3UFskOTco5gsztk2+jcz8GzJNUxYqdDaSrcNn5coTMYi4qdWnrU
         m+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pr7T8YmXgcjyBw/qQmjL0IBnyhjt5WfV1o0h0y0cqLo=;
        b=LyKkaOjrNJSS91KP9k96a1LqqpxPhT66NB+iMJRlf11Xj+1+9OAHGfVdeCJ7/jxyIw
         6f/L8stISB0E5z+3MOAAP4YlZnOSD75MwVvEQqDv5A+JiIulZF1yc2HKmo/AHYiPSi8O
         lPJqHDmsw2KyMKIEk8MowEfY9DTM9bKs2K2o0wMSO7NezusKheyYMZyd3sUtUW7ECzQO
         YvhrZGMf8uC3so+VPbFYKrWoEU+36q9QoGcEZaxrgo9RL2B11qVIF2CwQp/FsIRCqNKw
         M7Zm6Y85sYqJdsq2Swb+z7pTjYxCm4wna3N4VOktwWBkaJdWm9EOVR90LxxupTjB0yat
         wY7Q==
X-Gm-Message-State: AJIora+rLg2t7Z0Is6xhuOrBIGEhb2h7jDpiROvv6XOHUA38yB2zAqVe
        Y45JGl6xcdSgSJ2vzm9qgbpJOg==
X-Google-Smtp-Source: AGRyM1tMPGykBs9w+D78J8rqM8+9tTmCD1BQ2SD16T66bz6Y2GIv2TDv0N7IcScJMAuw816F7z2s4w==
X-Received: by 2002:a05:651c:220d:b0:25d:5fa0:a83a with SMTP id y13-20020a05651c220d00b0025d5fa0a83amr473229ljq.276.1658514140953;
        Fri, 22 Jul 2022 11:22:20 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id e28-20020ac25cbc000000b00489c5db8bb6sm1176644lfq.176.2022.07.22.11.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:22:20 -0700 (PDT)
Message-ID: <522433ce-7a3d-73a3-cdf0-4e69edbf3de6@linaro.org>
Date:   Fri, 22 Jul 2022 20:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
 <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
 <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
 <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
 <4b5100e4a6e9e581f4b8ab58e5ca4927@milecki.pl>
 <c5b37e68-dc1f-cdae-83e4-23aa0216db69@linaro.org>
 <1d39bbba3f267086eb2884ffcbf4807b@milecki.pl>
 <e5f3474c-ba7f-7107-064b-74a04b11d7af@gmail.com>
 <15e4a51c-a89f-79ef-1364-ddca6b6f7b83@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <15e4a51c-a89f-79ef-1364-ddca6b6f7b83@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 21:35, William Zhang wrote:
> 
> 
> On 07/21/2022 09:43 AM, Florian Fainelli wrote:
>> On 7/21/22 00:50, Rafał Miłecki wrote:
>>> On 2022-07-21 09:36, Krzysztof Kozlowski wrote:
>>>> On 21/07/2022 09:13, Rafał Miłecki wrote:
>>>>>> That's better argument. But what's the benefit of adding generic
>>>>>> compatible? Devices cannot bind to it (it is too generic). Does it
>>>>>> describe the device anyhow? Imagine someone adding compatible
>>>>>> "brcm,all-soc-of-broadcom" - does it make any sense?
> 
> 
>>>>>
>>>>> OK, I see it now. I can't think of any case of handling all devices
>>>>> covered with suc a wide brcm,bcmbca binding.
>>>>
>>>> Maybe there is some common part of a SoC which that generic compatible
>>>> would express?
>>>>
>>>> Most archs don't use soc-wide generic compatible, because of reasons I
>>>> mentioned - no actual benefits for anyone from such compatible.
>>>>
>>>> But there are exceptions. I fouun socfpga and apple. The apple sounds as
>>>> mistake to me, because the generic "apple,arm-platform" compatible looks
>>>> like covering all possible Apple ARM platforms. I think Apple ARM
>>>> designs in 20 years will not be compatible at all with current design,
>>>> so such broad compatible is not useful... but that's only my opinion.
>>>
>>> Let's see if William / Broadcom guys can provide a valid argument for
>>> the brcm,bcmbca.
>>
>> It is common practice to provide a generic fallback compatible string for a given chip family/architecture and all of our existing in-tree (and out of tree for that matter) DTSes for Broadcom SoCs do that:
>>
>> - Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
>> - Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
>> - Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
>> - Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
>>
>> list goes on and on, of course the counter examples are bcm2835, bcm4708 etc. although those are both chip and families technically, so I suppose the conflation is appropriate in that case. So the pattern is simple:
>>
>> - outside of Broadcom contributors used convention
>> - inside of Broadcom contributors used another
>>
>> so if nothing else, we ought to be consistent within ourselves as Broadcom insiders, which we are doing here.
>>
>> While the generic fallback may not be in use, it still serves a purpose:
>>
>> - Broadcom likes to create a gazillion of part numbers that are hard to untangle from their original SoC architecture unless you happen to work there so it serves as documentation for others to identify what family they belong to, and what to expect from that
>>
>> - you never know when you might want to be matching on just the generic compatible string of a family and putting it in there costs nothing at all
>>
>> The point of William's patch series is to right a number of wrongs on Broadcom's side:
>>
>> - lack of appropriate involvements at the time Rafal submitted the 4908 support as a "standalone" family, I am to take the blame for suggesting that name in the first place, though I did not know at the time that William and others would ever be contributing upstream
>>
>> - avoid the proliferation of "sub" families within a larger family (BCMBCA) since that serves no purpose other than to make it harder on users to select what they should be selecting in their kernel *and* it makes us inconsistent with arch/arm64/Kconfig.platforms that attempts to reduce those
>>
>> I would conclude by asking you: why is this such a big issue? What *actual* problem does it causes, except maybe setting a precedent that you do not like, but for which you practically should have no reason to care as long as the binding is enforced.
>>
> Totally agreed.  Just want to emphasize that the main reason of this 
> change to merge all the bcmbca family chips into the same group for 
> better organization and reduce the clutter to the kernel source. Think 
> about 18 bcmbca devices with different changes to yaml, kconfig, 
> makefile, sub-directory while they actually share many common blocks, 
> drivers and dts entries.

Your commit does not explain why you are doing it at all. We have all
this discussion, you put so many arguments, but why none of it is in the
commit description?

> 
> While nobody would bind a device to brcm,bcmbca (and it can not be 
> binded because bcmbca,yaml require to prefix with a specific chip), it 
> is a great way to make it easy for people to understand what device they 
> are working and look for the bcmbca common driver and other support code 
> as well. Wouldn't this be good thing to have?
> 
> And don't forget we introduced bcmbca awhile back with first SoC 47622 
> and have set a clear goal for the purpose we are discussing here today:
> Please see this patch series:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2022-April/732867.html
> "This change introduces Broadcom's ARCH_BCMBCA architecture for
> armv7 and armv8 based Broadband SoCs. We expect to send additional
> patches for each SoC in the near future."
> 
> And Krzysztof acked that yaml for brcm,bcabca here :
> http://lists.infradead.org/pipermail/linux-arm-kernel/2022-April/732867.html

and I keep discussing, so bringing it up proves what? That new comments
appeared?

> 
> 


Best regards,
Krzysztof
