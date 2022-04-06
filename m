Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07C4F5616
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiDFF6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377408AbiDFFwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 01:52:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F73D344FE1;
        Tue,  5 Apr 2022 22:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649221793; x=1680757793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7akzH623VSv4BBE9/ra9/iPv62pdaCdpBK5z80L2VRs=;
  b=jqov6GriHomjrrVGxh5CFqpZd0AhtAO/LykuWK0WIkYSjH4fsJBMkA8D
   Jozos8DVbyjpxf9jeGWbFuwc74mf587+BvjUW3qBqK5cz3ABkEqF3wXr5
   70tGoMeYyu+EkyZlL5MLSMH9ZnU02J8+m8gsdXvGIQlmbgKsNbucfbo1v
   3a7ZaKPCkzAqlF3j1UppBnvKxILsdsSjvQ3XfKrBKcc8A0bgTLrC/I1Qp
   l3Oi7JbCD2p2PskPoA/+4GJt84E7JYvdb+e1Lu+e8I6PcnCpDlapVKHJf
   62NljGxTDeKd3UMRyeRTVVVSEWLgsTcgufIlmf1Dx17ED7cwrkluoSLHx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259785423"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="259785423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 22:09:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="523776195"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 22:09:50 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 06 Apr 2022 08:09:48 +0300
Date:   Wed, 6 Apr 2022 08:09:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: alderlake: Fix register offsets for
 ADL-N variant
Message-ID: <Yk0gnG+oqpARzC+m@lahna>
References: <20220405170251.72154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405170251.72154-1-andriy.shevchenko@linux.intel.com>
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

On Tue, Apr 05, 2022 at 08:02:51PM +0300, Andy Shevchenko wrote:
> It appears that almost traditionally the N variants have deviations
> in the register offsets in comparison to S one. This is the case
> for Intel Alder Lake as well. Fix register offsets for ADL-N variant.
> 
> Fixes: 114b610b9048 ("pinctrl: alderlake: Add Intel Alder Lake-N pin controller support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
