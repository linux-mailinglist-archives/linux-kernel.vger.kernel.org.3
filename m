Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B95560557
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiF2QGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiF2QGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:06:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B2F46;
        Wed, 29 Jun 2022 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656518759; x=1688054759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbrc7F9sL6YCxOWkN0oDWBJ6MPHOZ5O2I+OeO5NRe3g=;
  b=anSd0rmji61s5Z6ThD+aTOBOdZp75440Z6zDr3sVaF9//7z+14IKYo1o
   s/s0Vzt7wKIiH4+WTiNx1z7hqZGuBEK/onZXgOvzCuNXkLZZdfsZP26r9
   1OVP/EeBRC08+CzLLLZ7Sj26cuaQr6mLpTgNNYQk8uY/2FRbdFRrXUNbn
   gm+ytAbXc+qefTMoRPbm0QGFBk+QvlwR9Tp2IzSwHvT9MH3WVvC2hMGn3
   VWrP7148C73aIUhHaqGeQ5F9/iu8UUfzyaBhH7LaVkOEFhGJnryaYs3H7
   UFefFH76FJ0cLKtg1w5lyy9wY15Yi2beB/4O7/4ZoXv4vbafDPYR21sSX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307569225"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="307569225"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:05:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="733232954"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:05:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6aCP-000xsR-Hl;
        Wed, 29 Jun 2022 19:05:53 +0300
Date:   Wed, 29 Jun 2022 19:05:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] of: unittest: Switch to use fwnode instead of
 of_node
Message-ID: <Yrx4YfwLfaucYx36@smile.fi.intel.com>
References: <20220629113839.4604-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629113839.4604-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:38:39PM +0300, Andy Shevchenko wrote:
> GPIO library now accepts fwnode as a firmware node, so
> switch the module to use it.

Sorry for a spam, here is v3 of this series, this one shouldn't be considered.

-- 
With Best Regards,
Andy Shevchenko


