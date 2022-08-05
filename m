Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E158AAF6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbiHEMnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiHEMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:43:16 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DE218341
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:43:12 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oJwfV-0002DF-Cc; Fri, 05 Aug 2022 22:43:09 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XANKiMxsnLQLBVHNNbP3DcmKvhZD0y02iF/Au5HpZ28=; b=UAc1BSL6sdSX05PonyAMlqP5j+
        pm1G5yZVCQjecW6JhyjPEJyUmnoZilxoDcKOOENVs9ba8jWR6sz3xl+eY6d1efqDffKEYhyz4WkJP
        TcUUlWJU5x62A26OWvYn/J88mK8xHLn/C7HsP2ZUUixeqHPvLzlp2IZqJUI7VAJqINT8=;
Message-ID: <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
Date:   Fri, 5 Aug 2022 20:43:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
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
 <Yuz/Q3MTVIhCZU+0@lahna>
Content-Language: en-AU
In-Reply-To: <Yuz/Q3MTVIhCZU+0@lahna>
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

On 5/8/22 19:30, Mika Westerberg wrote:
> Hi,
> 
> On Fri, Aug 05, 2022 at 03:41:14PM +0800, Brad Campbell wrote:
>> [  620.072070] pcieport 0000:2a:05.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [  620.676124] pcieport 0000:2a:05.0: pciehp: pcie_do_write_cmd: no response from device
>> [  621.903381] hrtimer: interrupt took 604006559 ns
>> [  622.296070] pcieport 0000:2a:05.0: pciehp: pcie_do_write_cmd: no response from device
>> [  622.698769] pcieport 0000:31:05.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [  623.302796] pcieport 0000:31:05.0: pciehp: pcie_do_write_cmd: no response from device
>> [  623.906840] pcieport 0000:31:04.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [  624.511090] pcieport 0000:31:04.0: pciehp: pcie_do_write_cmd: no response from device
>> [  625.115091] pcieport 0000:04:01.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [  625.719304] pcieport 0000:04:01.0: pciehp: pcie_do_write_cmd: no response from device
>> [  625.920747] thunderbolt 0000:05:00.0: 303: timeout writing config space 2 to 0x28
>> [  625.920752] thunderbolt 0-303: reading DROM failed: -5
>> [  625.920753] thunderbolt 0000:05:00.0: 303: uid: 0x0
>> [  626.524964] pcieport 0000:31:05.0: pciehp: pcie_do_write_cmd: no response from device
>> [  626.726306] pcieport 0000:31:04.0: pciehp: pcie_do_write_cmd: no response from device
>> [  626.927661] pcieport 0000:04:01.0: pciehp: pcie_do_write_cmd: no response from device
>> [  627.330332] pcieport 0000:04:02.0: can't change power state from D3cold to D0 (config space inaccessible)
>> [  627.837000] thunderbolt 0000:05:00.0: 303: timeout reading config space 1 from 0x0
>> [  627.837005] thunderbolt 0-303: failed to initialize port 1
>> [  628.277015] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x3b
>> [  628.716825] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x3b
>> [  629.156976] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x3b
>> [  629.597002] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
>> [  630.037013] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
>> [  630.477032] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
>> [  630.916994] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
>> [  631.356836] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x39
>> [  631.806792] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x39
>> [  632.246828] thunderbolt 0000:05:00.0: 0: timeout reading config space 2 from 0x10f
>> [  632.686977] thunderbolt 0000:05:00.0: 0: timeout reading config space 2 from 0x10f
>>
>> I'm dangerously *assuming* that when trying to configure an already configured system the thunderbolt
>> driver is getting stuck because booting without trying to load the driver works fine.
>>
>> If I try and warm boot when its in this state, the machine doesn't reach the EFI and I have to
>> hard reset or power cycle.
>>
>> My questions are :
>> A) Since I have a viable but hacky work-around, is this something
>> you'd be interested in helping chase down?
> 
> I can try yes.
> 
>> B) If so, what debugging information can I supply?
> 
> Well can you try so that you disable PCIe PM for starters? Pass
> "pcie_port_pm=off" in the command line and see if anything changes. Of
> course this prevents low power states.
> 

That allows me to modprobe thunderbolt from an xterm :

