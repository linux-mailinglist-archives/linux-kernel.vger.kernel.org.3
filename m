Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F914B5ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiBNUKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:10:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiBNUKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:10:22 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BEE15AF23;
        Mon, 14 Feb 2022 12:10:06 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so20723597oov.3;
        Mon, 14 Feb 2022 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hl4qsjV2/BjMWMt6d0Z5bX8ipVYCO7ywdol0OaxdhA0=;
        b=IT1f6OznZuk6hhgifsQ27Cjw3NiaxwNL+YnYQG4ggfQgJ3mKSVh7q1ieT1KNP766sL
         LsrymuBJHzd+MBjDTImy4QQ81fdfzndb8+Ya5+zRC/Ue3FZZnzErbzmwD8cVg8ppA7RN
         rjJ0sGRvcehtw1ukBFiCy6B0XI+NC7GZ7GPdUyTRJzSGcXbno7CC/7n7OCqMq6TMne0a
         jxgH2vDw/aViqp74PmqDqKZxwqQheluqp2UgqiDKVSra5KxXeq4XoMF+EFJthtKsy6Pi
         tL3S9i6TdVmhd54+JED8GxA99Asgu5WbSHnt06pKvY7mjVIFkFSc9pu8LP6duGydT5SB
         XTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hl4qsjV2/BjMWMt6d0Z5bX8ipVYCO7ywdol0OaxdhA0=;
        b=sMxk8n8PhdH4qqELdihiNWrViRoejtlntz/SPUcBDEBLjJ4Xfy0h7JXWeUiquskcl+
         ni9JKM6n7cgDu5SdrsWLSBw6kisrR4sJULPKgH2arz/NK/Hb7r/3rbspg9L66zXUhOUh
         nhhKY/U9Euytj7dWcyRpX8pJlE5RNrWDUumzWrg3orR97IkCWDdsQnITHH7Y5pWb1yX6
         7DFGYNNtlBBk8O+oHrPHXlwKNUIm7KzpLQD26rkkMfVAjL/ZuMx+kCWWRlSD1OkV5atx
         CPhXKzcxn6Bzy6OzkYAgoMrr6QFhZ5ckG/CI9WA/rP8wIhg/EOtnrPRIsYynLPkpDuat
         FBYg==
X-Gm-Message-State: AOAM5301qCUtRaxxTzouCrsBWR4Xtkw/8UC8GdiSyAHIpRRlLaaCUX4b
        x/eUTnJVdpmHXD9KP5jQkHNtfDCeHFMxD4OzPODxZUiB
X-Google-Smtp-Source: ABdhPJz3af0Y9Mc8Z6rmvm36o5KBI6HjJruaU9QKo+S+kx9Fka41SIEiQiI9icVHJKzio5HgHzYrP/hKwpOIT3wovtE=
X-Received: by 2002:a17:90a:178d:b0:1b9:75ce:34d8 with SMTP id
 q13-20020a17090a178d00b001b975ce34d8mr292785pja.228.1644868555400; Mon, 14
 Feb 2022 11:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20220210224933.379149-1-yury.norov@gmail.com> <20220210224933.379149-46-yury.norov@gmail.com>
 <CAJZ5v0hWse+A6ipWiAgfgzSQA52=e45WZgrRX9hUTsekkQjBig@mail.gmail.com>
 <YgqurDJYAqHjpKmf@yury-laptop> <CAJZ5v0jMwi7Jbx=tEC6GHW7iSe9_9EM6B31e949y0wFEp3V6qA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jMwi7Jbx=tEC6GHW7iSe9_9EM6B31e949y0wFEp3V6qA@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 14 Feb 2022 11:55:43 -0800
Message-ID: <CAAH8bW9yRaTa+b8RVkKAe-By-GG_2rEA-WwxsrTuExdQw4qCOQ@mail.gmail.com>
Subject: Re: [PATCH 45/49] ACPI: replace nodes__weight with nodes_weight_ge
 for numa
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alison Schofield <alison.schofield@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:45 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 14, 2022 at 8:36 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Mon, Feb 14, 2022 at 08:18:27PM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Feb 11, 2022 at 1:31 AM Yury Norov <yury.norov@gmail.com> wrote:
> > > >
> > > > acpi_map_pxm_to_node() calls nodes_weight() to compare the weight
> > > > of nodemask with a given number. We can do it more efficiently with
> > > > nodes_weight_eq() because conditional nodes_weight may stop
> > > > traversing the nodemask earlier, as soon as condition is (or is not)
> > > > met.
> > > >
> > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > ---
> > > >  drivers/acpi/numa/srat.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > > index 3b818ab186be..fe7a7996f553 100644
> > > > --- a/drivers/acpi/numa/srat.c
> > > > +++ b/drivers/acpi/numa/srat.c
> > > > @@ -67,7 +67,7 @@ int acpi_map_pxm_to_node(int pxm)
> > > >         node = pxm_to_node_map[pxm];
> > > >
> > > >         if (node == NUMA_NO_NODE) {
> > > > -               if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
> > > > +               if (nodes_weight_ge(nodes_found_map, MAX_NUMNODES))
> > > >                         return NUMA_NO_NODE;
> > > >                 node = first_unset_node(nodes_found_map);
> > > >                 __acpi_map_pxm_to_node(pxm, node);
> > > > --
> > >
> > > Applied as 5.18 material, thanks!
> >
> > It depends on patches 44 and 26. Are you applying them too?
>
> No, I'm not (I've only received this one directly).
>
> I'll drop this patch now and please feel free to add my ACK to it.

OK, thanks.
