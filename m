Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017B85AECE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiIFOBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbiIFN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:57:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89882845;
        Tue,  6 Sep 2022 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471749; x=1694007749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wcz1W2S6TTPoz9vhPjyd2cS1A1djfa8aNebGbDdSKCI=;
  b=bU4pLcZFArCbfiVavU6Dc8Xy46DNrSaDOnBD1yfbDXqTu+iWQ4T5210U
   YV2b/vPGzOAY6dNMVexU605NO+GikshMboyoA1qxc2BnTEiY14BiC7VKF
   DU3/IQzudJMNDgxizE96/5OALLCa/K1YmZtPoSRD/+bSrrXI+dRRY5VAr
   RSoMuwlqNWTjOxpKz9XoE13Jv5tjs7XqH/9GGZ+lBkkHoa3pClx4x47q0
   TeU2QB9/BcjnLdcDSuumhiBibir+S8in/5X1POW/4QRXNnkMV+7Q2InMH
   3R8wE7BjonmUlzO2a+B3jV0bHFgzSn3baJDFT4W03MkhR0OvaiBcnnuib
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283588937"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283588937"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:41:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682399822"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:41:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVYpO-0098fa-14;
        Tue, 06 Sep 2022 16:41:22 +0300
Date:   Tue, 6 Sep 2022 16:41:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 1/3] clk: Remove never used devm_of_clk_del_provider()
Message-ID: <YxdOAj5KLDY6y66p@smile.fi.intel.com>
References: <20220623115719.52683-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623115719.52683-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:57:17PM +0300, Andy Shevchenko wrote:
> For the entire history of the devm_of_clk_del_provider) existence
> (since 2017) it was never used. Remove it for good.

Any comments on this series?

-- 
With Best Regards,
Andy Shevchenko


