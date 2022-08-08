Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB658C97C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiHHNbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiHHNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:31:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08EAF78
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:31:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so10938746wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GiRVWjLaeTq4bwRmFmvvoFT6ftmqIf6M/URaB1Ctnzg=;
        b=szcVgf8m8WJvtE5gnipsM5vQKf7KCnLNPJ+u3VKMuEykYIiygVOa7aSIO8GXu6dxin
         C9cN1pT2M7tkqSxLTQ7dEVCI+bTDkIQrvmBHhlH226szPJbK9TDVm0cj3w+hAEBYDeuS
         kuN5fmrWuU9jX9u2cSYdFmZAH0Q9zg90ZB+Y2Q0O5czLc0IhrJBHqzUIDRrvqxeMobzp
         MWC5M/IEaW4beCNYx7AAe2phe0YPGi3kmWCiDtoq4wZ+O9nQ0hSFGvM9w0a3Z6C1+eES
         3NaGqGOTUmlTtOOk/S6l+yQq5g25tDsdg1dnKXql0r7ZtwkTqNQ3fL1uypK6EeT6xGAv
         YU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GiRVWjLaeTq4bwRmFmvvoFT6ftmqIf6M/URaB1Ctnzg=;
        b=ArtyFmXdiI6wuZdLPcW+WyxkS8tIjpvvY8kkEJALrolEe3ynIgA6k5kVNdpPMRnvyr
         W/VV8+Q+RW/4fxu3KaXVwWlyJ/SWJCWRKJfQmkjsiSfODspQULkSSn5KnT3KtT6rPHis
         /qR7qmhxQfxarRVDBKYxwULn1bHWPd7EOx6l7jx+wYrjhjYKmRTN7zBVRcBDvJfXvyM4
         XXNQUcEU2g8dZj0D91RhKw40S5DqaU+5UcKVoMbXMX6v0ofqcBLGcsZgG8CfHerL2Qyc
         BU1s2X8ExgyY6aeANcr8Y442E1vWrC3a/aaz+T6khwEv0Iui6srrV76nMad13qbsGJ9X
         3vvQ==
X-Gm-Message-State: ACgBeo1j0RlahcNzOXezH6wxbjnkdVAMvaxchtbTSZGnJT6EqgGdSVwZ
        WllLNqSaErEyZwH8kXS0uRsdgQ==
X-Google-Smtp-Source: AA6agR4tDfsDfFt7qIu/1NfPJKT5E3XCnPORK+fkpaRYUHopQtyUadTGtAorGFjCYlZOJaI9Q1zrMA==
X-Received: by 2002:adf:ee09:0:b0:21e:f4e4:aa68 with SMTP id y9-20020adfee09000000b0021ef4e4aa68mr11486799wrn.324.1659965476379;
        Mon, 08 Aug 2022 06:31:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5a02:3ab6:cc02:eb4e? ([2a05:6e02:1041:c10:5a02:3ab6:cc02:eb4e])
        by smtp.googlemail.com with ESMTPSA id j1-20020a056000124100b0021d221daccfsm11516170wrx.78.2022.08.08.06.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 06:31:15 -0700 (PDT)
Message-ID: <24be0922-74a5-456e-411b-b1c6e7924f99@linaro.org>
Date:   Mon, 8 Aug 2022 15:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     daniel.lezcano@linexp.org, abailon@baylibre.com,
        anarsoul@gmail.com, baolin.wang7@gmail.com,
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
 <cd4fef23-15b3-15ab-8125-91860bd83315@linaro.org>
 <8a979d0fcab90f4d5ffee95f322c5ace@walle.cc>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8a979d0fcab90f4d5ffee95f322c5ace@walle.cc>
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

On 08/08/2022 15:24, Michael Walle wrote:
> Hi Daniel,
> 
> Am 2022-08-08 15:09, schrieb Daniel Lezcano:
>> Does this fix solves this first issue ?
>>
>> https://lore.kernel.org/all/YvDzovkMCQecPDjz@kili/
> 
> Unfortunately not, it is still the same:

Ok, thanks for testing

