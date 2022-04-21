Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268C50ABE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442245AbiDUXU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442211AbiDUXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:20:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20EC3982A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:17:33 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hh4so4398359qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4De3YRMK1Ra85Dips/fnb0PQnHGIx9mJCfq1fssj8tg=;
        b=NahulHgG7AbSSsGtdussdVQis65kI8sp5gMXA41OPT6pGnY/J/4EzAjaq/y77Z2HXw
         aOv8oX2SNChMWUOv81wt0xVJAtxuYfbsKco7GTIoFywSROonMW44bI6fESBxGV9tOLK+
         UJn1uFBSDVlSTXnBKxF7bxejGfuT0CVDlHE621+N2rH5vB8GlOuXKG5EkttdqR13qkzz
         WI3U2fkUUuKIl78IFOFSjcdHQ3fw5oeGRtBpoFuen9BPAmdpacd2Kpm4m7ae9F2WjcEO
         q78IrsC2YKd/NF8fUonEGoD5HYSfshBpzLSn4KwAiBYkzCl425g/dqC+zk+lRn0x99so
         GlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4De3YRMK1Ra85Dips/fnb0PQnHGIx9mJCfq1fssj8tg=;
        b=tbkUuHTSYTTJ9v6ex4KMq1EuDTP0czKud3AYRjDLrOey+R6OdRrXDeFfD6KQcPwB3k
         FnG4ZkuGOHGf66l/X1Mp8iCAjWwRDD8RIQ3LWA4FZVNDaeVR9/IyW7H+kIULtJMl/fgL
         W6IIhi09sOgXQ++uqzN1HrtFPn2zpGKS/eb+b5mE7tSY81k5VRksO2Lh+73Gbr9NEv+Y
         kASWNiukgWdCgMOrz5rXhjQq/gwqNGzvMYLfBZx6BrSycdKzrzC3X+5mBXLz4fxS2TVn
         g/z6y8KoSTlutxlwC3J2d42NGYT1qliag+ruQ2f4Rx+XG9BS9aQ+/qW7R2gBV6mdZ0VP
         Ntrg==
X-Gm-Message-State: AOAM533ac0xWAAqNO/AF3NT89gF5a2ewmUJMhn2VQ4E+eBqYXKdgZ/4i
        dGmgtcLCT5toi61SkdXnUIo=
X-Google-Smtp-Source: ABdhPJyYbA/4NtfvAf2c391c2gmRt86bly6dOI/e0Wpz6xRjKeXrAL0qHq6/hcVKXFRdCyqGe1zvXQ==
X-Received: by 2002:ac8:7c4e:0:b0:2f3:365b:54d3 with SMTP id o14-20020ac87c4e000000b002f3365b54d3mr1358438qtv.37.1650583052958;
        Thu, 21 Apr 2022 16:17:32 -0700 (PDT)
Received: from localhost ([2601:c4:c432:668:da50:5094:8aba:8f5e])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm265322qta.76.2022.04.21.16.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:17:32 -0700 (PDT)
Date:   Thu, 21 Apr 2022 16:17:31 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re:
Message-ID: <YmHmC1VVxEuViqJx@yury-laptop>
References: <20220421164138.1250943-1-yury.norov@gmail.com>
 <92a2715c-3c98-251d-9195-872d1cf01f9d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a2715c-3c98-251d-9195-872d1cf01f9d@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 04:04:44PM -0700, John Hubbard wrote:
> On 4/21/22 09:41, Yury Norov wrote:
> > Subject: [PATCH] mm/gup: fix comments to pin_user_pages_*()
> > 
> 
> Hi Yuri,
> 
> Thanks for picking this up. I have been distracted and didn't trust
> myself to focus on this properly, so it's good to have help!
> 
> IT/admin point: somehow the first line of the commit description didn't
> make it into an actual email subject. The subject line was blank when it
> arrived in my inbox, and the subject is in the body here instead. Not
> sure how that happened.
> 
> Maybe check your git-sendemail setup?
 
git-sendmail is OK. I just accidentally added empty line above Subject,
which broke format. My bad, sorry for this.
 
