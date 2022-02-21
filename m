Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84094BDCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350870AbiBUJkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:40:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiBUJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:33:15 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13F28997;
        Mon, 21 Feb 2022 01:13:54 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.138.12])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id C3F61E720712;
        Mon, 21 Feb 2022 10:13:23 +0100 (CET)
Received: from [192.168.1.103] (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 10:13:22 +0100
Message-ID: <e4b4fbc7-53ee-987b-7849-bf625fc2155e@traphandler.com>
Date:   Mon, 21 Feb 2022 10:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 6/6] clk: renesas: r9a06g032: Disable the watchdog
 reset sources when halting
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-renesas-soc@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        <linux-watchdog@vger.kernel.org>
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
 <20220208183511.2925304-7-jjhiblot@traphandler.com>
 <CAMuHMdUCT-qwhN53mRnAUox2pqw+Y5-7Gw5EbC+-HCF054kkgQ@mail.gmail.com>
 <4595fbfe-da0b-1b1a-2478-6d537012a2bf@roeck-us.net>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <4595fbfe-da0b-1b1a-2478-6d537012a2bf@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: CAS4.emp2.local (172.16.1.4) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 6319676177827838292
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeeufeeggeevkefguedtheeufefftdehkeegkeetudetjeehjedtudeuveffkeehteenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/02/2022 16:34, Guenter Roeck wrote:
> On 2/14/22 02:45, Geert Uytterhoeven wrote:
>> Hi Jean-Jacques,
>>
>> CC watchdog people, who only received some patches.
>>
>> On Tue, Feb 8, 2022 at 7:35 PM Jean-Jacques Hiblot
>> <jjhiblot@traphandler.com> wrote:
>>> The watchdog reset sources must be disabled when the system is halted.
>>> Otherwise the watchdogs will trigger a reset if they have been armed.
>>>
>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>
>> Thanks for your patch!
>>
>> [inserting changelog]
>>
>> | Changes v1 -> v2:
>> | * Modified the clock driver to not enable the watchdog reset sources.
>> |   On other renesas platforms, those bits are by the bootloader. The
>> |   watchdog reset sources are still disabled when the platform is 
>> halted
>> |   to prevent a watchdog reset.
>>
>> I still have my doubts about this part. So on halt, you override the
>> policy configured by the boot loader, which means the watchdog is no
>> longer triggered on halt.
>>
>>> From a system perspective, the system can be in five states:
>>    1. Running,
>>    2. Crashed/lock-ed up,
>>    3. Halt,
>>    4. Reboot,
>>    5. Poweroff.
>>
>> Now, from a policy perspective, what is the difference between a
>> system that crashes or locks up, and a system that halts?
>> I.e. should the system reboot on halt, or not?
>>
>> I think halting a system where the watchdog has been activated makes
>> no sense, and the user either wants to explicitly reboot the system, or
>> power it off, but never halt it.  So I think this patch is not needed.

I don't see halting the machine as a must-have feature either, but it 
seemed to me

that there could be other people relying on it. I'll remove this patch 
from the series.

>>
>> Watchdog people: what is your opinion?
>
> In my understanding the shutdown code is always executed, ie also for
> restarts and poweroff. Disabling the watchdog in that situation is not
> always desirable, though sometimes necessary depending on the hardware.
> Disabling it through the backdoor (instead of calling 
> watchdog_stop_on_reboot)
> seems odd, though.


Unfortunately, in this case it is not possible to stop the watchdog once 
started.

The only way to halt the machine is to disable the watchdog reset source.


JJ


>
> Guenter
>
>> Thanks!
>>
>>> --- a/drivers/clk/renesas/r9a06g032-clocks.c
>>> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
>>> @@ -129,6 +129,11 @@ enum { K_GATE = 0, K_FFC, K_DIV, K_BITSEL, 
>>> K_DUALGATE };
>>>
>>>   #define R9A06G032_CLOCK_COUNT (R9A06G032_UART_GROUP_34567 + 1)
>>>
>>> +#define R9A06G032_SYSCTRL_REG_RSTEN            0x120
>>> +#define WDA7RST1       BIT(2)
>>> +#define WDA7RST0       BIT(1)
>>> +#define MRESET         BIT(0)
>>> +
>>>   static const struct r9a06g032_clkdesc r9a06g032_clocks[] = {
>>>          D_ROOT(CLKOUT, "clkout", 25, 1),
>>>          D_ROOT(CLK_PLL_USB, "clk_pll_usb", 12, 10),
>>> @@ -893,6 +898,19 @@ static void 
>>> r9a06g032_clocks_del_clk_provider(void *data)
>>>          of_clk_del_provider(data);
>>>   }
>>>
>>> +static void r9a06g032_reset_sources(struct r9a06g032_priv *clocks,
>>> +                       uint32_t mask, uint32_t value)
>>> +{
>>> +       uint32_t rsten;
>>> +       unsigned long flags;
>>> +
>>> +       spin_lock_irqsave(&clocks->lock, flags);
>>> +       rsten = readl(clocks->reg);
>>> +       rsten = (rsten & ~mask) | (value & mask);
>>> +       writel(rsten, clocks->reg + R9A06G032_SYSCTRL_REG_RSTEN);
>>> +       spin_unlock_irqrestore(&clocks->lock, flags);
>>> +}
>>> +
>>>   static int __init r9a06g032_clocks_probe(struct platform_device 
>>> *pdev)
>>>   {
>>>          struct device *dev = &pdev->dev;
>>> @@ -910,6 +928,8 @@ static int __init r9a06g032_clocks_probe(struct 
>>> platform_device *pdev)
>>>          if (!clocks || !clks)
>>>                  return -ENOMEM;
>>>
>>> +       platform_set_drvdata(pdev, clocks);
>>> +
>>>          spin_lock_init(&clocks->lock);
>>>
>>>          clocks->data.clks = clks;
>>> @@ -963,9 +983,18 @@ static int __init r9a06g032_clocks_probe(struct 
>>> platform_device *pdev)
>>>          if (error)
>>>                  return error;
>>>
>>> +
>>>          return r9a06g032_add_clk_domain(dev);
>>>   }
>>>
>>> +static void r9a06g032_clocks_shutdown(struct platform_device *pdev)
>>> +{
>>> +       struct r9a06g032_priv *clocks = platform_get_drvdata(pdev);
>>> +
>>> +       /* Disable the watchdog reset sources */
>>> +       r9a06g032_reset_sources(clocks, WDA7RST0 | WDA7RST1, 0);
>>> +}
>>> +
>>>   static const struct of_device_id r9a06g032_match[] = {
>>>          { .compatible = "renesas,r9a06g032-sysctrl" },
>>>          { }
>>> @@ -976,6 +1005,7 @@ static struct platform_driver 
>>> r9a06g032_clock_driver = {
>>>                  .name   = "renesas,r9a06g032-sysctrl",
>>>                  .of_match_table = r9a06g032_match,
>>>          },
>>> +       .shutdown = r9a06g032_clocks_shutdown,
>>>   };
>>>
>>>   static int __init r9a06g032_clocks_init(void)
>>
>> Gr{oetje,eeting}s,
>>
>>                          Geert
>>
>> -- 
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- 
>> geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a 
>> hacker. But
>> when I'm talking to journalists I just say "programmer" or something 
>> like that.
>>                                  -- Linus Torvalds
>
