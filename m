Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78784EB559
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiC2Vfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiC2Vfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:35:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69211114DF1;
        Tue, 29 Mar 2022 14:34:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w7so32550334lfd.6;
        Tue, 29 Mar 2022 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=phALv9mY0wITJH6lJS6EVyuXuWVc0bzsLfvwtVve004=;
        b=E1sNVQUgcCs1YlYBuXLH9oWXstFhkuBfb996QIHwQijCyxUljxyVeCWzy8R3i0vRmk
         QuPSyqF1xU+p8XqZG7qIB+ooUtyAySCobuC83AdhgLDv1C6OffZ5JRAcHl8h9Yamg1ti
         NoShiuABosOiFa2MfhkBIXahRdOfVn/whImZwvyaeTrUngcZMj6MPXsnRmi2AxXaP8If
         SvyxqAMhkTOWQTWCg5pNQvgpz/U7wHhM9LmpOxYcvM5b+mrxucR63zLP/cwYRmrC/r6M
         CRPq9Ra0XQBtTPbrr+l7MF/KyxnmlmzkBhGohe3flNkrF/tyjvZHOKH1Dy/RqKWa1Q0t
         snTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=phALv9mY0wITJH6lJS6EVyuXuWVc0bzsLfvwtVve004=;
        b=w5kk1qu1bS0rdWaRtAX+li9+slS44aNmFVdjGbvnNwE7PNL0hrFYdnc/nWYivgloqZ
         D80wEDIxmRcawHYRGwnukxEiZafesNBqvYnS+mX8HKLgdg/mSqFiCzAjJlfpF7BgR1eg
         540Dh7prHyHSm6gDx5NiuXhEHIRfYo+gUxmFEyozedqbO4kGR6h49OTgzuLR5tLdBSQH
         4DDidpeAisyn7b+XyNqCNkWy4k20TaExt9s7RaqTa6Y5SUtYD3keoCgztQIRhpRU3q7W
         fmJiLwihfsE5oJDMvGVrrVgrlLPnHA3RjRy2gUcfA9G7ekX3ioftE9cjYNSEWDA7SEVf
         xv/g==
X-Gm-Message-State: AOAM532oANFEAFuqr1YQg3m1Z/wbYSDGIdKNYyQ3lbcoM5cbcjSS0RrA
        1yXRHy958rWmgOqW/j8PBao=
X-Google-Smtp-Source: ABdhPJygl7RpwWEJA7JHCK5Gy8tSqC5GhaXKLrCdbJbTw3pohtg4V8j6NJPgcz2XJeyLop4nodEL4A==
X-Received: by 2002:a05:6512:13a9:b0:448:9dd3:b84 with SMTP id p41-20020a05651213a900b004489dd30b84mr4470218lfa.556.1648589638575;
        Tue, 29 Mar 2022 14:33:58 -0700 (PDT)
Received: from [192.168.1.2] (235.132.246.94.ip4.artcom.pl. [94.246.132.235])
        by smtp.googlemail.com with ESMTPSA id b14-20020a19670e000000b0044a3adf07d3sm2117198lfc.64.2022.03.29.14.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 14:33:58 -0700 (PDT)
Message-ID: <57df6bed-3b74-df63-0c5c-7218aef8534b@gmail.com>
Date:   Tue, 29 Mar 2022 23:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug 215726 - si2157.c: mention name of the missing firmware file
Content-Language: pl-PL
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Robert Schlabbach <robert_s@gmx.net>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        az0123456@gmx.de,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info>
From:   Piotr Chmura <chmooreck@gmail.com>
In-Reply-To: <5f660108-8812-383c-83e4-29ee0558d623@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's supposed to be fixed by:
https://lore.kernel.org/linux-media/trinity-6009a608-b0ff-4e1a-9b91-ba4a97f10324-1648057812747@3c-app-gmx-bs71/T/#t

Test it please.

Best regards,
Piotr Chmura

W dniu 29.03.2022 o 10:33, Thorsten Leemhuis pisze:
> Hi, this is your Linux kernel regression tracker.
>
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215726 :
>
>> I get the following error messages when trying to use si2157.ko in linux 5.17:
>> si2157 13-0060: found a 'Silicon Labs Si2157-A30 ROM 0x50'
>> si2157 13-0060: Can't continue without a firmware
>> I did work in linux 5.16.16 without a firmware file. Unfortunately the driver does not tell me the name of the missing firmware file.
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
>
> Anyway, to get this tracked:
>
> #regzbot introduced: v5.16..v5.17
> #regzbot from: az0123456@gmx.de <az0123456@gmx.de>
> #regzbot title: media: si2157.c: mention name of the missing firmware file
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215726
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
>

