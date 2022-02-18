Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3B4BC06A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiBRTqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:46:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiBRTqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:46:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872491A2E71
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:45:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx21so17261760ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=TnkmE51UkNMsCcfFfMpS33esSVozAPP7mpptFWEYpDM=;
        b=dKSzoS/3aMC9ZRTMRyoosCDwk0ZSwBgTYl7XOfoKh4dfyzYc0fm4Gex4e8pwyOivcP
         SYAJlV3s0lYSSGU7TjYA717k0mEzY4L+r0w2xUh0A1LafHFru6PLi9IXvCbEDEaJRMQ1
         5iKvU1QviQ6hvuziixKIgraX1Pj7S7s/2x7dMeeWDNMaCoOmeIE/NjNnBkB/c93f1ZCq
         wfY7XSIqb6EGClIXRzo95STJU1+3WiAyTHMdyyebIvKGEIhAo9eohREh9rW5BIvM+8vJ
         tCX59RL/RbirgTbFao0An00pgMqcG2xL2b+OXt/tKz2LHvzgECYKFJmZd16VU1r69UJw
         VMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=TnkmE51UkNMsCcfFfMpS33esSVozAPP7mpptFWEYpDM=;
        b=TbjHZKOPkzxDAMWneFtMhSgoLZUUa5wnQEHqdWafecr0iB2FYiMpBfvjcFCbigCIgc
         WZP5amgXaG5OIu8QMqk0UZRSG2jq0l7rLQZXf8qcQJ6nsQAkBZ5yMr8jQZR9GUoo1rkG
         9OGH/u2DQTcBcDMXnO4/xEcrgmwHc6DcogmyDbJsrQGaXqi17nvDB535HD6CzZAPMJAx
         6PZQ95W+BFe5mdvtWW8pBjvb1fHdUWejzg4QmL7hR8Wjv3ZpL1McQjNwFmGgNnNY21j+
         LwepgEH7HZHyEN2pd3LNVIG9+3Jv+gCxdqHus3+21IM+qZMzASOHvcXyIZvfDpCVcgK4
         6mhg==
X-Gm-Message-State: AOAM531v6JHzsrU8pAp64mhs3H/W01tLdxvrSBTjUT1iwX1wqE+lfjA1
        q7xFZbBvqdmZdVPCiPupfnM5nWkNqaYdJw==
X-Google-Smtp-Source: ABdhPJxHrwyJCxDhLFrjCzW69ZvfsjmR+IMuhgAuKO0gzs2uTEtYDNQO2rPGEtUNikscE07/abTwUw==
X-Received: by 2002:a17:906:9b88:b0:6d0:f843:4068 with SMTP id dd8-20020a1709069b8800b006d0f8434068mr195022ejc.678.1645213554058;
        Fri, 18 Feb 2022 11:45:54 -0800 (PST)
Received: from ?IPV6:2a00:a040:197:458f:c93a:90a3:1c34:c6d2? ([2a00:a040:197:458f:c93a:90a3:1c34:c6d2])
        by smtp.gmail.com with ESMTPSA id o12sm412793ejg.105.2022.02.18.11.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 11:45:53 -0800 (PST)
Message-ID: <9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com>
Date:   Fri, 18 Feb 2022 21:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
Subject: False positive kmemleak report for dtb properties names on powerpc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I was running a powerpc 32bit kernel (built using 
qemu_ppc_mpc8544ds_defconfig
buildroot config, with enabling DEBUGFS+KMEMLEAK+HIGHMEM in the kernel 
config)
on qemu and invoked the kmemleak scan (twice. for some reason the first 
time wasn't enough).

(Actually the problem will probably reproduce on every ppc kernel with
HIGHMEM enabled, but I only checked this config)

I got 97 leak reports, all similar to the following:

```

unreferenced object 0xc1803840 (size 16):
   comm "swapper", pid 1, jiffies 4294892303 (age 39.320s)
   hex dump (first 16 bytes):
     64 65 76 69 63 65 5f 74 79 70 65 00 00 00 00 00 device_type.....
   backtrace:
     [<(ptrval)>] kstrdup+0x40/0x98
     [<(ptrval)>] __of_add_property_sysfs+0xa4/0x10c
     [<(ptrval)>] __of_attach_node_sysfs+0xc0/0x110
     [<(ptrval)>] of_core_init+0xa8/0x15c
     [<(ptrval)>] driver_init+0x24/0x3c
     [<(ptrval)>] kernel_init_freeable+0xb8/0x23c
     [<(ptrval)>] kernel_init+0x24/0x14c
     [<(ptrval)>] ret_from_kernel_thread+0x5c/0x64
```

The objects in the reports are the names of the sysfs files created for 
the dtb
nodes and properties.

These are definitely not leaked, as they are even visible to the user as 
the sysfs file names.

These strings (for dtb properties, in the case of the shown report, but 
the case with dtb nodes is very similar) are created in 
__of_add_property_sysfs() and the pointer to them is stored in 
pp->attr.attr.name (so, actually stored in the memory pointed by pp)

pp is one of the dtb property objects which are allocated in 
early_init_dt_alloc_memory_arch() in of/fdt.c using memblock_alloc. This 
happens very early, in setup_arch()->unflatten_device_tree().

memblock_alloc lets kmemleak know about the allocated memory using 
kmemleak_alloc_phys (in mm/memblock.c:memblock_alloc_range_nid()).

The problem is with the following code (mm/kmemleak.c):

```c

void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
                                gfp_t gfp)
{
         if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
                 kmemleak_alloc(__va(phys), size, min_count, gfp);
}

```

When CONFIG_HIGHMEM is enabled, the pfn of the allocated memory is 
checked against max_low_pfn, to make sure it is not in the HIGHMEM zone.

However, when called through unflatten_device_tree(), max_low_pfn is not 
yet initialized in powerpc.

max_low_pfn is initialized (when NUMA is disabled) in 
arch/powerpc/mm/mem.c:mem_topology_setup() which is called only after 
unflatten_device_tree() is called in the same function (setup_arch()).

Because max_low_pfn is global it is 0 before initialization, so as far 
as kmemleak_alloc_phys() is concerned, every memory is HIGHMEM (: and 
the allocated memory is not tracked by kmemleak, causing references to 
objects allocated later with kmalloc() to be ignored and these objects 
are marked as leaked.

I actually tried to find out whether this happen on other arches as 
well, and it seems like arm64 also have this problem when dtb is used 
instead of acpi, although I haven't had the chance to confirm this.

I don't suppose I can just shuffle the calls in setup_arch() around, so 
I wanted to hear your opinions first

Thanks!

