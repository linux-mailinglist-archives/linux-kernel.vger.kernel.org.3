Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A515755DE28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiF0JXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiF0JXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:23:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A10E2DE4;
        Mon, 27 Jun 2022 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656321826; x=1687857826;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vtuj/GeBkHA5KwrozFoymb6ynohmJjqPDoiYReRC71M=;
  b=Ont6+M/g9gEOW3MInanIlfh2bgHK14dowpLEaHepq3k85OOB9Nb7c7h7
   HuNv+7bowbPtPDZWXMTOyU8uBMEYFbnFvgR6QIb7pJTd28kMjH8qkZftv
   xeXMNUkGglVpIyUQD6CRMdLkh2Ex9gVwZeMG7Z92XsgS2zWWRNAcs2kXz
   ySuKAPszvlgBUP+XMr69Fymu9p1JzNwcVKXboRWIC8WywmXSpGwLoGriv
   RoVDeRO6chVOxmhMJri/cJBqwOaIAXRNSbfKy716yf9W8VvS+JLNMwFyO
   ctSyw9yJhHFu8RJvDXVr25xNyWvzu8YTcVPf0xjIbunhWyKEhf71MTY4b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="345407303"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="345407303"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 02:23:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="646353034"
Received: from gretavix-mobl3.amr.corp.intel.com ([10.249.43.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 02:23:42 -0700
Date:   Mon, 27 Jun 2022 12:23:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 5/8] dt_bindings: rs485: Correct delay values
In-Reply-To: <c8919968-74e8-fc9d-15b4-daa28b48d8d8@linux.intel.com>
Message-ID: <9f3accf9-319-f0b-9035-9cff3c6cbf@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-6-LinoSanfilippo@gmx.de> <YrSU4eL9hgISg3Y1@smile.fi.intel.com> <6c50fdca-aac4-aaf5-ad34-18a60fcc0aa0@gmx.de> <c8919968-74e8-fc9d-15b4-daa28b48d8d8@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1944914680-1656321828=:1622"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1944914680-1656321828=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 25 Jun 2022, Ilpo Järvinen wrote:

> On Thu, 23 Jun 2022, Lino Sanfilippo wrote:
> 
> > On 23.06.22 at 18:29, Andy Shevchenko wrote:
> > > On Wed, Jun 22, 2022 at 05:46:56PM +0200, Lino Sanfilippo wrote:
> > >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > >>
> > >> The maximum allowed delay for RTS before and RTS after send is 100 ms.
> > >> Adjust the documentation accordingly.
> > >
> > >
> > > Is it only documentation issue? If the code allows this to be set higher
> > > than 100, we may not change the documentation since this an ABI (from
> > > firmware <--> kernel perspective) we need to support old variants.
> > >
> > 
> > Well currently the documentation claims that a maximum of 1000 msecs is allowed but
> > nothing actually checks the values read from device tree/ACPI and so it is possible
> > to set much higher values (note that the UART drivers dont check the delays read from
> > DT/ACPI either, the only exception I found is max310x which clamps it to 15 ms).
> > 
> > We already have a maximum of 100 ms defined for RTS delays set via TIOCSRS485. To be
> > consistent with TIOCSRS485 the same limit is used for DT/ACPI values in this patch.
> > 
> > I am aware that this changes the firmware/kernel ABI. But we had a similar situation when
> > the sanity checks for TIOCSRS485 were introduced
> > (see https://lore.kernel.org/all/20220410104642.32195-2-LinoSanfilippo@gmx.de/)
> > since before we did not have those limits for all drivers (some drivers clamped the
> > values itself but many did not care).
> > Furthermore 100 ms is already a very high value for RTS delays (which are usually rather
> > in usecs range). So IMHO the risk is very low to break anything when values are clamped
> > that are higher than that.
> 
> Did you see this development direction (from Lukas):
> 
> https://lore.kernel.org/linux-serial/20220309125908.GA9283@wunner.de/
> 
> ?
> 
> Effectively, he wants to making a compat threshold at 1msec and beyond 
> that the input value would be interpreted as nsecs.

I was thinking this more the other day and came up with the idea of adding
SER_RS485_DELAY_RTS_NSEC and SER_RS485_DELAY_RTS_MSEC flags instead of
magic threshold and deprecate specifying those delays w/o either flag. 
That way we'd not need to change behavior and we provide an easy way to 
keep the delay in msec if somebody really wants (just for the sake of 
getting rid of the warning).

-- 
 i.

--8323329-1944914680-1656321828=:1622--
