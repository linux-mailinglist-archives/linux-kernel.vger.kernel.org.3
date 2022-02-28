Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD864C7034
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiB1PAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiB1PAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:00:22 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3944C43C;
        Mon, 28 Feb 2022 06:59:43 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so9694055otn.2;
        Mon, 28 Feb 2022 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nrB15hcA5QqFXQ6AIQVs9TqJCSIuEkAhji/LjC8Jbuc=;
        b=Mu8/I9B0dLt8lFnjWb9eK7RJxKYalbmqbJYfau9aPs6qte4fAN21ioBig2Jxi4hciq
         dh3xCYnliIOUwulexSTipoiPmX7u5QbAfICeJCFu+q3W3Ew/76twjWqBBYNC1Ctehcjh
         mRiBbyaavKczWspBWWvt4WHCnH/B+lRwT1CZ0ihKztwE3bRunOFI3DT7VcJqxDUlZuv6
         HjOOQ0pXdRviaYUpJ2ioEWCnb3gn226Gvm5GxYtWWEewRw3UXQnEm/UeGt+pkKPiXZNH
         klpDecodNsIEX/4pNFVZLfxDizLHlLzr2tOTrFjFg0fddqegLm1XY/UDcPy67+YqSrGN
         v3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nrB15hcA5QqFXQ6AIQVs9TqJCSIuEkAhji/LjC8Jbuc=;
        b=250H6XKzO1qgWRHMxHqa/QuBsslpdXX6fxOm9QnLZvbbgz30fsbiljpHwK9zAJfp0L
         TgaDK8M77Isw7w1w2a9XbNkqrtwaiiGxM5ztClM3dHShtszIsd5DsdFX0ovSWJxZm83w
         yjbnaGfRbjES/Iojx/0/eTn03cP7gOR+P9FlP9+vhVizPvRVgBuhig9IXEAhV8jVWWcm
         a+iOvZKpQdQCGp9xbRhd45e6pIHByoWuSh7VKXPu+bmgA2NEDgDKEyZSsaAMtnXmQ8CB
         /xQ5aORxr1fGFKEyBRJh14jTB2FIRv5Dqwhk//bEqvlyjABVv03FsKAlR/m5HK/OjX/L
         6wkA==
X-Gm-Message-State: AOAM531PJ/FJ9FWOfT9THxHJMfAAXKNskWjDNtynNVB39s6Ekt+eOjHt
        UUCneQjt6Tt/6NP6FJOZU1I=
X-Google-Smtp-Source: ABdhPJy8QrJN42tfMwLJ96IfizbtyKV6OXRV+FfNIfRT7RZQHfMESebe2/Y506hV/gDq6gZxoZC7fA==
X-Received: by 2002:a9d:65d2:0:b0:5af:3e05:680b with SMTP id z18-20020a9d65d2000000b005af3e05680bmr9288630oth.68.1646060382586;
        Mon, 28 Feb 2022 06:59:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r9-20020a056870e8c900b000d7133a15b3sm2030745oan.20.2022.02.28.06.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:59:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <84401f5e-38a3-04b1-eac5-5ab1d0ab5e09@roeck-us.net>
Date:   Mon, 28 Feb 2022 06:59:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] pin control fixes for the v5.17 series
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
 <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com>
 <CACRpkdbWkm1WDY30qoGLEQba+G2cDEhT+M8nCdJbcD=ZQiu6uw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CACRpkdbWkm1WDY30qoGLEQba+G2cDEhT+M8nCdJbcD=ZQiu6uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 06:43, Linus Walleij wrote:
> On Sun, Feb 27, 2022 at 9:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Sat, Feb 26, 2022 at 5:11 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>
>>> some more pin control fixes that trickled in the last week or
>>> two.
>>
>> Hmm. Am I confused because I thought I'd see a fix for the orangepi
>> problem that Guenter has been reporting?
>>
>> That problem has been pending for quite a while now.
> 
> OK let's poke Hans, he usually fix things quickly so it must have been missed.
> 
> Hans did you see Guenthers remark here:
> https://lore.kernel.org/linux-gpio/20220128172003.GA2666058@roeck-us.net/
> 
> Do you want to attempt patching it or shall I just revert the patch for now?
> 
> Yours,
> Linus Walleij

The fix has long since been submitted and is available in linux-next.

 From my notes:

Fix posted at
https://patchwork.kernel.org/project/linux-media/patch/0f536cd8-01db-5d16-2cec-ec6d19409a49@xs4all.nl/
and in linux-next as commit 3c5412cdec9f ("pinctrl-sunxi:
sunxi_pinctrl_gpio_direction_in/output: use correct offset").
The fix exposes a lockdep splat for which a fix is posted at
https://lore.kernel.org/lkml/20220216040037.22730-1-samuel@sholland.org/
This patch is available in linux-next as commit 4649b97042c3 ("pinctrl:
sunxi: Use unique lockdep classes for IRQs").

Guenter
