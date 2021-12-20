Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81247AB35
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhLTOUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:20:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:48901 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhLTOUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:20:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="239981712"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="239981712"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 06:20:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="663625999"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 20 Dec 2021 06:20:34 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Dec 2021 16:20:33 +0200
Date:   Mon, 20 Dec 2021 16:20:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] acpi: Store the known device locations
Message-ID: <YcCRMUgpSSEhGeug@kuha.fi.intel.com>
References: <20211217132415.39726-1-heikki.krogerus@linux.intel.com>
 <20211217132415.39726-2-heikki.krogerus@linux.intel.com>
 <CAJZ5v0g9HjLr8n3OQwMY0EK5GdCc+8CJnO3mEUXom3g2sz9jXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g9HjLr8n3OQwMY0EK5GdCc+8CJnO3mEUXom3g2sz9jXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 06:01:48PM +0100, Rafael J. Wysocki wrote:
> And overall I'm wondering if this can be achieved by storing the
> pld_crc directly in struct acpi_device and doing a
> bus_for_each_dev(&acpi_bus_type, ...) walk every time a list of
> devices sharing a _PLD is needed?
> 
> It looks like typec_link_ports() is the only user of this and it can
> easily afford doing a walk like the above if I'm not mistaken.

OK. I'll try that out.

thanks,

-- 
heikki
