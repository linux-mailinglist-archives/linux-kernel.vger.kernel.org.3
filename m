Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3356B11A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiGHDtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiGHDtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:49:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACB474DC9;
        Thu,  7 Jul 2022 20:49:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso680172pjh.1;
        Thu, 07 Jul 2022 20:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ijb37wuvcMqI82JLez9O+wctpjHcQ7yqmdff0rtexpI=;
        b=RZqjr8uI1VfLekuUerA/zObBcgGl3Yk1Mv4xd0m7aYz95przPYtIHvJFyLfIfHm1ff
         sD9ARxPzPXlAnc/JU/mTDq9NWFul/vEACpQaqcw34y9JoEvTtGmhpvPHCiRINEYLPaHb
         62whRVGlxPtER8e5K6WO9CPOzp0TPG7n1bIP8zc4PM9RVKkMAaoJnaJfbmepEyfVW2YL
         Pq7lJINwPWzEd4jDUMjMWlcmkxzSathx9HjDzUEArwqxcN9KRotjvXLZi4Onyqmz7mJM
         LUx0IkZhbcMOBpzKviEi4U6YIYjlzCQJQ4RH4a2PQQDsxwziUTW8Ij77MCHxS9FbiFGk
         pKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ijb37wuvcMqI82JLez9O+wctpjHcQ7yqmdff0rtexpI=;
        b=FXNUC0f/B0SZ+GD7tG8u+NRpsr3k37AjUlS03IGV9sdzfLtEX4WjvtRcZbRCkOMGy7
         whiPcnwKmFnP+RkQfRarzrAjdtCEHUBql5E6cqFrnC4eL0wylfRp/SOrVvaVtyqixavX
         WF2puHpN58H256H6bY9jE1ercEQLqupFnLGpIPzK1nwo15br13WOAIk3Zjq9qxoi3PzH
         eeq07qTjgkptcnyp3Ofl8xbYf6IAG6JVMXQnGLbViWQ5Ze74xKRo80iYb2EEaNj7Ydkv
         iXeJmuYF8IZvsbPxNF8BAS6YbRjjaeT0+XVeEjFEPD3hDSA7phzJpCt7OI8v445s7JeK
         8+ig==
X-Gm-Message-State: AJIora/4dKEeO0WetielFuvBqiXPw0gCoyq4Wo9kIHynG+bzeEoKB1p+
        vVgC+gx4Y3cVG6Js3KPlkKs=
X-Google-Smtp-Source: AGRyM1tu/FpiE1NaWCN51qWfp9HqlnB0HzZAdqHZxdaHagmh8N9zbNt3m7M6LCXP6vzx8GULZTs+BQ==
X-Received: by 2002:a17:90b:350f:b0:1ed:4d69:75f3 with SMTP id ls15-20020a17090b350f00b001ed4d6975f3mr9052596pjb.17.1657252170135;
        Thu, 07 Jul 2022 20:49:30 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id x9-20020aa784c9000000b005251fc16ff8sm27424972pfn.220.2022.07.07.20.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 20:49:29 -0700 (PDT)
Message-ID: <4ccbea1c-1bcf-68b2-e7ec-3a19a75dbfa9@gmail.com>
Date:   Thu, 7 Jul 2022 20:49:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [RESEND PATCH 3/8] hwrng: bcm2835: bcmbca: Replace ARCH_BCM_63XX
 with ARCH_BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Conor.Dooley@microchip.com, f.fainelli@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        andre.przywara@arm.com, cai.huoqing@linux.dev,
        geert+renesas@glider.be, herbert@gondor.apana.org.au,
        mpm@selenic.com, sgoutham@marvell.com, tsbogend@alpha.franken.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-3-william.zhang@broadcom.com>
 <f14b59fb-c02f-cd59-3c92-cb4def7ad601@gmail.com>
 <30b06496-27a0-28a0-2775-ad81893330dd@broadcom.com>
 <9ce5272f-f90d-6b26-a0f8-0159a90e4502@microchip.com>
 <e24acc99-0dce-5879-2379-6a5e3191e123@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <e24acc99-0dce-5879-2379-6a5e3191e123@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2022 11:18 AM, William Zhang wrote:
> 
> 
> On 7/7/22 10:16, Conor.Dooley@microchip.com wrote:
>> On 07/07/2022 18:05, William Zhang wrote:
>>> On 7/7/22 09:23, Florian Fainelli wrote:
>>>> On 7/6/22 23:57, William Zhang wrote:
>>>>> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
>>>>> HW_RANDOM_BCM2835 depending on ARCH_BCMBCA.
>>>>>
>>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>>
>>>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>
>>>> There is no cover letter for this 8 patch series :/ it is not clear 
>>>> to me whether each subsystem maintainer will be in a posotion to 
>>>> merge these patches individually, yet still have all 8 (7 of them 
>>>> actually, see comment to patch 1) land in 5.20.
>>>>
>>> The cover letter will gather all the recipients which will be more 
>>> than 50
>>
>> tbf, you probably could cut down the CC list if you want, it isnt 
>> required
>> to CC absolutely everyone that gets spat out by get_maintainer.
>>
>> For example, I am CCed because I was a recent author for the hwrng 
>> kconfig
>> file, so people like me could be safely excluded if you need to cut 
>> down on
>> the number of people that you are CCing.
>>
>> Not that I have a problem with being CCed, just if it helps you hit a 
>> min.
>> threshold feel free to drop me :)
> Thanks! That is my plan too. Try to figure out the threshold now lol

Try adding --norolestats to your get_maintainer.pl invocation.
-- 
Florian