[   79.123662] ACPI: bus type thunderbolt registered
[   79.123692] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[   79.123744] thunderbolt 0000:05:00.0: total paths: 12
[   79.123751] thunderbolt 0000:05:00.0: IOMMU DMA protection is disabled
[   79.123886] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[   79.123899] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[   79.123908] thunderbolt 0000:05:00.0: control channel created
[   79.123911] thunderbolt 0000:05:00.0: ICM not supported on this controller
[   79.123918] thunderbolt 0000:05:00.0: freeing RX ring 0
[   79.123923] thunderbolt 0000:05:00.0: freeing TX ring 0
[   79.123928] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[   79.123934] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[   79.123941] thunderbolt 0000:05:00.0: control channel created
[   79.123941] thunderbolt 0000:05:00.0: using software connection manager
[   79.123942] thunderbolt 0000:05:00.0: NHI initialized, starting thunderbolt
[   79.123942] thunderbolt 0000:05:00.0: control channel starting...
[   79.123943] thunderbolt 0000:05:00.0: starting TX ring 0
[   79.123950] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[   79.123952] thunderbolt 0000:05:00.0: starting RX ring 0
[   79.123959] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[   79.123963] thunderbolt 0000:05:00.0: security level set to user
[   79.124115] thunderbolt 0000:05:00.0: current switch config:
[   79.124116] thunderbolt 0000:05:00.0:  Thunderbolt 3 Switch: 8086:15ea (Revision: 6, TB Version: 16)
[   79.124117] thunderbolt 0000:05:00.0:   Max Port Number: 13
[   79.124117] thunderbolt 0000:05:00.0:   Config:
[   79.124118] thunderbolt 0000:05:00.0:    Upstream Port Number: 7 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[   79.124119] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[   79.129236] thunderbolt 0000:05:00.0: initializing Switch at 0x0 (depth: 0, up port: 7)
[   79.169173] thunderbolt 0000:05:00.0: 0: uid: 0xedd9a650496900
[   79.171088] thunderbolt 0000:05:00.0:  Port 1: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   79.171090] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   79.171090] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.171091] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.171092] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.173008] thunderbolt 0000:05:00.0:  Port 2: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   79.173009] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   79.173010] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.173010] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.173011] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.174932] thunderbolt 0000:05:00.0:  Port 3: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   79.174933] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   79.174933] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.174934] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.174934] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.176852] thunderbolt 0000:05:00.0:  Port 4: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[   79.176853] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[   79.176853] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.176854] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.176854] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.177104] thunderbolt 0000:05:00.0:  Port 5: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[   79.177106] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[   79.177107] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.177107] thunderbolt 0000:05:00.0:   NFC Credits: 0x180000c
[   79.177107] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   79.177364] thunderbolt 0000:05:00.0:  Port 6: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[   79.177365] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[   79.177366] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.177366] thunderbolt 0000:05:00.0:   NFC Credits: 0x180000c
[   79.177366] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   79.178134] thunderbolt 0000:05:00.0:  Port 7: 8086:15ea (Revision: 6, TB Version: 1, Type: NHI (0x2))
[   79.178135] thunderbolt 0000:05:00.0:   Max hop id (in/out): 11/11
[   79.178136] thunderbolt 0000:05:00.0:   Max counters: 16
[   79.178136] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[   79.178137] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[   79.178388] thunderbolt 0000:05:00.0:  Port 8: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   79.178389] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.178390] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.178390] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.178391] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.178644] thunderbolt 0000:05:00.0:  Port 9: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[   79.178645] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.178645] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.178646] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.178646] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.179156] thunderbolt 0000:05:00.0:  Port 10: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   79.179157] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   79.179158] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.179158] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.179159] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.179668] thunderbolt 0000:05:00.0:  Port 11: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[   79.179669] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   79.179669] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.179670] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.179670] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.179924] thunderbolt 0000:05:00.0:  Port 12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   79.179925] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.179926] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.179926] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.179926] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.180180] thunderbolt 0000:05:00.0:  Port 13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[   79.180181] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.180181] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.180182] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[   79.180182] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[   79.180183] thunderbolt 0000:05:00.0: 0: linked ports 1 <-> 2
[   79.180183] thunderbolt 0000:05:00.0: 0: linked ports 3 <-> 4
[   79.185300] thunderbolt 0000:05:00.0: 0: TMU: supports uni-directional mode
[   79.185301] thunderbolt 0000:05:00.0: 0: TMU: current mode: HiFi
[   79.185425] thunderbolt 0000:05:00.0: 0:1: is unplugged (state: 7)
[   79.185556] thunderbolt 0000:05:00.0: 0:3: is connected, link is up (state: 2)
[   79.185810] thunderbolt 0000:05:00.0: current switch config:
[   79.185811] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   79.185812] thunderbolt 0000:05:00.0:   Max Port Number: 13
[   79.185813] thunderbolt 0000:05:00.0:   Config:
[   79.185813] thunderbolt 0000:05:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[   79.185814] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[   79.190417] thunderbolt 0000:05:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[   79.207829] thunderbolt 0000:05:00.0: 3: reading drom (length: 0x97)
[   79.701533] thunderbolt 0000:05:00.0: 3: DROM version: 1
[   79.702553] thunderbolt 0000:05:00.0: 3: uid: 0x1000100189170
[   79.705501] thunderbolt 0000:05:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   79.705503] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   79.705504] thunderbolt 0000:05:00.0:   Max counters: 32
[   79.705504] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c0000c
[   79.705505] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.708445] thunderbolt 0000:05:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   79.708447] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   79.708448] thunderbolt 0000:05:00.0:   Max counters: 32
[   79.708448] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c0000c
[   79.708449] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.711384] thunderbolt 0000:05:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   79.711385] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   79.711385] thunderbolt 0000:05:00.0:   Max counters: 32
[   79.711386] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.711386] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.714329] thunderbolt 0000:05:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   79.714330] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   79.714331] thunderbolt 0000:05:00.0:   Max counters: 32
[   79.714331] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   79.714332] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   79.714332] thunderbolt 0000:05:00.0: 3:5: disabled by eeprom
[   79.714333] thunderbolt 0000:05:00.0: 3:6: disabled by eeprom
[   79.715229] thunderbolt 0000:05:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   79.715230] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.715231] thunderbolt 0000:05:00.0:   Max counters: 1
[   79.715231] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   79.715232] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   79.716121] thunderbolt 0000:05:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   79.716122] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.716123] thunderbolt 0000:05:00.0:   Max counters: 1
[   79.716123] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   79.716123] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   79.716124] thunderbolt 0000:05:00.0: 3:9: disabled by eeprom
[   79.717017] thunderbolt 0000:05:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   79.717018] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   79.717018] thunderbolt 0000:05:00.0:   Max counters: 1
[   79.717019] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   79.717019] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   79.718168] thunderbolt 0000:05:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   79.718170] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   79.718170] thunderbolt 0000:05:00.0:   Max counters: 2
[   79.718171] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   79.718171] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   79.718172] thunderbolt 0000:05:00.0: 3:12: disabled by eeprom
[   79.718173] thunderbolt 0000:05:00.0: 3:13: disabled by eeprom
[   79.736492] thunderbolt 0000:05:00.0: 3: TMU: current mode: bi-directional, HiFi
[   79.736504] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[   79.736506] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[   79.737004] thunderbolt 0000:05:00.0: 3:3: is connected, link is up (state: 2)
[   79.737260] thunderbolt 0000:05:00.0: current switch config:
[   79.737260] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[   79.737262] thunderbolt 0000:05:00.0:   Max Port Number: 13
[   79.737262] thunderbolt 0000:05:00.0:   Config:
[   79.737262] thunderbolt 0000:05:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x303 Enabled: 1, PlugEventsDelay: 255ms
[   79.737264] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[   79.741868] thunderbolt 0000:05:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[   79.759278] thunderbolt 0000:05:00.0: 303: reading drom (length: 0x97)
[   80.252978] thunderbolt 0000:05:00.0: 303: DROM version: 1
[   80.254002] thunderbolt 0000:05:00.0: 303: uid: 0x100010102a740
[   80.256943] thunderbolt 0000:05:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.256945] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.256946] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.256947] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.256947] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.259889] thunderbolt 0000:05:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.259891] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.259892] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.259892] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.259893] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.262833] thunderbolt 0000:05:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.262834] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.262835] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.262835] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[   80.262836] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.265777] thunderbolt 0000:05:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[   80.265778] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[   80.265779] thunderbolt 0000:05:00.0:   Max counters: 32
[   80.265779] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c0000c
[   80.265780] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[   80.265780] thunderbolt 0000:05:00.0: 303:5: disabled by eeprom
[   80.265781] thunderbolt 0000:05:00.0: 303:6: disabled by eeprom
[   80.266674] thunderbolt 0000:05:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   80.266675] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.266675] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.266676] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.266676] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.267580] thunderbolt 0000:05:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[   80.267583] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.267584] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.267585] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.267585] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.267586] thunderbolt 0000:05:00.0: 303:9: disabled by eeprom
[   80.268472] thunderbolt 0000:05:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[   80.268480] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[   80.268481] thunderbolt 0000:05:00.0:   Max counters: 1
[   80.268482] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.268482] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.269617] thunderbolt 0000:05:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[   80.269619] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[   80.269619] thunderbolt 0000:05:00.0:   Max counters: 2
[   80.269620] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[   80.269620] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[   80.269621] thunderbolt 0000:05:00.0: 303:12: disabled by eeprom
[   80.269622] thunderbolt 0000:05:00.0: 303:13: disabled by eeprom
[   80.288377] thunderbolt 0000:05:00.0: 303: TMU: current mode: bi-directional, HiFi
[   80.288394] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[   80.288396] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[   80.288508] thunderbolt 0000:05:00.0: 303:1: is unplugged (state: 7)
[   80.289784] thunderbolt 0000:05:00.0: discovering Video path starting from 0:5
[   80.289913] thunderbolt 0000:05:00.0: 0:5:  In HopID: 9 => Out port: 4 Out HopID: 8
[   80.289914] thunderbolt 0000:05:00.0: 0:5:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   80.289915] thunderbolt 0000:05:00.0: 0:5:    Counter enabled: 0 Counter index: 2047
[   80.289916] thunderbolt 0000:05:00.0: 0:5:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   80.289917] thunderbolt 0000:05:00.0: 0:5:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.290041] thunderbolt 0000:05:00.0: 3:2:  In HopID: 8 => Out port: 4 Out HopID: 8
[   80.290042] thunderbolt 0000:05:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   80.290042] thunderbolt 0000:05:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   80.290043] thunderbolt 0000:05:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   80.290044] thunderbolt 0000:05:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.290168] thunderbolt 0000:05:00.0: 303:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[   80.290169] thunderbolt 0000:05:00.0: 303:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   80.290170] thunderbolt 0000:05:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[   80.290171] thunderbolt 0000:05:00.0: 303:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   80.290171] thunderbolt 0000:05:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.290172] thunderbolt 0000:05:00.0: path discovery complete
[   80.290552] thunderbolt 0000:05:00.0: discovering AUX TX path starting from 0:5
[   80.290681] thunderbolt 0000:05:00.0: 0:5:  In HopID: 8 => Out port: 4 Out HopID: 9
[   80.290681] thunderbolt 0000:05:00.0: 0:5:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.290682] thunderbolt 0000:05:00.0: 0:5:    Counter enabled: 0 Counter index: 2047
[   80.290683] thunderbolt 0000:05:00.0: 0:5:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.290684] thunderbolt 0000:05:00.0: 0:5:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.290808] thunderbolt 0000:05:00.0: 3:2:  In HopID: 9 => Out port: 4 Out HopID: 9
[   80.290809] thunderbolt 0000:05:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.290810] thunderbolt 0000:05:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[   80.290810] thunderbolt 0000:05:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.290811] thunderbolt 0000:05:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.290937] thunderbolt 0000:05:00.0: 303:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[   80.290937] thunderbolt 0000:05:00.0: 303:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.290938] thunderbolt 0000:05:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[   80.290939] thunderbolt 0000:05:00.0: 303:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.290939] thunderbolt 0000:05:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.290940] thunderbolt 0000:05:00.0: path discovery complete
[   80.291704] thunderbolt 0000:05:00.0: discovering AUX RX path starting from 303:11
[   80.291832] thunderbolt 0000:05:00.0: 303:11:  In HopID: 8 => Out port: 4 Out HopID: 8
[   80.291833] thunderbolt 0000:05:00.0: 303:11:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.291834] thunderbolt 0000:05:00.0: 303:11:    Counter enabled: 0 Counter index: 2047
[   80.291834] thunderbolt 0000:05:00.0: 303:11:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.291835] thunderbolt 0000:05:00.0: 303:11:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.291960] thunderbolt 0000:05:00.0: 3:4:  In HopID: 8 => Out port: 2 Out HopID: 8
[   80.291961] thunderbolt 0000:05:00.0: 3:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.291962] thunderbolt 0000:05:00.0: 3:4:    Counter enabled: 0 Counter index: 2047
[   80.291962] thunderbolt 0000:05:00.0: 3:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.291963] thunderbolt 0000:05:00.0: 3:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.292088] thunderbolt 0000:05:00.0: 0:4:  In HopID: 8 => Out port: 5 Out HopID: 8
[   80.292089] thunderbolt 0000:05:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.292090] thunderbolt 0000:05:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[   80.292090] thunderbolt 0000:05:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.292091] thunderbolt 0000:05:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.292091] thunderbolt 0000:05:00.0: path discovery complete
[   80.292344] thunderbolt 0000:05:00.0: 0:5 <-> 303:b (DP): discovered
[   80.292728] thunderbolt 0000:05:00.0: discovering Video path starting from 0:6
[   80.292856] thunderbolt 0000:05:00.0: 0:6:  In HopID: 9 => Out port: 3 Out HopID: 8
[   80.292857] thunderbolt 0000:05:00.0: 0:6:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   80.292858] thunderbolt 0000:05:00.0: 0:6:    Counter enabled: 0 Counter index: 2047
[   80.292858] thunderbolt 0000:05:00.0: 0:6:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   80.292859] thunderbolt 0000:05:00.0: 0:6:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.292984] thunderbolt 0000:05:00.0: 3:1:  In HopID: 8 => Out port: 11 Out HopID: 9
[   80.292985] thunderbolt 0000:05:00.0: 3:1:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[   80.292986] thunderbolt 0000:05:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   80.292986] thunderbolt 0000:05:00.0: 3:1:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[   80.292987] thunderbolt 0000:05:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.292988] thunderbolt 0000:05:00.0: path discovery complete
[   80.293240] thunderbolt 0000:05:00.0: discovering AUX TX path starting from 0:6
[   80.293368] thunderbolt 0000:05:00.0: 0:6:  In HopID: 8 => Out port: 3 Out HopID: 9
[   80.293369] thunderbolt 0000:05:00.0: 0:6:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.293370] thunderbolt 0000:05:00.0: 0:6:    Counter enabled: 0 Counter index: 2047
[   80.293370] thunderbolt 0000:05:00.0: 0:6:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.293371] thunderbolt 0000:05:00.0: 0:6:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.293496] thunderbolt 0000:05:00.0: 3:1:  In HopID: 9 => Out port: 11 Out HopID: 8
[   80.293497] thunderbolt 0000:05:00.0: 3:1:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.293498] thunderbolt 0000:05:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   80.293498] thunderbolt 0000:05:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.293499] thunderbolt 0000:05:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.293500] thunderbolt 0000:05:00.0: path discovery complete
[   80.294008] thunderbolt 0000:05:00.0: discovering AUX RX path starting from 3:11
[   80.294136] thunderbolt 0000:05:00.0: 3:11:  In HopID: 8 => Out port: 1 Out HopID: 8
[   80.294137] thunderbolt 0000:05:00.0: 3:11:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.294138] thunderbolt 0000:05:00.0: 3:11:    Counter enabled: 0 Counter index: 2047
[   80.294138] thunderbolt 0000:05:00.0: 3:11:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.294139] thunderbolt 0000:05:00.0: 3:11:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.294264] thunderbolt 0000:05:00.0: 0:3:  In HopID: 8 => Out port: 6 Out HopID: 8
[   80.294265] thunderbolt 0000:05:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[   80.294266] thunderbolt 0000:05:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   80.294266] thunderbolt 0000:05:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.294267] thunderbolt 0000:05:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.294268] thunderbolt 0000:05:00.0: path discovery complete
[   80.294520] thunderbolt 0000:05:00.0: 0:6 <-> 3:b (DP): discovered
[   80.295032] thunderbolt 0000:05:00.0: discovering PCIe Up path starting from 0:9
[   80.295160] thunderbolt 0000:05:00.0: 0:9:  In HopID: 8 => Out port: 3 Out HopID: 10
[   80.295161] thunderbolt 0000:05:00.0: 0:9:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   80.295162] thunderbolt 0000:05:00.0: 0:9:    Counter enabled: 0 Counter index: 2047
[   80.295162] thunderbolt 0000:05:00.0: 0:9:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.295163] thunderbolt 0000:05:00.0: 0:9:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.295288] thunderbolt 0000:05:00.0: 3:1:  In HopID: 10 => Out port: 10 Out HopID: 8
[   80.295289] thunderbolt 0000:05:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   80.295290] thunderbolt 0000:05:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   80.295291] thunderbolt 0000:05:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.295291] thunderbolt 0000:05:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.295292] thunderbolt 0000:05:00.0: path discovery complete
[   80.295800] thunderbolt 0000:05:00.0: discovering PCIe Down path starting from 3:10
[   80.295928] thunderbolt 0000:05:00.0: 3:10:  In HopID: 8 => Out port: 1 Out HopID: 9
[   80.295929] thunderbolt 0000:05:00.0: 3:10:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   80.295930] thunderbolt 0000:05:00.0: 3:10:    Counter enabled: 0 Counter index: 2047
[   80.295930] thunderbolt 0000:05:00.0: 3:10:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.295931] thunderbolt 0000:05:00.0: 3:10:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.296056] thunderbolt 0000:05:00.0: 0:3:  In HopID: 9 => Out port: 9 Out HopID: 8
[   80.296057] thunderbolt 0000:05:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   80.296058] thunderbolt 0000:05:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   80.296058] thunderbolt 0000:05:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.296059] thunderbolt 0000:05:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.296060] thunderbolt 0000:05:00.0: path discovery complete
[   80.296184] thunderbolt 0000:05:00.0: 0:9 <-> 3:a (PCI): discovered
[   80.296569] thunderbolt 0000:05:00.0: discovering PCIe Up path starting from 3:7
[   80.296696] thunderbolt 0000:05:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   80.296697] thunderbolt 0000:05:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   80.296698] thunderbolt 0000:05:00.0: 3:7:    Counter enabled: 0 Counter index: 2047
[   80.296698] thunderbolt 0000:05:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.296699] thunderbolt 0000:05:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.296824] thunderbolt 0000:05:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[   80.296825] thunderbolt 0000:05:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   80.296826] thunderbolt 0000:05:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   80.296826] thunderbolt 0000:05:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.296827] thunderbolt 0000:05:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.296828] thunderbolt 0000:05:00.0: path discovery complete
[   80.297339] thunderbolt 0000:05:00.0: discovering PCIe Down path starting from 303:10
[   80.297466] thunderbolt 0000:05:00.0: 303:10:  In HopID: 8 => Out port: 3 Out HopID: 8
[   80.297467] thunderbolt 0000:05:00.0: 303:10:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   80.297469] thunderbolt 0000:05:00.0: 303:10:    Counter enabled: 0 Counter index: 2047
[   80.297469] thunderbolt 0000:05:00.0: 303:10:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   80.297470] thunderbolt 0000:05:00.0: 303:10:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.297593] thunderbolt 0000:05:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   80.297594] thunderbolt 0000:05:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   80.297595] thunderbolt 0000:05:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   80.297596] thunderbolt 0000:05:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   80.297597] thunderbolt 0000:05:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   80.297597] thunderbolt 0000:05:00.0: path discovery complete
[   80.297720] thunderbolt 0000:05:00.0: 3:7 <-> 303:a (PCI): discovered
[   80.298232] thunderbolt 0000:05:00.0: 0:5: DP IN resource available
[   80.298360] thunderbolt 0000:05:00.0: 0:6: DP IN resource available
[   80.682432] [drm] perform_link_training_with_retries: Link(2) training attempt 1 of 4 failed @ rate(10) x lane(4) : fail reason:(8)
[   80.982402] [drm] perform_link_training_with_retries: Link(2) training attempt 2 of 4 failed @ rate(10) x lane(4) : fail reason:(8)
[   81.332421] [drm] perform_link_training_with_retries: Link(2) training attempt 3 of 4 failed @ rate(10) x lane(4) : fail reason:(8)
[   81.732436] [drm] enabling link 2 failed: 15

Unfortunately things either work normally for a while and then lock up hard (all screens/input devices) frozen, or it fails to
reboot (performs shut down, tries to reboot and everything stays dark). On the other hand, a reset will bring it back whereas
previously I had to power cycle the box.

If I leave thunderbolt compiled in or don't have the module blacklisted it will reliably lock up on warm boot.

It looks I'm going to have to break out the serial console.

Regards,
Brad
