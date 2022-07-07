Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7E56A661
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiGGO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiGGO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:58:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D395070D;
        Thu,  7 Jul 2022 07:56:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so10855852wmb.3;
        Thu, 07 Jul 2022 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=voIuhHjotG29LZKq3AduMD8mpNiKzKzHqGAaZ/sgY6c=;
        b=keerhShR130G73yAd7O37OBdm72WSMoHQAuVvi2qDp7np1/BVHyAkU+5d0e41KGgt0
         nEST1QmqnwpLcL3dM5ZEgWCCQATVV7BZBiyM5+2N6hiwSMQiOZ2mFCXBa3f4v3ht+4Lx
         Dd9X4GaPdGF8zSYw70I+GoTVFE17umQMFUBJii2hy5OXDFKFiwoaKv1sxTFtd7JKCvDA
         vPM4a4P9j6HGFeXccQnPFBiqrhxFSPvL07TUF5XUD89bbhYwntJgipnNK9WWs71RrbXK
         B8nYoMn1iNcl0JVP2wjFopQzBkRDRFwdgdYwU6JTadLR1DlZMurP1E28dKw5B4UAgcHt
         9yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=voIuhHjotG29LZKq3AduMD8mpNiKzKzHqGAaZ/sgY6c=;
        b=r4zqNVly7PfiuJPBz9EkqmM6mAPubG79Ik2Neun1YHTGNG89ZEkaU60c83HmGJ3Jiy
         iTv9sGkc1N2HA4G6TqkTiSy4Am2BH1X/eUQmXTnnfCP9LWTTtRBw41fIFjvaKRkuk8dq
         3bUQ5LTfP6BS4LESchLdmphR1EqBCGAqIeC7hQndam0pKWCcH4dKLI5Lda1iIckBM/a/
         QZmavOLiKA71QQE00AdKgt8yLVcqUWZyGobl516sih0O7qEyQMbTV8cHK2hiU0WMwSp9
         W8lN/vytfOTDwvSwTvMkL1VwAH0EQJK4lbq7Y/NuVlG6IIY3BHsc2Id3J5XH4ShH+rty
         6s2g==
X-Gm-Message-State: AJIora9agdVPAz5KSCyLXYT/g2X4T6M8TvjKnA9q+2JtA6S5WdBvUNv5
        eItX38PnH/6v3weK8uUdmPw=
X-Google-Smtp-Source: AGRyM1umDZDAQurtByAfQ/x81wQRL1UZhAlGwyPtG9Sj4tjBBXzXdDnytnsWbXN9fz4iG8XF5cSHIw==
X-Received: by 2002:a05:600c:510e:b0:3a1:145d:baaf with SMTP id o14-20020a05600c510e00b003a1145dbaafmr5000734wms.204.1657205818234;
        Thu, 07 Jul 2022 07:56:58 -0700 (PDT)
Received: from localhost (92.40.203.175.threembb.co.uk. [92.40.203.175])
        by smtp.gmail.com with ESMTPSA id k27-20020adfd23b000000b0021d728d687asm9187078wrh.36.2022.07.07.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:56:57 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
 <4c9092d20a35ef3fd6a1723e07adad79@walle.cc>
 <R11Wg2gY4kEFeq6ZSy2mXbGejo7XRfjG@localhost>
 <4ca4580a3f5157e3ac7a5c8943ef607b@walle.cc>
 <DfKGwB5bggV3msX63bZrjjUX37ipAwv7@localhost>
 <e3e3b4ed3b05368266d871e45235c899@walle.cc>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] gpio: regmap: Support registers with more than one
 bit per GPIO
In-reply-to: <e3e3b4ed3b05368266d871e45235c899@walle.cc>
Date:   Thu, 07 Jul 2022 15:58:07 +0100
Message-ID: <oKO3Oqm6eUjM9BAWdWWV35iWjzxy6glX@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Walle <michael@walle.cc> writes:

> Am 2022-07-06 22:46, schrieb Aidan MacDonald:
>>> Am 2022-07-04 18:01, schrieb Aidan MacDonald:
>>>>> Am 2022-07-03 13:10, schrieb Aidan MacDonald:
>>>>>> Some devices use a multi-bit register field to change the GPIO
>>>>>> input/output direction. Add the ->reg_field_xlate() callback to
>>>>>> support such devices in gpio-regmap.
>>>>>> ->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
>>>>>> driver to return a mask and values to describe a register field.
>>>>>> gpio-regmap will use the mask to isolate the field and compare or
>>>>>> update it using the values to implement GPIO level and direction
>>>>>> get and set ops.
>>>>> Thanks for working on this. Here are my thoughts on how to improve
>>>>> it:
>>>>>  - I'm wary on the value translation of the set and get, you
>>>>>    don't need that at the moment, correct? I'd concentrate on
>>>>>    the direction for now.
>>>>>  - I'd add a xlate_direction(), see below for an example
>>>> Yeah, I only need direction, but there's no advantage to creating a
>>>> specific mechanism. I'm not opposed to doing that but I don't see
>>>> how it can be done cleanly. Being more general is more consistent
>>>> for the API and implementation -- even if the extra flexibility
>>>> probably won't be needed, it doesn't hurt.
>>> I'd prefer to keep it to the current use case. I'm not sure if
>>> there are many controllers which have more than one bit for
>>> the input and output state. And if, we are still limited to
>>> one register, what if the bits are distributed among multiple
>>> registers..
>>> 
>> I found three drivers (not exhaustive) that have fields for setting the
>> output level: gpio-amd8111, gpio-creg-snps, and gpio-lp3943. Admittedly
>> that's more than I expected, so maybe we shouldn't dismiss the idea of
>> multi-bit output fields.
>
> I'm not dismissing it, but I want to wait for an actual user
> for it :)
>
>> If you still think the API you're suggesting is better then I can go
>> with it, but IMHO it's more code and more special cases, even if only
>> a little bit.
>
> What bothers me with your approach is that you are returning
> an integer and in one case you are interpreting it as gpio
> direction and in the other case you are interpreting it as
> a gpio state, while mine is more explicit, i.e. a
> xlate_direction() for the direction and if there will be
> support for multi bit input/output then there would be a
> xlate_state() or similar. Granted, it is more code, but
> easier to understand IMHO.
>
> -michael

Fair enough. I'll use your approach then.

I thought the semantic mix-up was a worthwhile compromise, but
perhaps not. Technically the part that 'interprets' is not the
values themselves, but the index into the values array, which
makes things a bit more confusing. You have to keep in mind how
the registers would behave if you had a single bit, because it's
the bit value that indexes the values array. It's not _that_ hard
to keep straight but obviously... not as obvious. :)
