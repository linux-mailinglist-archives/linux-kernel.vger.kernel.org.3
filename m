Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1F4C38CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiBXW2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiBXW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:27:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A4141E20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:27:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i19so651675wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:content-transfer-encoding;
        bh=2Po0su4OQcLwD05ycOpYEUEszvD751jwueFeSIX1Bho=;
        b=Qyw2vcM4btgWfaluW8pKS/moQhpNh/TZ3cE53BIXTMb8mk9+SYXnRBax4x9Syyt/QD
         d9TkB1PDTkGrYzOzUQc4fHSOLZHM2O98a4kcp7cZG9sAzfxm7ZppiS4IFDeHo1/RdqCx
         4lJrI6BAV4bvUNNTh32xWpGwCsDcv217oiPIDVyMETHxmTUN/3JsagXMYdNWt2qjxXWy
         bAu/0TM4vZalGHNMF/a1lzi7RJGBnwIv7bQtTgdNZkYiYM3KEYGHXagtY45+W8ucF+l4
         pF5HULAt5uQC55NxUMFei/HVMfyrcrRkJV706QJT2OboiPhJpGkY+opjeNnZfjGtJ8M5
         sMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:content-transfer-encoding;
        bh=2Po0su4OQcLwD05ycOpYEUEszvD751jwueFeSIX1Bho=;
        b=8P2JNKflKIkIMZnYa1Uhvkn2m47lk/sp6ZQ0SrS9YabCzdALWy6oaVudUTOh/5wDXq
         gq/d/yGIG9I0Y4XBD+h9W5e4AMarT2U1++YgEeqjzcidMErgD+Li8zYqxDzOuGamGuOf
         gTr7Ly1f5JLNU2XwYA5iV8C9qsctyNurjiLnH27F7awyUFCe8HGhExeokyPlAh8SpsoZ
         m6DZMU8BXNwMqlCS+z5a7k/meHJbSBpMLCTYaV/Cm6zHDKX5/mQl8NjF/EOJQAgaALPy
         YsclvK1yiZbRQwvYqGZY7s7AoMheWydoaUwRSFGIPc5zIc1bLIv6vZjdKBFEeb8hkgSt
         vqVQ==
X-Gm-Message-State: AOAM530qAsLGMCVMBFmxxM0e5XQvRhwQn8ZLZRHj9InSUdSaG6xdRNfm
        sTUU3o6+aC5rX+kC2j7g2db3RvKTV4I+eQ==
X-Google-Smtp-Source: ABdhPJzOirp7GVopNHMhr7m/DqyvKKDcPOT5QKM44AbjfpcZHJBBYhn+3WKEhp5Ijabtkn/KpREwZQ==
X-Received: by 2002:a1c:a483:0:b0:380:c27c:225b with SMTP id n125-20020a1ca483000000b00380c27c225bmr157750wme.121.1645741643402;
        Thu, 24 Feb 2022 14:27:23 -0800 (PST)
Received: from ?IPV6:2a02:6680:1100:883:dfa4:b9d3:d1f9:d299? ([2a02:6680:1100:883:dfa4:b9d3:d1f9:d299])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6608000000b001e73a0f21ffsm582697wru.6.2022.02.24.14.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 14:27:23 -0800 (PST)
Message-ID: <1e976df3-2925-f6c6-6723-67f127b9e544@gmail.com>
Date:   Fri, 25 Feb 2022 00:27:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: False positive kmemleak report for dtb properties names on
 powerpc
Content-Language: en-US
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

On 18/02/2022 21:45, Ariel Marcovitch wrote:
> Hello!
>
> I was running a powerpc 32bit kernel (built using 
> qemu_ppc_mpc8544ds_defconfig
> buildroot config, with enabling DEBUGFS+KMEMLEAK+HIGHMEM in the kernel 
> config)
> on qemu and invoked the kmemleak scan (twice. for some reason the 
> first time wasn't enough).
>
> (Actually the problem will probably reproduce on every ppc kernel with
> HIGHMEM enabled, but I only checked this config)
>
> I got 97 leak reports, all similar to the following:
>
> ```
>
> unreferenced object 0xc1803840 (size 16):
>   comm "swapper", pid 1, jiffies 4294892303 (age 39.320s)
>   hex dump (first 16 bytes):
>     64 65 76 69 63 65 5f 74 79 70 65 00 00 00 00 00 device_type.....
>   backtrace:
>     [<(ptrval)>] kstrdup+0x40/0x98
>     [<(ptrval)>] __of_add_property_sysfs+0xa4/0x10c
>     [<(ptrval)>] __of_attach_node_sysfs+0xc0/0x110
>     [<(ptrval)>] of_core_init+0xa8/0x15c
>     [<(ptrval)>] driver_init+0x24/0x3c
>     [<(ptrval)>] kernel_init_freeable+0xb8/0x23c
>     [<(ptrval)>] kernel_init+0x24/0x14c
>     [<(ptrval)>] ret_from_kernel_thread+0x5c/0x64
> ```
>
> The objects in the reports are the names of the sysfs files created 
> for the dtb
> nodes and properties.
>
> These are definitely not leaked, as they are even visible to the user 
> as the sysfs file names.
>
> These strings (for dtb properties, in the case of the shown report, 
> but the case with dtb nodes is very similar) are created in 
> __of_add_property_sysfs() and the pointer to them is stored in 
> pp->attr.attr.name (so, actually stored in the memory pointed by pp)
>
> pp is one of the dtb property objects which are allocated in 
> early_init_dt_alloc_memory_arch() in of/fdt.c using memblock_alloc. 
> This happens very early, in setup_arch()->unflatten_device_tree().
>
> memblock_alloc lets kmemleak know about the allocated memory using 
> kmemleak_alloc_phys (in mm/memblock.c:memblock_alloc_range_nid()).
>
> The problem is with the following code (mm/kmemleak.c):
>
> ```c
>
> void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int 
> min_count,
>                                gfp_t gfp)
> {
>         if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
>                 kmemleak_alloc(__va(phys), size, min_count, gfp);
> }
>
> ```
>
> When CONFIG_HIGHMEM is enabled, the pfn of the allocated memory is 
> checked against max_low_pfn, to make sure it is not in the HIGHMEM zone.
>
> However, when called through unflatten_device_tree(), max_low_pfn is 
> not yet initialized in powerpc.
>
> max_low_pfn is initialized (when NUMA is disabled) in 
> arch/powerpc/mm/mem.c:mem_topology_setup() which is called only after 
> unflatten_device_tree() is called in the same function (setup_arch()).
>
> Because max_low_pfn is global it is 0 before initialization, so as far 
> as kmemleak_alloc_phys() is concerned, every memory is HIGHMEM (: and 
> the allocated memory is not tracked by kmemleak, causing references to 
> objects allocated later with kmalloc() to be ignored and these objects 
> are marked as leaked.
>
> I actually tried to find out whether this happen on other arches as 
> well, and it seems like arm64 also have this problem when dtb is used 
> instead of acpi, although I haven't had the chance to confirm this.
>
> I don't suppose I can just shuffle the calls in setup_arch() around, 
> so I wanted to hear your opinions first
>
> Thanks!
>
