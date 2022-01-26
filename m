Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F549CA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiAZNOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:14:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:44536 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234991AbiAZNOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643202884; x=1674738884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aTN22F5cUIH86re3kf8Brx9AzzNMtIEiqIDfUt3h+vA=;
  b=Gu9iO2qJvAg+U1FNahO5tynLziUEPbBU8+1EGD3ZCVVizqu3Ca7H+2hY
   ihagIBUaa7IxKEEu6CvRkPuUqaNBz2wqaTFgx/sEahNMdJAV6RwC5v8VT
   /n9b7KMHkcHG7VVcTfzUSQ6/tG5l+eb7bMDkBur6wVaFgDG+lZ32aiJAx
   KlxeibUQx6D+8QqXkMP7im7PuDYHZOfty/M/T7c1dPSCXWkgG+OF96oBC
   Gddg5xFlCnzpy56vzgEULntfd2/oPXqzcrxQ7+118dsC/0mP+Sl+PwEah
   Vitd5gtXwS5063yb39JTUKcZyH6tkoMNroLKsHkqwIAzNf4y2pW6Frn5h
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="230119762"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="230119762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:14:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="617959590"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:14:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCi7B-00EbZM-RD;
        Wed, 26 Jan 2022 15:13:33 +0200
Date:   Wed, 26 Jan 2022 15:13:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Message-ID: <YfFI/VAWY8HGaAkx@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de>
 <ebb9b4f4-32cd-c8a4-ed2d-e94b4759a984@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb9b4f4-32cd-c8a4-ed2d-e94b4759a984@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:31:40PM +0100, Thomas Zimmermann wrote:
> Am 26.01.22 um 12:17 schrieb Helge Deller:

...

> And none of those examples is out-ruled by DRM. In fact we do support
> devices that fall in those categories.
> 
> This is last week's discussion all over again.

Fine, write a driver or accept existing solution.
While there is no other solution, let's go with the existing.

-- 
With Best Regards,
Andy Shevchenko


