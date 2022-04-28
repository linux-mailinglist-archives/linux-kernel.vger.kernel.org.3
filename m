Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9181851314F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiD1Kca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiD1Kc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:32:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B653E17;
        Thu, 28 Apr 2022 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651141753; x=1682677753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GFRbWkn3PBPqGL9xwfna2VQj3DYDSKswtXSwu8Tf1Gk=;
  b=ZcxI4eFUw1mPhSL1hSx2KxGaNWbRHxcuiHkLiIv+nNVsEtaAaODezbJv
   RReahfeQbwuTA/rCsy3km8xibf2KHHiQhHGqSF4/K1UCHqIKy/MTU2qK/
   vUPzo65fdc5zvPWpVgmHysP+LmnNNotDx9IssfAGPe6H2HgpMbqLpdYqs
   /aRU66oWCayMd9ZrKJS70O5OY8jjaOhBiHeWKI/CpDqTPpQHlyCRBqGnv
   wLxByIsRDlP9bH9R8SgJGwfU5lRkW9gFFVRULZVnS0rTKqj0Lg1iCny6Z
   EqHLs4oxws+V7Zat+6hkQbr7PDEswNO5fSNRIgF0OH449IUudeNXMaxeI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246156437"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="246156437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:29:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="596729808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 03:29:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nk1OV-009Fbx-Cm;
        Thu, 28 Apr 2022 13:29:07 +0300
Date:   Thu, 28 Apr 2022 13:29:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] platform/x86: pmc_atom: remove unused
 pmc_atom_write()
Message-ID: <Ympsc5PG9YRZmJzG@smile.fi.intel.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <20220428062430.31010-2-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428062430.31010-2-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:24:27AM -0400, Paul Gortmaker wrote:
> This function isn't used anywhere in the driver or anywhere in tree.
> So remove it.  It can always be re-added if/when a use arises.

Can we first move the driver under intel subfolder and then update?

I have no strong opinion, but personally I would keep it (even unexported) just
for the sake of consistency. Up to Mark and Hans.

-- 
With Best Regards,
Andy Shevchenko


