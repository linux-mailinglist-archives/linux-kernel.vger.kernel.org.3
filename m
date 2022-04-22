Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887350B2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445538AbiDVIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444991AbiDVIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:36:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F452E6B;
        Fri, 22 Apr 2022 01:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A59BB82AF4;
        Fri, 22 Apr 2022 08:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F946C385A0;
        Fri, 22 Apr 2022 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650616414;
        bh=yNlnwq4VGj4ovbztu0mv7SuTxiT88c0qHz3zb371ldg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYlf8x/mdnucvGuXZN6ArR7FFewm8gzrqGZ3JDxqlCqQJtPS1mpykFR4dmK6ItsAY
         Jc2tdnimggR3AdqupLSKFcT+NgwAe+vmh3erSJhIrdkPzoTRiQdcKpALXmJPc69ZoW
         QywltPs9XOTZEKZXRy7eVMqlCiM/bHvOfhVA6P/A4o2ZQllCSojRqxg8gIpGdZTAAK
         oB7tzaVIp6pRiHTApINlPZKjyvr43EiI59ftJ+HQKdNKG+Fe757oonvJ2EbIrPzY1N
         2KZccrGvHLHVAxse/DjmA0xQjGtZuNgw0JFsbjU2ykg2grQK8lN/XytNAjjs4PR7fW
         uLkiUIZlo+iAQ==
Date:   Fri, 22 Apr 2022 11:33:25 +0300
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
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] Documentation/vm: Include kdocs from highmem*.h into
 highmem.rst
Message-ID: <YmJoVeGdJxVedUnQ@kernel.org>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
 <20220421180200.16901-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421180200.16901-3-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

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
> 

-- 
Sincerely yours,
Mike.
