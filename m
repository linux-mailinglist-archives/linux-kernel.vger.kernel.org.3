Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977C14E95C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiC1Lzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiC1Ly6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:54:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CF3C739;
        Mon, 28 Mar 2022 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648468226; x=1680004226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FJ1OglmGOS8icee/o/DH8YSN94x6fKOdIMCNXQr/Tks=;
  b=Pk2alWBnWbHAOI5Rokz4KPjv+YDa/tvD7w43v0a1VN5aNGU6GbIH8DvO
   bxJeKBJYsoLlcwVMSDMXhJvO7IU7isSf80nooZx+8O5smnqLibd8JGXrZ
   x8D54rjsdduhFnt9tBrTONEverLz+pzK1RT18DgoHA1TW1/4Lp7D4b8wv
   MlWvyAUVrIYSOKP4T9+P3u3Yw8YbB3V+1lN0GrOIWJZV+phZzB2Dl6/Q7
   P/WFDM5QJFn7c0azZkv7nsCKOJatP8ubQhS/3KPksQ8SrtV4z+xWUvYfV
   ckQmCVufGeyHYDpbnuGpuESOoumtv5cqlW1O4TzWWHLDjc49t/BbUvYGb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="239574447"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="239574447"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 04:50:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="604024156"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 04:50:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nYnsc-0085Ex-IO;
        Mon, 28 Mar 2022 14:49:50 +0300
Date:   Mon, 28 Mar 2022 14:49:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: armada-37xx: Switch to use fwnode
 instead of of_node
Message-ID: <YkGg3qgP9MEFOZ0M@smile.fi.intel.com>
References: <20220325201425.54847-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325201425.54847-1-andriy.shevchenko@linux.intel.com>
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

On Fri, Mar 25, 2022 at 10:14:25PM +0200, Andy Shevchenko wrote:
> GPIO library now accepts fwnode as a firmware node,
> so switch the driver to use it.

It will be used as a prerequisite patch in the v2 of gpiochip_count() series.

-- 
With Best Regards,
Andy Shevchenko


