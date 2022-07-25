Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0A580277
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiGYQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiGYQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:11:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F137DDFB2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:11:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z3so10854716plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NRFNfWu56kkzzF2baqz39rI6gVA3xLi6nUY9pbACpq4=;
        b=E4LYa+nsBWnbDjWkmdZ3AwLixMxym9dJ6HxfgUA2O0r78DTMLup90mNPGnjErpkdA+
         1IkTsStdJMUnwqsHYYgUcum1AyR8zmV5dT2fPTimJ35mOMVR4KVClbTNMR9Z9IWZNlmj
         nYsDUL6/DX0U1imlX6leUyKopQ7kt+QDeQ68mDOQCUwwU1HeOVuMqGXeV02wjEx3U1/J
         mezd2sTf4Z25iz7Q9McrrICVoQlM/Gp6CJBGd4t2MlEJTHeqXdi9eqJA5Mi//31tXbeW
         L8OxKPKUErOfYI7BRX27n3thzpGR6VIyslTH2r913Wf6wrjq9JE2Tz5xf8ShCpLZB5DJ
         tDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NRFNfWu56kkzzF2baqz39rI6gVA3xLi6nUY9pbACpq4=;
        b=YglWTFJ2CYExkY8zps5Jov5hGSB4HWWf84cwXOBer5BLPBXIKIcF/cLpWh9/SzyZsO
         bXLgFzXzEDCRwVNkcghxfr5a7BfaIQPvqUXJUNHwY2FOj31gTiT/ZioyAb843mWDh9yv
         cnKwU9pmzGtectc8jLXi0HrQK75vaLEPCjaFPAFEq43D3U97X4hZVr9wVp5lU0wnz8V0
         WXlKETkkooq09ng+4CUiR9LWy7Y8rJROyaO/tF4cTDyjYoaXW659Z+T6MhfbIdNY+64t
         anyE19gLdc96I7IZJ3ZEeVJLkKtCfgaX7zpkIDFmzIWmqfg5Avwx49XkVZLS74YhLgmt
         AhGQ==
X-Gm-Message-State: AJIora/6ojiRAQeIhnKSd6/1mp5VtN4KhczfV9SeZ849y+jXe54Q4CM6
        6kEgylSnT9oAEuFX94yrIK0hG74T7ryT2A==
X-Google-Smtp-Source: AGRyM1sYiy6XXEtqdQYLTbUqqT8I9fZ2ih2r2FkDN0kAHbQm47V8U0Qxn6lHXMeJCeI3uhFKyzALvQ==
X-Received: by 2002:a17:902:ce8c:b0:16c:4be6:254d with SMTP id f12-20020a170902ce8c00b0016c4be6254dmr12888199plg.51.1658765503262;
        Mon, 25 Jul 2022 09:11:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902b94500b001635b86a790sm9411573pls.44.2022.07.25.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:11:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Jul 2022 09:11:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <20220725161141.GA1306881@roeck-us.net>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 01:42:18PM -0700, Linus Torvalds wrote:
> As already mentioned last week, this release is one of those "extra
> week of rc" ones, and here we are, with release candidate #8.
> 
> There's nothing really surprising in here - a few smaller fixups for
> the retbleed mess as expected, and the usual random one-liners
> elsewhere.
> 
> The diffstat shows mainly some documentation updates and a couple of
> drivers with bigger fixes (eg the i916 GuC firmware thing), and the
> networking sysctl data-race annotations.
> 
> So it all just makes me go "yeah, I'm happy to have done another rc,
> but there is nothing particularly interesting here". Which is all
> fine. Shortlog appended for the curious among you.
> 
> We'll let this simmer for another week, and please do give it another
> round of testing to make this last week count, ok?
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 489 pass: 489 fail: 0

I still randomly see

BUG: KFENCE: out-of-bounds read in _find_next_bit_le+0x10/0x48

That is not a new problem; I see it with some arm boot tests
whenever KFENCE is enabled. I attached a trace with decoded
symbols below. Maybe someone with more experience than me can
figure out if this is an arm specific problem or a test problem
or a qemu problem.

Guenter

---
test_bitmap: parselist: 14: input is '0-2047:128/256' OK, Time: 11667
==================================================================
BUG: KFENCE: out-of-bounds read in _find_next_bit_le (arch/arm/lib/findbit.S:88)

Out-of-bounds read at 0xef59e000 (4096B right of kfence-#93):
_find_next_bit_le (arch/arm/lib/findbit.S:88)
kfence-#93: 0xef59d000-0xef59dfff, size=4096, cache=kmalloc-4k
allocated by task 1 on cpu 1 at 18.432911s:
test_bitmap_printlist (./include/linux/slab.h:600 lib/test_bitmap.c:452)
test_bitmap_init (lib/test_bitmap.c:883 lib/test_bitmap.c:889)
do_one_initcall (./include/linux/jump_label.h:261 ./include/linux/jump_label.h:271 ./include/trace/events/initcall.h:48 init/main.c:1296)
kernel_init_freeable (init/main.c:1367 init/main.c:1384 init/main.c:1403 init/main.c:1610)
kernel_init (init/main.c:1501)
ret_from_fork (arch/arm/kernel/entry-common.S:149)
 0x0
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc8 #1
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at _find_next_bit_le (arch/arm/lib/findbit.S:88)
LR is at bitmap_list_string.constprop.0 (lib/vsprintf.c:1246)
pc : lr : psr: 20000113
sp : f082dc70  ip : 00000001  fp : 00000001
r10: 00000000  r9 : 0000002d  r8 : ef59d000
r7 : c0e55514  r6 : c2215000  r5 : 00008000  r4 : 00008000
r3 : 845cac12  r2 : 00008001  r1 : 00008000  r0 : ef59d000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc8 #1
Hardware name: Samsung Exynos (Flattened Device Tree)
unwind_backtrace from show_stack (arch/arm/kernel/traps.c:255)
show_stack from dump_stack_lvl (lib/dump_stack.c:107)
dump_stack_lvl from kfence_report_error (mm/kfence/report.c:262)
kfence_report_error from kfence_handle_page_fault (mm/kfence/core.c:1151)
kfence_handle_page_fault from __do_kernel_fault.part.0 (arch/arm/mm/fault.c:143)
__do_kernel_fault.part.0 from do_page_fault (arch/arm/mm/fault.c:380)
do_page_fault from do_DataAbort (arch/arm/mm/fault.c:539)
do_DataAbort from __dabt_svc (arch/arm/kernel/entry-armv.S:214)
Exception stack(0xf082dc20 to 0xf082dc68)
dc20: ef59d000 00008000 00008001 845cac12 00008000 00008000 c2215000 c0e55514
dc40: ef59d000 0000002d 00000000 00000001 00000001 f082dc70 c0715930 c06ff18c
dc60: 20000113 ffffffff
__dabt_svc from _find_next_bit_le (arch/arm/lib/findbit.S:88)
==================================================================
test_bitmap: bitmap_print_to_pagebuf: input is '0-32767
', Time: 15696250
