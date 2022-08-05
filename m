Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B458AC4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiHEOVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbiHEOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:21:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4189E0E1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659709278; x=1691245278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H4oUjAfVG+cVxgQZlTPGzChmgNpT0+EiKhnaSk4xprI=;
  b=R5fcefaIyoskN6YzM740/DUrULx/bYtt9fe/W8MnwcJllwNmIIZeX75G
   ZCwxC2LX6HTdVn3gWkwefSZAU8IsuXJuOUiwa3u+n+BaHDASEvT7NNzvH
   x01m+MnZvAU9v5PDC2DUJqP64Ca1Vcx2sA4SSFSZnZBZp4CCZd0psyZ+T
   2k80QP08TR4XPvMMNpeztTyqB0S8VvNUb5ugioWx+bgd6a+qLt9TZ9Qt6
   uripb6MpdFtxmR6cuC0/wCoLz32gSrNCRDxwGQ8BAbe3ZbdTAMI9jF1gq
   LJdzxIOi/usDT/KXGRCAQ6pj+JRFFcrA2rGm4136AX+z0Gcsm3uzlU02U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="269980262"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="269980262"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 07:21:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="607139561"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 07:21:16 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 05 Aug 2022 17:21:14 +0300
Date:   Fri, 5 Aug 2022 17:21:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <Yu0nWro4xXURbSX6@lahna>
References: <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
 <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
 <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
 <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
 <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 10:13:53PM +0800, Brad Campbell wrote:
