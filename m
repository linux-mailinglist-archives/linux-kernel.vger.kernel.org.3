Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC494A6DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbiBBJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:36:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:23217 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbiBBJg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643794587; x=1675330587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aGOR40E//2wKW+FbAQsqESY03jgYlxNctka/YDN7FLE=;
  b=EM1DF3SVoMev8MwxrfiKW/oVMBuawXrI0KBPia1CvV8scuvi+1JUipY/
   vB4ghhKll/GxAmlP2LEX9D3xgmcERmOAD2OD3hmU4nV9M2Z88d34Ij62C
   kRKx7YP9+6hD8YF8OP17eU7P/EVvxhbbMzq4D0F3Ur9Xc6hjnkyc0GzYc
   1/1WyIu7Jk7RNYDKK/Uzf7Lu3zskLBIcd/gGH2R9osfMYJglSGksuTL/Y
   DtVCs5T4yQEBaZY3OGL1zEOBwKKwFEhzXEHcpVHvKQ52YeJid2ROPg7YX
   fFrK6XKxcyQ8I735sBV7mKanGqAeD4NBQg5pplm6furxBTx6gH/TbqqTu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="235277853"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="235277853"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 01:36:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="630863516"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 01:36:23 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 02 Feb 2022 11:36:21 +0200
Date:   Wed, 2 Feb 2022 11:36:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Replace acpi_bus_get_device()
Message-ID: <YfpQlQ6CH5eoRjuD@lahna>
References: <1883502.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1883502.PYKUYFuaPT@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 08:12:30PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Let me know if you want me to pick this up.
