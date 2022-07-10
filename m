Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD956CFA2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGJPHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:07:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B864D9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:07:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t25so5026554lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vGEjMzeV4rTjdQROSqSy+BxXp6ecV7Lq7pIOwPsbuAE=;
        b=s6BThfFG4EarVDkAudG5X1ZYaeWgrZtXddhCPSddcKAWl3WKXtDLI9eXl6KE20VvMd
         t/oGvsaAJZWZYCiO3bT9P1UCDWBfwNs5XcVcnoiHBF/BbtCBL/Idttd2ihyJQ19h/BoU
         ktb7lHfVkwj0/gzQuxVagEn6nN0p5nGsQCvR3UXlsQdnwyJCP6F2OG8M3IiwwW/k85F1
         IKOlRQv9xnYEh32kHH5aquQCmkNVrGKrZdxbcKNk2b8+5W/e47baqTzISIfUdIvevKsa
         W8YOKzY/PIq4wIniikImWReEBiDm+kKu5q2vQv7elmorYYab2D8rI1qpXl9C7Td4ZCoW
         zdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vGEjMzeV4rTjdQROSqSy+BxXp6ecV7Lq7pIOwPsbuAE=;
        b=oGTI1wTRbC6hd61nLaur/lZRSpDmczziAoYOikF2rc2WHjxi4PTGOcszrLBV/prq2U
         CSHelZztRD6V4C6sUj9CBnXJ1NFo47nZlYJplk9xlXmdjWUrbKHZVI9iP/9Lj8Wmmmeu
         mIi4f0jo4kGkACe2ZQtcEvlWOH7VGoXfnetMWmY+ASYKimzXQ+UmdDB/G7s9kgWzTa54
         sszpGq0dzAj47vyMuzVuTp5zDHP9Hv9eoN/EbjETy8DU0GWyy0nHA9nSuKxZ5L0jl2JQ
         /sFJhhEZr0j3BA1DmR4b2bO8emqNk5KbsSbgU32GWJhnB3i8jIFX961aQi26jVTs7A24
         0lrA==
X-Gm-Message-State: AJIora9XMoVE5yofNRSqSJB7EKp2qmJJO/S/a+ZEJCyyJoRXD362QXm6
        N4V09uLrc82l2Z3si0GhBrFS6UTFBPajUwNh
X-Google-Smtp-Source: AGRyM1vLwUbT2fb18HuVdKAPiyMGsyAUDEdTOU9pfeGW5RW3V3XRBkBfjuEgnFng75vcKN/rWNUzYw==
X-Received: by 2002:a05:6512:3188:b0:489:de7c:101e with SMTP id i8-20020a056512318800b00489de7c101emr130634lfe.595.1657465619290;
        Sun, 10 Jul 2022 08:06:59 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cac-200.bb.online.no. [88.92.172.200])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05651c0ba100b0025a91928236sm1122078ljb.90.2022.07.10.08.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 08:06:58 -0700 (PDT)
Message-ID: <1f3189ef-7d3f-27b3-a691-b9649090b650@linaro.org>
Date:   Sun, 10 Jul 2022 17:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <3bb0ffa0-8091-0848-66af-180a41a68bf7@linaro.org>
 <CAODwPW89xZQZiZdQNt6+CcRjz=nbEAAFH0h_dBFSE5v3aFU4rQ@mail.gmail.com>
 <8f51aed8-956b-ac09-3baf-2b4572db1352@linaro.org>
 <CAODwPW9MvYJo8QbKOoVcUAKJ8Hxon2MCv_H5qpv=yaSTLLc+ug@mail.gmail.com>
 <628a7302-1409-81f7-f72b-6b1645df9225@linaro.org>
 <CAODwPW-4i+idH8Nz6=EmNUXYWgWkoOHs3wOZ7BbrH5GwGDZ1Ww@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW-4i+idH8Nz6=EmNUXYWgWkoOHs3wOZ7BbrH5GwGDZ1Ww@mail.gmail.com>
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

