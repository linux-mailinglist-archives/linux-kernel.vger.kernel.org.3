Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC0A4B54DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355891AbiBNPfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:35:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbiBNPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:35:01 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081154AE3C;
        Mon, 14 Feb 2022 07:34:54 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so19684109oor.12;
        Mon, 14 Feb 2022 07:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=V+AbT9afN3Lk/XDr7tPzEf4FCiHajxGw14pMWElGaIE=;
        b=QSjWOZTQnt9byVuYBLxaUlaL8mkDCGULJDjDkBvLMTe/feuNWn+2mwPeEsMloYldcw
         gkw0HruMFdUSZm1tE/vdFaURJ8IuHcH0nbnVyUiHiaMe8xugxzwtTR0/2EIbqI1Y9lMc
         BvVYdZmIkgZHPrR5AJlzaUFKNE1AXAtIbDz9gw0tXZH2IEH7gF8r6UlxhD6PE0mx+hYO
         2t1aI1IUJVW83O9KKXYp8Q1YBYm/UqHk3q79rraVvqwqXTG9k/hmcKkuxect0cNEc7fT
         FdNnjV2GsQo/WNWvqnioHrJclSIc6DZp5p67OJTdrAgMy9PhzyzVwbJzioLOpIsoM1r8
         IZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=V+AbT9afN3Lk/XDr7tPzEf4FCiHajxGw14pMWElGaIE=;
        b=Vh4eBnkD0Erwx1YpOUzHAQcArIUpf40szansCg58x0N0RKqcrftgBTm27mpamLIK3M
         EsaJPHNqNwkoWjnfoN/UWLvaWTiAhrap9GFCCSbkkjyH3kVRf3E5eR5yRiZcSrvVUfSF
         qhPNBHlSFbpVUvQNWzQdKK87VbJmxkzLP32bgW93VGO+UXw+cF6sd8lscFSyTIuifVem
         TQt7gxW2e8Hami0Swe+fEqIQdj+z67gc63gjz3VJ3x6h0yf2JoS6U6427TFUrSz5+lF6
         WcMo/nREoNhTYTkZUyVM6Lu44jlYMeQoHZBQS7X7oLGsp8liZevBKafxuLqgNvomiRPw
         f26g==
X-Gm-Message-State: AOAM531f8sBIP9/Ofnv+AQDPY1ket4ZDZAFInujPHofOmssW7G6aR9I3
        W+d15jVSTniDoLYAAI+hNwXSMBnzCaLMgA==
X-Google-Smtp-Source: ABdhPJxwtjw1Jm8N+AIQhTrzjZyJBbmIrx6eJIxeh1SsQG7y60dTqid6Rfloo0cOrBU0GVebV6GqNw==
X-Received: by 2002:a05:6870:3442:: with SMTP id i2mr4246687oah.176.1644852893350;
        Mon, 14 Feb 2022 07:34:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w7sm12745219oou.13.2022.02.14.07.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 07:34:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4595fbfe-da0b-1b1a-2478-6d537012a2bf@roeck-us.net>
Date:   Mon, 14 Feb 2022 07:34:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
 <20220208183511.2925304-7-jjhiblot@traphandler.com>
 <CAMuHMdUCT-qwhN53mRnAUox2pqw+Y5-7Gw5EbC+-HCF054kkgQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 6/6] clk: renesas: r9a06g032: Disable the watchdog
 reset sources when halting
In-Reply-To: <CAMuHMdUCT-qwhN53mRnAUox2pqw+Y5-7Gw5EbC+-HCF054kkgQ@mail.gmail.com>
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

