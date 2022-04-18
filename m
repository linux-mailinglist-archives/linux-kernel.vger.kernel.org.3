Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49194505F60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiDRVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDRVel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:34:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0782C101;
        Mon, 18 Apr 2022 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650317521; x=1681853521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pWZo464sUxiW05q7McGFoy+T3hUzXkIV8S9hvGadCbk=;
  b=V7My+BMPtmG7izUc61BcR9XgyEbOotD4ogXJUIlBnwqRZkBe3SZVFlqk
   RDl90inmGS9xSw/9Fu2bMq1DuU/D9bFsUCMQvbw2WnbfR/sLDJXOJ/2nh
   /vS8P036O1X0aE2i+cMe8vMTOnAbsuDhPB3Pj6S7Tq/URphulJ7lXEnHs
   YzzHmTHzoSnGBA34diZsTuMbi7zEzFbuH0WWCwMBOtpAR4R1i7tHtaOcq
   cm2DEY6HtcIPlZPumbMl9atXJJTmeTD/GD/vB42xL7O3YPtp2WSJbSNFW
   G1mrbhX98QR6UR1NddosBRgqSIF/69/v29vRNKTx8YUH+iuXZsss06TGJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250917657"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="250917657"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:32:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="804431077"
Received: from moseshab-mobl1.amr.corp.intel.com (HELO localhost) ([10.209.143.127])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:32:00 -0700
Date:   Mon, 18 Apr 2022 14:32:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Documentation/vm: Include kernel-doc to
 highmem.rst
Message-ID: <Yl3Y0F/WT5xKoJCt@iweiny-desk3>
References: <20220415231917.25962-1-fmdefrancesco@gmail.com>
 <20220415231917.25962-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415231917.25962-3-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 01:19:17AM +0200, Fabio M. De Francesco wrote:
> Include kernel-doc comments to highmem.rst from
> include/kernel/highmem.h.
> 
> From now on, the "Using kmap_atomic" section is redundant and obsolete,
> therefore remove it.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  Documentation/vm/highmem.rst | 41 ++++++------------------------------
>  1 file changed, 6 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> index 12dcfbee094d..5dcee6233cd5 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -117,41 +117,6 @@ The kernel contains several ways of creating temporary mappings:
>    synchronization to unmap.
>  
>  
> -Using kmap_atomic
> -=================
> -
> -When and where to use kmap_atomic() is straightforward.  It is used when code
> -wants to access the contents of a page that might be allocated from high memory
> -(see __GFP_HIGHMEM), for example a page in the pagecache.  The API has two
> -functions, and they can be used in a manner similar to the following::
> -
> -	/* Find the page of interest. */
> -	struct page *page = find_get_page(mapping, offset);
> -
> -	/* Gain access to the contents of that page. */
> -	void *vaddr = kmap_atomic(page);
> -
> -	/* Do something to the contents of that page. */
> -	memset(vaddr, 0, PAGE_SIZE);
> -
> -	/* Unmap that page. */
> -	kunmap_atomic(vaddr);
> -
> -Note that the kunmap_atomic() call takes the result of the kmap_atomic() call
> -not the argument.
> -
> -If you need to map two pages because you want to copy from one page to
> -another you need to keep the kmap_atomic calls strictly nested, like::
> -
> -	vaddr1 = kmap_atomic(page1);
> -	vaddr2 = kmap_atomic(page2);
> -
> -	memcpy(vaddr1, vaddr2, PAGE_SIZE);
> -
> -	kunmap_atomic(vaddr2);
> -	kunmap_atomic(vaddr1);
> -
> -
>  Cost of Temporary Mappings
>  ==========================
>  
> @@ -190,3 +155,9 @@ The general recommendation is that you don't use more than 8GiB on a 32-bit
>  machine - although more might work for you and your workload, you're pretty
>  much on your own - don't expect kernel developers to really care much if things
>  come apart.
> +
> +
> +Functions
> +=========
> +
> +.. kernel-doc:: include/linux/highmem.h
> -- 
> 2.34.1
> 
