Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388B058C648
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbiHHKWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiHHKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:22:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BDB12D1B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:22:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso5621262wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=J6ZVNADyKTbQixcRRwr5+iYgPIyFaFRfnAwe3AZXzG8=;
        b=jN6WCrYWQ2jC9ZXlc1TGgoPmuqkLvvvix3wRLHNKam69FJylZAuMn1T+go58xyXU0k
         UwwynBmOPjAgbO9uXmg2IySjvW3/VxbmfRWfgW6tcPX6o+HWoJwT89qj1RuOmgaKXfsv
         hQ2UmeMGjjSM30xGMCbpJqJlm7MbvjjU38Dk1Nh1RMLgGQVRrF47+jVevhHUIDCT+G3N
         GU3XaHSabyOsgQ4KQcN5AUvsW5U3I8tnhCv89JnRXuGqMu+a18tVtCED80Sg9LN4Rzr0
         wZhmgy6S8euKWg/YMXL7p/9w0c8hmdFZp/kTivkLV33q/PNqo80XsxRqa/sE/rADGM9q
         eFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=J6ZVNADyKTbQixcRRwr5+iYgPIyFaFRfnAwe3AZXzG8=;
        b=CjfGw6ioNwPlUHO9m22nWCdb8L7Vmiyq4Onn4hWUIvoFZKhoD/CplE1q5+rTUVI1T4
         hUB9KH679tJtdb1yTbK7XI93yuGYet1oVs1vAULvLPVMV2Y0itYpGkUYCSN36TxY5+Gb
         OLCDW7jsoOzay6zPTPYoFH0Iepv7dQFdOAg5eQd45V3ZYqvzdpqw8lSw+putM3pV94d1
         +VAzCk09LugVmDh56pY/+nsdCcpdQsomcn8I+sbMbIj8oFTIvZdZNQnuI7jGF9pwOqmk
         2+E4sRunyZZah48p4zE+nfwWTEdRfmyPgeLIUyKQB80u2NC2fcicJjvoe3bZkCECPVNS
         NP5Q==
X-Gm-Message-State: ACgBeo3r73kCvHZKbFo6BimqNGY3SxaBS+Kt+0ZR/uaa/30Pnmh7aRs1
        31FM4sQvp9EAzCLCy4ee/ekv/Q==
X-Google-Smtp-Source: AA6agR7jdIkl0S4iYu4brpVO3NjNmmY52GYqlyF4M5MvrYI85rfNu1cRzMx2DqrvGB85+5wqJtwy4w==
X-Received: by 2002:a1c:1985:0:b0:3a3:2cf8:ebe with SMTP id 127-20020a1c1985000000b003a32cf80ebemr17600187wmz.7.1659954120777;
        Mon, 08 Aug 2022 03:22:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:54d7:57c:c89f:760b? ([2a05:6e02:1041:c10:54d7:57c:c89f:760b])
        by smtp.googlemail.com with ESMTPSA id o19-20020a05600c4fd300b0039747cf8354sm14087596wmq.39.2022.08.08.03.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 03:22:00 -0700 (PDT)
Message-ID: <9b6aea8b-23fb-a882-4c47-5cd70cf266bf@linaro.org>
Date:   Mon, 8 Aug 2022 12:21:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     abailon@baylibre.com, anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, daniel.lezcano@linaro.org,
        digetx@gmail.com, f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 00/33] New thermal OF code
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


Hi Michael,

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

Thanks for reporting, I'll investigate the issues you are reporting.

There is no need to update any device tree file. The code does not 
change the bindings, it is a rewrite of the implementation supposed to 
be without impact on the existing bindings, thus the existing device 
tree descriptions.

Why are you saying there are missing trip points ? The dts shows trip 
points for 'core-cluster' and 'ddr-controller' ?

> On my second board
> (arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts). I get the
> following error:
>
> [    6.292819] thermal_sys: Unable to find thermal zones description
> [    6.298872] thermal_sys: Failed to find thermal zone for hwmon id=0
> [    6.305375] lan966x-hwmon e2010180.hwmon: error -EINVAL: failed to register hwmon device
> [    6.313508] lan966x-hwmon: probe of e2010180.hwmon failed with error -22

Interesting ...

> Again, is there seems to be something missing in the device tree. For this
> board a device tree change should be easily doable, as it is still in
> development.


> Let me know if I can help testing changes.

Yes, definitively, thanks for proposing



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