On 2/14/22 02:45, Geert Uytterhoeven wrote:
> Hi Jean-Jacques,
> 
> CC watchdog people, who only received some patches.
> 
> On Tue, Feb 8, 2022 at 7:35 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> The watchdog reset sources must be disabled when the system is halted.
>> Otherwise the watchdogs will trigger a reset if they have been armed.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> 
> Thanks for your patch!
> 
> [inserting changelog]
> 
> | Changes v1 -> v2:
> | * Modified the clock driver to not enable the watchdog reset sources.
> |   On other renesas platforms, those bits are by the bootloader. The
> |   watchdog reset sources are still disabled when the platform is halted
> |   to prevent a watchdog reset.
> 
> I still have my doubts about this part. So on halt, you override the
> policy configured by the boot loader, which means the watchdog is no
> longer triggered on halt.
> 
>>From a system perspective, the system can be in five states:
>    1. Running,
>    2. Crashed/lock-ed up,
>    3. Halt,
>    4. Reboot,
>    5. Poweroff.
> 
> Now, from a policy perspective, what is the difference between a
> system that crashes or locks up, and a system that halts?
> I.e. should the system reboot on halt, or not?
> 
> I think halting a system where the watchdog has been activated makes
> no sense, and the user either wants to explicitly reboot the system, or
> power it off, but never halt it.  So I think this patch is not needed.
> 
> Watchdog people: what is your opinion?

In my understanding the shutdown code is always executed, ie also for
restarts and poweroff. Disabling the watchdog in that situation is not
always desirable, though sometimes necessary depending on the hardware.
Disabling it through the backdoor (instead of calling watchdog_stop_on_reboot)
seems odd, though.

Guenter

> Thanks!
> 
>> --- a/drivers/clk/renesas/r9a06g032-clocks.c
>> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
>> @@ -129,6 +129,11 @@ enum { K_GATE = 0, K_FFC, K_DIV, K_BITSEL, K_DUALGATE };
>>
>>   #define R9A06G032_CLOCK_COUNT          (R9A06G032_UART_GROUP_34567 + 1)
>>
>> +#define R9A06G032_SYSCTRL_REG_RSTEN            0x120
>> +#define WDA7RST1       BIT(2)
>> +#define WDA7RST0       BIT(1)
>> +#define MRESET         BIT(0)
>> +
>>   static const struct r9a06g032_clkdesc r9a06g032_clocks[] = {
>>          D_ROOT(CLKOUT, "clkout", 25, 1),
>>          D_ROOT(CLK_PLL_USB, "clk_pll_usb", 12, 10),
>> @@ -893,6 +898,19 @@ static void r9a06g032_clocks_del_clk_provider(void *data)
>>          of_clk_del_provider(data);
>>   }
>>
>> +static void r9a06g032_reset_sources(struct r9a06g032_priv *clocks,
>> +                       uint32_t mask, uint32_t value)
>> +{
>> +       uint32_t rsten;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&clocks->lock, flags);
>> +       rsten = readl(clocks->reg);
>> +       rsten = (rsten & ~mask) | (value & mask);
>> +       writel(rsten, clocks->reg + R9A06G032_SYSCTRL_REG_RSTEN);
>> +       spin_unlock_irqrestore(&clocks->lock, flags);
>> +}
>> +
>>   static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>>   {
>>          struct device *dev = &pdev->dev;
>> @@ -910,6 +928,8 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>>          if (!clocks || !clks)
>>                  return -ENOMEM;
>>
>> +       platform_set_drvdata(pdev, clocks);
>> +
>>          spin_lock_init(&clocks->lock);
>>
>>          clocks->data.clks = clks;
>> @@ -963,9 +983,18 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>>          if (error)
>>                  return error;
>>
>> +
>>          return r9a06g032_add_clk_domain(dev);
>>   }
>>
>> +static void r9a06g032_clocks_shutdown(struct platform_device *pdev)
>> +{
>> +       struct r9a06g032_priv *clocks = platform_get_drvdata(pdev);
>> +
>> +       /* Disable the watchdog reset sources */
>> +       r9a06g032_reset_sources(clocks, WDA7RST0 | WDA7RST1, 0);
>> +}
>> +
>>   static const struct of_device_id r9a06g032_match[] = {
>>          { .compatible = "renesas,r9a06g032-sysctrl" },
>>          { }
>> @@ -976,6 +1005,7 @@ static struct platform_driver r9a06g032_clock_driver = {
>>                  .name   = "renesas,r9a06g032-sysctrl",
>>                  .of_match_table = r9a06g032_match,
>>          },
>> +       .shutdown = r9a06g032_clocks_shutdown,
>>   };
>>
>>   static int __init r9a06g032_clocks_init(void)
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

