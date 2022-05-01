Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D35161E0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 07:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbiEAFPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 01:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiEAFPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 01:15:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B814A906;
        Sat, 30 Apr 2022 22:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651381904; x=1682917904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JKmlc2N07ImkrRm9eM53sgRdX9aGwES/lKiUIH8s89E=;
  b=Z+fh6qMqWJk7JPLVgtxSdnDWJSbZlgflc0oiH4iixon1wp5mUBzeQrdy
   cw4sZ11dujimuPUmI7ICbU9qPxbF+yGpPUeDN01grEaS3arcQEDVMRA70
   TYWR68CGojMJpqZlcoFETgDjxPeDMZOU5+ktHlDa4k0kuB83foOaqx8mP
   k9AV3KQOVB6YJfejFF/KQVNKA9FQqSNfUwNL3Tuuz2IriL038VuZM/QxG
   +zeP9H9GxK2isw2PDhzEYpz1Ty+1AnM8LWDPytXDpoIYWb9l8+RfV2Ksa
   DO2PYvjslwZC5YtKOXujqUaf3/6mZW+4/XdKGjKSt2bNvGoufWmjYDU2L
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="264552675"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="264552675"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 22:11:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="732846343"
Received: from iweiny-server.sc.intel.com (HELO localhost) ([172.25.222.75])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 22:11:43 -0700
Date:   Sat, 30 Apr 2022 22:11:43 -0700
From:   ira.weiny@intel.com
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v4 0/4] Extend and reorganize Highmem's documentation
Message-ID: <Ym4WSstEQI7yYU0n@iweiny-server>
References: <20220428212455.892-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428212455.892-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:24:51PM +0200, Fabio M. De Francesco wrote:
> This series has the purpose to extend and reorganize Highmem's
> documentation.
> 
> This is a work in progress because some information should still be moved
> from highmem.rst to highmem.h and highmem-internal.h. Specifically I'm
> talking about moving the "how to" information to the relevant headers, as
> it as been suggested by Ira Weiny (Intel).
> 
> Also, this is a work in progress because some kdocs in highmem.h and
> highmem-internal.h should be improved.
> 
> However, I think (and hope that my thoughts are also shared by Maintainers
> and Reviewers) that this series constitues a sensible step forward
> improving Highmem's documentation, despite some important issues are not
> yet addressed.

For the series:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Changes from v1 to v2:
> 
>         1/4 - Fix typos (Mike Rapoport); re-write the description of @page
>               because the original was wrong (Ira Weiny); add Ira's and
>               Mike's tags in the commit message.
>         2/4 - Add Ira's and Mike's tags in the commit message.
>         3/4 - Rework the subject to better summarize what this patch
>               changes; merge the section which was removed from highmem.rst
>               with the kdocs of highmem.h (suggested by Ira Weiny); add
>               Ira's tag in the commit message.
>         4/4 - Reformulate a sentence that was incomprehensible due to my
>               own mistakes in copying and pasting the text of another
>               paragraph (problem noted by Ira Weiny); refer to the kdocs
>               of kmap_local_page () to show how nested mappings should be
>               handled; fix grammar error; add Ira's tag in the commit
>               message.
> 
> Changes from v2 to v3:
> 
>         1/4 - Add a deprecation notice to kunmap_atomic() for consistency
>               with the same notice in kmap_atomic() (Sebastian Andrzej
>               Siewior); shorten subject and extend commit message.
>         2/4 - No changes.
>         3/4 - No changes.
>         4/4 - Correct a technical inaccuracy about preemption disabling /
>               re-enabling in kmap_atomic() / kunmap_atomic() (Sebastian
>               Andrzej Siewior).
> 
> Changes from v3 to v4:
> 
> 	1/4 - Correct some techinal inaccuracies about the side effects
> 	      of calling kmap_atomic() and kmap_local_page() (Sebastian
> 	      Andrzej Siewior); drop "Acked-by:" and "Reviewed-by:" tags
> 	      because relevant parts of this patch have changed.
> 	2/4 - No changes.
> 	3/4 - No changes.
> 	4/4 - Shorten a couple of paragraphs by removing redundant
> 	      information (Sebastian Andrzej Siewior).
> 
> Fabio M. De Francesco (4):
>   mm/highmem: Fix kernel-doc warnings in highmem*.h
>   Documentation/vm: Include kdocs from highmem*.h into highmem.rst
>   Documentation/vm: Move "Using kmap-atomic" from highmem.rst to
>     highmem.h
>   Documentation/vm: Rework "Temporary Virtual Mappings" section
> 
>  Documentation/vm/highmem.rst     | 100 ++++++++++++++++++-------------
>  include/linux/highmem-internal.h |  18 +++++-
>  include/linux/highmem.h          |  51 ++++++++++++----
>  3 files changed, 113 insertions(+), 56 deletions(-)
> 
> -- 
> 2.34.1
> 
