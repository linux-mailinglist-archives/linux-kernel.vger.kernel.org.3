Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3352F57E671
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiGVSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiGVSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:24:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248AB9B570
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:24:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t1so8898017lft.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y4PUfnBxYpq9HSb+fauW+K364XPSFPA2RCgwysiSwtk=;
        b=POp8xz8gqsVDeOEnSV/znwpLLT/7mt1y58ijKtYQv6llFmQcKLiM0tfuj9mzKssBKm
         2Lv5tr+E76TkfjZA+va5wO6hvWlCrFMa30uPQt1voOY7asDLbyv6q7M4Py75une3UypE
         93MAw89KTptjHuWOD5VJr69Wt3YGrVuAbLbHftnh0K0wJ5Jjx/FQBpB4VrhE8i0eQwQa
         wE5p2vXX/NXWoCwXcLIu8/sDZqRRXXHk0SASmNsfQaXGBTopm5pMbzv9Ku9GU3ruKoW2
         EdeqWolvfW/bZQptiziFbwaTAWDV8J3JF+pxi2BkQ3ryfjE29/CyCaNR8Ut7D7HfMzHn
         XmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y4PUfnBxYpq9HSb+fauW+K364XPSFPA2RCgwysiSwtk=;
        b=CepDfJKED/UZ6yU0p+TsFEvvQh88ky0mDd3zWNdwR9t/0VYBxoSI5jWHCmylExtnnf
         gper+bn6Ei8VBaW9kbbCBSuj8v05q2NqCePyzj8GLIZ2nUutkXYElk+CMgLbJePczVuX
         4vZmX6JfOWme8zYOX/Obz3a18PGHGt+03ApMWFBGeFKw3+A9KEaTIr6qZ79joGoJQYOs
         Uu8/rq6MNMACdfNIKG/r+HSLD1GlieFXNH61vFZGXzzFGCFRa6BrpnQnahAuBbaV+zPo
         JG1JQadmWMYtfIL2/xIAS+OUV2nr/CoYF+xQcLRKOjQQwVUIsdgnJYCuSUcwMIfQo3ut
         aShg==
X-Gm-Message-State: AJIora+v90LBAXZF/4+1A4hIg9iTBxcZj50301n83UZzyy2e/KzP0I/K
        hRRbsc6/Xy9XQOKz3s91fmDgkw==
X-Google-Smtp-Source: AGRyM1us6rSOUrvpiq6AQc8XjSdjL0FZeX63+7AyN+7xrpuEnWAHs+uGC22kUuETgJIr17SRL6nggw==
X-Received: by 2002:a05:6512:1683:b0:47f:78ca:8ac5 with SMTP id bu3-20020a056512168300b0047f78ca8ac5mr452500lfb.663.1658514264494;
        Fri, 22 Jul 2022 11:24:24 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f08000000b0048a6bb9418esm1172037lfq.295.2022.07.22.11.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:24:23 -0700 (PDT)
Message-ID: <3b60aa59-c40e-11d0-c6d5-dc1b022ec349@linaro.org>
Date:   Fri, 22 Jul 2022 20:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
 <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
 <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
 <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
 <bbc67617-9137-28d4-8d6f-a36507923010@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bbc67617-9137-28d4-8d6f-a36507923010@broadcom.com>
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

On 22/07/2022 02:07, William Zhang wrote:
> 
> 
> On 07/21/2022 12:01 AM, Krzysztof Kozlowski wrote:
>> On 21/07/2022 08:51, Rafał Miłecki wrote:
>>> On 2022-07-21 08:44, Krzysztof Kozlowski wrote:
>>>> On 21/07/2022 02:06, William Zhang wrote:
>>>>> Append "brcm,bcmbca" to BCM4908 chip family compatible strings. Add
>>>>> generic 4908 board entry.
>>>>
>>>> This does not explain at all why you are doing it. Improve your commit
>>>> messages.
>>>
>>> To clarify it from my side (and maybe help a bit):
>>>
>>> 1. As I understand it BCMBCA is a one big family of SoCs.
>>> 2. BCM4908 is a subset of that family (a subfamily?) designed for a
>>>      specific group of devices.
>>>
>>> If that's correct I think William it's what you should describe in your
>>> commit message. That would make binding more accurate and should be a
>>> good argument for your change (I believe).
>>
>> That's better argument. But what's the benefit of adding generic
>> compatible? Devices cannot bind to it (it is too generic). Does it
>> describe the device anyhow? Imagine someone adding compatible
>> "brcm,all-soc-of-broadcom" - does it make any sense?
>>
> In case you were also referring the generic 4908 board compatible string 
> brcm,bcm94908, this is for a bare bone 4908 board dts that only enables 

No, we refer to the contents of the patch, so bcmbca compatible.

I did not see you introducing here bcm4908 compatible.

> ARM cpu subsystem, memory and uart. It can be used on all 4908 based 
> Broadcom reference boards and customer board. It is especially useful 
> for initial board bring up and one can load this generic board and start 
> work and debug from the console. Also would be helpful to do a quick 
> verification of new kernel version when there is cpu subsystem related 
> change.
> 
> I guess my mindset already assume people are now familiar with this 
> model of bcmbca binding addition for a new SoC since we introduced the 
> bcmbca arch with first soc 47622 and 10+ other socs late. But sure I 
> agree and I will update the commit message with more details in addition 
> to what the cover letter says.



Best regards,
Krzysztof
