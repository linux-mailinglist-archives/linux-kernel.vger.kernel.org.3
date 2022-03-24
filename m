Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7DB4E648E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347700AbiCXOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCXOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:00:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C153B5D;
        Thu, 24 Mar 2022 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648130349; x=1679666349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=048nY8VsL0lxScI7e1OWenjrAALfi13hwM090OpLTTs=;
  b=YFApCKGokkKptRPfzfRl+t/CleiDZoB7UyKSAds/PInXXobka2GwZ4Qf
   Eg7q2MyHdhhnwqp9eCG8qK2uOnAJgoyKr7x16WskHinboxaT1EI6Zx58r
   RXCXBuLWCfuB09eEIZVb2EZgK2gtkMOK3auzcyfX7ECcBQ0qharmFtUob
   yo3326UirJUmyzB0R14IVQCjFEcC2tNEpOKuu1Y7rtVnzXF2Dp9nAkE8O
   jNZygL/4yGX9M4C8mGYbZy4JBtlaSQ1vE8VY0CMK7lZNeWsVtNlbfPGlh
   OXJ7q+RURSdSsvDtRxdT9xWfLXWyM0A5xCoa4oHGd7IEABxWNU/gqAN7A
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="255948361"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="255948361"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 06:59:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="601696066"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 06:58:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXNyo-005r2r-9I;
        Thu, 24 Mar 2022 15:58:22 +0200
Date:   Thu, 24 Mar 2022 15:58:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com
Subject: Re: [PATCH 2/4] serial: 8250_dw: Add MStar MSC313 quirk
Message-ID: <Yjx4/TXKiizuQ+yH@smile.fi.intel.com>
References: <20220324124402.3631379-1-daniel@0x0f.com>
 <20220324124402.3631379-3-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324124402.3631379-3-daniel@0x0f.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 09:44:00PM +0900, Daniel Palmer wrote:
> The version of the IP used on the MStar MSC313 and later
> MStar and SigmaStar SoCs has the USR register at a different
> location. Add a quirk for this.

I'm fine with the change if it goes before [1]. Otherwise
you will need to rebase.

[1]: https://lore.kernel.org/linux-serial/20220317174627.360815-1-miquel.raynal@bootlin.com/

-- 
With Best Regards,
Andy Shevchenko


