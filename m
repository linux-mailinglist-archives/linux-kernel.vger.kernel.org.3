Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8C532100
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiEXCdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiEXCdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:33:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279C66680
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:33:33 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso4421993oto.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MPHja832ANi10gaH5FMmuz+bjOzyj3EVy77AsEb0SpI=;
        b=odS0Sr/naOs3opwkR4MYV9uV42JVwKcJEAtRq9zkzbnV6Rp5LL0v2LvKsqcPUxoUke
         wVoXGeDDKEjVnh3iO0ol+DXf5OUy7vY4yqSxku5/SkXfrIsr5Bivml8ddg8FqMRL4dNJ
         c4yUxod6bLDsIteo0SS1RGwQTPO7CddviTDF2LmRJxJHO7b9r9cBqMOtfvbakBctYC5S
         n8w2JMRliv7JRmU3+1zTessQxO9FzZoWiBGiSeEdUH1QNorsc0+LE/VQYVdJlVepE0Bo
         iG93ExFt5FCkHwnVa/A8576UgL3L5Nbt+INd23oI9Qu8nInoHjsOBKLvxWAHtBBi9aOd
         oWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MPHja832ANi10gaH5FMmuz+bjOzyj3EVy77AsEb0SpI=;
        b=cJWsakET6Q8L8DUagEqp8MW/jDZFCBECQEgT9ydeeFHFZjHd9wZJfatbryO+a8JS7h
         YnjePIOXmceCUMACVpd5klw3cIZQVV15WZoASn3g6YGwjBYLgVmxic970qdBNrlprSP7
         QpwifzZCUsbsAm6of2UY5F6VcrvRXEla7YawB409R0Vw6SkB/ieDdZey3e7jvYwC+tVi
         5yYVt3/YDhgX+PIocf8akP+8HxKEaj2qxGcPC9Ev5AHyclm0eal7bp+V8/vU5YCaq7ok
         h89hjXQU94tvGuDsgny0tQsoSOjyAnrVpHXVR3r1+3n5WSnrdmSLZTUHV7wfgo4GfwAS
         ZC9A==
X-Gm-Message-State: AOAM533mWjMPnVqtZGomtUeUuYYTubuwA9UafaYhfsZ8k5RUIAjQgtPJ
        WZmjdHC92YdhBV6NydKTYm/kAI4wYfI/Ig==
X-Google-Smtp-Source: ABdhPJwOJ4cS0xvhS7EcONlcFavBc/3lf0i3DCICy+Kdf0llicQ1Ngplw7gD/+sPeamKHN6r3k1+Rw==
X-Received: by 2002:a05:6830:199:b0:60b:2046:900 with SMTP id q25-20020a056830019900b0060b20460900mr1029143ota.21.1653359613175;
        Mon, 23 May 2022 19:33:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb6-20020a056820160600b0040e8c09f99dsm1903807oob.23.2022.05.23.19.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 19:33:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <92cecde5-3a7e-54c5-de62-12a133f2de88@roeck-us.net>
Date:   Mon, 23 May 2022 19:33:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ARM: 9192/1: amba: fix memory leak in
 amba_device_try_add()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20220523211700.GA236401@roeck-us.net>
 <85df3427-1dc8-aac0-71fc-1a8b81a731d9@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <85df3427-1dc8-aac0-71fc-1a8b81a731d9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 18:57, Kefeng Wang wrote:
> 
> On 2022/5/24 5:17, Guenter Roeck wrote:
>> On Mon, Apr 18, 2022 at 07:07:14AM +0100, Wang Kefeng wrote:
>>> If amba_device_try_add() return error code (not EPROBE_DEFER),
>>> memory leak occurred when amba device fails to read periphid.
>>>
>> This patch results in a refcount underflow.
>>
>> NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> DMA: preallocated 256 KiB pool for atomic coherent allocations
>> platform vga: Fixing up cyclic dependency with bridge
>> OF: amba_device_add() failed (-19) for /amba/smc@10100000
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
>> refcount_t: underflow; use-after-free.
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0-next-20220523 #1
>> Hardware name: ARM-Versatile (Device Tree Support)
>>   unwind_backtrace from show_stack+0x10/0x14
>>   show_stack from dump_stack_lvl+0x38/0x5c
>>   dump_stack_lvl from __warn+0xc8/0x1d4
>>   __warn from warn_slowpath_fmt+0x90/0xc8
>>   warn_slowpath_fmt from of_platform_bus_create+0x33c/0x3dc
>>   of_platform_bus_create from of_platform_bus_create+0x1ec/0x3dc
>>   of_platform_bus_create from of_platform_populate+0x68/0xd8
>>   of_platform_populate from customize_machine+0x1c/0x30
>>   customize_machine from do_one_initcall+0x8c/0x2fc
>>   do_one_initcall from kernel_init_freeable+0x190/0x220
>>   kernel_init_freeable from kernel_init+0x10/0x108
>>   kernel_init from ret_from_fork+0x14/0x3c
> 
> Thank,  I use vexpress-v2p-ca15-tc1 and can't reproduce , but after check the code,
> 
> amba_device_try_add() is called amba_deferred_retry() and amba_device_add(),
> 
> 1) for amba_device_add(), called by of_amba_device_create() and amba_handler_attach(),
> 
> which has called amba_device_put() to release resource when meet error, my
> 
> patch leads to the above issue.
> 
> 2) for amba_deferred_retry(),  it only releases the  struct deferred_device, but forget
> 
> to call amba_device_put() to release amba device and device name
> 
> so we only need to call amba_device_put() in amba_deferred_retry(), could you
> 
> help me to try the following patch, thanks.
> 

