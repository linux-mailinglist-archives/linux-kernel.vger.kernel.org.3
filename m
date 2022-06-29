Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48B560559
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiF2QGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiF2QGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:06:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FBFBF6F;
        Wed, 29 Jun 2022 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656518779; x=1688054779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyVcJwpKkoHPhWd05QkSO/zGE66w2VkCpP77v7bD+Uw=;
  b=hl7knr8NSJnY+co0qvGcIqILusaZ6X9kz6Hu79OdruEt2mGR+9s+RJvw
   4CBNsOt9VerWH7boxL8+TPtpXKBueoV7ohE1wJFQcQxJ8sQT0gzbAf9E2
   +SlbyEv385Zz8pKoEcSK/cUDnG+UteP784YOj5iCmLH9dXY4yVsNdDfOH
   k9P903q1s5mNT65esEUgHxz3WI9ZLuizS+2DpWC58hFX/SMmRq13DLIn/
   2qaiw+j8P6ZT74zY4haJftFDrI/q5esdcCAEtY85jTwMixkWFT4aGKVkG
   v7Kd/Q05YKEgQZUXN3oJ3gs5NsQntvPiLnbA7Lh9GmWvLi2o4VSEb9xrI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="265107558"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="265107558"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:06:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="717881129"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:06:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6aCi-000xsY-Q6;
        Wed, 29 Jun 2022 19:06:12 +0300
Date:   Wed, 29 Jun 2022 19:06:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/1] of: unittest: Switch to use fwnode instead of
 of_node
Message-ID: <Yrx4dBmilHKsESl3@smile.fi.intel.com>
References: <20220629114156.6001-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629114156.6001-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:41:56PM +0300, Andy Shevchenko wrote:
> GPIO library now accepts fwnode as a firmware node, so
> switch the module to use it.

Sorry for a spam, here is v3 of this series, this one shouldn't be considered.

-- 
With Best Regards,
Andy Shevchenko


