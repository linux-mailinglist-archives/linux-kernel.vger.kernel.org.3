Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B329515016
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378702AbiD2QC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiD2QCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:02:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7FED4CAA;
        Fri, 29 Apr 2022 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651247968; x=1682783968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LunjCm+37B3707gwlaCjwsukup9zTufYxEeYOdMcWLQ=;
  b=HCYzI6rAQfxHC5IwWlIkn6zhf9f3mNwWTZ3CRA79DVR76k1+gm9uMC8+
   x9ACwikcMG1kiK6LBpnLQTeYYSRZcRWqo0yI7l0p2A9JX+XsR7/KLVq0h
   oI9Ogkp47s0gn3AcQ9dG1vP2SL9jNF6QHTFn0/8rUzK3QDMvtxtla81qz
   77f+J/hSrmfpqaCy/VdlTmEQ0zPEsMeE5Nlh8YkwtIN+SPJKzCAiLzhLp
   oIdzpXS1NJ2RAi4K94vDyBSDt7pw0V/NOZx/qtQ8OEKTRcXshL73Mg5bn
   l39rqhPj5UBWpqyDGlpq1CqX9I9EmUXY//Y2mKqiCEfrqBA/cZ4Xd0W0m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="291854502"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="291854502"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 08:59:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="582206894"
Received: from nadelgad-mobl.amr.corp.intel.com (HELO localhost) ([10.212.108.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 08:59:27 -0700
Date:   Fri, 29 Apr 2022 08:59:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev,
        "Acked-by : Mike Rapoport" <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <YmwLXvtSgl2BA2mC@iweiny-desk3>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
 <20220425162400.11334-2-fmdefrancesco@gmail.com>
 <YmeYzKT8Ikq5SfdE@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmeYzKT8Ikq5SfdE@linutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:01:32AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-04-25 18:23:57 [+0200], Fabio M. De Francesco wrote:
> > index a77be5630209..aa22daeed617 100644
> > --- a/include/linux/highmem-internal.h
> > +++ b/include/linux/highmem-internal.h
> > @@ -236,9 +236,17 @@ static inline unsigned long totalhigh_pages(void) { return 0UL; }
> >  
> >  #endif /* CONFIG_HIGHMEM */
> >  
> > -/*
> > - * Prevent people trying to call kunmap_atomic() as if it were kunmap()
> > - * kunmap_atomic() should get the return value of kmap_atomic, not the page.
> > +/**
> > + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> > + * @__addr:       Virtual address to be unmapped
> > + *
> > + * Unmaps an address previously mapped by kmap_atomic() and re-enables
> > + * pagefaults and preemption. Mappings should be unmapped in the reverse
> 
> You mind adding "Deprecated!" like kmap_atomic() has? The part about
> disabling/ enabling preemption is true for !PREEMPT_RT. The part that
> worries me is that people use it and rely on disabled preemption like
> some did in the past. 
> I've been told this API is about to be removed (or so I have been told)
> so I hope that it will be gone soon ;)

I think some discussion needs to happen around this API.

Highmem has little use.  I don't think anyone disagrees with Linus there.
(Although I think there are still a few users out there.)

kmap may be a poor name for an API without the highmem functionality.  But
perhaps not.  One could interpret it to mean simply getting the kernel mapping
of the page rather than creating one.  After all that is what 64bit has done
all along.

This interpretation helps when you consider features which attempt to layer the
direct map with additional protections like PKS.[1]  Those protections mean
that a simple page_address() is insufficient to access the direct map.

As far as calling kmap() and kmap_atomic() deprecated I'm ok with that if the
community is.

The current kmap() call sites need work and Fabio's work on auditing them is
extremely helpful.  That said, if we officially deprecate kmap_atomic() then
those sites could be added to the list for rework.

Ira

[1] https://lore.kernel.org/lkml/20220419170649.1022246-1-ira.weiny@intel.com/

> 
> > + * order that they were mapped. See kmap_local_page() for details.
> > + * @__addr can be any address within the mapped page, so there is no need
> > + * to subtract any offset that has been added. In contrast to kunmap(),
> > + * this function takes the address returned from kmap_atomic(), not the
> > + * page passed to it. The compiler will warn you if you pass the page.
> >   */
> >  #define kunmap_atomic(__addr)					\
> >  do {								\
> 
> Sebastian
