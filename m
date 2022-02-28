Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9004C703C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiB1PCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiB1PCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:02:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB451333;
        Mon, 28 Feb 2022 07:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D3B60F3E;
        Mon, 28 Feb 2022 15:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90B1C340E7;
        Mon, 28 Feb 2022 15:01:50 +0000 (UTC)
Message-ID: <4347abab-8bd6-a843-5346-8e28cef46ff3@xs4all.nl>
Date:   Mon, 28 Feb 2022 16:01:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [GIT PULL] pin control fixes for the v5.17 series
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
 <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com>
 <CACRpkdbWkm1WDY30qoGLEQba+G2cDEhT+M8nCdJbcD=ZQiu6uw@mail.gmail.com>
 <84401f5e-38a3-04b1-eac5-5ab1d0ab5e09@roeck-us.net>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <84401f5e-38a3-04b1-eac5-5ab1d0ab5e09@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/22 15:59, Guenter Roeck wrote:
> On 2/28/22 06:43, Linus Walleij wrote:
>> On Sun, Feb 27, 2022 at 9:38 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> On Sat, Feb 26, 2022 at 5:11 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>
>>>> some more pin control fixes that trickled in the last week or
>>>> two.
>>>
>>> Hmm. Am I confused because I thought I'd see a fix for the orangepi
>>> problem that Guenter has been reporting?
>>>
>>> That problem has been pending for quite a while now.
>>
>> OK let's poke Hans, he usually fix things quickly so it must have been missed.
>>
>> Hans did you see Guenthers remark here:
>> https://lore.kernel.org/linux-gpio/20220128172003.GA2666058@roeck-us.net/
>>
>> Do you want to attempt patching it or shall I just revert the patch for now?
>>
>> Yours,
>> Linus Walleij
> 
> The fix has long since been submitted and is available in linux-next.
> 
> From my notes:
> 
> Fix posted at
> https://patchwork.kernel.org/project/linux-media/patch/0f536cd8-01db-5d16-2cec-ec6d19409a49@xs4all.nl/
> and in linux-next as commit 3c5412cdec9f ("pinctrl-sunxi:
> sunxi_pinctrl_gpio_direction_in/output: use correct offset").
> The fix exposes a lockdep splat for which a fix is posted at
> https://lore.kernel.org/lkml/20220216040037.22730-1-samuel@sholland.org/
> This patch is available in linux-next as commit 4649b97042c3 ("pinctrl:
> sunxi: Use unique lockdep classes for IRQs").

Thank you, Guenter, I was just working on a similar reply.

That's my understanding as well.

Regards,

	Hans

> 
> Guenter
