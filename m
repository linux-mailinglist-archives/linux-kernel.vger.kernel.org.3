Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC84A9BF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359714AbiBDP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:28:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:22990 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbiBDP2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643988535; x=1675524535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6nti2nHnDlfeNj5M881WSjbE9zNMRtxl0v0M1zZMQE=;
  b=nHtjUfNyaM9kKPbxLrynhOtS8ONoRbiUkEr133uLvZ+j9pbrJ2EoBtuF
   fNbfk4+Vb+O2rL9jsfl9OBKI5l5tWhDHxNFpydMGgpPipNNOhVi93qhlz
   WLWNs/cshNzl0p9kCmVcQ1UGOqRp5mOHNkpoLsVXaIuP4yUxq5DbtlOMb
   z2HBnk8Brkp2H+Xdi3IoPULPtCvkz+6C2ZdNM0xcESifbV8aljWARZc7L
   tSblPjmFaZv+GwXxymu/2s1i05j4E68CzpOC474yC7yPYclDPlDZHSmq4
   RnGSBrnmnCgZAHL+bk9tTxp1Ye6bn+uYrsEMYF4wfNz0qdlkJdBOTPlNP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309129693"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="309129693"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:28:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="498507760"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:28:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nG0V7-000xv6-7l;
        Fri, 04 Feb 2022 17:27:53 +0200
Date:   Fri, 4 Feb 2022 17:27:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tty: Drop duplicate NULL check in TTY port
 functions
Message-ID: <Yf1F+R8YZ+Lg7Xw8@smile.fi.intel.com>
References: <20220202165704.5680-1-andriy.shevchenko@linux.intel.com>
 <37e31d03-eee6-7052-fe32-1f37f1b460e1@kernel.org>
 <YfuxANmSQDfIQZO4@smile.fi.intel.com>
 <Yf07R9xdUtmcHU7m@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf07R9xdUtmcHU7m@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:42:15PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 03, 2022 at 12:40:00PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 03, 2022 at 09:36:55AM +0100, Jiri Slaby wrote:
> > > On 02. 02. 22, 17:57, Andy Shevchenko wrote:

...

> > > > Note, INIT_KFIFO() is safe without that check, because it's aware of kfifo PTR
> > > > versus embedded kfifo.
> > > 
> > > Not sure what you mean here ^^^? But it might be one of the morning brain
> > > parser errors.
> > 
> > Or maybe my evening weren't working...
> > 
> > Actually INIT_KFIFO() can be outside of that check from day 1 because it
> > operates on a separate member and does not rely on the FIFO itself to be
> > allocated.
> > 
> > I tried to explain that, while kfifo allocation goes together with buffer,
> > there is no dependency to any of those allocations.
> 
> Can you rewrite the changelog to say this?

Sure!

-- 
With Best Regards,
Andy Shevchenko


