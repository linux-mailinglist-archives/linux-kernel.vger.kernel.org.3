Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667684A873D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351645AbiBCPGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:06:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:55933 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237438AbiBCPGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643900811; x=1675436811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kimg+WP471TxgYHSZdGgWrJTRHBz7dzY4QrTP/ooh3U=;
  b=OCWJIFRR4jday+H6NJj8nAfWe8634Md2Tp/wzApPpbUZ38ceNQls58l/
   ZDUkal7O7SbXS1lwDQicZqWKzFSnKsLFn5uRqK2ZV2rPqBxE8ARvFoqss
   NJBsKM69QsBK3DSF80kTQAhqfm+M6Jjk2t4NnO0IRW56X6WIMv5vLICsT
   6me/SdeJQpTlIVpNBcQdphZRVg4SeFdmXtbGgdkV2pjejlOt2mYn4mwTA
   A6VlifGbUR7Z9fb9UfrAYnsOKTTS6er0csRi0CG4euy2OJ0PCqjmHmupe
   LkosW+BHLDy6R8btpRaY/ltBDqSm5QMHuqx+Y0rENDwEH3hLlnJie00Ii
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248112289"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248112289"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:06:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="699336743"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:06:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFdgA-000Rxn-5I;
        Thu, 03 Feb 2022 17:05:46 +0200
Date:   Thu, 3 Feb 2022 17:05:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Allen Pais <apais@linux.microsoft.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/1] firmware: tee_bnxt: Use UUID API for exporting
 the UUID
Message-ID: <YfvvSTrSv3lv4CEE@smile.fi.intel.com>
References: <20220127160150.48140-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127160150.48140-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 06:01:50PM +0200, Andy Shevchenko wrote:
> There is export_uuid() function which exports uuid_t to the u8 array.
> Use it instead of open coding variant.
> 
> This allows to hide the uuid_t internals.

Any comments, tags? Can it be accepted now?

-- 
With Best Regards,
Andy Shevchenko


