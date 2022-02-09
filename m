Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5004AF9E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiBISYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiBISYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:24:50 -0500
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7BC0613C9;
        Wed,  9 Feb 2022 10:24:53 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.4.23])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 9152623D181;
        Wed,  9 Feb 2022 18:24:50 +0000 (UTC)
Received: from [192.168.1.103] (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 19:24:49 +0100
Message-ID: <5d21aa14-72fc-1cd9-05b1-6f91c62eb14d@traphandler.com>
Date:   Wed, 9 Feb 2022 19:24:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/6] clk: renesas: r9a06g032: Enable the watchdog reset
 sources
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220204161806.3126321-1-jjhiblot@traphandler.com>
 <20220204161806.3126321-2-jjhiblot@traphandler.com>
 <CAMuHMdUsWSXqQ6oOP8c0XBJpAoMUg74kTJN1rU8uiq7UXRiKkw@mail.gmail.com>
 <89c0a032-3124-fc56-607c-5aeaac73fdc4@traphandler.com>
 <CAMuHMdVvrs-p4Tz2m7R8g7gXJRetTGKJNaQPEO_DYKDzu5u64A@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAMuHMdVvrs-p4Tz2m7R8g7gXJRetTGKJNaQPEO_DYKDzu5u64A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG1EX2.emp2.local (172.16.2.2) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 500462510111537627
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpefhiedthedttdegueeggfdtjeegtdeileeftdegheeutdetjeeuieehtdevvdefieenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 08/02/2022 11:35, Geert Uytterhoeven wrote:
> Hi Jean-Jacques,
>
> On Tue, Feb 8, 2022 at 11:25 AM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> On 07/02/2022 16:34, Geert Uytterhoeven wrote:
>>> On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
>>> <jjhiblot@traphandler.com> wrote:
>>>> The watchdog reset sources are not enabled by default.
>>>> Enabling them here to make sure that the system resets when the watchdog
>>>> timers expire.
>>>>
>>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>> Thanks for your patch!
>>>
>>> R-Car Gen3 and RZ/G2 SoCs have a similar mechanism.
>>> On these SoCs, the boot loader takes care of the configuration, as this
>>> is a system policy that goes beyond the Linux realm.
>>> Perhaps the RZ/N1 boot loader can do the same?
>>>
>>> Gr{oetje,eeting}s,
>> Thanks for you reviews and comments.
>>
>> I'm not conformable with the idea that the safety induced by the
>> watchdog is removed because the bootloader didn't set the register.
> What if the CM33 is the master, and the CM33 just wants to receive an
> interrupt when one of the CA7 watchdog timers times out?

In the next version of the patch I removed the part that enables the 
reset source.

However I kept the part that disables the reset source when the system 
is halted

because the system would otherwise reboot when a watchdog expires. Do you

see a scenario where this could be a problem ?

JJ

>
>> I'd rather that the kernel is able to enable the watchdog reset source.
>> If it is acceptable, we could use a new DTS entry to force the policy.
> DT describes hardware. not software policy.
> Although I agree e.g. the watchdog timeout value is software policy.

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
