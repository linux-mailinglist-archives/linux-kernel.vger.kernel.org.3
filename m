Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9054C52DF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbiESVQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiESVQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:16:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9326A009;
        Thu, 19 May 2022 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652995008; x=1684531008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xO5sYrwPLYvDvNwBmDE02zb9y09MFDW+vVwtKqnVbS8=;
  b=UaAUp5zEBNxaFzs87a7mievkkzWbqNP7OF2aW4ZzMmj36SfeigehrIvy
   WhrNm8caZ3VBgr8qLTW3wih+7xELRMVXfK5mYUzP4tZUwjN4Q+L0mCuXy
   ALUVVYdWa793rCGZs4IUOIEBKbHB6eJR9HdpfvW8S/eIlZ82yX9WP+z7B
   Jd8HxO0wtGcE+p0gahROIt95+CiY26jc6Z+U+tGY4UmOmM1RF65zWgoYA
   yOlhnXky4GHNEFJz0atgcObfMEKm8Am5s4fhqOCEXmpiejhbzRqfnmwqM
   qWbnXSpwtjVY1k1FnWMM0criCxNjwKMkZHlKxQVqVmro/A8DseVVJi4Kt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259959399"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="259959399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:16:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="524292762"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:16:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nrnVh-000GI8-MB;
        Fri, 20 May 2022 00:16:41 +0300
Date:   Fri, 20 May 2022 00:16:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        willy@infradead.org
Subject: Re: [PATCH v2 07/28] lib/printbuf: Unit specifiers
Message-ID: <YoazuWvIU63zNGJr@smile.fi.intel.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-8-kent.overstreet@gmail.com>
 <Yoam1bW/vni3srLc@smile.fi.intel.com>
 <20220519202626.3x3kyqs3jttel7u4@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519202626.3x3kyqs3jttel7u4@moria.home.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:26:26PM -0400, Kent Overstreet wrote:
> On Thu, May 19, 2022 at 11:21:41PM +0300, Andy Shevchenko wrote:
> > On Thu, May 19, 2022 at 01:24:00PM -0400, Kent Overstreet wrote:

...

> > > +	if (v < 0)
> > > +		pr_char(buf, '-');
> > > +	pr_human_readable_u64(buf, abs(v));
> > 
> > Wouldn't -v work?
> 
> This is a bit terser

Have you checked assembly? Basically the question here is does the compiler see
the same conditional and avoid duplicating it?

...

> > > + * pr_human_readable_u64 - Print out a u64 according to printbuf unit options
> > 
> > Have you ever compile this? We have kernel doc validator running when compiling
> > the code...
> 
> Yes I have, but I've never seen the kernel doc validator - can you point me to
> something so I can get that working?

I run `make W=1`, but I think the kernel doc validator is run anyway.

You always can run it manually

	scripts/kernel-doc -v -none lib/printbuf.c

-- 
With Best Regards,
Andy Shevchenko


