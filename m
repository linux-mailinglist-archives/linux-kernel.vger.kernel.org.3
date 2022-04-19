Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7750710B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353435AbiDSOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353316AbiDSOzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:55:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990783A732
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650379944; x=1681915944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hrs0xD2jX10H7QRs6Pu6i33/iA3hmmlURHnOfKEEZHc=;
  b=b2Hh2lmo8K/d/stizHW2VueEutnETAwZlI2ATCX7xYi9A3xU8KEgm0x6
   xl5CN4ZOK99Wz6sLIQ0Uw+GLYaTtObljhifKH4jcarwXTWUOEriIGgSSw
   XjcPfX4VnkJaAaaahFHZ3dkva/poTdN/n2WsiHdp6XNKtUvimFAmMQYEl
   AXYH+b1Au9B/5k5mNKS6wPxfgAmfvQX4YoF2e2MSNEGj6mTSZrkB3k1NB
   2GkYr4gKTREs+khs8I1ivzfKcbzOzqe+rygcW/Nv/NhsNHMSlEEjLTk07
   be80uzUBCPc4EX003JTIMzQIHt81pF2Te1BUjZe9pYrZ2+e79aJ/avTa4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263542789"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="263542789"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:52:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="530337191"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:52:23 -0700
Date:   Tue, 19 Apr 2022 07:52:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <Yl7MpmsXtzOfztHu@iweiny-desk3>
References: <20220418175638.30018-1-fmdefrancesco@gmail.com>
 <Yl6unkluUEeRZBbB@casper.infradead.org>
 <4058661.1IzOArtZ34@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4058661.1IzOArtZ34@leap>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 03:25:16PM +0200, Fabio M. De Francesco wrote:
> On martedì 19 aprile 2022 14:44:14 CEST Matthew Wilcox wrote:
> > On Mon, Apr 18, 2022 at 07:56:38PM +0200, Fabio M. De Francesco wrote:
> > > +/**
> > > + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> > > + * @__addr:       Virtual address to be unmapped
> > > + *
> > > + * Counterpart to kmap_atomic().
> > 
> > I don't think this is a terribly useful paragraph?
> 
> I agree but let me remind you that this patch is _only_ about fixing 
> kernel-doc warnings. This warning was simply fixed by moving kdoc comment 
> from highmem.h to highmem-internal.h (which is the file where the 
> definition of kunmap_atomic() resides) and merging the text with few lines 
> that already were in highmem-internal.h.
> 
> Furthermore, I've already had an "Acked-by:" tag from Mike Rapoport. I 
> suppose that if I changed the paragraph here I could not forward his ack to 
> the next version.

No drop the ack for now.

> 
> > > + * Effectively a wrapper around kunmap_local() which additionally 
> undoes
> > > + * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
> > > + * preemption. Prevent people trying to call kunmap_atomic() as if it
> > > + * were kunmap() because kunmap_atomic() should get the return value 
> of
> > > + * kmap_atomic(), not its argument which is a pointer to struct page.
> > 
> > I'd rather this were useful advice to the caller than documentation of
> > how it works.  How about:
> > 
> >  * Unmap an address previously mapped by kmap_atomic().  Mappings
> >  * should be unmapped in the reverse order that they were mapped.
> >  * See kmap_local_page() for details.  @__addr can be any address within
> >  * the mapped page, so there is no need to subtract any offset that has
> >  * been added.  In contrast to kunmap(), this function takes the address
> >  * returned from kmap_atomic(), not the page passed to kmap_atomic().
> >  * The compiler will warn you if you pass the page.
> 
> A change like this should go to a separate patch and indeed I'll send it 
> ASAP. Probably, when I'll rework this text in a separate patch, I'll also 
> copy-paste the paragraph you wrote as-is (too easy!).
> 
> However, since the rework of the text in paragraph can only be applied on 
> top of this patch, I'm not sure if I should either (1) make a series with 
> two patches or (2) make a separate patch with a warning to Maintainers that 
> the changes in the new patch can only be applied on top of this patch.
> 
> Actually, I don't yet know how the Community wants tasks like these to be 
> carried out. Any suggestion?
> 
> Thanks for your review and for suggesting a better suited text for the next 
> patch.

I think you should gather all these patches together into a series and submit.
If I am following correctly there are at least 4 patches now?  But I'm unsure
of which ones are stand alone.

It would be easier to see what changes are being made along the way as well as
the final result of the fixes.

Ira

> 
> Fabio M. De Francesco
> 
> 
