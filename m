Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6730E47C0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhLUNcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:32:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:25104 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhLUNcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640093573; x=1671629573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEuJ2PuemPrnmcu2w9PXAA6A8k1T5UjeeafKu5mrQfc=;
  b=fMj9KD9DORQsgmnFlguu4lbU7jZlrjFneV3ZqR8Wy8yLsH7YPtbIoIyv
   FuEngKybpAR5UZWZxx2cL5xzpqhZDckT0imkoksLbUlOyZex/eREhf4in
   /pLo1ZFpG0qVDCqwryiw7RltWTCul5lNJoqz00tVtKvL/JhPr48RwlAT/
   uf3Apy6/bFHENqKZ5SBGX8Qb0DLl/BVlWswt1Mthkx+qPe7HQUR6yqJOQ
   HuQxlTde+SnMIvcbY7LSZcU+mt+j16a6cBarzmCWft9wIjvAFLcV788d0
   /0Nk+uhTQ5qxrLXLW7IfRtqQQDaqzAEPM231pcN2qJ2MpJAkF8AAyOT5j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="301161499"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="301161499"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 05:32:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="755810858"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 05:32:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mzfEj-000Reh-Ed;
        Tue, 21 Dec 2021 15:31:25 +0200
Date:   Tue, 21 Dec 2021 15:31:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] software node: Update MAINTAINERS data base
Message-ID: <YcHXLZwTfNEwC/9S@smile.fi.intel.com>
References: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
 <YcHAkuyML0VLjxP/@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcHAkuyML0VLjxP/@valkosipuli.retiisi.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 01:54:58PM +0200, Sakari Ailus wrote:
> On Tue, Dec 21, 2021 at 09:14:09AM +0200, Andy Shevchenko wrote:

> > +R:	Daniel Scally <djrscally@gmail.com>
> 
> I wouldn't mind being added as reviewer, too. :-)

NP, I have just sent a v2 with your name included.

-- 
With Best Regards,
Andy Shevchenko


