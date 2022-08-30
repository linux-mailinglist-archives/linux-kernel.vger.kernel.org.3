Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F645A6713
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiH3PON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiH3POL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:14:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFBF122BD3;
        Tue, 30 Aug 2022 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661872449; x=1693408449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MZ2ZerYuF3A2KgxxfSjNdhOa11NynO633L1K+Ai+Uz0=;
  b=cMw3OyAn6N4dEtGDxEAaQT3Dlr85eJtz8Oka3BwzjS+SlZZW42olMRTE
   28CINRO+tv/5h0DDF26Qs1oMbeJMb+RQQSlfru5nB1mvuBeZOiTXE2Rvy
   jm0Hwf90GlaFTL9Jkbqu6L4cbeZNZnG9SK2fKFu2z4bneCknVgilJ2ERN
   RkRY6x/NJLp2LNSx/3HbzAEYqNSXFWs2WPFGjR9HQFF0ywgXw+9woHy+4
   8OjW+Gqczmcn/DVemHOEJ1IxwgI9EYCSP0oaOVBkgdg1vORhsjCVBDFol
   EuSf3m17DxzdcMT7cY3nfmb47Bw1lkDQdOHwhFonVhEeoUnEkGBTjKXul
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381499167"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="381499167"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 08:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="644863987"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 08:14:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oT2wF-0060Qb-29;
        Tue, 30 Aug 2022 18:14:03 +0300
Date:   Tue, 30 Aug 2022 18:14:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ACPI: PMIC: Use sizeof() instead of hard coded
 value
Message-ID: <Yw4pO+0+pVAsoG2n@smile.fi.intel.com>
References: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:55:31PM +0300, Andy Shevchenko wrote:
> It's better to use sizeof() of a given buffer than spreading
> a hard coded value.

It seems I have noticed more to convert. But I will wait for
others to comment on the published version.

-- 
With Best Regards,
Andy Shevchenko


