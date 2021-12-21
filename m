Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB98A47BCBA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhLUJSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:18:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:48796 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236300AbhLUJS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640078306; x=1671614306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UJT/zIE7nM+C+Co4agHm2XJooaDgVDkG1DuXmrE90LE=;
  b=kKyUzbpDyK7pvv6sOZBWCWLYsKeXiEDNPYLQ/hjEhAEY02HPfV5z4HPo
   o0QOCAWgHSOZxyuK61ODgfC2YgtfJpPRrohF9CpIaX6oecer97DDJV8ID
   GQpYu/8PnKNUY35JVHSqM5l3f91WSTC+bjTAIbFTRNPYn+yEKnoH1jJlO
   s7Xj+CoO2JKaghZPHuuU7wjonC4vtFwnxvDL9L0olV87HRw/KSRwImUs+
   ZhcTCYk1jLVUJDTt1IALBq5+AkExlV1vvYDmirUxnDl2f5ZowSZqY0c97
   Dd0PjwoXu3MMRpwwgtytfbFZ+IARwi81pbqojBsswX6GiusPrf4AW9S/8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227651902"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="227651902"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 01:18:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684601384"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 01:18:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mzbGT-000OLW-Hl;
        Tue, 21 Dec 2021 11:16:57 +0200
Date:   Tue, 21 Dec 2021 11:16:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] software node: Update MAINTAINERS data base
Message-ID: <YcGbidqy+rgiY1vf@smile.fi.intel.com>
References: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
 <35944dfd-a20a-f67b-5d34-a0e0a4cb7066@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35944dfd-a20a-f67b-5d34-a0e0a4cb7066@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:15:30AM +0000, Daniel Scally wrote:
> Morning
> 
> On 21/12/2021 07:14, Andy Shevchenko wrote:
> > There are two updates to the MAINTAINERS regarding to software node API:
> > - add Dan Scally to be designated reviewer
> > - add rather tightly related device property files to the list
> > - adjust section name accordingly
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > Based on the latest Dan's involvement and amount of patches seen recently
> > I went ahead and added his name to the list. Dan, please tell me if it's
> > not appropriate.
> 
> This is fine by me - I don't know if you need a tag from me for this but
> feel free to add whichever's appropriate

Yep, please give a formal tag (usually Acked-by in this kind of cases).


-- 
With Best Regards,
Andy Shevchenko


