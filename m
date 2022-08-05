Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA458AC32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbiHEOOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiHEOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:14:00 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E1C17E2F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:13:57 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oJy5K-0002Fg-CD; Sat, 06 Aug 2022 00:13:54 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GwU75RuJ0DPnoHO+lfZmU3G8AkxN2l5p2ksQmGsm6bo=; b=RV7goBI8aHN9cbrbuW2naCUfaH
        JngnuHa4vA004Pxs5o8hMcZNY6O6CLFrU+TMTViV605AZxlZIiQM9ckHfnWxd104p0ITPw8LfdGFQ
        tlzRmjkTFeqh6zkLa5oVpp4Sdl8t88jdx3I+Xwc+EAeHO4I71V4MVcJly9EQRYvyVrDk=;
Message-ID: <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
Date:   Fri, 5 Aug 2022 22:13:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
 <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
 <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
 <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
 <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
Content-Language: en-AU
In-Reply-To: <Yu0UuOVGeIv/U+jU@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/22 21:01, Mika Westerberg wrote:
> On Fri, Aug 05, 2022 at 08:43:08PM +0800, Brad Campbell wrote:
>>> Well can you try so that you disable PCIe PM for starters? Pass
>>> "pcie_port_pm=off" in the command line and see if anything changes. Of
>>> course this prevents low power states.
>>>
>>
>> That allows me to modprobe thunderbolt from an xterm :
> 
> Okay does it work any better if you don't have anything attached to the
> TBT ports when you boot up? If it does, how about just adding a single
> device (no display connected)?
> 

Yes, with nothing attached to the Tb ports it's fine. Been working that way for months.

With a non-display TB device it appears to work ok also.

The only device I have that will work on an Apple TB1<->TB2 adapter without external power is
an Apple TB1->GBe dongle. But that sets up, works and does repeated warn boots. The BIOS even detects
the network port once Linux has set it up the first time.

Again, module manually loaded after warm boot :

