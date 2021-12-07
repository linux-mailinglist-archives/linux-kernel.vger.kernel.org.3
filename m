Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621D846BA1A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhLGLd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:33:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:17459 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230496AbhLGLd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:33:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218241477"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="218241477"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 03:30:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="515515292"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 03:30:22 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 07 Dec 2021 13:30:20 +0200
Date:   Tue, 7 Dec 2021 13:30:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 0/2] ACPI: scan: Introduce a replacement for
 acpi_bus_get_device()
Message-ID: <Ya9FzEgjmMDvKEFr@lahna>
References: <2828957.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2828957.e9J7NaK4W3@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:34:58PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> Because acpi_bus_get_device() turned out to be problematic in the past, it has
> been changed to the point that its calling convention doesn't make much sense
> any more (ie. the pointer passed to it as the second argument is cleared on
> errors and it can only return one error value if that pointer is nonzero, so
> there is some duplication of information in there) and it has to make redundant
> checks.
> 
> Moreover, its name suggests some kind of reference counting which really isn't
> the case.
> 
> Thus patch [1/2] introduces a replacement for it, called acpi_fetch_acpi_dev(),
> and makes the code in scan.c use it instead of acpi_bus_get_device() internally.
> 
> Patch [2/2] updates all of the callers of acpi_bus_get_device() within the ACPI
> subsystem to use the replacement (which involves fixing a couple of bugs related
> to that).

Makes perfect sense!

For the series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
