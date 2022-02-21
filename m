Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADFB4BE2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354311AbiBUP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:27:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbiBUP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:27:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE5C1EAD0;
        Mon, 21 Feb 2022 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645457237; x=1676993237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YheXgA/w0kWmZiHgabea6UMdQrnEpsk76xiXGIY5Z1k=;
  b=T6f/rUKmlfWk1EYChztwif94jiGGltUiEMHTIZZDd2B+IXJb6J1pbGWS
   oNO7yJzxpLXLw5Rv8P/Xxy0AIoRaGARm0JQ38aVYIfLNjG+n60CkW9rH3
   1fuFRsY/+VJCwYFnmhYjeQQgibgcGZY7hAZFobEFIuQBwJCubBlpqF6qG
   UUpmCWJc3fKLqyANRa1OBT/u2pHakPsHCTk6StBsP84kvnpHWa+M1a57C
   G1fkTWeR6XfsDc8eFSqD3PBM4bh1f3Hkkde8QmQukvaY6sZgaSWCDhkus
   TOC4+YS8sQ4640RRylAb2E8znGSh1IFKVdziXhqB8S0MuWcsTliCgGhPl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250346521"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="250346521"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 07:27:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="505116097"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 07:27:14 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Feb 2022 17:24:59 +0200
Date:   Mon, 21 Feb 2022 17:24:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/4] pinctrl: alderlake: Add Raptor Lake-S ACPI ID
Message-ID: <YhOrxJJ5F+gQk58Z@lahna>
References: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
 <20220215152800.21104-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215152800.21104-2-andriy.shevchenko@linux.intel.com>
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

On Tue, Feb 15, 2022 at 05:27:58PM +0200, Andy Shevchenko wrote:
> Intel Raptor Lake-S PCH has the same GPIO hardware than Alder Lake-S PCH
> but the ACPI ID is different. Add this new ACPI ID to the list of supported
> devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
