Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811114AA50C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378767AbiBEA1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiBEA1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:27:50 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AD3DF8E3CC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:27:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z131so6284626pgz.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 16:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14C76zcAecy6QkWHP0x84SCdOoX/8DbylNPgLbpYjVc=;
        b=X97Crus95tXaoDwfIJoGl2bEuTJAEN2K54jJx2q4aiiLLJIzjMJ7iLTq5Dl8c3R5dY
         slANIi5qTT+DjREN3JOUw0xpn7Z1pVLp0FhIbExQZXEvGw4DvVzSP2ZIkhaXorrK37xX
         S0wjr1n+BW0R0iYPH6ogu0j9LGqn86XQPLMrtTzKSWcQH2xfic9tJn4b/Sn4tfHZgJM8
         d/eyZJVoBD2jSczF7U/WoFRia4KybaLygQERn0C6JFM9BpL+U2ID687u+5pSNzPACfNl
         Vz+doDFhgnY1jaxMVfxVo/6d+xodSXwgbRjNeP8AMOpQ6yBljPhrtRhoQ5vi9MenaEq1
         t0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14C76zcAecy6QkWHP0x84SCdOoX/8DbylNPgLbpYjVc=;
        b=MgMtTNtoLrmzdP5GKsphs4h4bTeahjFH4Att4BytRdWrizVyS0OHURfSsNR9OLzgUM
         CQ7wSSrRv0ltGykyHNQh9n+9yadWaxMPtkB1aFN4h+Rz4FxHiTNU3mZXQk9ybmHE5eka
         4BD7kHZ31ezCZXYXH3gOH9G+s6DU7RVjezcvu8R3M3KZGxo8ACF+nAswtSgAEROcB45A
         V3oC9oem2DOqDImhw1GYh2/QyqkBtctyITQ9vVToug3Q4MMzpV1mKTmKX0FyImN2+Dtt
         92HGVHPEBrUAZbPOE57KuetSYgdo5IYkGlvjIN1YbLyZ1i77S4ml56mluCYFAnBWHGi7
         epLg==
X-Gm-Message-State: AOAM533BRHzT7illP4eRWyxxC6k45T+9KEcbS62NxKgbpBJRNW59gIaN
        onnAXDDeQntXEgFxupMYut+2xhb0NNHR5iVbsrbu2A==
X-Google-Smtp-Source: ABdhPJx0ty69M690qLEIZqimTrLV7otaDN5/K4DfNw6zW7VTs6llpgC2ebPpiGNE8qwFPN/B7arSerygletp8NkiZgE=
X-Received: by 2002:a62:784b:: with SMTP id t72mr5702587pfc.86.1644020869332;
 Fri, 04 Feb 2022 16:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-39-ira.weiny@intel.com>
 <CAPcyv4iYOGD2XpmO3RH+wViuXx8EYrq-BK7vuKv6we+KR60YCg@mail.gmail.com>
 <20220205000953.GD785175@iweiny-DESK2.sc.intel.com> <CAPcyv4jmnUbywDcXOAL9DwKxGaUf9cw9iDYbDcz6_CHyYPtytw@mail.gmail.com>
 <CAPcyv4iLVh_BesJLcZb=Pktd-h5x6-xuos5Cj4TzuWYC=Q-vLg@mail.gmail.com>
In-Reply-To: <CAPcyv4iLVh_BesJLcZb=Pktd-h5x6-xuos5Cj4TzuWYC=Q-vLg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 16:27:38 -0800
Message-ID: <CAPcyv4gUSDwvOysAMM59yVsERtYpA_kY6s4=xunkjc2eJ8Mi1w@mail.gmail.com>
Subject: Re: [PATCH V8 38/44] memremap_pages: Define pgmap_mk_{readwrite|noaccess}()
 calls
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 4:25 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Feb 4, 2022 at 4:19 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Feb 4, 2022 at 4:10 PM Ira Weiny <ira.weiny@intel.com> wrote:
> > >
> > > On Fri, Feb 04, 2022 at 10:35:59AM -0800, Dan Williams wrote:
> > > > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> > > > >
> > >
> > > [snip]
> > >
> > > I'll address the other comments later but wanted to address the idea below.
> > >
> > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > index f5b2be39a78c..5020ed7e67b7 100644
> > > > > --- a/include/linux/sched.h
> > > > > +++ b/include/linux/sched.h
> > > > > @@ -1492,6 +1492,13 @@ struct task_struct {
> > > > >         struct callback_head            l1d_flush_kill;
> > > > >  #endif
> > > > >
> > > > > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > > > > +       /*
> > > > > +        * NOTE: pgmap_prot_count is modified within a single thread of
> > > > > +        * execution.  So it does not need to be atomic_t.
> > > > > +        */
> > > > > +       u32                             pgmap_prot_count;
> > > > > +#endif
> > > >
> > > > It's not at all clear why the task struct needs to be burdened with
> > > > this accounting. Given that a devmap instance is needed to manage page
> > > > protections, why not move the nested protection tracking to a percpu
> > > > variable relative to an @pgmap arg? Something like:
> > > >
> > > > void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> > > > {
> > > >        migrate_disable();
> > > >        preempt_disable();
> > >
> > > Why burden threads like this?  kmap_local_page() is perfectly able to migrate
> > > or be preempted?
> > >
> > > I think this is way to restrictive.
> >
> > kmap_local_page() holds migrate_disable() over the entire mapping, so
> > we're only talking about preempt_disable(). I tend to think that
> > bloating task_struct for something that is rarely used "kmap on dax
> > pmem pages" is not the right tradeoff.
>
> Now, I can see an argument that promoting kmap_local_page() to
> preempt_disable() could cause problems, but I'd like help confirming
> that before committing to extending task_struct.

...as I say that it occurs to me that the whole point of
kmap_local_page() is to be better than kmap_atomic() and this undoes
that. I'd at least like that documented as the reason that task_struct
needs to carry a new field.
