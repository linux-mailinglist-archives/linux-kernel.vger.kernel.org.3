Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AED55A8B6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiFYJyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiFYJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:54:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329932ED8;
        Sat, 25 Jun 2022 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656150885; x=1687686885;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VKuQVwQN3wupa/wWGwfy2HpIYFCAp6PhOr5/aA9piQw=;
  b=kGJDTSrxVPlGQ7hvsgNNOWBvyj3C3x0r2F2bKbBjaDgomO/n8M7HcmCb
   qNawYE6+DMIKXg6yh/P9l2bSdfMIhFfdqmMe+iS+A7+bZ6hJD/L1LiLMn
   O41D8cWBQ+GKPhY/f2v5pacgm0WsK8Q7cml/2W0wcP2JYhDw0C4TB370k
   11qkvUwAEjjD7Ky+Y3G8J6U5cl6+H5VGM349U1YNfEBeysa49Z+/qyDLI
   iGSD76xfmKRR3UCVjdyw0un3peDrJCHsHY66qcXs9r59GY/My4cnS/iCC
   ThHZriFFoBZM87cSGfbi+hOrZ8W6PhTrLZQ9IvN1XzTmNxfO/Nj2OOGVA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281214559"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="281214559"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 02:54:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="645644075"
Received: from selvaku-mobl.ger.corp.intel.com ([10.252.60.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 02:54:42 -0700
Date:   Sat, 25 Jun 2022 12:54:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 5/8] dt_bindings: rs485: Correct delay values
In-Reply-To: <6c50fdca-aac4-aaf5-ad34-18a60fcc0aa0@gmx.de>
Message-ID: <c8919968-74e8-fc9d-15b4-daa28b48d8d8@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-6-LinoSanfilippo@gmx.de> <YrSU4eL9hgISg3Y1@smile.fi.intel.com> <6c50fdca-aac4-aaf5-ad34-18a60fcc0aa0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022, Lino Sanfilippo wrote:

> On 23.06.22 at 18:29, Andy Shevchenko wrote:
> > On Wed, Jun 22, 2022 at 05:46:56PM +0200, Lino Sanfilippo wrote:
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> The maximum allowed delay for RTS before and RTS after send is 100 ms.
> >> Adjust the documentation accordingly.
> >
> >
> > Is it only documentation issue? If the code allows this to be set higher
> > than 100, we may not change the documentation since this an ABI (from
> > firmware <--> kernel perspective) we need to support old variants.
> >
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

Did you see this development direction (from Lukas):

https://lore.kernel.org/linux-serial/20220309125908.GA9283@wunner.de/

?

Effectively, he wants to making a compat threshold at 1msec and beyond 
that the input value would be interpreted as nsecs.

-- 
 i.

