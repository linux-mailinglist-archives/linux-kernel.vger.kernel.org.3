Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F546D0F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhLHK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:29:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:9955 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231583AbhLHK3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:29:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="261879074"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="261879074"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:26:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="600591195"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:26:16 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 08 Dec 2021 12:26:13 +0200
Date:   Wed, 8 Dec 2021 12:26:13 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rajmohan Mani <rajmohan.mani@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v1 1/1] thunderbolt: Do not dereference fwnode in struct
 device
Message-ID: <YbCIRdUl6mhCQ3je@lahna>
References: <20211207154143.11477-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207154143.11477-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:41:43PM +0200, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific dev_fwnode() API for that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This version is fine. Applied to thunderbolt.git/next, thanks!
