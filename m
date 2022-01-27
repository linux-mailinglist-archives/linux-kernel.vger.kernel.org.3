Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E649E98A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiA0R6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:58:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:31766 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245069AbiA0R4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306164; x=1674842164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VjGGxTzCVF41Hl7cJRMdJ6bVgo2yimWqvnjX5qwuRt4=;
  b=f6Chi3tm+lDBnNQkjg1ph41TXPn75LZ81rZzttup0IPAl84qxn5Hrck3
   WtO4SnWZDXne5HoQOKFqE1eSne14LAt968+Fc0ji15eWJf1LRjkkGg6m9
   tFON+PCId4O9ScmSiIhIszWPn58RmVt0iPoR9QboCjFh2aHnh3I1nOPa2
   OyM8U5KvdVzBggW1hXcFUnSHjPgwjguS+WikenX/v8qRaR1aqi8d2B3tZ
   y+K2BcU2GXP0toS7mDxfYEx6hBvzEHQDsZEqygJU3O62dknk4e6/oLCjn
   cRqwQHI+poy2TBwpQZfbXIlhSHyhj/pMvGtelRmgk9xHed4pov+m4I4qA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230500304"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="230500304"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:56:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="696743411"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:56:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nD8z3-00F4xt-5O;
        Thu, 27 Jan 2022 19:54:57 +0200
Date:   Thu, 27 Jan 2022 19:54:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v2 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <YfLccEk2PKpWH4eX@smile.fi.intel.com>
References: <20220127163258.48482-1-andriy.shevchenko@linux.intel.com>
 <1e2e99f6-e9bf-7d93-9629-3d70275c77f4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2e99f6-e9bf-7d93-9629-3d70275c77f4@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:21:21AM -0800, Randy Dunlap wrote:
> On 1/27/22 08:32, Andy Shevchenko wrote:

...

> > -Reported-by tag.
> > +Reported-by tag. The tag is intended for bugs; please do not use it to credit
> > +feature requests.
> 
> LGTM.
> Although it could refer to Suggested-by.  :)

The main issue here is that automated CIs may suggest people to include the tag.
And people (especially who are new in the community) tend to obey without a
doubt.

> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


