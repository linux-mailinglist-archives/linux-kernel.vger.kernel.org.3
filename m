Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44075A682D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiH3QUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiH3QTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:19:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056D10E0;
        Tue, 30 Aug 2022 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661876390; x=1693412390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZQPKJ4u30LgHZYy7pYFq8/WK3HtHOpZxJaqan/zXgM=;
  b=JgyPGxNbFogshzz3XATLynEo2ZwhxqSYDzIitmogbTQ2vtvl5C9KyfiU
   VAtAj6BxbhLaogz6NiEcNQeiKcePwpldWbQdgm56eZeZnpQziPI8ffaSL
   M6nv4lGmk+hnqQfX/xdr2o97f9bnlOWJ1ZsmcJ5BmJKK6+9PCpUJZbZzb
   GW/5ww7eC20TrKdMiiWJSJQOMzhKjMcZbBmDg00eCISm7AoM8AzL1dxtE
   NTDGo4j1qyjm8S/OUs2i2ttsz1CHtQjmXQfBuQJqSlfdAElD0kc3YEXpq
   eMTKs/jlyZYLVdbZvT/woEViGSgU49mfLe7u6NWiTt/fWwuYQI9qO1rz3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296500479"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296500479"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:11:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="641438785"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:11:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oT3pJ-0061WG-1u;
        Tue, 30 Aug 2022 19:10:57 +0300
Date:   Tue, 30 Aug 2022 19:10:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/2] ACPI: PMIC: Use sizeof() instead of hard coded
 value
Message-ID: <Yw42ka9czLbBmTtp@smile.fi.intel.com>
References: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
 <Yw4zaBJu81SvkFMM@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw4zaBJu81SvkFMM@black.fi.intel.com>
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

On Tue, Aug 30, 2022 at 06:57:28PM +0300, Mika Westerberg wrote:
> On Tue, Aug 30, 2022 at 04:55:31PM +0300, Andy Shevchenko wrote:
> > It's better to use sizeof() of a given buffer than spreading
> > a hard coded value.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks! As I replied to this, I'm preparing a v2 which will cover more
conversions. I won't use your tag because it will cover just like a half of it.

-- 
With Best Regards,
Andy Shevchenko


