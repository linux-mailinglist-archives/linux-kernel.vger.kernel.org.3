Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B267D57D79C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiGVAJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiGVAJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:09:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A408D5C4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:09:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 17so3210746pfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ou8N7CNVah/MspZ0FIMh0nlDpe5eq14kgqKxFpIHdF8=;
        b=T8fo8S5Ni2Qf4FEUKxf8icacxiaSNYfXbi9CNzrTu/vm/eGzzTYUMa6M41BC9zh4ME
         pqzTBmUXelmLQal8HD/20Wsxu/BAdJfuIDVtknor6mM8jvws3IShfyBcmhmw6JBCBrcm
         5uABsOPBeeO7OglMr2REv0RXuAPVKpy1cSV60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ou8N7CNVah/MspZ0FIMh0nlDpe5eq14kgqKxFpIHdF8=;
        b=gvD2FLrwmC4d5W8raQ2JdCieWPSx8jTapTJO9XHoUOOImlpRj02mE2OW2AuKOZKcxa
         6Xs+4ICt0D7AdARYSA5ZRFAwt20y2kRDFHL9imUKMwCkb4GWsw2XWLGOHyUFeJDEYTvf
         dTP3goADhMl51t199qNwhN/HYNzi+NBo/ydgGrbJmReOQxYSz5iQ4nlTZkULn2dUc7IQ
         nzg1qibwznMdfxAvrTkGwIRqwyT1jHvr5oa/ecb14caxZfYgIuDFpXu7CklTARLJQcmp
         Cm7LecLoTytsSFNfJq+6Hdhbww8fj74mF/UuzzdEaJtPjDBy/5uJVzs+rrd3T0ciZO2n
         DNXg==
X-Gm-Message-State: AJIora8fFHmih5pocjDCC1NJOAmpEdPAMh5wJLPJNBIT67S+9dWC0HnN
        J2rZLeFbjKuXycV1URmGqQtovBBNWWQbZnbthJdx+vl7OeuhAijvU0p15h+mERaoCMNo3sRJarV
        oZiSpkD55xrEUXKZt4qUuBo6S25r04dcrkDlgad1mA7txe+0rmwxQeMOqf5ZigildB97Hofx54i
        oezxzBhTyD
X-Google-Smtp-Source: AGRyM1u0bUR1xR6ur3/2Met1Iqqa8+qEUo3CpxpaSZHxaCgfEBIVwpr4uDlUawIbW4KmiF1WaW3Utg==
X-Received: by 2002:a63:2c0d:0:b0:411:4fd7:ecba with SMTP id s13-20020a632c0d000000b004114fd7ecbamr767235pgs.64.1658448570577;
        Thu, 21 Jul 2022 17:09:30 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b0016be368fb30sm2382389plg.212.2022.07.21.17.07.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 17:08:45 -0700 (PDT)
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <bbc67617-9137-28d4-8d6f-a36507923010@broadcom.com>
Date:   Thu, 21 Jul 2022 17:07:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/21/2022 12:01 AM, Krzysztof Kozlowski wrote:
> On 21/07/2022 08:51, Rafał Miłecki wrote:
>> On 2022-07-21 08:44, Krzysztof Kozlowski wrote:
>>> On 21/07/2022 02:06, William Zhang wrote:
>>>> Append "brcm,bcmbca" to BCM4908 chip family compatible strings. Add
>>>> generic 4908 board entry.
>>>
>>> This does not explain at all why you are doing it. Improve your commit
>>> messages.
>>
>> To clarify it from my side (and maybe help a bit):
>>
>> 1. As I understand it BCMBCA is a one big family of SoCs.
>> 2. BCM4908 is a subset of that family (a subfamily?) designed for a
>>      specific group of devices.
>>
>> If that's correct I think William it's what you should describe in your
>> commit message. That would make binding more accurate and should be a
>> good argument for your change (I believe).
> 
> That's better argument. But what's the benefit of adding generic
> compatible? Devices cannot bind to it (it is too generic). Does it
> describe the device anyhow? Imagine someone adding compatible
> "brcm,all-soc-of-broadcom" - does it make any sense?
>
In case you were also referring the generic 4908 board compatible string 
brcm,bcm94908, this is for a bare bone 4908 board dts that only enables 
ARM cpu subsystem, memory and uart. It can be used on all 4908 based 
Broadcom reference boards and customer board. It is especially useful 
for initial board bring up and one can load this generic board and start 
work and debug from the console. Also would be helpful to do a quick 
verification of new kernel version when there is cpu subsystem related 
change.

I guess my mindset already assume people are now familiar with this 
model of bcmbca binding addition for a new SoC since we introduced the 
bcmbca arch with first soc 47622 and 10+ other socs late. But sure I 
agree and I will update the commit message with more details in addition 
to what the cover letter says.

> Best regards,
> Krzysztof
> 

