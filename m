Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C643484485
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiADP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:27:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:8859 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbiADP14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641310076; x=1672846076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=slqc+GZKvR4BwvK+tcSNwUuglkJ5OqLCdfP9vfTJWpM=;
  b=IEincwQx2we5npoQD8k4fPPbg/J0insyrUMIdHR4pf4xo4EXiDmNTtbF
   BVegL1NIvp/xNc3fr0KfyWaoZVyRyrMm6F1OTod2S9JkEplJEY2ae6V4U
   119nI9pQINECbcy5w8w1S62TbR1qfS2kltY0lnfDpTtwXWmoQYgou9hb/
   jU6v3tT5BrLx8g+hSzR/iE0GHspO4PX7FtjceEBbxCYWznw32+7bX4QC0
   OL8JgM6jctJI0HYHRA7tpElmT7uhRGfzKMoZLjVIvt4lzZ+GuFOTcX+uM
   OWO/pfYprOmyvdXwJSVZpYhNZMsXwy+aRNVVplT+sSMQqP+m/EyUuS+dA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229556293"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229556293"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:27:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="760464912"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:27:51 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 04 Jan 2022 17:27:48 +0200
Date:   Tue, 4 Jan 2022 17:27:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: Re: [PATCH v1 5/5] thunderbolt: Drop duplicate NULL checks around
 nvmem_unregister()
Message-ID: <YdRndPUqeOfCqQgo@lahna>
References: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
 <20220104133843.44272-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104133843.44272-5-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:38:43PM +0200, Andy Shevchenko wrote:
> Since nvmem_unregister() checks for NULL, no need to repeat in
> the caller. Drop duplicate NULL checks.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
