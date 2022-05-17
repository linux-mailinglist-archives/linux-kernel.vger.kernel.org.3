Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756F5529EED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbiEQKKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbiEQKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:07:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3631CB35;
        Tue, 17 May 2022 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652782052; x=1684318052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IJ2e0bHcymHypRBWw4N3tfS2H54h0ez0vXwzpdUU3zc=;
  b=a+gWhzyYeqEy9oHHHjsIL48Kge6uck03qnqPLAbCL83et6eINLMbo66P
   mwtK6QtLIAAH6RlklR4hSFOhot6sSyi28pmGbVXLteAtjedM+JUoqVa3f
   xaWeF6WNcYws3qhpT5lFMi/64FhlHTC/kQqiPZgGuMZmZyT+8XgbbywoY
   fuuFQITYuKpPbrYfGR9wy/treZX+uGeHgvXeltSnBdsvdsyyX9/i8/3XR
   6xWGeEDhmx9+XUSa1nmbMSe1zMRVrGngHr4Lmaumgxz8an890ye2uSjTE
   X6Rb7Oc0mB/tqm6KVjyQsRThjbDqmFfDANgcL5Vn3TWxuVA5joKB7/3o3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271077023"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271077023"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 03:07:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="522891092"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 03:07:30 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 17 May 2022 13:07:27 +0300
Date:   Tue, 17 May 2022 13:07:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: cherryview: Use GPIO chip pointer in
 chv_gpio_irq_mask_unmask()
Message-ID: <YoNz34dfCIrKYn6n@lahna>
References: <20220516185500.32304-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516185500.32304-1-andriy.shevchenko@linux.intel.com>
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

On Mon, May 16, 2022 at 09:55:00PM +0300, Andy Shevchenko wrote:
> The callers already have dereferenced pointer to GPIO chip, no need to
> do it again in chv_gpio_irq_mask_unmask(). Hence, replace IRQ data pointer
> by GPIO chip pointer.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
