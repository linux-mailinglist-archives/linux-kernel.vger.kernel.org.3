Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C276152046A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbiEISWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiEISWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:22:04 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE3F2B94E6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:18:09 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id o7xLnswDmF4GZo7xLniG7Y; Mon, 09 May 2022 20:18:07 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 09 May 2022 20:18:07 +0200
X-ME-IP: 86.243.180.246
Message-ID: <4460783f-6a1f-e8c4-863a-4f6d926590d6@wanadoo.fr>
Date:   Mon, 9 May 2022 20:18:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 1/2] serial: 8250_dw: Use devm_add_action_or_reset()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220509172129.37770-1-andriy.shevchenko@linux.intel.com>
 <d76c13b2-16a0-d53f-0cc9-562fa96f373d@wanadoo.fr>
 <CAHp75Vca60m+mkPDzh022B4pU2sng8-ZLoEK0POLQON3EWjBKg@mail.gmail.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAHp75Vca60m+mkPDzh022B4pU2sng8-ZLoEK0POLQON3EWjBKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 09/05/2022 à 19:59, Andy Shevchenko a écrit :
> On Mon, May 9, 2022 at 7:49 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> Le 09/05/2022 à 19:21, Andy Shevchenko a écrit :
> ...
>
>>> +static void dw8250_clk_disable_unprepare(void *data)
>>> +{
>>> +     clk_disable_unprepare(data);
>>> +}
>> we already have several time this function in different drivers.
>> Maybe, it would be nice to have something standart for it.
>>
>> A devm_clk_prepare_enable() or something devm-helpers.h ([1])
> Seems you missed the full story. We tried to add that several times
> [1] and CCF maintainers refused all the time. You may work with them
> to convince them.
>
> [1]: https://lore.kernel.org/linux-clk/20210304221247.488173-2-linux@rasmusvillemoes.dk/
> (the latest one AFAIK)
>
LoL, got it.

Sorry for the noise.

CJ