> > pin_user_pages API forces FOLL_PIN in gup_flags, which means that the
> > API requires struct page **pages to be provided (not NULL). However,
> > the comment to pin_user_pages() says:
> > 
> >      * @pages:      array that receives pointers to the pages pinned.
> >      *              Should be at least nr_pages long. Or NULL, if caller
> >      *              only intends to ensure the pages are faulted in.
> > 
> > This patch fixes comments along the pin_user_pages code, and also adds
> > WARN_ON(!pages), so that API users will have better understanding
> > on how to use it.
> 
> No need to quote the code in the commit log. Instead, just summarize.
> For example:
> 
> pin_user_pages API forces FOLL_PIN in gup_flags, which means that the
> API requires struct page **pages to be provided (not NULL). However, the
> comment to pin_user_pages() clearly allows for passing in a NULL @pages
> argument.
> 
> Remove the incorrect comments, and add WARN_ON_ONCE(!pages) calls to
> enforce the API.
> 
> > 
> > It has been independently spotted by Minchan Kim and confirmed with
> > John Hubbard:
> > 
> > https://lore.kernel.org/all/YgWA0ghrrzHONehH@google.com/
> 
> Let's add a Cc: line for Michan as well:
> 
> Cc: Minchan Kim <minchan@kernel.org>
 
He's in CC already, I think...
 
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >   mm/gup.c | 26 ++++++++++++++++++++++----
> >   1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index f598a037eb04..559626457585 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2871,6 +2871,10 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
> >   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> >   		return -EINVAL;
> > +	/* FOLL_PIN requires pages != NULL */
> 
> Please delete each and every one of these one-line comments, because
> they merely echo what the code says.

Sure.
 
> > +	if (WARN_ON_ONCE(!pages))
> > +		return -EINVAL;
> > +
> >   	gup_flags |= FOLL_PIN;
> >   	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
> >   }
> > @@ -2893,6 +2897,10 @@ int pin_user_pages_fast_only(unsigned long start, int nr_pages,
> >   	 */
> >   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> >   		return 0;
> > +
> > +	/* FOLL_PIN requires pages != NULL */
> > +	if (WARN_ON_ONCE(!pages))
> > +		return 0;
> >   	/*
> >   	 * FOLL_FAST_ONLY is required in order to match the API description of
> >   	 * this routine: no fall back to regular ("slow") GUP.
> > @@ -2920,8 +2928,7 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
> >    * @nr_pages:	number of pages from start to pin
> >    * @gup_flags:	flags modifying lookup behaviour
> >    * @pages:	array that receives pointers to the pages pinned.
> > - *		Should be at least nr_pages long. Or NULL, if caller
> > - *		only intends to ensure the pages are faulted in.
> > + *		Should be at least nr_pages long.
> >    * @vmas:	array of pointers to vmas corresponding to each page.
> >    *		Or NULL if the caller does not require them.
> >    * @locked:	pointer to lock flag indicating whether lock is held and
> > @@ -2944,6 +2951,10 @@ long pin_user_pages_remote(struct mm_struct *mm,
> >   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> >   		return -EINVAL;
> > +	/* FOLL_PIN requires pages != NULL */
> > +	if (WARN_ON_ONCE(!pages))
> > +		return -EINVAL;
> > +
> >   	gup_flags |= FOLL_PIN;
> >   	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
> >   				       pages, vmas, locked);
> > @@ -2957,8 +2968,7 @@ EXPORT_SYMBOL(pin_user_pages_remote);
> >    * @nr_pages:	number of pages from start to pin
> >    * @gup_flags:	flags modifying lookup behaviour
> >    * @pages:	array that receives pointers to the pages pinned.
> > - *		Should be at least nr_pages long. Or NULL, if caller
> > - *		only intends to ensure the pages are faulted in.
> > + *		Should be at least nr_pages long.
> >    * @vmas:	array of pointers to vmas corresponding to each page.
> >    *		Or NULL if the caller does not require them.
> >    *
> > @@ -2976,6 +2986,10 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
> >   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> >   		return -EINVAL;
> > +	/* FOLL_PIN requires pages != NULL */
> > +	if (WARN_ON_ONCE(!pages))
> > +		return -EINVAL;
> > +
> >   	gup_flags |= FOLL_PIN;
> >   	return __gup_longterm_locked(current->mm, start, nr_pages,
> >   				     pages, vmas, gup_flags);
> > @@ -2994,6 +3008,10 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> >   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> >   		return -EINVAL;
> > +	/* FOLL_PIN requires pages != NULL */
> > +	if (WARN_ON_ONCE(!pages))
> > +		return -EINVAL;
> > +
> >   	gup_flags |= FOLL_PIN;
> >   	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
> >   }
> 
> I hope we don't break any callers with the newly enforced !pages, but it's
> the right thing to do, in order to avoid misunderstandings.
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA

Let me test v2 and resend shortly.

Thanks,
Yury
