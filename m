Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271D659E8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbiHWRMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245445AbiHWRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:09:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4671593DC;
        Tue, 23 Aug 2022 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661261833; x=1692797833;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=eAM4IfLs4EeAKfq7vCYp78zY0+nWzIBl6fYHI3SUFrA=;
  b=mJj44z54ZNjCGygqZBv95BTvAJlV6ke75E1bGb+1OQyRv/l3W/KGpi9H
   fSbLEhjZRGhfyIfdLnAysxj5FUxncEp03I+YXQVc3GybLklaQVeccXvzI
   DZizqkzotRTEcq+qvPWPp8FyQ1vltLhWXeQPpKYGEc611o23erfr+B8YV
   j9gJhSoQAXvVxoq/lW6KqWzhis+PT/bC8vuDBtd0St2W+Y2w56RImxrRy
   BL8sH3rclqG+c8QR98BQD9VNsGa9+2FC3H8dzbH3HfMw/SYlEv4gtn7Tj
   lmIfELArjdDCrbDnev72JywnuY3buIM0BdPGyuiJekGmZWifp6yWMZFqV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291248724"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="291248724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:37:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="785249686"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:37:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQU5c-002SLI-1z;
        Tue, 23 Aug 2022 16:37:08 +0300
Date:   Tue, 23 Aug 2022 16:37:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] pinctrl: nomadik: Convert drivers to use struct
 pingroup and PINCTRL_PINGROUP()
Message-ID: <YwTYBKtBIzgujqM7@smile.fi.intel.com>
References: <20220621112904.65674-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621112904.65674-1-andriy.shevchenko@linux.intel.com>
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

On Tue, Jun 21, 2022 at 02:29:04PM +0300, Andy Shevchenko wrote:
> The pin control header provides struct pingroup and PINCTRL_PINGROUP() macro.
> Utilize them instead of open coded variants in the driver.

Any news?

-- 
With Best Regards,
Andy Shevchenko