It doesn't apply; it looks like you used cut-and-paste, which replaced
tabs with spaces. I tried to fix it up, but it didn't work.
Please send a clean patch.

Thanks,
Guenter

> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 0e3ed5eb367b..0cb20324da16 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -493,13 +493,8 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>                  goto skip_probe;
> 
>          ret = amba_read_periphid(dev);
> -       if (ret) {
> -               if (ret != -EPROBE_DEFER) {
> -                       amba_device_put(dev);
> -                       goto err_out;
> -               }
> +       if (ret)
>                  goto err_release;
> -       }
> 
>   skip_probe:
>          ret = device_add(&dev->dev);
> @@ -546,6 +541,7 @@ static int amba_deferred_retry(void)
>                          continue;
> 
>                  list_del_init(&ddev->node);
> +               amba_device_put(ddev->dev);
>                  kfree(ddev);
>          }
> 
> 
> 
>>
>> Guenter
>>
>> ---
>> # bad: [cc63e8e92cb872081f249ea16e6c460642f3e4fb] Add linux-next specific files for 20220523
>> # good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
>> git bisect start 'HEAD' 'v5.18'
>> # bad: [a812cac8ff60a3f57d59225eaf668f574fd36a65] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>> git bisect bad a812cac8ff60a3f57d59225eaf668f574fd36a65
>> # bad: [ad67b5f981704e575b24e3b650653bae607980dc] Merge branch 'for-next' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>> git bisect bad ad67b5f981704e575b24e3b650653bae607980dc
>> # bad: [793dd6392ef951ae61473acfc7e7016ea22c40f4] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
>> git bisect bad 793dd6392ef951ae61473acfc7e7016ea22c40f4
>> # good: [00ad84f582be91dd03132c133917cc6b62d754e2] Merge branch 'arm/dt' into for-next
>> git bisect good 00ad84f582be91dd03132c133917cc6b62d754e2
>> # bad: [5c4a49fbe99c7c9b814d677ac99e3efcc43d019a] Merge branch 'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
>> git bisect bad 5c4a49fbe99c7c9b814d677ac99e3efcc43d019a
>> # good: [33cd6948f953ab47ffa493bac6c0f34feb191e0d] Merge branch 'clang-format' of https://github.com/ojeda/linux.git
>> git bisect good 33cd6948f953ab47ffa493bac6c0f34feb191e0d
>> # good: [d6fc5db0f82828c74742319cb6c988c4a8aac535] Merge branch 'for-next/kselftest' into for-next/core
>> git bisect good d6fc5db0f82828c74742319cb6c988c4a8aac535
>> # good: [d7015e50a9ed180dcc3947635bb2b5711c37f48b] perf intel-pt: Add support for emulated ptwrite
>> git bisect good d7015e50a9ed180dcc3947635bb2b5711c37f48b
>> # good: [5b86b659fa4b3dd45acbdce13f2e94f882a3d125] Merge branch 'for-next' of git://git.infradead.org/users/hch/dma-mapping.git
>> git bisect good 5b86b659fa4b3dd45acbdce13f2e94f882a3d125
>> # good: [945980a9ba0744038659769e9f04e83e8f6b494b] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
>> git bisect good 945980a9ba0744038659769e9f04e83e8f6b494b
>> # bad: [b6f21d14f1ac1261579b691673a0c823275cbaf8] ARM: 9204/2: module: Add all unwind tables when load module
>> git bisect bad b6f21d14f1ac1261579b691673a0c823275cbaf8
>> # bad: [c4f486f1e7b34b27ec578494a236061b337d50ae] ARM: 9198/1: spectre-bhb: simplify BPIALL vector macro
>> git bisect bad c4f486f1e7b34b27ec578494a236061b337d50ae
>> # bad: [7719a68b2fa404fa8af6b0b7119a38c406c74858] ARM: 9192/1: amba: fix memory leak in amba_device_try_add()
>> git bisect bad 7719a68b2fa404fa8af6b0b7119a38c406c74858
>> # good: [1f44de0f5e309e8699b569b49a8e89ef4e7527c7] ARM: 9193/1: amba: Add amba_read_periphid() helper
>> git bisect good 1f44de0f5e309e8699b569b49a8e89ef4e7527c7
>> # first bad commit: [7719a68b2fa404fa8af6b0b7119a38c406c74858] ARM: 9192/1: amba: fix memory leak in amba_device_try_add()
>>
>>
>> .

