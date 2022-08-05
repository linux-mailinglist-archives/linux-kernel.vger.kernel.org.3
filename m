Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAD258AA22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbiHELaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbiHELaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:30:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1606E2BF7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659699016; x=1691235016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8xNLtusIimRO9mhtCJCbCypio6ydvA8reKrCEGaRvBk=;
  b=dRHhEpqX9Z3DnsrtWWz7n1y3DEYSIEsGpAo+vEgfMXYevkF2cPR5dMYr
   kZyzRl+StknW6jsRxUx1FiB0cVRZX5aTBBf3ApJokSswRWQY4K6Tu7z8m
   O8C6vlvsF52exLakUqcukal1I7QBYOl7qUB7MxB1Iw6BeQGgB3OyaC/jO
   nglKqq1TziOWuEjI7nk7gp47UtcHf+REq5CjHaig8q+etK4y8iRMBDV2l
   TmQIcHrSPi+FgW0FrKecWYeYDyA6mR4ClJ/I0JiRt39Fj4qpQRQLtgUpK
   9R5h/gB3HGJFNqR7MosP56SEE2mIGekfvUgmbKD3nCBZiZ3E0p9WMb4EC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="287742983"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287742983"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 04:30:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671660992"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 04:30:14 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 05 Aug 2022 14:30:11 +0300
Date:   Fri, 5 Aug 2022 14:30:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <Yuz/Q3MTVIhCZU+0@lahna>
References: <YkXYdcUZ1E18ENle@lahna>
 <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
 <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
 <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
 <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
 <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 05, 2022 at 03:41:14PM +0800, Brad Campbell wrote:
> [  620.072070] pcieport 0000:2a:05.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  620.676124] pcieport 0000:2a:05.0: pciehp: pcie_do_write_cmd: no response from device
> [  621.903381] hrtimer: interrupt took 604006559 ns
> [  622.296070] pcieport 0000:2a:05.0: pciehp: pcie_do_write_cmd: no response from device
> [  622.698769] pcieport 0000:31:05.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  623.302796] pcieport 0000:31:05.0: pciehp: pcie_do_write_cmd: no response from device
> [  623.906840] pcieport 0000:31:04.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  624.511090] pcieport 0000:31:04.0: pciehp: pcie_do_write_cmd: no response from device
> [  625.115091] pcieport 0000:04:01.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  625.719304] pcieport 0000:04:01.0: pciehp: pcie_do_write_cmd: no response from device
> [  625.920747] thunderbolt 0000:05:00.0: 303: timeout writing config space 2 to 0x28
> [  625.920752] thunderbolt 0-303: reading DROM failed: -5
> [  625.920753] thunderbolt 0000:05:00.0: 303: uid: 0x0
> [  626.524964] pcieport 0000:31:05.0: pciehp: pcie_do_write_cmd: no response from device
> [  626.726306] pcieport 0000:31:04.0: pciehp: pcie_do_write_cmd: no response from device
> [  626.927661] pcieport 0000:04:01.0: pciehp: pcie_do_write_cmd: no response from device
> [  627.330332] pcieport 0000:04:02.0: can't change power state from D3cold to D0 (config space inaccessible)
> [  627.837000] thunderbolt 0000:05:00.0: 303: timeout reading config space 1 from 0x0
> [  627.837005] thunderbolt 0-303: failed to initialize port 1
> [  628.277015] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x3b
> [  628.716825] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x3b
> [  629.156976] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x3b
> [  629.597002] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
> [  630.037013] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
> [  630.477032] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
> [  630.916994] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
> [  631.356836] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x39
> [  631.806792] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x39
> [  632.246828] thunderbolt 0000:05:00.0: 0: timeout reading config space 2 from 0x10f
> [  632.686977] thunderbolt 0000:05:00.0: 0: timeout reading config space 2 from 0x10f
> 
> I'm dangerously *assuming* that when trying to configure an already configured system the thunderbolt
> driver is getting stuck because booting without trying to load the driver works fine.
> 
> If I try and warm boot when its in this state, the machine doesn't reach the EFI and I have to
> hard reset or power cycle.
> 
> My questions are :
> A) Since I have a viable but hacky work-around, is this something
> you'd be interested in helping chase down?

I can try yes.

> B) If so, what debugging information can I supply?

Well can you try so that you disable PCIe PM for starters? Pass
"pcie_port_pm=off" in the command line and see if anything changes. Of
course this prevents low power states.
