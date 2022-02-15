Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02044B6833
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiBOJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:52:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBOJwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:52:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89A10335B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644918740; x=1676454740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oe4YO6EvDJseL0z7C+Rpj3omkU3reoCERPtvQmTBO+k=;
  b=GYtwXxDGqHvo3vebvThFnCLegIBaYzTJQXsY2uHSy6glimwB+SXAW5Sb
   eYPVx3VryroF1bPnBg98lxejCQgP1ywgcziH3EV+eIcwlU9OFi2Me6nOH
   dzQI5m180ZqOS8TqjUdwZFnrBDS1XcM6yXiHGO4t94wBRNY5u2N7JCr3r
   0WoLpjRKMni7ynQutKziChCUnJieKd/VBgAbbrHeA/vIYRbxXQe7hx3GJ
   iVBh3bPu0HIP1nswPQjsncE/4ZGW28nbYn6CsgRA6awm7AFa3tT/z3Y/M
   s7F3zuP5g7BHTaFzMDp1gZsyoWMiilfUsnBnCp2daUofuAAYbQkLAdqy7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249146354"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="249146354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 01:52:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="635765473"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 01:52:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJuUI-004s5J-9I;
        Tue, 15 Feb 2022 11:51:10 +0200
Date:   Tue, 15 Feb 2022 11:51:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Message-ID: <Ygt3jibBVRyCn909@smile.fi.intel.com>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
 <YgpY1IIBkFIxxjbm@8bytes.org>
 <30e45a7e-088d-7479-a284-68effadf3cbe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e45a7e-088d-7479-a284-68effadf3cbe@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 09:31:37AM +0800, Lu Baolu wrote:
> On 2/14/22 9:27 PM, Joerg Roedel wrote:
> > On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:

...

> > > +extern const struct iommu_ops intel_iommu_ops;

> > The intel_iommu_ops symbol is only used in drivers/iommu/intel, so I
> > would prefer a header in that directory. But I leave that up to Baolu to
> > decide.
> 
> Agreed. I also have a plan to split them out into a internal header.

The above change is hanging for more than a year, can we apply it and then
you can do a split?

-- 
With Best Regards,
Andy Shevchenko