> On 5/8/22 21:01, Mika Westerberg wrote:
> > On Fri, Aug 05, 2022 at 08:43:08PM +0800, Brad Campbell wrote:
> > > > Well can you try so that you disable PCIe PM for starters? Pass
> > > > "pcie_port_pm=off" in the command line and see if anything changes. Of
> > > > course this prevents low power states.
> > > > 
> > > 
> > > That allows me to modprobe thunderbolt from an xterm :
> > 
> > Okay does it work any better if you don't have anything attached to the
> > TBT ports when you boot up? If it does, how about just adding a single
> > device (no display connected)?
> > 
> 
> Yes, with nothing attached to the Tb ports it's fine. Been working that way for months.
> 
> With a non-display TB device it appears to work ok also.
> 
> The only device I have that will work on an Apple TB1<->TB2 adapter without external power is
> an Apple TB1->GBe dongle. But that sets up, works and does repeated warn boots. The BIOS even detects
> the network port once Linux has set it up the first time.
> 
> Again, module manually loaded after warm boot :
> 
> [   76.239198] ACPI: bus type thunderbolt registered
> [   76.239225] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
> [   76.239275] thunderbolt 0000:05:00.0: total paths: 12
> [   76.239278] thunderbolt 0000:05:00.0: IOMMU DMA protection is disabled
> [   76.239409] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
> [   76.239422] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
> [   76.239433] thunderbolt 0000:05:00.0: control channel created
> [   76.239436] thunderbolt 0000:05:00.0: ICM not supported on this controller
> [   76.239442] thunderbolt 0000:05:00.0: freeing RX ring 0
> [   76.239447] thunderbolt 0000:05:00.0: freeing TX ring 0
> [   76.239453] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
> [   76.239460] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
> [   76.239466] thunderbolt 0000:05:00.0: control channel created
> [   76.239467] thunderbolt 0000:05:00.0: using software connection manager
> [   76.239467] thunderbolt 0000:05:00.0: NHI initialized, starting thunderbolt
> [   76.239468] thunderbolt 0000:05:00.0: control channel starting...
> [   76.239468] thunderbolt 0000:05:00.0: starting TX ring 0
> [   76.239475] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
> [   76.239477] thunderbolt 0000:05:00.0: starting RX ring 0
> [   76.239484] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
> [   76.239487] thunderbolt 0000:05:00.0: security level set to user
> [   76.239678] thunderbolt 0000:05:00.0: current switch config:
> [   76.239678] thunderbolt 0000:05:00.0:  Thunderbolt 3 Switch: 8086:15ea (Revision: 6, TB Version: 16)
> [   76.239679] thunderbolt 0000:05:00.0:   Max Port Number: 13
> [   76.239680] thunderbolt 0000:05:00.0:   Config:
> [   76.239680] thunderbolt 0000:05:00.0:    Upstream Port Number: 7 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
> [   76.239681] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
> [   76.244798] thunderbolt 0000:05:00.0: initializing Switch at 0x0 (depth: 0, up port: 7)
> [   76.284740] thunderbolt 0000:05:00.0: 0: uid: 0xedd9a650496900
> [   76.286660] thunderbolt 0000:05:00.0:  Port 1: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
> [   76.286663] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
> [   76.286663] thunderbolt 0000:05:00.0:   Max counters: 16
> [   76.286664] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
> [   76.286664] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
> [   76.288580] thunderbolt 0000:05:00.0:  Port 2: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
> [   76.288581] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
> [   76.288582] thunderbolt 0000:05:00.0:   Max counters: 16
> [   76.288582] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
> [   76.288583] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
> [   76.290500] thunderbolt 0000:05:00.0:  Port 3: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
> [   76.290500] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
> [   76.290501] thunderbolt 0000:05:00.0:   Max counters: 16
> [   76.290501] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
> [   76.290502] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
> [   76.292416] thunderbolt 0000:05:00.0:  Port 4: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
> [   76.292417] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
> [   76.292417] thunderbolt 0000:05:00.0:   Max counters: 16
> [   76.292417] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
> [   76.292418] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
> [   76.292677] thunderbolt 0000:05:00.0:  Port 5: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
> [   76.292678] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
> [   76.292679] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.292679] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
> [   76.292680] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
> [   76.292932] thunderbolt 0000:05:00.0:  Port 6: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
> [   76.292933] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
> [   76.292933] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.292934] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
> [   76.292934] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
> [   76.293700] thunderbolt 0000:05:00.0:  Port 7: 8086:15ea (Revision: 6, TB Version: 1, Type: NHI (0x2))
> [   76.293701] thunderbolt 0000:05:00.0:   Max hop id (in/out): 11/11
> [   76.293701] thunderbolt 0000:05:00.0:   Max counters: 16
> [   76.293702] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
> [   76.293702] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
> [   76.293956] thunderbolt 0000:05:00.0:  Port 8: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
> [   76.293957] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
> [   76.293957] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.293958] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
> [   76.293958] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
> [   76.294212] thunderbolt 0000:05:00.0:  Port 9: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
> [   76.294212] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
> [   76.294213] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.294213] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
> [   76.294214] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
> [   76.294724] thunderbolt 0000:05:00.0:  Port 10: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
> [   76.294725] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
> [   76.294725] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.294726] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
> [   76.294726] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
> [   76.295232] thunderbolt 0000:05:00.0:  Port 11: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
> [   76.295233] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
> [   76.295234] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.295234] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
> [   76.295235] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
> [   76.295488] thunderbolt 0000:05:00.0:  Port 12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
> [   76.295489] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
> [   76.295489] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.295490] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
> [   76.295490] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
> [   76.295743] thunderbolt 0000:05:00.0:  Port 13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
> [   76.295743] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
> [   76.295744] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.295744] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
> [   76.295745] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
> [   76.295745] thunderbolt 0000:05:00.0: 0: linked ports 1 <-> 2
> [   76.295746] thunderbolt 0000:05:00.0: 0: linked ports 3 <-> 4
> [   76.300868] thunderbolt 0000:05:00.0: 0: TMU: supports uni-directional mode
> [   76.300869] thunderbolt 0000:05:00.0: 0: TMU: current mode: HiFi
> [   76.300993] thunderbolt 0000:05:00.0: 0:1: is unplugged (state: 7)
> [   76.301120] thunderbolt 0000:05:00.0: 0:3: is connected, link is up (state: 2)
> [   76.301376] thunderbolt 0000:05:00.0: current switch config:
> [   76.301377] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1549 (Revision: 0, TB Version: 1)
> [   76.301378] thunderbolt 0000:05:00.0:   Max Port Number: 2
> [   76.301378] thunderbolt 0000:05:00.0:   Config:
> [   76.301378] thunderbolt 0000:05:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
> [   76.301379] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
> [   76.304961] thunderbolt 0000:05:00.0: 3: unknown capability 0xef at 0x95
> [   76.306373] thunderbolt 0000:05:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
> [   76.323781] thunderbolt 0000:05:00.0: 3: reading drom (length: 0x7b)
> [   76.727884] thunderbolt 0000:05:00.0: 3: DROM version: 1
> [   76.728135] thunderbolt 0000:05:00.0: 3: uid: 0x1000206596ce0
> [   76.730061] thunderbolt 0000:05:00.0:  Port 1: 8086:1549 (Revision: 0, TB Version: 1, Type: Port (0x1))
> [   76.730062] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
> [   76.730063] thunderbolt 0000:05:00.0:   Max counters: 4
> [   76.730063] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
> [   76.730064] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
> [   76.730315] thunderbolt 0000:05:00.0:  Port 2: 8086:1549 (Revision: 0, TB Version: 1, Type: PCIe (0x100102))
> [   76.730316] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
> [   76.730316] thunderbolt 0000:05:00.0:   Max counters: 2
> [   76.730317] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
> [   76.730317] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
> [   76.731467] thunderbolt 0000:05:00.0: 3: TMU: current mode: bi-directional, HiFi
> [   76.731475] thunderbolt 0-3: new device found, vendor=0x1 device=0x8003
> [   76.731477] thunderbolt 0-3: Apple, Inc. Thunderbolt to Gigabit Ethernet Adapter
> [   76.732870] thunderbolt 0000:05:00.0: discovering PCIe Up path starting from 0:9
> [   76.733000] thunderbolt 0000:05:00.0: 0:9:  In HopID: 8 => Out port: 3 Out HopID: 8
> [   76.733001] thunderbolt 0000:05:00.0: 0:9:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
> [   76.733002] thunderbolt 0000:05:00.0: 0:9:    Counter enabled: 0 Counter index: 2047
> [   76.733003] thunderbolt 0000:05:00.0: 0:9:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
> [   76.733004] thunderbolt 0000:05:00.0: 0:9:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
> [   76.733127] thunderbolt 0000:05:00.0: 3:1:  In HopID: 8 => Out port: 2 Out HopID: 8
> [   76.733128] thunderbolt 0000:05:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
> [   76.733129] thunderbolt 0000:05:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
> [   76.733129] thunderbolt 0000:05:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
> [   76.733130] thunderbolt 0000:05:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
> [   76.733131] thunderbolt 0000:05:00.0: path discovery complete
> [   76.733639] thunderbolt 0000:05:00.0: discovering PCIe Down path starting from 3:2
> [   76.733768] thunderbolt 0000:05:00.0: 3:2:  In HopID: 8 => Out port: 1 Out HopID: 8
> [   76.733769] thunderbolt 0000:05:00.0: 3:2:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
> [   76.733770] thunderbolt 0000:05:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
> [   76.733770] thunderbolt 0000:05:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
> [   76.733771] thunderbolt 0000:05:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
> [   76.733893] thunderbolt 0000:05:00.0: 0:3:  In HopID: 8 => Out port: 9 Out HopID: 8
> [   76.733894] thunderbolt 0000:05:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
> [   76.733894] thunderbolt 0000:05:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
> [   76.733895] thunderbolt 0000:05:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
> [   76.733896] thunderbolt 0000:05:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
> [   76.733897] thunderbolt 0000:05:00.0: path discovery complete
> [   76.734028] thunderbolt 0000:05:00.0: 0:9 <-> 3:2 (PCI): discovered
> [   76.734150] thunderbolt 0000:05:00.0: 0:5: DP IN resource available
> [   76.734277] thunderbolt 0000:05:00.0: 0:6: DP IN resource available
> 
> I now wonder if it's one of the PCIe connected devices in the Thunderbolt displays not "playing nice" ?

They are pretty standard so I suspect myself the display side of things.
Not sure if it is possible (I think it is from sysfs /sys/class/drm/*)
to disable the tunneled DP connections and see if that makes it not
hang. Alternatively you can try to comment out the call to
tb_tunnel_dp() from the driver. Let me know if you want me to make hack
patch that does it for you.
