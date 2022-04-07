Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552174F8AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiDGXp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiDGXpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:45:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661A149D1D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:43:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t6so84940plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pj1m7MSDvtJlWRF9Wy+Vpq6RgerTAYzRujcuh4rQzlI=;
        b=r3TTgu/GSCJO4lgpmKH+62o1l/WHx0lcIaWhYDrBkTHGeIniXcLPe1ymY9DY99QIse
         m7zuXMNL0ZG33Krt4B/McCxKF1j0bTCNGqCexVynVoEb1NI76yDgA4Y67whCjQJ7IhsF
         Gzt6DRtqw+NmkbtULcdhF2D7PqxUEZiT2UoNGTlsiSE7C9eWRz/pBh5PuzDVHD7XYYYu
         7eNxdPucFOYzKd+IpapxE0VyzB+PEhO9f9fSmx55MxwIEZGHSMiuWFRWZIecxWSsXv9Q
         GWOf1tYDrjfeyQDxVs7RlOJ4QwYj5ohNY7aK4fhQunFYuXENc+xfFfFBZIUh6kVGesxX
         zBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pj1m7MSDvtJlWRF9Wy+Vpq6RgerTAYzRujcuh4rQzlI=;
        b=SggFZvvRP+TjUeAyMC9kxh80DBabWT9SyxeyX9aSJl4FqBWv1QXvF5kRRMYgqsEoP4
         mhs7uWvm39vRH8BCflAUoOkK3GkrWi1ujxZJY4wzQiir7Mw3+Z4hnk1y+5uzg0LB2SWp
         Q3bsex3oQVthheLkeoCdXJf+6vor4Krzl8eEYMSg6wkDzaZPW/DC8Oqln6FUrfziN+Oa
         Io75TpyLuV4QbiL/L9Ain3aQxjMZ8Hayo5QfzOLM9tDQQJosyyZOQFnAVqDO3mgloC7z
         /qeu2LVjYK1C+dUrqhDlSVnhs11jEbBagirIhl0NIJB3gJ3ovmg6KLVWe+J8iYcn2RDS
         UmRA==
X-Gm-Message-State: AOAM530uawcwMCQTeTxH7QqSeXeMdl660G9/Uzc6gp30miP/FdGf4vrT
        dOkSEAfmS0jl6MUZultPp9w9qoE9MYCUxAF9i0aPNA==
X-Google-Smtp-Source: ABdhPJyMwfI9k4IT6Nyps62AlO0jNpMsz9kn3F6fV9YDeY5aDDromm/1G7ZPfCQGxOTNQEl3GgO5lOpz7A1/08m7i24=
X-Received: by 2002:a17:903:32c5:b0:156:b466:c8ed with SMTP id
 i5-20020a17090332c500b00156b466c8edmr16267018plr.34.1649375000969; Thu, 07
 Apr 2022 16:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <202005211950.D56130B81@keescook> <202204061243.FB134CA4B1@keescook> <CAPcyv4htK6Ur4-B=cfkQeOD__9s7ZfxMTo+uCCPVDLG=_WNy7A@mail.gmail.com>
In-Reply-To: <CAPcyv4htK6Ur4-B=cfkQeOD__9s7ZfxMTo+uCCPVDLG=_WNy7A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Apr 2022 16:43:10 -0700
Message-ID: <CAPcyv4hFxVAKgUqt-mua5_1NZkfyKKFL-3F0tSWuSmD=4Z1sBw@mail.gmail.com>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the region
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 11:47 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Apr 6, 2022 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > *thread necromancy*
>
> It's alive!
>
> >
> > Hi Dan,
> >
> > I'm doing a KSPP bug scrub and am reviewing
> > https://github.com/KSPP/linux/issues/74 again.
> >
> > Do you have a chance to look at this? I'd love a way to make mmap()
> > behave the same way as read() for the first meg of /dev/mem.
>
> You want 0-reads or SIGBUS when attempting to access the first 1MB?
>
> Because it sounds like what you want is instead of loudly failing with
> -EPERM in drivers/char/mem.c::mmap_mem() you want it to silently
> succeed but swap in the zero page, right? Otherwise if it's SIGBUS
> then IO_STRICT_DEVMEM=y + marking that span as IORESOURCE_BUSY will
> "Do the Right Thing (TM).".

In other words, if IO_STRICT_DEVMEM is enabled then the enforcement is
already there at least for anything marked IORESOURCE_BUSY. So if
tools are ok with that protection today, maybe there is no need to do
the zero page dance. I.e. legacy tools the read(2) /dev/mem below 1MB
get zeroes, and apparently no tools were mmap'ing below 1MB otherwise
they would have complained by now? At least Fedora is shipping
IO_STRICT_DEVMEM these days:

https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config#_2799
