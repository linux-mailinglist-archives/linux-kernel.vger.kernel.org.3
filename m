Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F37477051
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhLPLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:32:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:33393 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhLPLcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:32:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="302845033"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="302845033"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:32:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="466011230"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:32:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mxozM-0070yW-Kp;
        Thu, 16 Dec 2021 13:31:56 +0200
Date:   Thu, 16 Dec 2021 13:31:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] uuid: Discourage people from using UAPI header in
 new code
Message-ID: <YbsjrK1qSt/Bz+mB@smile.fi.intel.com>
References: <20211213203507.54157-1-andriy.shevchenko@linux.intel.com>
 <20211216083213.GA24815@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216083213.GA24815@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 09:32:13AM +0100, Christoph Hellwig wrote:
> Both patches looks good to me:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 
> Given that the uuid tree isn't in linux-next anymore due to inactivity,
> can you send them to Andrew for inclusion in -mm with my ACK?

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko


