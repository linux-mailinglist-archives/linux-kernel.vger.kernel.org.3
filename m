Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2473350B51E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446511AbiDVKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbiDVKfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97DD1FCE1;
        Fri, 22 Apr 2022 03:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B2661E92;
        Fri, 22 Apr 2022 10:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4764EC385A4;
        Fri, 22 Apr 2022 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650623574;
        bh=kCHmAoEYM+X2ISaQSA8mntrf3ayDGNn8yy9TcbltI04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HeCsLhZUJUwSUKnsNxbqq+BjOGTFMs9Qn+sU+nKnvib9LBPEVIwyk977m2JplR5gb
         bVFaZTiAyT2bQrXjqjKUsaMf0Gw3L3FjPhat8eOOu8WJfwJaW4UHmlyrc6wSzN8mXy
         gIik16XUZNHKBFXsGkw/csLkoTHdtCPPS7U2qT2fQn+PbQ8B97h0TDv4L6I0JRi8fX
         6N3s4j6H5vQcP55PGC2x/l20W6fYSZsvu4tFtiiLLAeNnUkFQ5CcViEW36fJGzkGsZ
         rg2kHyWHCo4e78KWp4wEONyVRa5GVPCe7kdvrhbUe0raa0dOp/Pq0HZ2l1WKVkwJrP
         x20wiAY4E9AoQ==
Date:   Fri, 22 Apr 2022 13:32:46 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 1/4] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <YmKETgjMzEOB2c+V@kernel.org>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
 <20220421180200.16901-2-fmdefrancesco@gmail.com>
 <YmJmLrS3hPR6gOaw@kernel.org>
 <1819415.CQOukoFCf9@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1819415.CQOukoFCf9@leap>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:36:28AM +0200, Fabio M. De Francesco wrote:
> On venerdì 22 aprile 2022 10:24:14 CEST Mike Rapoport wrote:
> > On Thu, Apr 21, 2022 at 08:01:57PM +0200, Fabio M. De Francesco wrote:
> > > `scripts/kernel-doc -v -none include/linux/highmem*` reports the 
> following
> > > warnings:
> > > 
> > > include/linux/highmem.h:160: warning: expecting prototype for 
> kunmap_atomic(). Prototype was for nr_free_highpages() instead
> > > include/linux/highmem.h:204: warning: No description found for return 
> value of 'alloc_zeroed_user_highpage_movable'
> > > include/linux/highmem-internal.h:256: warning: Function parameter or 
> member '__addr' not described in 'kunmap_atomic'
> > > include/linux/highmem-internal.h:256: warning: Excess function 
> parameter 'addr' description in 'kunmap_atomic'
> > > 
> > > Fix these warnings by (1) moving the kernel-doc comments from highmem.h 
> to
> > > highmem-internal.h (which is the file were the kunmap_atomic() macro is
> > > actually defined), (2) extending and merging it with the comment which 
> was
> > > already in highmem-internal.h, and (3) using correct parameter names.
> > > 
> > > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >  include/linux/highmem-internal.h | 14 +++++++++++---
> > >  include/linux/highmem.h          | 15 +++------------
> > >  2 files changed, 14 insertions(+), 15 deletions(-)
> > >
> > > [...]
> > >
> > > + *
> > > + * Unmap an address previously mapped by kmap_atomic() and re-enables
> > 
> > Unmap ... and re-enable
> > 
> > or 
> > 
> > Unmaps ... and re-enables
> 
> Sorry, I should have read it twice before submitting :(
> 
> This entire series has already been taken by Andrew Morton for "-mm" 
> immediately after submission. I think that probably the better suited 
> solution is to send a correction when they show upstream. 

You can send a correction as an incremental patch against mmotm tree that's
mirrored here:

https://github.com/hnaz/linux-mm

I believe Andrew will add it to his mmotm queue.
 
> Do you agree with me or you prefer that I resubmit the whole series as a v2 
> now?
> 
> > 
> > Other than that
> > 
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> 
> I also saw your "Acked-by" tag in patch 2/4. Thanks!
> 
> Regards,
> 
> Fabio
> 
> 

-- 
Sincerely yours,
Mike.
