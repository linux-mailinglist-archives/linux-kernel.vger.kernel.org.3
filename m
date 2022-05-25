Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1BA534103
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbiEYQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbiEYQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:05:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651E2B82DD;
        Wed, 25 May 2022 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653494741; x=1685030741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qtq8NsRkQ5MXSb0vyxgaVhO2wTrtOk/ncJF+4DTDLd0=;
  b=kqSUtIo2wPCFYn4p+/jtSY6S/rBxpsOcxc2Hk+ECeVmxy1AJGp10s2fF
   3g6NW8v6L2W+KzXXB4fXfA/Tr5JcMcXXneYd1/EbcR6ouw+r47Wfms8qR
   GtfAElqRpitPHnA9q38go1b7QdiYWc+UzNob65yvNs0c7Ep776dMide6W
   KrbulRLY4jMNvdLTUOTkg4Pkn0wWmRZStJImcqIAoWFBskaUM6Ir0y0E+
   +Ilssh8JxZlzswKcueFT3/EzJPhLCch3uFdqivvYSho77QkKV7BJnLHPU
   ODpXdtRgW2Duoq5HG0vi4dYfAzGyVit45Iapebu+HX3YHg/U8STMyxFpS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="273855084"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273855084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 09:03:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601970811"
Received: from vlpathak-mobl.amr.corp.intel.com (HELO localhost) ([10.212.116.219])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 09:03:12 -0700
Date:   Wed, 25 May 2022 09:03:12 -0700
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
Message-ID: <Yo5TQOByKbMbvE8m@iweiny-desk3>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
 <20220425162400.11334-2-fmdefrancesco@gmail.com>
 <YmeYzKT8Ikq5SfdE@linutronix.de>
 <YmwLXvtSgl2BA2mC@iweiny-desk3>
 <Yo34GGK62yVkPzZy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo34GGK62yVkPzZy@linutronix.de>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 11:34:16AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-04-29 08:59:26 [-0700], Ira Weiny wrote:
> > I think some discussion needs to happen around this API.
> > 
> > Highmem has little use.  I don't think anyone disagrees with Linus there.
> > (Although I think there are still a few users out there.)
> 
> arm32 is still built and they have sometimes 1 - 2 GiB of memory.

Yep :-) I was thinking of arm when I said this.

> 
> > kmap may be a poor name for an API without the highmem functionality.  But
> > perhaps not.  One could interpret it to mean simply getting the kernel mapping
> > of the page rather than creating one.  After all that is what 64bit has done
> > all along.
> > 
> > This interpretation helps when you consider features which attempt to layer the
> > direct map with additional protections like PKS.[1]  Those protections mean
> > that a simple page_address() is insufficient to access the direct map.
> > 
> > As far as calling kmap() and kmap_atomic() deprecated I'm ok with that if the
> > community is.
> > 
> > The current kmap() call sites need work and Fabio's work on auditing them is
> > extremely helpful.  That said, if we officially deprecate kmap_atomic() then
> > those sites could be added to the list for rework.
> 
> Maybe I oversee something obvious but there is no problem with removing
> kmap_atomic*() and keeping only kmap_local*() around, is there?

No there is not.  But some kmap_atomic() sites may have to open code the
preempt_disable() while others may not.

I have not done a full audit of the kmap_atomic() sites but I suspect most
don't really need the preempt_disable() but many may need to.  I just don't
know.

Regardless marking it deprecated can stop the growth of kmap_atomic() calls.

> I never intended to deprecated kmap(), only kmap_atomic*() in favour of
> kmap_local*().

Ok.  But I do want to see kmap() use removed.  The PKS code can't work with
kmap() and in general we are seeing more and more restrictions on the direct
map which may or may not be compatible with kmap().  What I presented at LSFmm
was to turn the kmap* interfaces into a more generic 'get me a temp kernel
address' interface instead of a highmem interface.

Any user who needs a long term address will need something other than kmap().
To that end there was some discussion on making vmap() more efficient or other
alternatives.

First we need to focus on reducing the kmap() call sites.  This documentation
change, making kmap() deprecated, will help ensure the kernel does not grow
more of them.

Ira

> 
> > Ira
> 
> Sebastian
