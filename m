Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03BF586C8D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiHAOGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAOG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:06:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82CDE0CE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:06:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31f661b3f89so109798067b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5UhvGzRrQcBGCWtOdqFEgZwHRGSXUKRpcxRX6CD/7s=;
        b=rAPWjvDI2x1MNj7Bu1CCOyfybJSBeCkfp/LO5TNPavNuMm1PCpq9vZac1affXCfVvt
         HfQUD8IDa7FYkHaDZMmcJgTJksD4uPs0blDFqQ4TqvxFRHM8ukS10lHLa+Zyoq/SswML
         dFVjUkxMDEro74y/G2bBenIgy9dTvbXgFbkcc5PnIJ+4PHL3ocZEDki/xulKClATsVTa
         8hSok7ks8K8ULZoPe5omstJhi8J3ZuM96/LSTUO/Sv9qL1U6a5psDTTSJObennoaI22A
         l4ANlFj4EZS+9RCDlPFPQfV+2r3BvdiPIQi/w8S3AYyLyMpIaQxPp6Uea92VnIcplfZ1
         WoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5UhvGzRrQcBGCWtOdqFEgZwHRGSXUKRpcxRX6CD/7s=;
        b=56U6ocwS6avLO1T9qihBw5c6syuQ3kiP6ndU03sKyPhnKHeJkGxk+lozyHW0w5d5KH
         pDE2f9ScHBRSFV5Dj2x9LeZzrwcqmQwmqa/wTBOkyKQRyaQye8EZeAk1BPjpzR6ycQWe
         98DzTNa6GjrTiWmccHPiAH8l7/0Pot8h7q7djnrzN+nzKhdMmht8/J5SDbkrkT9VRw7A
         LGF4J4pYuJQT1VNy9Mk59gT9JQMGCDOz/+zRimHBBlM3PFm6mJ9ZeOwLuNUyu7SirkJc
         NA4O8AibjOZxh7NaTwjKfAIx/nA9Pb8uBsxV/+x0uXbNiCLWOLAeNNy2jCzv6ySNsQXT
         xepg==
X-Gm-Message-State: ACgBeo1FyuTPRRpfS3c+fYMQSOaD4G0eYyVs/VjvPD2XULV2iPeJc7mw
        TD8ImA5kkIKf4TDXus50q3oWbxU5AxLIVK+VzoFJDQ==
X-Google-Smtp-Source: AA6agR6vW/VAc4Dmh2BSzM1CMV3dpkiThH+Yy3VeiFrVu6/wrlBxfsp4wfADdlQot0YVXYIc8OqwDm89KXSYApQ8LVE=
X-Received: by 2002:a0d:f045:0:b0:324:55ec:6595 with SMTP id
 z66-20020a0df045000000b0032455ec6595mr11570098ywe.255.1659362787035; Mon, 01
 Aug 2022 07:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220628113714.7792-1-yee.lee@mediatek.com> <20220628113714.7792-2-yee.lee@mediatek.com>
 <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
 <20220715163305.e70c8542d5e7d96c5fd87185@linux-foundation.org>
 <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
 <CANpmjNPhhPUZFSZaLbwyJfACWMOqFchvm-Sx+iwGSM3sxkky8Q@mail.gmail.com>
 <20220719161356.df8d7f6fc5414cc9cc7f8302@linux-foundation.org> <dc7800c0-43f3-6453-ef5f-1ceb659062de@intel.com>
In-Reply-To: <dc7800c0-43f3-6453-ef5f-1ceb659062de@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 1 Aug 2022 16:05:50 +0200
Message-ID: <CANpmjNNpvbBR6z0T7m1gCp1XoVOHN7CpHoauMKLvtFd5NYJK2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        yee.lee@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+x86 maintainers ...]

On Wed, 20 Jul 2022 at 01:22, Dave Hansen <dave.hansen@intel.com> wrote:
> On 7/19/22 16:13, Andrew Morton wrote:
> > On Mon, 18 Jul 2022 16:26:25 +0200 Marco Elver <elver@google.com> wrote:
> >
> >> On Sat, 16 Jul 2022 at 20:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> [...]
> >>>> - This patch has been accused of crashing the kernel:
> >>>>
> >>>>         https://lkml.kernel.org/r/YsFeUHkrFTQ7T51Q@xsang-OptiPlex-9020
> >>>>
> >>>>   Do we think that report is bogus?
> >>> I think all of this is highly architecture-specific...
> >> The report can be reproduced on i386 with CONFIG_X86_PAE=y. But e.g.
> >> mm/memblock.c:memblock_free() is also guilty of using __pa() on
> >> previously memblock_alloc()'d addresses. Looking at the phys addr
> >> before memblock_alloc() does virt_to_phys(), the result of __pa()
> >> looks correct even on PAE, at least for the purpose of passing it on
> >> to kmemleak(). So I don't know what that BUG_ON(slow_virt_to_phys() !=
> >> phys_addr) is supposed to tell us here.
> >>
> > It's only been nine years, so I'm sure Dave can remember why he added
> > it ;)
> >
> >               BUG_ON(slow_virt_to_phys((void *)x) != phys_addr);
> >
> > in arch/x86/mm/physaddr.c:__phys_addr().
>
> I think I intended it to double check that the linear map is *actually*
> a linear map for 'x'.  Sure, we can use the "x - PAGE_OFFSET" shortcut,
> but did it turn out to be actually accurate for the address it was handed?
>
> I'd be curious what the page tables actually say for the address that's
> causing problems.

test robot just reminded us again:
https://lore.kernel.org/all/YufXncrWhJZH0ifB@xsang-OptiPlex-9020/T/#u

Few things I noticed:

* mm/memblock.c's memblock_free() also uses __pa() to convert back to
physical address. Presumably that's also wrong. What should be used
instead?

* kmemleak happily converts phys_addr_t to unsigned long everywhere,
but with i386 PAE, this will narrow a 64-bit address to a 32-bit
address. Is that correct? Does kmemleak need a "depends on 64BIT ||
!PHYS_ADDR_T_64BIT"?
