Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF64247BB08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhLUH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:28:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:32604 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233600AbhLUH2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640071732; x=1671607732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lFhj7QbD1YcOmcSNs4qGTtxdQG+ailgkPGCRWxFeY+w=;
  b=R9cVk/PDL7dyL/qXdSzmlN41SWLubBDTmOjenrx0vzrKUOZh4nnql4pV
   vguCA+gsaRqEkiPeSu9f6LCwbOiF/VxZpYmAjzhDkjvOvxJjvafh9Y/6G
   VLXgZsTrFKnZx1god+Y6wnCT9c8Ld97Uw/9AG+uNXcxxu2rWk9ofRkLp8
   AJH9VplHfUU9YbEjSZoNxE5HKtm8De+bzFSEBLUkOsEnw4lg3DnWYPT1o
   D/DR2rqedzbVtDD1p8cPHXZoqVDIgQon4sO1NO0pADHSHeH7svGOqiSTz
   zppIPmb8yGsMO6LQ88fjeQWvOyCthCZCj5n87rruPfLVwyM7Q0tBk4F98
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240566801"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="240566801"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:28:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="616679940"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:28:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mzZYR-000Kwq-Pf;
        Tue, 21 Dec 2021 09:27:23 +0200
Date:   Tue, 21 Dec 2021 09:27:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 1/1] ARM: orion/gpio: Get rid of unused first
 parameter in orion_gpio_init()
Message-ID: <YcGB2/+Oe7Qr1w3h@smile.fi.intel.com>
References: <20211214140656.53694-1-andriy.shevchenko@linux.intel.com>
 <Ybiu1F10qpQ3KlGT@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybiu1F10qpQ3KlGT@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 02:48:52PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 14, 2021 at 04:06:56PM +0200, Andy Shevchenko wrote:
> > The OF node pointer is always NULL, get rid of unused parameter in
> > orion_gpio_init(). As a side effect it will allow to switch GPIO
> > library to the fwnode API, as well as in case of resurrecting it here
> > it should be fwnode_handle anyways.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thank you, Russell and Andrew, now I'm wondering who can pick this up?

-- 
With Best Regards,
Andy Shevchenko


