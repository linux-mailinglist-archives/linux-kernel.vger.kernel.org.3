Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A0484506
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiADPou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:44:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:10256 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233957AbiADPot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641311089; x=1672847089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I6lsDsclC6uxxN63s5a0QcBsBGF9UunWICe3B08VBgw=;
  b=D6dS1Zv2vgx39VJ5Y/oRbeIS/jeBQ/gxUm7jdiqps9q6lLDiUxgN37/f
   w6yuagG801zZCWWxhGW2IL2SwOcGIlr4eYaHf5ZCopn8KPcT1y2vkuhze
   9HXEvZhAO9ybf+eBvOx/usbOW3SwhXNsrum8Y60naAfkCp4PyDtA73dWK
   WLK4XDsYrOsu1JJJhfyI0IOq8ovfuNz9x3yehhkD/26DwBNYgS/NnY1Vb
   t8yMDkSfmP5yNhqDIHcdy4EHywnxEtZJ12VovC78IXVXgSwY8oCs8oCm+
   KB6YHS6IFYmGF0JrS0gIdUrFaR8wCUddoONvqEUU5BzanaQDnkrFNwOAQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229559460"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229559460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:44:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="574061951"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:44:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n4ly9-006GNe-LN;
        Tue, 04 Jan 2022 17:43:25 +0200
Date:   Tue, 4 Jan 2022 17:43:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 1/1] software node: Update MAINTAINERS data base
Message-ID: <YdRrHRXYt5/8tAv1@smile.fi.intel.com>
References: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
 <YcHHB82r7qT/yJmg@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcHHB82r7qT/yJmg@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:22:31PM +0200, Heikki Krogerus wrote:
> On Tue, Dec 21, 2021 at 09:14:09AM +0200, Andy Shevchenko wrote:
> > There are two updates to the MAINTAINERS regarding to software node API:
> > - add Dan Scally to be designated reviewer
> > - add rather tightly related device property files to the list
> > - adjust section name accordingly
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Another way would be to have a separate entry for the unified device
> property API, and that could then have you (Andy), Sakari and Daniel
> as the reviers. I don't think I have much to say about those parts -
> I'm only interested in the software nodes. But it's up to you. FWIW:

Currently property.h shares information that is highly used by swnode.c.
I believe the current variant describes the state of affairs as is.

> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


