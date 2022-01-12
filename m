Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A662948C3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiALMWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbiALMWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:22:09 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E06C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:22:09 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id bj47so1493288vkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96p7tEdmiHeKMcV80I4h0qebMYnM7Uwa9HKh4DEYM88=;
        b=iJrtzLcrKPuRNy9vZ+7KHXqLyl6LLh8cLEyeuSLf1pvGu1AT34XoqroAiT8nNX4zZH
         5TrYPRqOrvSCpxaQLJgThYdiQip4U6ddiS9EMYKljXRb3iji3XDoRDUeI4mDXFNdKW3H
         DXvDAVVzI5UJ5U19IQtUHdeIrAnfqbyn7Bg0JSFggmhgdyhQfpIAXY+PBbRQB0ot88g/
         E8RMD/dj1JkCHkH1lAWWY2ECOgA58wgtuF6vBgTHZ7SxZPTraSCFgTRgaE6DKv6xZWwn
         kkRaNLEu7dR+gQQ0rM6gs5tH63oG4l+TS5MjBztTK/kS2ob/nBj0Wq6SsNlg45ZSuxE6
         hRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96p7tEdmiHeKMcV80I4h0qebMYnM7Uwa9HKh4DEYM88=;
        b=WqPK3lNRlosGdKdipb5Xy9RgEJi2Z2bPeZte+3ig1ld6mmPqaMj2KLbrOL1sXUr+77
         oPZVUCcRcYWlZATKRGvypP9c80SdvO8YD0QGKj03um+ePG867XglVktpgOUSzM6W3/dM
         Rmd5tbTrxPdr+oDRkvuANs28/o976XsaQG63F3crP0vCJT7n0+WO/WtQ5cd6eihUcLQh
         KPbPvtw8RqZrA7IBv03nrauBE27MFKPYk8NDMn/LdGvCPGarBLnX6zIjj6TNPeZxF3A1
         Gij8YgxLWc7J8CCOOonL/fCz6iADZeV6un7Ori869B0HFVw9rkNNbLSznYzQ6uy2tHWs
         hsqA==
X-Gm-Message-State: AOAM532q980Zz85I34mYvug7CsOnKodvqgh8UYa4GrKM/L4VqFh43jBe
        JVUmV4ix9+P7aRDNnL0o2nvUlTl1jsQpXg7VnjU=
X-Google-Smtp-Source: ABdhPJxWfq0NWYUaKiSU6199xtPq1oyDZEZ2hTdjsctVo/Li9Ip8PtyFprnhKMQV9YP34vHyREauL8Fgt0hZPKWl4w0=
X-Received: by 2002:a05:6122:99e:: with SMTP id g30mr4575267vkd.23.1641990128139;
 Wed, 12 Jan 2022 04:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20211207124002.59877-1-liuqi115@huawei.com> <20211213183851.GD12405@willie-the-truck>
 <20211214092657.5b9c26b4e3852602eced4fda@kernel.org> <CAAgTQPUKqFn9_ENKbfJkFjT3v9L2NiFAY2xvULEj_6wguqWYNg@mail.gmail.com>
 <f4552c3e-8f1a-bef1-9396-39aa2405b486@huawei.com> <CAAgTQPWAK==cYPKeYNGE7nPGh0Y7Py4TcUoMPz76h15YNBNsLQ@mail.gmail.com>
 <CAAgTQPWomoiGdVJxwYBmXOj7RegHM4TSa2+yKVTQFhBFg8PtLg@mail.gmail.com>
 <20220104113559.7dd1ff2cb575f62e0b01fb47@kernel.org> <dbcbc161-228d-ee78-e1f0-b59ad9b0a36f@huawei.com>
