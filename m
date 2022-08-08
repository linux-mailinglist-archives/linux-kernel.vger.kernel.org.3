Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF4958C33B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiHHGXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiHHGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:23:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A53238A0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:23:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a9so11190473lfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yxNLL9tpBx91XzWobigk9RDfgExcwH7LpcZxDBrQRTg=;
        b=nfOgGbBryi+MIHG/k3ir1A8gwTr7wlkFdC3hakFiQ0gMbD5OVVqP93DkFLZfPJ7f29
         5XENF458oipXJgfQ9MOvxEjz+Kb/tP2JAD4stY2Ib0bFt1JrsOhuL4yBb4DirtGPpAwt
         MJoqN7JQ9i/tw0Z2Ccgv3SEPu2vjwrdQCmhkzE5o9oMRvyqn+J0yD3vU34q51HwR9kN8
         WyWMSjmh4BrVwCMCXeADXQrkni7hUdJLgHmOx/ZSzOysr7ur4F4NXi3+2Arjw56Uq76Z
         d+uK9P4eKpzWLZ7pe6uHB0faW+U9L8zwODqNtkFnv9pky6rKypQ8iZrmZ9Krk1ryoUM2
         63EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yxNLL9tpBx91XzWobigk9RDfgExcwH7LpcZxDBrQRTg=;
        b=tGAU13Z/1yt6TjumauGkME2uf3pAEEh0t7LaSnk4PFS1+PiQhHbO0za4NLnO7tiIgN
         INlJZ4lc7bNgSGP4Ucr3RSlf0Zgc/0SJNwZqzJm06RFQ2QUfqnYjlSeK1y8IfWKAmYy+
         UBEu2fjgZAxbgaHvocA97EBHPz8eI/me3EOS5jKrXlDqHc97Nf+GhRJwXlaE4RNs4RJa
         oO3yaXtwMT8r7DPA1J2QfVeBF8ck3a24rd+ftwJ7DbXg747PYAVcRpyCQklr8/mGSGHC
         VU9Q4EBk2TRIgNSF94Vj4Q7I4sFdRRTieUA1TbKGR02xNYQexLvqXMH5K3N210UZG5Za
         2sZg==
X-Gm-Message-State: ACgBeo3kCbqq6L1kNUebdvpHCqlnCBb2k5utb/OVbWs/8FmYHqCknEYD
        y/fh6mujTLicq6vfMskGxxWtNw==
X-Google-Smtp-Source: AA6agR6eKjzRFEDKHgXnXApp+dh1+H6EeF9aURP5fo1sS6KZBA33kjiX17kFxzI/LU/WM4qvhXHf2Q==
X-Received: by 2002:a19:4f56:0:b0:48b:205f:91a9 with SMTP id a22-20020a194f56000000b0048b205f91a9mr5652395lfk.543.1659939794838;
        Sun, 07 Aug 2022 23:23:14 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id w5-20020a05651234c500b0048af508d99csm1310885lfr.185.2022.08.07.23.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:23:14 -0700 (PDT)
Message-ID: <cb3c24e7-e207-e114-d256-ddfa45259312@linaro.org>
Date:   Mon, 8 Aug 2022 09:23:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
Content-Language: en-US
To:     minyard@acm.org, Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220804181800.235368-1-tmaimon77@gmail.com>
 <20220805115827.GG3834@minyard.net>
 <CAP6Zq1gfvEpUF-TKhA8EdJqBtwaVvJR3qxtn=8Li4swHB6sDYQ@mail.gmail.com>
 <20220807121138.GL3834@minyard.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220807121138.GL3834@minyard.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2022 14:11, Corey Minyard wrote:
> On Sun, Aug 07, 2022 at 11:03:56AM +0300, Tomer Maimon wrote:
>> Hi Corey,
>>
>> Thanks for your comment.
>>
>> On Fri, 5 Aug 2022 at 14:58, Corey Minyard <minyard@acm.org> wrote:
>>>
>>> On Thu, Aug 04, 2022 at 09:18:00PM +0300, Tomer Maimon wrote:
>>>> Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
>>>> string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
>>>>
>>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>>>> index cbc10a68ddef..4fda76e63396 100644
>>>> --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>>>> +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>>>> @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their host.
>>>>  Required properties:
>>>>  - compatible : should be one of
>>>>      "nuvoton,npcm750-kcs-bmc"
>>>> -    "nuvoton,npcm845-kcs-bmc"
>>>> +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
>>>
>>> This is just wrong.  The compatible is supposed to identify the device,
>>> not the board the device is on.  I think compatible here should be
>>> "npcm7xx-kcs-bmc", and just use that everywhere.  It's fine if that is
>>> used on a board named npcm845.
>> The NPCM8XX is not a board, The Nuvoton NPCM8XX is a fourth-generation
>> BMC SoC device family.
> 
> Ok, but same principle applies.
> 
> If the device is exactly the same, then you would only use one of the
> "npcm7xx-kcs-bmc" and put that in both device trees.  You can use
> "nuvoton,npcm750-kcs-bmc", it's really not that important.  Or even
> "nuvoton,npcm-kcs-bmc"

No, because it is too generic. Compatibles must be specific.

> 
> If the device has a minor difference that can be expressed in a 
> parameter, then create a parameter for it.
> 
> If the device has enough differences that a parameter or two doesn't
> cover it, then you put either nuvoton,npcm750-kcs-bmc or
> nuvoton,npcm750-kcs-bmc in the device tree.  Not both.  Then you need
> two entries in the of_device_id array and you use the data field or
> something to express the difference.

It's quite common to have generic and specific compatibles for
compatible devices and a driver which can match to both of them. I don't
understand where is exactly the problem here?

> 
> Since there appears to be no difference, just put
> "nuvoton,npcm750-kcs-bmc" in the npcm845 and I will drop the patch
> adding all this.  T

Again no, because recommended (also writing bindings document) is always
to have a specific compatible.

> hen a patch can be added saying it applies to both
> the 7xx and 8xx series of BMC SOCs.  If you want to change the name,
> then a patch will be needed for that, but then you will need multiple
> entries in your device tree, but you would not document it as such, as
> there would only be one that applies for this kernel.
> 
> I'm pretty sure the only reason to have muliple compatible entries in a
> device tree is to cover multiple kernels where the name changed.

Best regards,
Krzysztof
