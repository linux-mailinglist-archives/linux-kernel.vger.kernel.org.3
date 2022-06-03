Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA58B53C7BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbiFCJjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243124AbiFCJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:39:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE63A712;
        Fri,  3 Jun 2022 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654249188; x=1685785188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vqMXlmZfQ3bWlHijNyQGJlwWJfb0ElLn2riu4A3k+Rc=;
  b=kVQZC4h7xNOmV2PfbxYSyJUA7LgwzDv0VNn6Hl4ioM1mYIrqJusVdISv
   /u+f5mDvI95iMD7JMIiWkR5zz4bCpq/svcXblR1M5WkI7EG/ZEPLm+5Y+
   HSjpMQxG9uEFYsdG3erDZSDqZMSSg5EUlXCBllJtJTk2VLEr2xvMMW/B1
   E8uOitkLT8r6W2MoIMKLGaJ3zYKi+SQddxutvQZ5vw1qASZBmXPVmNvcc
   FM0v4P5KtsP7FOYTM7c5GBnAU4H4uj+sLUZhHMj7/GbbTrKHKYC9GuyBF
   VdRwxNWF2+JKdHYKEPBOBWxrImcRNNZ9bouzKTqj2aFoUh0FMLwkpzWci
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="258286210"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="258286210"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 02:39:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="634453383"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 02:39:40 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 03 Jun 2022 12:39:37 +0300
Date:   Fri, 3 Jun 2022 12:39:37 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: PM: Drop pme_interrupt reference
Message-ID: <YpnW2bWS7n5r0ayk@lahna>
References: <20220602163330.317-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602163330.317-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:33:30AM -0500, Mario Limonciello wrote:
> `pme_interrupt` was dropped from `struct pci_dev` as part of commit
> 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev"),
> but the Documentation still includes this member.
> 
> Remove it from the documentation as well and update it to have the missing
> `pme_poll` member instead.
> 
> Fixes: 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
