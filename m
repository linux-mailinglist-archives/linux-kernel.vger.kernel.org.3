Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107FF55D2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbiF1KD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiF1KDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:03:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401642E9E9;
        Tue, 28 Jun 2022 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656410602; x=1687946602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6F1wA0MP/XvdHSRksenwLF7TskHY3KOWwY3P9Ta6U+I=;
  b=FtrVIO1vHiaP29zgONSRl4tI3ttpj3leE5JcAqttb5gNs+KQaH5WIHwo
   dOvSOIsfcrMEYZj8ahsSV0GMUNccRY35Mg7QHMAbv5z7u746aGl3KU5iV
   ax4KAs/0vh2T5JPkjDWSLzuHHuXs5pIDf+VNojsAu60ODycGYZCemPt19
   ETJz0DrDp3R3PqQUn7jZJoGyAWTHJh7ef5FUxpNsZ+b8dPaAtH4G+nFO1
   ULD6djPC4ZKciziPvW+gPICxAgRNuWK5AUd7lSBqf0jPfJy3bTiDAMEXI
   XkRse2XdR1CwdRlbDzf+2eX3hwEDvJNxt9l/LzrLc1lXDn1JQev2JdOWZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282790166"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282790166"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:03:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="590261183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:03:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o683u-000wgu-T2;
        Tue, 28 Jun 2022 13:03:14 +0300
Date:   Tue, 28 Jun 2022 13:03:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 5/8] dt_bindings: rs485: Correct delay values
Message-ID: <YrrR4hItCx56bpxI@smile.fi.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-6-LinoSanfilippo@gmx.de>
 <YrSU4eL9hgISg3Y1@smile.fi.intel.com>
 <6c50fdca-aac4-aaf5-ad34-18a60fcc0aa0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c50fdca-aac4-aaf5-ad34-18a60fcc0aa0@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:17:06PM +0200, Lino Sanfilippo wrote:
> On 23.06.22 at 18:29, Andy Shevchenko wrote:
> > On Wed, Jun 22, 2022 at 05:46:56PM +0200, Lino Sanfilippo wrote:
> >>
> >> The maximum allowed delay for RTS before and RTS after send is 100 ms.
> >> Adjust the documentation accordingly.
> >
> > Is it only documentation issue? If the code allows this to be set higher
> > than 100, we may not change the documentation since this an ABI (from
> > firmware <--> kernel perspective) we need to support old variants.
> 
> Well currently the documentation claims that a maximum of 1000 msecs is allowed but
> nothing actually checks the values read from device tree/ACPI and so it is possible
> to set much higher values (note that the UART drivers dont check the delays read from
> DT/ACPI either, the only exception I found is max310x which clamps it to 15 ms).
> 
> We already have a maximum of 100 ms defined for RTS delays set via TIOCSRS485. To be
> consistent with TIOCSRS485 the same limit is used for DT/ACPI values in this patch.
> 
> I am aware that this changes the firmware/kernel ABI. But we had a similar situation when
> the sanity checks for TIOCSRS485 were introduced
> (see https://lore.kernel.org/all/20220410104642.32195-2-LinoSanfilippo@gmx.de/)
> since before we did not have those limits for all drivers (some drivers clamped the
> values itself but many did not care).
> Furthermore 100 ms is already a very high value for RTS delays (which are usually rather
> in usecs range). So IMHO the risk is very low to break anything when values are clamped
> that are higher than that.

You need to elaborate all this in the commit message to justify the change.

-- 
With Best Regards,
Andy Shevchenko


