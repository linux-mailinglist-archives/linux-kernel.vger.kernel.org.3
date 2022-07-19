Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AECD57A204
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbiGSOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiGSOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:40:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B851005
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:37:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b6so8557352wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=13i0/0dHDWi3Tz13pQIy2h+YZzYm8zFkGL1fzxGqmuY=;
        b=Dc9qshxWkOXoVpeRUOWXqvpJrKUxArsmLW0NXjuZv5YDKKFa2Abk13pR9Fw7HOpsC2
         hvtQ9aaLQPeb4FWX0Jroj+ryDzDFrO1N9NXIWCjcY0mb5M2qy+WXB//MHr2LQMoMKZAM
         1lBh/D3EwLEd8QLtpTcdhfUEpXN2H0LTq/L5Wve+ABzp83zffEGvDZ6IUQ3rYjxwHBFo
         EBW3biuXNrckDn19gRuWBo+/mVwT5c29SxdI6j4wr6iPHp7mzocV9p50UEuqNiDPYM4Q
         mc2s1CbVjXq0TQUClYoHsIk3s7XtsEPsXuel2zD/ja6J4aLXc+Ud78OrJL0iz+37gN9S
         XZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=13i0/0dHDWi3Tz13pQIy2h+YZzYm8zFkGL1fzxGqmuY=;
        b=FfuqvL0L6xmYcBf8KkfopwDeYpBfh9DbzfTJ199IkT6fZ9nTE/5dFGr0R0qZsTBOVh
         H7o+2+LKA11NQCbKmyOY+xx+go7Bt6Iq3+FYYB0DJjARB6JpUwKwrGeAz1CP3KjXSWjH
         xj5lcoWm1+1ppO81WvmSbXeIOpbEyXCprvSNz4ETZ42+rV4Y6yPiIcestJwoVuPAPbwR
         HAPXxr4UDUEWN6BHmpOwY4vAce2mCS1HKDEFDJeGjJXJyOIuW22tAjA2o8puc0dgjpTR
         BHK2vtlCGb6JsQz1QpEwXaXEXgy3dM2P2Rk7NssDnkpoNOJ55fht06y2g0/sDy5NfhWj
         7KKg==
X-Gm-Message-State: AJIora/6Gxvo0/IplOuuD0SXZkEf0vsz0ceAP6dmOchJ+rGrQh/FizKx
        n861gjUWZ0nEQldVLwZ8cGQeTg==
X-Google-Smtp-Source: AGRyM1tCx3e3TI0EjYZ4gYglOXYON94UkAj86OkaD0BcFK9/cemoKGaTW1p1o37GsZxCjg70+qR1LQ==
X-Received: by 2002:a05:600c:190a:b0:3a2:e8cc:57ca with SMTP id j10-20020a05600c190a00b003a2e8cc57camr31823297wmq.118.1658241445315;
        Tue, 19 Jul 2022 07:37:25 -0700 (PDT)
Received: from [192.168.2.90] ([109.76.0.125])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b003a32297598csm2893662wmq.43.2022.07.19.07.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:37:24 -0700 (PDT)
Message-ID: <73f9d00c-b64c-7c70-c49f-99d3894fad24@conchuod.ie>
Date:   Tue, 19 Jul 2022 15:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 09/21] arch_topology: Add support to parse and detect
 cache attributes
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Gavin Shan <gshan@redhat.com>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
 <20220704101605.1318280-10-sudeep.holla@arm.com>
 <CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 15:22, Geert Uytterhoeven wrote:
> Hi Sudeep,
>

Hey Geert,

  
> On Mon, Jul 4, 2022 at 12:19 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Currently ACPI populates just the minimum information about the last
>> level cache from PPTT in order to feed the same to build sched_domains.
>> Similar support for DT platforms is not present.
>>
>> In order to enable the same, the entire cache hierarchy information can
>> be built as part of CPU topoplogy parsing both on ACPI and DT platforms.
>>
>> Note that this change builds the cacheinfo early even on ACPI systems,
>> but the current mechanism of building llc_sibling mask remains unchanged.
>>
>> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -7,6 +7,7 @@
>>    */
>>
>>   #include <linux/acpi.h>
>> +#include <linux/cacheinfo.h>
>>   #include <linux/cpu.h>
>>   #include <linux/cpufreq.h>
>>   #include <linux/device.h>
>> @@ -780,15 +781,28 @@ __weak int __init parse_acpi_topology(void)
>>   #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>>   void __init init_cpu_topology(void)
>>   {
>> +       int ret, cpu;
>> +
>>          reset_cpu_topology();
>> +       ret = parse_acpi_topology();
>> +       if (!ret)
>> +               ret = of_have_populated_dt() && parse_dt_topology();
>>
>> -       /*
>> -        * Discard anything that was parsed if we hit an error so we
>> -        * don't use partial information.
>> -        */
>> -       if (parse_acpi_topology())
>> -               reset_cpu_topology();
>> -       else if (of_have_populated_dt() && parse_dt_topology())
>> +       if (ret) {
>> +               /*
>> +                * Discard anything that was parsed if we hit an error so we
>> +                * don't use partial information.
>> +                */
>>                  reset_cpu_topology();
>> +               return;
>> +       }
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               ret = detect_cache_attributes(cpu);
>> +               if (ret) {
>> +                       pr_info("Early cacheinfo failed, ret = %d\n", ret);
> 
> This is triggered
> 
>      Early cacheinfo failed, ret = -12
> 
> on all my RV64 platforms (K210, PolarFire, StarLight).

This should be fixed by Sudeeps most recent patchset, at least
it was when I tested it!
https://lore.kernel.org/all/20220713133344.1201247-1-sudeep.holla@arm.com/

> -12 = -ENOMEM.
> 
> The boot continues regardless, and the K210 even has enough spare
> RAM after boot to run "ls", unlike two weeks ago ;-)
> 
>> +                       break;
>> +               }
>> +       }
>>   }
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
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