In-Reply-To: <dbcbc161-228d-ee78-e1f0-b59ad9b0a36f@huawei.com>
From:   Jianhua Liu <jianhua.ljh@gmail.com>
Date:   Wed, 12 Jan 2022 20:21:57 +0800
Message-ID: <CAAgTQPUEgSf-E_GOUNY_=4Piiy0K_-5U_YVbnoMAZ94Q3ducOg@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: kprobe: Enable OPTPROBE for arm64
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 9:31 AM liuqi (BA) <liuqi115@huawei.com> wrote:
>
>
>
> On 2022/1/4 10:35, Masami Hiramatsu wrote:
> > Hi Jianhua,
> >
> > On Mon, 3 Jan 2022 17:03:33 +0800
> > Jianhua Liu <jianhua.ljh@gmail.com> wrote:
> >
> >> Hi Qi,
> >> I have tested your patch on UNISOC s9863a.
> >> Test case "kprobe_example & kretprobe_example" is OK.
> >>
> >> Two point:
> >> 1. backtrace is not perfect.
> >>     optprobe_common does not saved frame pointer,
> >>     backtrace lacks two calls.
> >> such as for dup_mm: lack copy_process-->dup_mm
> >> dup_mm backtrace from your patch:
> >> [  832.387066] CPU: 0 PID: 296 Comm: sh Not tainted 5.16.0-rc5+ #8
> >> [  832.387078] Hardware name: Spreadtrum SP9863A-1H10 Board (DT)
> >> [  832.387083] Call trace:
> >> [  832.387086]  dump_backtrace+0x0/0x1e0
> >> [  832.387103]  show_stack+0x24/0x30
> >> [  832.387112]  dump_stack_lvl+0x68/0x84
> >> [  832.387123]  dump_stack+0x18/0x34
> >> [  832.387131]  handler_pre+0x40/0x50 [kprobe_example]
> >> [  832.387143]  opt_pre_handler+0x84/0xc0
> >> [  832.387154]  optprobe_optimized_callback+0xec/0x164
> >> [  832.387164]  optprobe_common+0x70/0xc4
> >> [  832.387173]  kernel_clone+0x98/0x440
> >> [  832.387182]  __do_sys_clone+0x54/0x80
> >> [  832.387191]  __arm64_sys_clone+0x2c/0x40
> >> [  832.387199]  invoke_syscall+0x50/0x120
> >> [  832.387208]  el0_svc_common.constprop.0+0x4c/0xf4
> >> [  832.387217]  do_el0_svc+0x30/0x9c
> >> [  832.387225]  el0_svc+0x20/0x60
> >> [  832.387235]  el0t_64_sync_handler+0xe8/0xf0
> >> [  832.387242]  el0t_64_sync+0x1a0/0x1a4
> >>
> >>
> >> dup_mm backtrace from other:
> >> [  173.352294] CPU: 6 PID: 309 Comm: sh Not tainted 5.16.0-rc5+ #19
> >> [  173.352301] Hardware name: Spreadtrum SP9863A-1H10 Board (DT)
> >> [  173.352304] Call trace:
> >> [  173.352307]  dump_backtrace+0x0/0x1d4
> >> [  173.352319]  show_stack+0x18/0x24
> >> [  173.352326]  dump_stack_lvl+0x68/0x84
> >> [  173.352333]  dump_stack+0x18/0x34
> >> [  173.352338]  handler_pre+0x38/0x48 [kprobe_example]
> >> [  173.352347]  opt_pre_handler+0x74/0xb0
> >> [  173.352354]  optimized_callback+0x108/0x130
> >> [  173.352361]  optinsn_slot+0x258/0x1000
> >> [  173.352366]  dup_mm+0x4/0x4b0
> >> [  173.352373]  copy_process+0x1284/0x1360
> >> [  173.352378]  kernel_clone+0x5c/0x3c0
> >> [  173.352384]  __do_sys_clone+0x54/0x80
> >> [  173.352390]  __arm64_sys_clone+0x24/0x30
> >> [  173.352396]  invoke_syscall+0x48/0x114
> >> [  173.352402]  el0_svc_common.constprop.0+0x44/0xec
> >> [  173.352408]  do_el0_svc+0x24/0x90
> >> [  173.352413]  el0_svc+0x20/0x60
> >> [  173.352420]  el0t_64_sync_handler+0xe8/0xf0
> >> [  173.352427]  el0t_64_sync+0x1a0/0x1a4
> >
>
> Hi Masami and Jianhua,
>
> optprobe_common() is added to minize size of code in trampoline, but
> each trampoline is alloced as PAGE_SIZE, so optprobe_common() seems
> unnecessary, and will make optprobe_trampoline.S much more complicated.
> How about drop optprobe_common() and use a maro to reduce duplicate code .
>
1. each trampoline is allocated as
(MAX_OPTINSN_SIZE*sizeof(kprobe_opcode_t)), not PAGE_SIZE
2. MAX_OPTINSN_SIZE should be "((unsigned long)(optprobe_template_end
- optprobe_template_entry)),
   your MAX_OPTINSN_SIZE  is not accurate.

3.optprobe_template_val in different kprobe may not be aligned with 8 byte.
   ldr instruction for this value, may use address that not aligned 8 byte.
   "ldr x0, 1f
   .global optprobe_template_common"

Thanks,
Jianhua
> Thanks,
> Qi
> > Is the second one with your patch?
> >
> >>
> >> 2. The reserve memory "OPT_SLOT_SIZE - PAGE_SIZE"  is waste.
> >>     kernel/kprobe.c used only one PAGE_SIZE slot memory.
> >
> > Good catch!
> > Qi, can you make an array (or bit map) of usage flags and
> > manage the reserved memory?
> >
> > #define OPT_INSN_PAGES (OPT_SLOT_SIZE/PAGE_SIZE)
> > static bool insn_page_in_use[OPT_INSN_PAGES];
> >
> > void *alloc_optinsn_page(void)
> > {
> >       int i;
> >
> >       for (i = 0; i < OPT_INSN_PAGES; i++)
> >               if (!insn_page_in_use[i])
> >                       goto found;
> >       return NULL;
> > found:
> >       insn_page_in_use[i] = true;
> >       return (void *)((unsigned long)optinsn_slot + PAGE_SIZE * i);
> > }
> >
> > void free_optinsn_page(void *page)
> > {
> >       unsigned long idx = (unsigned long)page - (unsigned long)optinsn_slot;
> >
> >       WARN_ONCE(idx & (PAGE_SIZE - 1));
> >       idx >>= PAGE_SHIFT;
> >       if (WARN_ONCE(idx >= OPT_INSN_PAGES))
> >               return;
> >       insn_page_in_use[idx] = false;
> > }
> >
> > Thank you,
> >
> >
> >
> >
