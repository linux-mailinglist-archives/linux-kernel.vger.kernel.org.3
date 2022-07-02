Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943BA56422F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiGBSyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGBSyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 14:54:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA5BDF4A;
        Sat,  2 Jul 2022 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656788067; x=1688324067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lDzURSo5CuKZu50QeulKtsbmIB9obJq/v1OWj46XbM0=;
  b=OlgtQOJjUa/RPPEESjRUIpeYMtvtUPqJBbNcdQ1S0c1YwmZv6EqTeiW3
   fOIGf5hfSPTicJBmaUzU0bdk9jDrTxSRXX4656p3uzSaiEEz23EOrjSLF
   ujBC069UV5I4sQX/Fh/HXb+yC9T0oHaRGVdhAus4GbNN0m3s+Z3uXdnHE
   tJ5qhJZicWWS0oDpjpigulqg27r/mF+OpzHQg/XSgatyk1lAnKASxl7vS
   1/jMA6OBXtlyuOi/Y4Ygy5/6s4og0PpIec6PN+nGNN6kMgwHWy6s8WhUf
   6eCxrxV3UfV+eqwAeRkiOHFZReilt8fW2Y0OshDrnL63aVfy7gpowJnwD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="262657839"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="262657839"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 11:54:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="681765037"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 11:54:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7iG4-0013pn-0n;
        Sat, 02 Jul 2022 21:54:20 +0300
Date:   Sat, 2 Jul 2022 21:54:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-s390@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/4] s390/cio: Rename bitmap_size() as idset_bitmap_size()
Message-ID: <YsCUW6vT7LlAv2UE@smile.fi.intel.com>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <3f2ad7fb91948525f6c52e0d36ec223cd3049c88.1656785856.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2ad7fb91948525f6c52e0d36ec223cd3049c88.1656785856.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Jul 02, 2022 at 08:29:09PM +0200, Christophe JAILLET wrote:
> In order to introduce a bitmap_size() function in the bitmap API, we have
> to rename functions with a similar name.
> 
> Add a "idset_" prefix and change bitmap_size() into idset_bitmap_size().
> 
> No functional change.

...

> -		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
> +		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));

Why not to use bitmap_zero()?

...

> -	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
> +	memset(set->bitmap, 0xff, idset_bitmap_size(set->num_ssid, set->num_id));

Why not to use bitmap_fill() ?


-- 
With Best Regards,
Andy Shevchenko


