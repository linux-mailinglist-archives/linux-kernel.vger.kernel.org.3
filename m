Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED714CA9AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbiCBPxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242409AbiCBPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:52:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047147030F;
        Wed,  2 Mar 2022 07:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236317; x=1677772317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Cjd4bFeVZvdpt/iarKU9NQ+uoIe9qw+z067MGTrAvA8=;
  b=CkEi6j+/0POB625YZF9/qgaxjkpGfa03farPQtECm2FvbxU3VK2Foofx
   t9mkvUnJmqnVyn1cGTZ3XO4RwH6pK11Y1DvBkAU4MIaF43h1uuc0n+K/E
   C2KZOdRsAXOCtNyS7nVpMi29bEcHuTrjWo55i01vgXmnaKm49VspvgIIg
   9sg7NSY1PE0QrF75fN7VwT0oq1hJgrD92okXOZmDGEp3GeHsIUdeyj4gt
   uxPNHnlNE33/KXNGnJh/ndKTCbZNw04abcNsxFVggoD61J9UOHjHtkjno
   6fvnrL2orKM6tzHZAEn3KDTMHVfrNe2oSVkbS+7sON6zjJNGV6qXJqKec
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233397397"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="233397397"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:51:15 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="493579099"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:51:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPRFC-00AMqj-Gw;
        Wed, 02 Mar 2022 17:50:26 +0200
Date:   Wed, 2 Mar 2022 17:50:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
Message-ID: <Yh+SQgD0Bq5qq6Cm@smile.fi.intel.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
 <20220213175559.46e8dee2@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220213175559.46e8dee2@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 05:55:59PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Feb 2022 15:55:20 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > In a couple of messages the constants, which have their definitions,
> > are hard coded into the message text. Unhardcode them.
> > 
> > While at it, add a trailing \n where it's currently missing.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> 
> Mostly so I can remember what is going on with this patch,
> Nuno is OoO and planning to test this series when he returns.
> 
> Given that I'll wait on Nuno's testing.

Any news?

-- 
With Best Regards,
Andy Shevchenko


