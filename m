Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2F4A72B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiBBOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:09:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:13379 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbiBBOJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643810963; x=1675346963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RRwV3oIvnozFrFibpyO8I95VWXndE72lqKzEOL6Ppk8=;
  b=fpCQZmpKWlC2q5VUYNUZARqQCal13FqgdWeMcWMwZe51/yYcyPaJ5IZM
   F6zrgMbpp7GEUFGWvg+Aj+bhVjKZUeEoV3hwG21p+F9a82MUUxPIpGZ5T
   aBMAz0reJ85lVqujvYi1SDNkyJ/WMQwI+whuqEgTWtsUDQ11WbnnTQNaz
   ZFDCdprTlLqVZ6nfgrVVEFBXPfPilZyLSQb+GGoib1BsCauH2vUc19ooT
   7byGBmKRQICabLuPtEx4TSy6gtcI429cuCNJ++xr/5O++fX419jb+ch72
   jMLLPBdrZOvwE1r8AF7b4I/6hXewusAqeXIw2KKXxdwFBhnOKEH0BhYfY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="272406351"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="272406351"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 06:09:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="627078979"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 06:09:19 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 02 Feb 2022 16:09:17 +0200
Date:   Wed, 2 Feb 2022 16:09:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Replace acpi_bus_get_device()
Message-ID: <YfqQjS5HBUCW6Tfn@lahna>
References: <1883502.PYKUYFuaPT@kreacher>
 <YfpQlQ6CH5eoRjuD@lahna>
 <CAJZ5v0ifQJ=XxXHUSnACzd2cTLRB+ncwEFrwLP0ybuivX2ORAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ifQJ=XxXHUSnACzd2cTLRB+ncwEFrwLP0ybuivX2ORAg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:46:26PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 2, 2022 at 10:36 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Tue, Feb 01, 2022 at 08:12:30PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Replace acpi_bus_get_device() that is going to be dropped with
> > > acpi_fetch_acpi_dev().
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Let me know if you want me to pick this up.
> 
> Yes, please, if you can.

Applied to thunderbolt.git/next, thanks!
