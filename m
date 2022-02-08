Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3044AD6A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357432AbiBHL2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356344AbiBHKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:33:41 -0500
X-Greylist: delayed 499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 02:33:39 PST
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2400C03FEC0;
        Tue,  8 Feb 2022 02:33:39 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.156.180])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 7359BE32ED97;
        Tue,  8 Feb 2022 11:25:18 +0100 (CET)
Received: from [192.168.1.103] (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 11:25:17 +0100
Message-ID: <89c0a032-3124-fc56-607c-5aeaac73fdc4@traphandler.com>
Date:   Tue, 8 Feb 2022 11:25:16 +0100
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
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAMuHMdUsWSXqQ6oOP8c0XBJpAoMUg74kTJN1rU8uiq7UXRiKkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: CAS3.emp2.local (172.16.1.3) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 4975914640143366619
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhephfeitdehtddtgeeugefgtdejgedtieelfedtgeehuedtteejueeihedtvedvfeeinecukfhppedtrddtrddtrddtpdekkedruddvhedrudefvddrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/02/2022 16:34, Geert Uytterhoeven wrote:
> Hi Jean-Jacques,
>
> On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> The watchdog reset sources are not enabled by default.
>> Enabling them here to make sure that the system resets when the watchdog
>> timers expire.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Thanks for your patch!
>
> R-Car Gen3 and RZ/G2 SoCs have a similar mechanism.
> On these SoCs, the boot loader takes care of the configuration, as this
> is a system policy that goes beyond the Linux realm.
> Perhaps the RZ/N1 boot loader can do the same?
>
> Gr{oetje,eeting}s,

Thanks for you reviews and comments.

I'm not conformable with the idea that the safety induced by the

watchdog is removed because the bootloader didn't set the register.

I'd rather that the kernel is able to enable the watchdog reset source.

If it is acceptable, we could use a new DTS entry to force the policy.
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
