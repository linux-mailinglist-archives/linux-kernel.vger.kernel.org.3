Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DCF545181
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbiFIQEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiFIQEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:04:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641EB33EA9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:04:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s135so6600698pgs.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3ILYlszPDrIeKXSmMjQGLue8JG/SuYTmYZ/Bt3QkU8=;
        b=PimOCmCn70NY7MMaB/ZP9mdeyusFf2CRAMHGF+lYFNCyqrmpCsAqXEM4L/qlBn/Buy
         EBhikOYA6fAYic8fLZuTQ515W60UdAOYkQ8y6MxWX6PrftL7Y9L+sJ/Vnr9ZgPEu8jRB
         bs4+y0A/TjW4KIrFe+0a2Z92kkqAHAUMkg3VJ4v/vMoC13W6nP213s+LG6yh3bJ+uPVT
         x3SA6CP2KvmocFlO841qFU/Iz+dieyq3Ob6seWf9rf1iHPLcYOAH8GiDu0Z1SVW4N4wF
         fH0xG7aeMVUQLU/g83c+sn4rn0xKBYj2hVKPfjolGq+ScxzEcu9coapXimxwQs9ezNqp
         dhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3ILYlszPDrIeKXSmMjQGLue8JG/SuYTmYZ/Bt3QkU8=;
        b=nT2FU+dPNJew9IqsHsXuIraQR28Wk7s6md9wYyAAyqwnfgCJsg4kGYQ+Cx66IN1WmC
         hVki9/Rc03JJQW+Mq50qb3RJP9pDu1CKhAdtDgfHJKIuMFc95JFPbCcaSa0Y8Vsewzqb
         bSONgnANWBkUPzDWnhI8vy0AwWwzfXP7jnzLe8SpslRdSySeShlufYPWc2c2gl24bv/8
         VNp6VP6mkSz2Z2MG3xPiqLByEAenUbXXIhabBCyQ8moLbWyDDUxnTeqgc4afIVbGg28i
         liCpYNX1Aqq8wIK+a3oRQ3h5l9FIOa4eaZCmp0UlqR5WC32I/nsULJCMGt511XikYVt2
         2ijQ==
X-Gm-Message-State: AOAM531crLjupBn8z13hPDOHB9pclQujYHbT664Qk9EKPdeYinhix42w
        TCTx9i6I73ywlWlS7EuvrZCCpM8Oid3i41cITJE=
X-Google-Smtp-Source: ABdhPJz+RjvLZsWcxQ9idwoZ/9r1IacyDDJ7x40ddb91Qr2LZnjOigrOD8tNk+KjTdwZUHyYyYUADdw/uWflREHtcbY=
X-Received: by 2002:a63:3183:0:b0:3fd:6797:70a8 with SMTP id
 x125-20020a633183000000b003fd679770a8mr24042161pgx.206.1654790683821; Thu, 09
 Jun 2022 09:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com> <CAHbLzkrWer5-HgujZ12b=qxtT2ByV0+Sy7fsYb2EBgHAGRuPpw@mail.gmail.com>
 <2b4f053b-de25-986c-f764-5cc6a28f4953@linux.ibm.com> <CAHbLzkqg++ENAEPdd+UY8Q5X0CuvbHC+JFAvYi2KLaS+2=q3_A@mail.gmail.com>
 <a81d4b1e-ee03-d44e-899b-166b42b09bf4@linux.ibm.com>
In-Reply-To: <a81d4b1e-ee03-d44e-899b-166b42b09bf4@linux.ibm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 9 Jun 2022 09:04:31 -0700
Message-ID: <CAHbLzkrhw7H4bbpPXnwmeJ1hm9Lr9CRoipa1_rA4bkhA6tVMqA@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 1:18 AM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 6/8/22 10:12 PM, Yang Shi wrote:
> > On Tue, Jun 7, 2022 at 9:58 PM Aneesh Kumar K V
> > <aneesh.kumar@linux.ibm.com> wrote:
>
> ....
>
> >>    config TIERED_MEMORY
> >>          bool "Support for explicit memory tiers"
> >> -       def_bool n
> >> -       depends on MIGRATION && NUMA
> >> -       help
> >> -         Support to split nodes into memory tiers explicitly and
> >> -         to demote pages on reclaim to lower tiers. This option
> >> -         also exposes sysfs interface to read nodes available in
> >> -         specific tier and to move specific node among different
> >> -         possible tiers.
> >> +       def_bool MIGRATION && NUMA
> >
> > CONFIG_NUMA should be good enough. Memory tiering doesn't have to mean
> > demotion/promotion has to be supported IMHO.
> >
> >>
> >>    config HUGETLB_PAGE_SIZE_VARIABLE
> >>          def_bool n
> >>
> >> ie, we just make it a Kconfig variable without exposing it to the user?
> >>
>
> We can do that but that would also mean in order to avoid building the
> demotion targets etc we will now have to have multiple #ifdef
> CONFIG_MIGRATION in mm/memory-tiers.c . It builds without those #ifdef
> So these are not really build errors, but rather we will be building all
> the demotion targets for no real use with them.

Can we have default demotion targets for !MIGRATION? For example, all
demotion targets are -1.

>
> What usecase do you have to expose memory tiers on a system with
> CONFIG_MIGRATION disabled? CONFIG_MIGRATION gets enabled in almost all
> configs these days due to its dependency against COMPACTION and
> TRANSPARENT_HUGEPAGE.

Johannes's interleave series is an example,
https://lore.kernel.org/lkml/20220607171949.85796-1-hannes@cmpxchg.org/

It doesn't do any demotion/promotion, just make allocations interleave
on different tiers.

>
> Unless there is a real need, I am wondering if we can avoid sprinkling
> #ifdef CONFIG_MIGRATION in mm/memory-tiers.c
>
> -aneesh
