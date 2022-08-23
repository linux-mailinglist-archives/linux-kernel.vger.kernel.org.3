Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F03459E874
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbiHWRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbiHWRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:01:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F51570C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661263722; x=1692799722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QGleQ3Y6XcUG4H6+bm+kkCZykmEPRuSH/26duaMmWz8=;
  b=DrDjMusRdZCbtJyppj+VMjBh0kaCW+OxylgayAgzJFbHxLpcexXKdTsr
   hLvS8+k+qqa+59c5FJan+N8SHBe8rGAEiY7iRT5QUqrvrjv/6k9f0arvL
   NVRXYpg5KzBE07ClMT6t4TMcQ+bMeldbD9tbkYSR4b93aS2kfuntsF13S
   0NRYLSYumfXGPNuBxnv6aZ/ODF8GE+j83eLKpEhV30L5JyJ0CMbgg78XV
   ArgI/sXWBRfuJFfNdt5cnD999bcf5DDBKI9fmx/voOfrVjgORU78IjA4I
   G3ZPbmodwooRawkQVbwLiWl4eiRqzrqIRcPMJyTEw3KYcMTkYzdnLCH6x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="293695154"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="293695154"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:08:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="560178643"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:08:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQUZt-002T40-12;
        Tue, 23 Aug 2022 17:08:25 +0300
Date:   Tue, 23 Aug 2022 17:08:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu: Do not dereference fwnode in struct device
Message-ID: <YwTfWdnAqB6S9Ysy@smile.fi.intel.com>
References: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 07:47:58PM +0300, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific dev_fwnode() API for that.

Any news?

-- 
With Best Regards,
Andy Shevchenko


