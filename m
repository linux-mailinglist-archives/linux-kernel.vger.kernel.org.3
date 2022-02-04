Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849F84A96FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357486AbiBDJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:41:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:37021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235827AbiBDJly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643967714; x=1675503714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zyAkA0z3hPV88z/IUZ/J6pW73hLdSGbtFR19wWtnHFs=;
  b=L8U+ABqyVanAxHWGTBVSXmbZT81M9p3uAuNeKlP/XxsQimDx063qM5aJ
   rLkpVjZTlVj+c6eXry+/Q7gk6xeqSdNbYtUnrCJcA5CHPHvf8za1+50w5
   xWV71gNUquhezNI0XwgOwHeeoIjoct14woMPUFxVUhbnmgVco1o6nQW2H
   FwjUlI/wXmnMO6m8S4INm9J1qTOsRQ3yIVYnWWUZVZDLG6PrIIqBFK8BC
   4qxvZbfPFqwW2iqLbbWrqzQvZpbxDGxxtJFTU1lFWx5iJKMBVTjG4QnyI
   fqTZtrmHFyVWsdZYUHtNPnQINpreJWQiFG477jOZM2Wz3mT4f+ou3KwO8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248554431"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="248554431"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 01:41:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="539111341"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 01:41:51 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 8BE4B20287;
        Fri,  4 Feb 2022 11:41:19 +0200 (EET)
Date:   Fri, 4 Feb 2022 11:41:19 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Don't split fwnode_get_irq*()
 APIs in the code
Message-ID: <Yfz0v7oqDkgfZyky@paasikivi.fi.intel.com>
References: <20220203125613.1166-1-andriy.shevchenko@linux.intel.com>
 <Yfzkm1CVNNRqHzd7@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfzkm1CVNNRqHzd7@paasikivi.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 10:32:27AM +0200, Sakari Ailus wrote:
> I'd prefer to prepend this patch to the rest of the set I have and get it
> all merged through linux-pm tree, on the dependent patch reaches it.

I rebased mine on this patch and I was quite surprised to see it doesn't
conflict! So either way works fine for me.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
