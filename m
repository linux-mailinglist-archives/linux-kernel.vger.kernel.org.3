Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2CE53ECA9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbiFFPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbiFFPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:39:14 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9741E2CC8E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:39:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h188so20199657oia.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/AEtQyVxob3WTNVCWKsRPr46NA0vB00z66orli4Jkzc=;
        b=lbbPC/JkqQBV+D2hsmNidhnbM94Q+uc0OZ+Rm576tRXkARdFnUnkOAuHtIVDWBa+gu
         P4sRkHeLq+kd6ZpS+jsoQ57jOG6diQhkXLMsqG5q6BlELb07DbJh1X8eMOiARPcxXHaQ
         fFBeEWaqoVJN2ZlrfaP60g0P0atZRhmEDmVj6HV+triGolM7wNwskrUqvzq9vtdrN0do
         feZZBJswb3uK6ONy97sf9PMdBJ9ofcPGNmoUBDuXhFQB1H8m0Dr1nFezGkjCA4sGLoz5
         Z1x1Y9LVY7tLWA/sSASNR34R5XVxFFTj0p9i+UMeqBQRnj/1UeVdtI1TyGuXIY+X7z+U
         0Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/AEtQyVxob3WTNVCWKsRPr46NA0vB00z66orli4Jkzc=;
        b=iZ9jkdRHQ099zh541CEzoTYBZoTqVkdsP/oeMo+Iho5m/XU8rBGyzhtlearWuA8LfX
         he6ZtGe6xCQcq0I6ZbBxJWg5BdghbSIE50nO6nbV1FBIcHO6BefBDkGVrJN47qst2ZqV
         dhBWSw+PEvxmRhgp/CAkU79+wThMEI0BFYbr577BvpM+DX+q+gZINQ0Mn8FoZhdi6EJR
         2nTHQi3wbnLcHyzRGxCO7jJkIA/yUWu2DCXpALGFNVvje6/OcdMf8pNhILcwhfpyERNS
         1ZkL/94h8zj2oQUsJdUEsHx/zTYeApO0Kr0La+Yq33PQNfiBdBoDDgM7iOmFVdkLbbcG
         7WaQ==
X-Gm-Message-State: AOAM530Pwh7yYImhmyrHVtIMcf7ROb9W8Q+JFXnB0aqL7JoVjwroXZZW
        /jjp2l73jEQ5c8NwahjttvhyplsOEto=
X-Google-Smtp-Source: ABdhPJwXbRf9WVMryDpsg/jtBad6KPRpX9FwZddetzZivMle1wY73NoAQzhwsGRrFXuftlp5H0Vk/g==
X-Received: by 2002:aca:b782:0:b0:325:7a29:352d with SMTP id h124-20020acab782000000b003257a29352dmr28501677oif.217.1654529952914;
        Mon, 06 Jun 2022 08:39:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf1-20020a056808190100b0032af3cffac7sm8845122oib.2.2022.06.06.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:39:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Jun 2022 08:39:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc1
Message-ID: <20220606153910.GA1773067@roeck-us.net>
References: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 05:42:33PM -0700, Linus Torvalds wrote:
> So the last two weeks were _fairly_ normal, although I will gripe and
> moan a bit about how many late pull requests I got. The second week
> started out very calm, but that was sadly only because a _lot_ of
> people left their final pull request pretty late. Not very pleasant at
> all.
> 
. ... ]
> 
> So hey, let's start calming things down and testing this all.
> 

Build results:
	total: 147 pass: 145 fail: 2
Failed builds:
	arm:allmodconfig
	powerpc:allmodconfig
Qemu test results:
	total: 489 pass: 489 fail: 0

arm:allmodconfig:

Error log:
ERROR: modpost: missing MODULE_LICENSE() in drivers/watchdog/gxp-wdt.o

Guess that one is on me. Fix is at
https://patchwork.kernel.org/project/linux-watchdog/patch/20220603131419.2948578-1-linux@roeck-us.net/

powerpc:allmodconfig:

Error: External symbol 'memset' referenced from prom_init.c
make[3]: [arch/powerpc/kernel/Makefile:202: arch/powerpc/kernel/prom_init_check] Error 1 (ignored)
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float,
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of
	file drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float,
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn315/dcn315_resource.o
powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float,
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o uses soft float
powerpc64-linux-ld: failed to merge target specific data of file
	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn316/dcn316_resource.o 

Bisects to commit 41b7a347bf14 ("powerpc: Book3S 64-bit outline-only KASAN support")
which seems to change dependencies.

There is also a runtime warning, seen with various qemu arm boot tests.

WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
refcount_t: underflow; use-after-free.
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0-rc1 #1
Hardware name: ARM-Versatile (Device Tree Support)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x38/0x5c
 dump_stack_lvl from __warn+0xc8/0x1d4
 __warn from warn_slowpath_fmt+0x90/0xc8
 warn_slowpath_fmt from of_platform_bus_create+0x33c/0x3dc
 of_platform_bus_create from of_platform_bus_create+0x1ec/0x3dc
 of_platform_bus_create from of_platform_populate+0x68/0xd8
 of_platform_populate from customize_machine+0x1c/0x30
 customize_machine from do_one_initcall+0x8c/0x2fc
 do_one_initcall from kernel_init_freeable+0x190/0x220
 kernel_init_freeable from kernel_init+0x10/0x108
 kernel_init from ret_from_fork+0x14/0x3c

This is fixed with commit d2ca1fd2bc70 ("ARM: 9207/1: amba: fix refcount
underflow if amba_device_add() fails") in linux-next.

Guenter
