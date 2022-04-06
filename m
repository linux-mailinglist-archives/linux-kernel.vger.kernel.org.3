Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14CD4F63B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiDFPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiDFPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:46:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD9D219AE3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649250207; x=1680786207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iTWnY1k7bbh1/b+9WL07ilkWgLIQ46sXRa4zPnKXvHw=;
  b=Q4HDE74FLPEMHJsE9HCcJeZPC/rXNtJ5lW4jq1KQr1lC5VmZm5S4s4EO
   mmmDKHoQI8yjJpTQ6AwNPtmccIZZW3zfdmNP91n/s5EztxK7jS2hHDAKo
   ly0z6nSMf85y1koEdO40DeXVZDT5k8ses2aviXlZpUeoO2N9hLFoR6F8c
   BzttIlSYd1/0LVMIZ2clx/QKbybxmQbAROzjvolly1MFIij1PQx6W0Nos
   ol2uiAjNFrM1evnJwzMQgUo22erg2UjStZv60501TV47VZMY98jM7umNZ
   tHlpvAPe0gnA11SI5MaJBahwUZsiG/4MXQANcrw9/rjZcPPE5qsPwMMa3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324206892"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="324206892"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:03:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="588361010"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:03:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc5I5-000EGZ-94;
        Wed, 06 Apr 2022 16:01:41 +0300
Date:   Wed, 6 Apr 2022 16:01:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 1/1] regulator/rpi-panel-attiny: Get rid of duplicate
 of_node assignment
Message-ID: <Yk2PNas3YIGQLZ04@smile.fi.intel.com>
References: <20220325184508.45670-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325184508.45670-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 08:45:08PM +0200, Andy Shevchenko wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove these assignment all at once.
> 
> For the details one may look into the of_gpio_dev_init() implementation.

Any comments on this? Can it be applied now?

-- 
With Best Regards,
Andy Shevchenko