> 
> [    1.915140] thermal_sys: Failed to find thermal zone for tmu id=2
> [    1.921279] qoriq_thermal 1f80000.tmu: Failed to register sensors
> [    1.927395] qoriq_thermal: probe of 1f80000.tmu failed with error -22
> [    1.934189] Unable to handle kernel paging request at virtual address 
> 01adadadadadad88
> [    1.942146] Mem abort info:
> [    1.944948]   ESR = 0x0000000096000004
> [    1.948708]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.954042]   SET = 0, FnV = 0
> [    1.957107]   EA = 0, S1PTW = 0
> [    1.960253]   FSC = 0x04: level 0 translation fault
> [    1.965147] Data abort info:
> [    1.968030]   ISV = 0, ISS = 0x00000004
> [    1.971878]   CM = 0, WnR = 0
> [    1.974852] [01adadadadadad88] address between user and kernel 
> address ranges
> [    1.982016] Internal error: Oops: 96000004 [#1] SMP
> [    1.986907] Modules linked in:
> [    1.989969] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
> 5.19.0-next-20220808-00080-g1c46f44502e0 #1697
> [    1.999135] Hardware name: Kontron KBox A-230-LS (DT)
> [    2.004199] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [    2.011185] pc : kfree+0x5c/0x3c0
> [    2.014516] lr : devm_thermal_of_zone_release+0x38/0x60
> [    2.019761] sp : ffff80000a22bad0
> [    2.023081] x29: ffff80000a22bad0 x28: 0000000000000000 x27: 
> ffff800009960464
> [    2.030245] x26: ffff800009a16960 x25: 0000000000000006 x24: 
> ffff800009f09a40
> [    2.037407] x23: ffff800009ab9008 x22: ffff800008d0eea8 x21: 
> 01adadadadadad80
> [    2.044569] x20: 6b6b6b6b6b6b6b6b x19: ffff00200232b800 x18: 
> 00000000fffffffb
> [    2.051731] x17: ffff800008d0eea0 x16: ffff800008d07d44 x15: 
> ffff800008d0d154
> [    2.056647] usb 1-1: new high-speed USB device number 2 using xhci-hcd
> [    2.058893] x14: ffff800008d0cddc x13: ffff8000088d1c2c x12: 
> ffff8000088d5034
> [    2.072597] x11: ffff8000088d46d4 x10: 0000000000000000 x9 : 
> ffff800008d0eea8
> [    2.079759] x8 : ffff002000b1a158 x7 : bbbbbbbbbbbbbbbb x6 : 
> ffff80000a0f53b8
> [    2.086921] x5 : ffff80000a22b960 x4 : 0000000000000000 x3 : 
> 0000000000000000
> [    2.094082] x2 : fffffc0000000000 x1 : ffff002000838040 x0 : 
> 01adb1adadadad80
> [    2.101244] Call trace:
> [    2.103692]  kfree+0x5c/0x3c0
> [    2.106666]  devm_thermal_of_zone_release+0x38/0x60
> [    2.111561]  release_nodes+0x64/0xd0
> [    2.115146]  devres_release_all+0xbc/0x350
> [    2.119253]  device_unbind_cleanup+0x20/0x70
> [    2.123536]  really_probe+0x1a0/0x2e4
> [    2.127208]  __driver_probe_device+0x80/0xec
> [    2.131490]  driver_probe_device+0x44/0x130
> [    2.135685]  __driver_attach+0x104/0x1b4
> [    2.139619]  bus_for_each_dev+0x7c/0xe0
> [    2.143465]  driver_attach+0x30/0x40
> [    2.147048]  bus_add_driver+0x160/0x210
> [    2.150894]  driver_register+0x84/0x140
> [    2.154741]  __platform_driver_register+0x34/0x40
> [    2.159461]  qoriq_tmu_init+0x28/0x34
> [    2.163133]  do_one_initcall+0x50/0x250
> [    2.166979]  kernel_init_freeable+0x278/0x31c
> [    2.171349]  kernel_init+0x30/0x140
> [    2.174847]  ret_from_fork+0x10/0x20
> [    2.178433] Code: b25657e2 d34cfc00 d37ae400 8b020015 (f94006a1)
> [    2.184546] ---[ end trace 0000000000000000 ]---
> [    2.189188] Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x0000000b
> [    2.196869] SMP: stopping secondary CPUs
> [    2.200803] Kernel Offset: disabled
> [    2.204296] CPU features: 0x2000,0800f021,00001086
> [    2.209100] Memory Limit: none
> [    2.212158] ---[ end Kernel panic - not syncing: Attempted to kill 
> init! exitcode=0x0000000b ]---
> 
> -michael


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
