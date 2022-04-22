Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFBC50C1C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiDVV5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiDVV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:57:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A157169E68;
        Fri, 22 Apr 2022 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650659994; x=1682195994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bf6kesfiGQW5FTsQbo0yY/hK5dAOEbAhAQZQcC1Uv1E=;
  b=EbEYr5fkfhrPtbisIHny/e0c2oCYiHESVOJvzmQH7qXUR+WuFGOTESfA
   p10snCFGQAN7/3rTZjJ/XKM0yWLBP/oerV0gIgWqGNVoJVk4XPwjxQh3W
   DtOS7O/puL3hGH1hEy0XTkydMN2Rqt6oVWscqiPx8rfEL/QZ224nkJ+DZ
   vz/P2QQkq8ZfmrQ8HgakTfGTkb2wNLGPeWLQz5aVnEd7ak0+58XNAuKee
   Hm26N1v1zC6G7s80I0piLWnhBQ1jhAhPSLVHb2d6el2il8QYtGU/GBQ5I
   SQxWH7CtE1DedChRzHytlAxE+UkX2WwB9XdWw1PncVJ643gfSgWBhOmhZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325200937"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="325200937"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 11:09:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="867993856"
Received: from hltravis-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.166.215])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 11:09:28 -0700
Date:   Fri, 22 Apr 2022 11:09:28 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] Documentation/vm: Include kdocs from highmem*.h into
 highmem.rst
Message-ID: <YmLvWE7vUduaXZVY@iweiny-desk3>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
 <20220421180200.16901-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421180200.16901-3-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:01:58PM +0200, Fabio M. De Francesco wrote:
> kernel-docs that are in include/linux/highmem.h and in
> include/linux/highmem-internal.h should be included in highmem.rst.
> 
> Use kdocs directives to include the above-mentioned comments into
> highmem.rst.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  Documentation/vm/highmem.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> index 0f69a9fec34d..ccff08a8211d 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -145,3 +145,10 @@ The general recommendation is that you don't use more than 8GiB on a 32-bit
>  machine - although more might work for you and your workload, you're pretty
>  much on your own - don't expect kernel developers to really care much if things
>  come apart.
> +
> +
> +Functions
> +=========
> +
> +.. kernel-doc:: include/linux/highmem.h
> +.. kernel-doc:: include/linux/highmem-internal.h
> -- 
> 2.34.1
> 
