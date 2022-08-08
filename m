Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06BE58C90F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbiHHNJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiHHNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:09:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB0CE37
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:09:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l22so10849679wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=uEKHwhdoHRSC58YgUNJDADgMvoAU2k0F32jAASUN5vw=;
        b=b4SbK7Cf23s+Yk/HDbtVHCilhzfqDjO9gzG08IJZdd9m79aDdD34QNt4OqZ/A1hwYG
         rPHw0rzy9gNRW9a+jXYss2AFIuvIAFKsaO241an3QJtvDY6RHJSxSwNPko7XErZfoz9u
         1zeZ0DGWDkAD4PDM7G+6D4tAo1O9SJ0i1EpkR8DkG9OBL36VsTftbhWWUbxgrsL5dTb5
         mj+ZtKLosoZmqIXlHb9LMPWjX2rhahCSTWqEIUWJdVaAY3/hUGWyqYDK+1MOX+cWDi5E
         XlxrMjBU/PtAZMbs24tgP9bpfkOVPjz+Hx/mbsEvIh+oN9aNUBAeC6l+Y8MJMCIcjbPg
         X5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uEKHwhdoHRSC58YgUNJDADgMvoAU2k0F32jAASUN5vw=;
        b=BmfykYMyZtmNj7KjbNYKOlSQeao+Yi8KAnr18quvbCawyEhyqMBtR6OB3dBhfx0Fgo
         IyEvp1p8veIZfJoOlXq8HXrWU6WElPcSao3KJgxvePSWrcCImnSx0R2fg4Uy9lTtxhE8
         R/1+oO5NidATch1qbrv3iaA2/cRsYxpof6DBJj8Qtfu1w++eROFP0Lt/Qf6EiJ7huYWT
         wwiFUCDpOoN8cLgh25q2ftjHx2mT+5/e+aHGkihU4VisDi9nJe3FuC9Z160gcSi2rJ3f
         Ix843NYKxOKyZj4BUSzQvuFfbUFQh0/yx2/NC9I4qqqeOchzN6xrZVgYrtc/VtX2kNyL
         U22Q==
X-Gm-Message-State: ACgBeo0ZEj7IaQV6QZe5ReH7TE97qIpCsQN63Bh4VOHNOrkqjWUxVN97
        E0pz9jjTvsJ3EZKtZMkhQR8brg==
X-Google-Smtp-Source: AA6agR7c/i66JoLnELpmlqKfhe+ZMqhA5Cx9GChOcA03eMAmhLuSXa8/8NwKLjayt89H46lQvZi8AQ==
X-Received: by 2002:a05:6000:c1:b0:220:5c10:5c51 with SMTP id q1-20020a05600000c100b002205c105c51mr10681120wrx.668.1659964172444;
        Mon, 08 Aug 2022 06:09:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5a02:3ab6:cc02:eb4e? ([2a05:6e02:1041:c10:5a02:3ab6:cc02:eb4e])
        by smtp.googlemail.com with ESMTPSA id p15-20020a05600c1d8f00b0039c454067ddsm3473000wms.15.2022.08.08.06.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 06:09:32 -0700 (PDT)
Message-ID: <cd4fef23-15b3-15ab-8125-91860bd83315@linaro.org>
Date:   Mon, 8 Aug 2022 15:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, daniel.lezcano@linexp.org
Cc:     abailon@baylibre.com, anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, digetx@gmail.com,
        f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220808094216.928018-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 11:42, Michael Walle wrote:
