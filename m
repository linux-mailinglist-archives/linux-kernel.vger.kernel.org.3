Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50355542296
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359568AbiFHAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389878AbiFGWx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:53:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53282E93F4;
        Tue,  7 Jun 2022 12:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654631375; x=1686167375;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=0MGJANZmWUnpCpze3iYseISZvaFBDIUwvfaKvGZBEhc=;
  b=HlldldWDFVq2K80AtluzAiGMNv7SmwXFSiE2whZ/qkhC4A6WiQfnPFcY
   fuBifpayGpgfVJdtbHqI2oLMwQztFrexEZ06UT07yDPvmiCRImxefie7d
   4ulnQm93+xtzk5mRZYFEOS1i/RcG4gUh+X/FkZOxRFJhBBw7SjQevhzhj
   5KwtEho0irF38vCwKOkP2Z9tNvoFggvzWwygbhpqNEvvQM0uL+/iq8aFJ
   NKWavt9TxqJK1DNXP9w9gEGFjMfYq+NLM7ofqZYaoP+t/B3siqEgNp5Xd
   LkAHk5RFV9+7Tp15/sS4ZnPIE3EisUCTI9ij5LePij/Z3R27DXf2wUISt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257184956"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="257184956"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 12:49:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636298348"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 12:49:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyfCl-000W1G-3i;
        Tue, 07 Jun 2022 22:49:31 +0300
Date:   Tue, 7 Jun 2022 22:49:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Replace match_true() by device_match_any()
Message-ID: <Yp+rymvjN2KzsMz/@smile.fi.intel.com>
References: <20220607190601.47363-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190601.47363-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:06:01PM +0300, Andy Shevchenko wrote:
> We have already a helper to match any device, use it and drop match_true().

Scratch this, it seems I compiled against wrong config and haven't noticed
types mismatch.

We can't use the proposed helper since it's only for for_each type of
functions.

-- 
With Best Regards,
Andy Shevchenko