[   76.239198] ACPI: bus type thunderbolt registered
[   76.239225] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[   76.239275] thunderbolt 0000:05:00.0: total paths: 12
[   76.239278] thunderbolt 0000:05:00.0: IOMMU DMA protection is disabled
[   76.239409] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[   76.239422] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[   76.239433] thunderbolt 0000:05:00.0: control channel created
[   76.239436] thunderbolt 0000:05:00.0: ICM not supported on this controller
[   76.239442] thunderbolt 0000:05:00.0: freeing RX ring 0
[   76.239447] thunderbolt 0000:05:00.0: freeing TX ring 0
[   76.239453] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[   76.239460] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[   76.239466] thunderbolt 0000:05:00.0: control channel created
[   76.239467] thunderbolt 0000:05:00.0: using software connection manager
[   76.239467] thunderbolt 0000:05:00.0: NHI initialized, starting thunderbolt
[   76.239468] thunderbolt 0000:05:00.0: control channel starting...
[   76.239468] thunderbolt 0000:05:00.0: starting TX ring 0
[   76.239475] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[   76.239477] thunderbolt 0000:05:00.0: starting RX ring 0
[   76.239484] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[   76.239487] thunderbolt 0000:05:00.0: security level set to user
[   76.239678] thunderbolt 0000:05:00.0: current switch config:
[   76.239678] thunderbolt 0000:05:00.0:  Thunderbolt 3 Switch: 8086:15ea (Revision: 6, TB Version: 16)
[   76.239679] thunderbolt 0000:05:00.0:   Max Port Number: 13
[   76.239680] thunderbolt 0000:05:00.0:   Config:
[   76.239680] thunderbolt 0000:05:00.0:    Upstream Port Number: 7 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[   76.239681] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[   76.244798] thunderbolt 0000:05:00.0: initializing Switch at 0x0 (depth: 0, up port: 7)
[   76.284740] thunderbolt 0000:05:00.0: 0: uid: 0xedd9a650496900
[   76.286660] thunderbolt 0000:05:00.0:  Port 1: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   76.286663] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   76.286663] thunderbolt 0000:05:00.0:   Max counters: 16
[   76.286664] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   76.286664] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   76.288580] thunderbolt 0000:05:00.0:  Port 2: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   76.288581] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   76.288582] thunderbolt 0000:05:00.0:   Max counters: 16
[   76.288582] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   76.288583] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   76.290500] thunderbolt 0000:05:00.0:  Port 3: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   76.290500] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   76.290501] thunderbolt 0000:05:00.0:   Max counters: 16
[   76.290501] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   76.290502] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   76.292416] thunderbolt 0000:05:00.0:  Port 4: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   76.292417] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   76.292417] thunderbolt 0000:05:00.0:   Max counters: 16
[   76.292417] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   76.292418] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   76.292677] thunderbolt 0000:05:00.0:  Port 5: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[   76.292678] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[   76.292679] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.292679] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[   76.292680] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   76.292932] thunderbolt 0000:05:00.0:  Port 6: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[   76.292933] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[   76.292933] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.292934] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[   76.292934] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   76.293700] thunderbolt 0000:05:00.0:  Port 7: 8086:15ea (Revision: 6, TB Version: 1, Type: NHI (0x2))
[   76.293701] thunderbolt 0000:05:00.0:   Max hop id (in/out): 11/11
[   76.293701] thunderbolt 0000:05:00.0:   Max counters: 16
[   76.293702] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[   76.293702] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   76.293956] thunderbolt 0000:05:00.0:  Port 8: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   76.293957] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   76.293957] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.293958] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   76.293958] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   76.294212] thunderbolt 0000:05:00.0:  Port 9: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   76.294212] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   76.294213] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.294213] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   76.294214] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   76.294724] thunderbolt 0000:05:00.0:  Port 10: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   76.294725] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   76.294725] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.294726] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   76.294726] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   76.295232] thunderbolt 0000:05:00.0:  Port 11: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   76.295233] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   76.295234] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.295234] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   76.295235] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   76.295488] thunderbolt 0000:05:00.0:  Port 12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   76.295489] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   76.295489] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.295490] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   76.295490] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   76.295743] thunderbolt 0000:05:00.0:  Port 13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   76.295743] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   76.295744] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.295744] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   76.295745] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   76.295745] thunderbolt 0000:05:00.0: 0: linked ports 1 <-> 2
[   76.295746] thunderbolt 0000:05:00.0: 0: linked ports 3 <-> 4
[   76.300868] thunderbolt 0000:05:00.0: 0: TMU: supports uni-directional mode
[   76.300869] thunderbolt 0000:05:00.0: 0: TMU: current mode: HiFi
[   76.300993] thunderbolt 0000:05:00.0: 0:1: is unplugged (state: 7)
[   76.301120] thunderbolt 0000:05:00.0: 0:3: is connected, link is up (state: 2)
[   76.301376] thunderbolt 0000:05:00.0: current switch config:
[   76.301377] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1549 (Revision: 0, TB Version: 1)
[   76.301378] thunderbolt 0000:05:00.0:   Max Port Number: 2
[   76.301378] thunderbolt 0000:05:00.0:   Config:
[   76.301378] thunderbolt 0000:05:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[   76.301379] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[   76.304961] thunderbolt 0000:05:00.0: 3: unknown capability 0xef at 0x95
[   76.306373] thunderbolt 0000:05:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   76.323781] thunderbolt 0000:05:00.0: 3: reading drom (length: 0x7b)
[   76.727884] thunderbolt 0000:05:00.0: 3: DROM version: 1
[   76.728135] thunderbolt 0000:05:00.0: 3: uid: 0x1000206596ce0
[   76.730061] thunderbolt 0000:05:00.0:  Port 1: 8086:1549 (Revision: 0, TB Version: 1, Type: Port (0x1))
[   76.730062] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   76.730063] thunderbolt 0000:05:00.0:   Max counters: 4
[   76.730063] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   76.730064] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   76.730315] thunderbolt 0000:05:00.0:  Port 2: 8086:1549 (Revision: 0, TB Version: 1, Type: PCIe (0x100102))
[   76.730316] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   76.730316] thunderbolt 0000:05:00.0:   Max counters: 2
[   76.730317] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   76.730317] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   76.731467] thunderbolt 0000:05:00.0: 3: TMU: current mode: bi-directional, HiFi
[   76.731475] thunderbolt 0-3: new device found, vendor=0x1 device=0x8003
[   76.731477] thunderbolt 0-3: Apple, Inc. Thunderbolt to Gigabit Ethernet Adapter
[   76.732870] thunderbolt 0000:05:00.0: discovering PCIe Up path starting from 0:9
[   76.733000] thunderbolt 0000:05:00.0: 0:9:  In HopID: 8 => Out port: 3 Out HopID: 8
[   76.733001] thunderbolt 0000:05:00.0: 0:9:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   76.733002] thunderbolt 0000:05:00.0: 0:9:    Counter enabled: 0 Counter index: 2047
[   76.733003] thunderbolt 0000:05:00.0: 0:9:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   76.733004] thunderbolt 0000:05:00.0: 0:9:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   76.733127] thunderbolt 0000:05:00.0: 3:1:  In HopID: 8 => Out port: 2 Out HopID: 8
[   76.733128] thunderbolt 0000:05:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   76.733129] thunderbolt 0000:05:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   76.733129] thunderbolt 0000:05:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   76.733130] thunderbolt 0000:05:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   76.733131] thunderbolt 0000:05:00.0: path discovery complete
[   76.733639] thunderbolt 0000:05:00.0: discovering PCIe Down path starting from 3:2
[   76.733768] thunderbolt 0000:05:00.0: 3:2:  In HopID: 8 => Out port: 1 Out HopID: 8
[   76.733769] thunderbolt 0000:05:00.0: 3:2:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   76.733770] thunderbolt 0000:05:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   76.733770] thunderbolt 0000:05:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   76.733771] thunderbolt 0000:05:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   76.733893] thunderbolt 0000:05:00.0: 0:3:  In HopID: 8 => Out port: 9 Out HopID: 8
[   76.733894] thunderbolt 0000:05:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   76.733894] thunderbolt 0000:05:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   76.733895] thunderbolt 0000:05:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   76.733896] thunderbolt 0000:05:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   76.733897] thunderbolt 0000:05:00.0: path discovery complete
[   76.734028] thunderbolt 0000:05:00.0: 0:9 <-> 3:2 (PCI): discovered
[   76.734150] thunderbolt 0000:05:00.0: 0:5: DP IN resource available
[   76.734277] thunderbolt 0000:05:00.0: 0:6: DP IN resource available

I now wonder if it's one of the PCIe connected devices in the Thunderbolt displays not "playing nice" ?

Regards,
Brad