> Hi,
> 
>> The following changes are depending on:
>>
>>   - 20220722200007.1839356-1-daniel.lezcano@linexp.org
>>
>> which are present in the thermal/linux-next branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
>>
>> The series introduces a new thermal OF code. The patch description gives
>> a detailed explanation of the changes. Basically we write new OF parsing
>> functions, we migrate all the users of the old thermal OF API to the new
>> one and then we finish by removing the old OF code.
>>
>> That is the second step to rework the thermal OF code. More patches will
>> come after that to remove the duplication of the trip definitions in the
>> different drivers which will result in more code duplication removed and
>> consolidation of the core thermal framework.
>>
>> Thanks for those who tested the series on their platform and
>> investigated the regression with the disabled by default thermal zones.
> 
> I haven't looked closely yet, but this series is breaking two of my
> boards.
> 
> There seems to be one mistake within the new thermal code:
> 
> [    2.030452] thermal_sys: Failed to find 'trips' node
> [    2.033664] usb 1-1: new high-speed USB device number 2 using xhci-hcd
> [    2.035434] thermal_sys: Failed to find trip points for tmu id=2
> [    2.048010] qoriq_thermal 1f80000.tmu: Failed to register sensors
> [    2.054128] qoriq_thermal: probe of 1f80000.tmu failed with error -22
> [    2.060607] devm_thermal_of_zone_release:707 res=ffff002002377180
> [    2.067044] Unable to handle kernel paging request at virtual address 01adadadadadad88
> [    2.075003] Mem abort info:
> [    2.077805]   ESR = 0x0000000096000004
> [    2.081562]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    2.086893]   SET = 0, FnV = 0
> [    2.089955]   EA = 0, S1PTW = 0
> [    2.093100]   FSC = 0x04: level 0 translation fault
> [    2.097993] Data abort info:
> [    2.100876]   ISV = 0, ISS = 0x00000004
> [    2.104724]   CM = 0, WnR = 0
> [    2.107698] [01adadadadadad88] address between user and kernel address ranges
> [    2.114863] Internal error: Oops: 96000004 [#1] SMP
> [    2.119754] Modules linked in:
> [    2.122815] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-next-20220808-00078-ga957a15f74fc-dirty #1694
> [    2.132504] Hardware name: Kontron KBox A-230-LS (DT)
> [    2.137568] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.144554] pc : kfree+0x5c/0x3c0
> [    2.147885] lr : thermal_of_zone_unregister+0x34/0x54
> [    2.152954] sp : ffff80000a22bab0
> [    2.156274] x29: ffff80000a22bab0 x28: 0000000000000000 x27: ffff800009960464
> [    2.163438] x26: ffff800009a16960 x25: 0000000000000006 x24: ffff800009f09a40
> [    2.170601] x23: ffff800009ab9008 x22: ffff800008d0d684 x21: 01adadadadadad80
> [    2.177763] x20: 6b6b6b6b6b6b6b6b x19: ffff002002335000 x18: 00000000fffffffb
> [    2.184925] x17: ffff800008d0d67c x16: ffff800008d072b4 x15: ffff800008d0c6c4
> [    2.192087] x14: ffff800008d0c34c x13: ffff8000088d5034 x12: ffff8000088d46d4
> [    2.199248] x11: ffff8000088d4624 x10: 0000000000000000 x9 : ffff800008d0d684
> [    2.206410] x8 : ffff002000b1a158 x7 : bbbbbbbbbbbbbbbb x6 : ffff80000a0f53b8
> [    2.213572] x5 : ffff80000a22b940 x4 : 0000000000000000 x3 : 0000000000000000
> [    2.220733] x2 : fffffc0000000000 x1 : ffff002000838040 x0 : 01adb1adadadad80
> [    2.227895] Call trace:
> [    2.230342]  kfree+0x5c/0x3c0
> [    2.233318]  thermal_of_zone_unregister+0x34/0x54
> [    2.238036]  devm_thermal_of_zone_release+0x44/0x54
> [    2.242931]  release_nodes+0x64/0xd0
> [    2.246516]  devres_release_all+0xbc/0x350
> [    2.250623]  device_unbind_cleanup+0x20/0x70
> [    2.254905]  really_probe+0x1a0/0x2e4
> [    2.258577]  __driver_probe_device+0x80/0xec
> [    2.262859]  driver_probe_device+0x44/0x130
> [    2.267055]  __driver_attach+0x104/0x1b4
> [    2.270989]  bus_for_each_dev+0x7c/0xe0
> [    2.274834]  driver_attach+0x30/0x40
> [    2.278418]  bus_add_driver+0x160/0x210
> [    2.281900] hub 1-1:1.0: USB hub found
> [    2.282264]  driver_register+0x84/0x140
> [    2.286109] hub 1-1:1.0: 7 ports detected
> [    2.289859]  __platform_driver_register+0x34/0x40
> [    2.289867]  qoriq_tmu_init+0x28/0x34
> [    2.302258]  do_one_initcall+0x50/0x250
> [    2.306104]  kernel_init_freeable+0x278/0x31c
> [    2.310474]  kernel_init+0x30/0x140
> [    2.313972]  ret_from_fork+0x10/0x20
> [    2.317559] Code: b25657e2 d34cfc00 d37ae400 8b020015 (f94006a1)
> [    2.323672] ---[ end trace 0000000000000000 ]---
> [    2.328317] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    2.335999] SMP: stopping secondary CPUs
> [    2.339932] Kernel Offset: disabled
> [    2.343425] CPU features: 0x2000,0800f021,00001086
> [    2.348229] Memory Limit: none
> [    2.351289] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> This was seen a sl28 board
> (arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts).
> The same board in the KernelCI also have some more information:
> https://lavalab.kontron.com/scheduler/job/151900#L1162
> 
> But I guess even if that is fixed, the driver will not probe due to the
> missing trip points? Are they now mandatory? Does it mean we'd need to
> update our device trees? But that will then mean older devices trees
> don't work anymore.

Does this fix solves this first issue ?

https://lore.kernel.org/all/YvDzovkMCQecPDjz@kili/



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
