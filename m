Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A440447AA6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhLTNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:34:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:45558 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhLTNe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:34:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="239972898"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="239972898"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 05:34:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="616398051"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 05:34:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mzInA-000501-1l;
        Mon, 20 Dec 2021 15:33:28 +0200
Date:   Mon, 20 Dec 2021 15:33:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Luke D. Jones" <luke@ljones.dev>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/3] platform/x86: asus-wmi: Join string literals back
Message-ID: <YcCGJ6Ikx1fyR/Vm@smile.fi.intel.com>
References: <20211210163009.19894-1-andriy.shevchenko@linux.intel.com>
 <YcCALCOv46Y0TogB@smile.fi.intel.com>
 <e93265b9-7700-fa79-046d-70bb5ec990f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93265b9-7700-fa79-046d-70bb5ec990f1@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 02:30:20PM +0100, Hans de Goede wrote:
> On 12/20/21 14:07, Andy Shevchenko wrote:
> > On Fri, Dec 10, 2021 at 06:30:07PM +0200, Andy Shevchenko wrote:
> >> For easy grepping on debug purposes join string literals back in
> >> the messages.
> >>
> >> No functional change.
> > 
> > Hans, any comments on the series?
> 
> No comments, the series looks good to me. I plan to another round of
> merging pdx86 patches tomorrow and then I plan to pick these up too.

Thanks for good news!

-- 
With Best Regards,
Andy Shevchenko


