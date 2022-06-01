Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B646D53AAAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355973AbiFAQF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242784AbiFAQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:05:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780AA5A94;
        Wed,  1 Jun 2022 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654099521; x=1685635521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDqz+zeD59WcYzE7cfdioIRHyhOeYFOdYrSIqs+P4JA=;
  b=Z5g3gkShprXqm1Oq+sjuwXJ6JtfAKou+Z//gZeGr44BlpsYGgmkJK3Gu
   kDZywk1WQE2WPlojXlBbfDlHukYcyM5rT/WmsRrabZ57yMdnFjwHcubm0
   l4sp0+MZWFdesBQYKNk96ultUbloLRYXlr0Z0U7WFA3ZK49oyRpUYuJ99
   YYhm2AegL5+S99iEkLfrjGHaiRi+2G9qWhAzkHbLAo/HfKbyrJyvM6Y69
   qDiwShz1g1xJTPwHGopt4L/GJJcG8LAwCRsKZ5iTLhe+1wKhSQukkh3hz
   LJRhOb+yO0jk4pIFvQivpCpL/KbipfS9lbRV+EgIjd06W5DYgAi/1D02/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275648799"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275648799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:05:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="562864057"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:05:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nwQqT-000QnX-3c;
        Wed, 01 Jun 2022 19:05:17 +0300
Date:   Wed, 1 Jun 2022 19:05:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH v1 1/1] MAINTAINERS: Update Intel pin control to Supported
Message-ID: <YpeOPI3fPODh97YD@smile.fi.intel.com>
References: <20220530115750.70470-1-andriy.shevchenko@linux.intel.com>
 <YpTDBAyBhr/z9z4X@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpTDBAyBhr/z9z4X@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:13:40PM +0300, Mika Westerberg wrote:
> On Mon, May 30, 2022 at 02:57:50PM +0300, Andy Shevchenko wrote:
> > The actual status of the code is Supported.
> > 
> > Reported-by: dave.hansen@linux.intel.com
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


