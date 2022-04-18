Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFBB505F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiDRVjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDRVja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:39:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6522E9FB;
        Mon, 18 Apr 2022 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650317810; x=1681853810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eEJGoHVsFofaV6UR/94SRICq/E+Aa7hOKpo5pnC+TWg=;
  b=OPq384zsCazXPpiowFRt49lJQYMQrk4oNsoezfiue+1L7H8rzsRhGHA1
   mWeGwg5KWCUHiEVZA4C3Hzzmg9apXXW6vZe2YtkwY4LqEDH13QSq4QzoP
   NHgrvRYqALkgDk/+n3OCRRF27svnwVtOzWOvIfhWRGm+WMYNJG0qCwiJu
   kKmCsVIzAxl5Jqec6YqYs9cUtvJCQ2N48uTZh3xgUswtCOTlvW6QXj7j/
   rgJHp3wQsdgDBPm7GPkptIAQHXmAV4uM+7ldVDLX/Z+FymYfSXbe8gAj/
   POw70d3r6REzJhaJJvP17Pg9RVlLV4bcFV/m1csKuX8BVPum95WEt/PFr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250918424"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="250918424"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:36:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="804432221"
Received: from moseshab-mobl1.amr.corp.intel.com (HELO localhost) ([10.209.143.127])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:36:49 -0700
Date:   Mon, 18 Apr 2022 14:36:49 -0700
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
Subject: Re: [PATCH] Documentation/vm: Include kernel-doc from
 highmem-internal.h
Message-ID: <Yl3Z8Qll+zGo4v/D@iweiny-desk3>
References: <20220418081740.21001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418081740.21001-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 10:17:40AM +0200, Fabio M. De Francesco wrote:
> In Documentation/vm/highmem.rst the kernel-doc comments are missing,
> therefore kunmap_local() and kunmap_atomic() are yet undocumented.
> 
> Add a kernel-doc directive to include the above-mentioned kernel-doc
> comments in highmem.rst.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

I thought I saw a patch fly by which changed the comment of kunmap_atomic() in
include/linux/highmem-internal.h?  Did I miss that somewhere?

This is a good inclusion for now.  However, I think I would rather see this as
part of a new series which puts the bulk of the documentation with the code as
I proposed in patch 1/2 in your other series.

For this particular change:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> This patch must be applied and built on top of 
> "[PATCH v3 2/2] Documentation/vm: Include kernel-doc to highmem.rst"
> https://lore.kernel.org/lkml/20220415231917.25962-3-fmdefrancesco@gmail.com/
> 
>  Documentation/vm/highmem.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> index 5dcee6233cd5..1a3e6a8f5d3e 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -161,3 +161,4 @@ Functions
>  =========
>  
>  .. kernel-doc:: include/linux/highmem.h
> +.. kernel-doc:: include/linux/highmem-internal.h
> -- 
> 2.34.1
> 
