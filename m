Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3672A48522D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiAEL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:59:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:62501 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239934AbiAEL7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641383962; x=1672919962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TZfIRrbR5PhA84dMm4UcecUL18+/HRVZeAo6C5IaEJ0=;
  b=QeGg4FJzr4ix0S3cBSFLZybRKaCWpxFnlslb2xXEtsRAASbw06xQf2bf
   Iq8OW+PgzeKiKErl8hRaxrkps57dbkDyCHpdjx3Zwei8fg1t85ZdaTV+L
   AepCiy2rCs36g1jAGoO543UUfhoeWFlgkgSfdooWJlBUW85UDTMvhtBoE
   x/JbDQrRQn0HyIIsQLtjrIkfin8fh8E4cACbxFD2LjwV6nyoPSL+A0AsR
   jjR5FuH7bgAXSeK1CmwlVcdRnhgCr0d3iq1vt0NsWQEJOayxjQs9cBY0m
   8XXKlQNsSHhRGvt/9l1dcOmrBKPRVezIOkSVjqVU2JbReW2OkDk5QVxsw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229742570"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="229742570"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 03:59:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="574365292"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 03:59:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n54vL-006gHd-OV;
        Wed, 05 Jan 2022 13:57:47 +0200
Date:   Wed, 5 Jan 2022 13:57:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS: Update information about printk git tree
Message-ID: <YdWHu6vpOWe4+2Gb@smile.fi.intel.com>
References: <20220105094157.26216-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105094157.26216-1-pmladek@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 10:41:55AM +0100, Petr Mladek wrote:
> I have noticed one outdated and one missing link to the printk git tree.
> I am not sure if it is worth sending for review and having two patches.
> I just want to avoid possible complains ;-)

FWIW,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Petr Mladek (2):
>   MAINTAINERS/vsprintf: Update link to printk git tree
>   MAINTAIERS/printk: Add link to printk git
> 
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


