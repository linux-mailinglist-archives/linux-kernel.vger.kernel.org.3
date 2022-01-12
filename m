Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5448BEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351160AbiALHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:14:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:16257 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237258AbiALHOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641971664; x=1673507664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KImqBKuOjo0bMNhC5UltBgHJjAqo/NyCnF+G2kC8Tp0=;
  b=X4DEMWJ9vSwAaLj5e6M6v8qt51qgYhq59DIM4/WwH50Mr5e8Y5hLTdcO
   zduPtFLZ+rFPWPwEjvoC999FmEmdswcAAZ+NrUyNAQXPVO/s+vVi2mX/a
   5/cbDfDMOgXH4cRiYPpHS2J5LV5gApxUzra04STPiX8OgLoNPcNSlC+En
   hpQN0+xDzrNOSA+6svhmeQvSlDR1a8UenQ+9DDWUKGkaTsC8HNJadj2wR
   ZJWReXbZcRzmhKU3MgDJH6tEnxWz3lTQC+wn5FLi9Wyrkr8XPH6pBhtZj
   OiCRPNWVRv8oSZY90by/9LLYSq6nQ6ivQbSF+ECZoqsRXYV5LYTuPZyn8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="304414375"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="304414375"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 23:14:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="623345730"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 23:14:22 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Jan 2022 09:14:19 +0200
Date:   Wed, 12 Jan 2022 09:14:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/3] ACPI: scan: acpi_scan_init() updates
Message-ID: <Yd5/y4uQtMOOmXYq@lahna>
References: <11903300.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11903300.O9o76ZdvQC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 05:45:23PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> There are some minor defects in acpi_scan_init() and because recent changes
> cause static checkers to catch them, it is better to address them right away.

Looks good to me :)

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