On 08/07/2022 03:20, Julius Werner wrote:
>> Then I would assume that all lpddr properties can differ between ranks,
>> including the timings. But probably some SDRAM memory expert should
>> clarify that.
> 
> Right, so that's what my proposal does -- separate timings nodes per
> rank (and channel).
> 
>>> That really doesn't work for our use case, we can't generate a
>>> specific compatible string for each part number. This may work when
>>> your board is only using a single memory part and you can hardcode
>>> that in the DTB blob bundled with the kernel, but we are trying to do
>>> runtime identification between dozens of different parts on our
>>> boards. The whole point of us wanting to add these bindings is that we
>>> want to have the firmware inject the raw values it can read from mode
>>> registers into the device tree (with just the compatible string
>>> "jedec,lpddr3"),
>>
>> You cannot have jedec,lpddr3 alone. You need specific compatible.
> 
> Sorry, what do you mean we cannot? Why not? 

Currently bindings do not allow it.

Whether this can be changed, I responded in last paragraph of my
previous email.

> That's the way we need to
> do it for our use case. Why shouldn't it work that way? As far as I
> understand the binding definition, this is one of the legal compatible
> strings for it. (I'm not saying other platforms can't register and
> provide specific compatible strings if they want to, of course, but
> for our situation that really doesn't work.)

Not for LPDDR3 bindings, yes for LPDDR2. Inconsistency is actually a bit
confusing.

> 
>>> so that we can then delegate the task of matching
>>> those values to part numbers to a userspace process.
>>
>> Constructing a vendor from mode registers is like 10 lines of C code, so
>> this is not a problem. Trouble would be with device part of compatible.
> 
> There's potentially 255 different manufacturer codes, and the
> assignments may be different for different LPDDR versions. That's a
> big string table that we don't want to have to fit in our firmware
> flash. Besides, as you said, that still only gives you the vendor...
> so then should we use "micron,lpddr3" or "elpida,lpddr3" instead of
> "jedec,lpddr3"? Where's the advantage in that?
> 
>>> Can we please revert that deprecation and at least keep the property
>>> around as optional?
>>
>> Yes, we can. You still would need to generate the compatible according
>> to the current bindings. Whether we can change it I am not sure. I think
>> it depends how much customization is possible per vendor, according to
>> JEDEC spec. If we never ever have to identify specific part, because
>> JEDEC spec and registers tell us everything, then we could skip it,
>> similarly to lpddr2 and jedec,spi-nor.
> 
> Shouldn't that be decided per use case? In general LPDDR is a pretty
> rigid set of standards and memory controllers are generally compatible
> with any vendor without hardcoding vendor-specific behavior, so I
> don't anticipate that this would be likely (particularly since there
> is no "real" kernel device driver that needs to initialize the full
> memory controller, after all, these bindings are mostly
> informational). 

If decided per use case understood as "decided depending how to use the
bindings" then answer is rather not. For example Linux implementation is
usually not the best argument to shape the bindings and usually to such
arguments answer is: "implementation does not matter".

If by "use case" you mean actual hardware or specification
characteristics, then yes, of course. This is why I wrote "it depends".

> Of course there may always be mistakes and broken
> devices that need custom handling, and if someone has a platform with
> such a case I of course don't want to preclude them from tying special
> behavior to a custom compatible string. But why would that mean we
> need to make this mandatory for all platforms even if it's not
> relevant (and not practically feasible) for them? Why not allow both?

Depends. If generic compatible is not enough (works only for your case)
then it should have never been added alone.

> 
>>> We need to be able to report the information that's currently encoded
>>> in the "jedec,lpddr2" binding separately for each channel+rank
>>> combination, and we need to be able to tell how many LPDDR chips are
>>> combined under a single memory channel.
>>
>> Who and why needs that information?
>>
>> To me it's not a very useful information without knowing how memory
>> ranges are mapped to the chips and then only kernel drivers should be
>> able to utilize that info in a meaningful way. What driver are we
>> talking about?
> 
> We're using this for diagnostic purposes, to be able to accurately
> report the installed memory configuration to the user or in automated
> error reporting. We're planning to just read it from userspace (via
> /proc/device-tree) and not actually add a kernel driver for it, but
> since it needs to come from the firmware through the device tree it
> should have a standardized binding all the same.

Sorry, I don't understand to whom you reply. It's a reply to me but you
quoted here few pieces of emails which were not from me. If you
argue/comment/discuss with any of my statements, please write your reply
under my quote. This allows me easily to find the relevant point of
discussion.

Best regards,
Krzysztof
