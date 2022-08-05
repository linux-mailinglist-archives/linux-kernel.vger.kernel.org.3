Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D658A78D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiHEH5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiHEH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:56:56 -0400
X-Greylist: delayed 934 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 00:56:54 PDT
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B71571F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:56:53 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oJrxL-00029T-PT; Fri, 05 Aug 2022 17:41:15 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=57ZN/4vqloRPdbLHSTuskW70GHLMimz2bNVPqs0W8QY=; b=WSNLNyoCXDa/UL2n6D+O939Pwk
        9lgWO4nfytjwIVWQvl+zVC0wnjJq0suQUzcGTqZa/HOQSYomr93NXGw9udv3wk+gDVtFKVdczNX9/
        nFZkUaeKpkNk6+sjy1z0RPNftXu5PM6FtI9HyANYiQDOPHgKTr/JPC1fwG2fbT27SETk=;
Message-ID: <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
Date:   Fri, 5 Aug 2022 15:41:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
 <YkXYdcUZ1E18ENle@lahna>
 <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
 <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
 <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
 <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
 <Yk2qMt568oEeTj8H@lahna>
Content-Language: en-AU
In-Reply-To: <Yk2qMt568oEeTj8H@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/22 22:56, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Apr 06, 2022 at 10:51:41AM +0800, Brad Campbell wrote:
>> Both included in-line.
>>
>> This is cold boot with the chain plugged in. I've re-added the dbg to
>> print the link number, and I've included your path discovery debugs.
>> Boot with chain plugged in, wait for it to settle, unplug and replug.
>> First head in the chain fails with :
>>
>> [   65.778129] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
>> [   65.778158] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
> 
> Thanks for the logs!
> 
> The DP tunnels look pretty much the same except that the Apple EFI CM
> seems to assign 7 buffers for the AUX RX path first hop whereas we
> always use 1 buffer. Not sure if that really makes a difference and we
> could try to use the same number but first, I realized that the PCI
> resource allocation seems not to work properly.
> 
> Can you disable PCIe tunneling (if you use Ubuntu/Fedora or similar
> there is the "Thunderbolt -> Direct Access" switch that you can turn
> off) and try again? Please also take 'sudo lspci -vv' for the resulting
> topology. I suspect this might also affect the other issues (the
> timeouts) you are seeing. Note this makes the peripherals connected to
> the monitors unusable too.
> 

G'day Mika,

Unfortunately before I had a chance to progress this my poor iMac GPU finally turned
up its toes.

I have now replaced it with a Gigabyte B550 Vision-d-p which happily drives the Apple
Thunderbolt displays. This has a Titan Ridge controller and I'm running a 5.18.16 vanilla kernel.

When cold booted, this fires up, routes both PCIe and Displayport and both displays work.

With this configuration the kernel locks up when doing a warm reboot (black screen, no information). It
also fails on reset, and only a power cycle will allow the kernel to complete the boot.

If I disable the PCIe tunneling and just leave DP then it cold boots and then warm boots without issue.

If I build thunderbolt as a module and blacklist it to prevent it auto loading, I can
load it the first time which establishes the DP and PCIe tunnels. They then remain established
across a warm boot, and provided I don't try and load the thunderbolt module the system will just keep
running. I can run different kernels, memtest, whatever. The EFI doesn't break the tunnels
and the kernel works with them.

If I then try and load the thunderbolt module I get this :

[  618.242923] ACPI: bus type thunderbolt registered
[  618.242957] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[  618.242983] thunderbolt 0000:05:00.0: total paths: 12
[  618.243147] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[  618.243163] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[  618.243176] thunderbolt 0000:05:00.0: control channel created
[  618.243180] thunderbolt 0000:05:00.0: ICM not supported on this controller
[  618.243187] thunderbolt 0000:05:00.0: freeing RX ring 0
[  618.243193] thunderbolt 0000:05:00.0: freeing TX ring 0
[  618.243202] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[  618.243210] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[  618.243218] thunderbolt 0000:05:00.0: control channel created
[  618.243220] thunderbolt 0000:05:00.0: using software connection manager
[  618.243221] thunderbolt 0000:05:00.0: NHI initialized, starting thunderbolt
[  618.243222] thunderbolt 0000:05:00.0: control channel starting...
[  618.243223] thunderbolt 0000:05:00.0: starting TX ring 0
[  618.243231] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[  618.243233] thunderbolt 0000:05:00.0: starting RX ring 0
[  618.243241] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[  618.243245] thunderbolt 0000:05:00.0: security level set to user
[  618.243458] thunderbolt 0000:05:00.0: current switch config:
[  618.243460] thunderbolt 0000:05:00.0:  Thunderbolt 3 Switch: 8086:15ea (Revision: 6, TB Version: 16)
[  618.243461] thunderbolt 0000:05:00.0:   Max Port Number: 13
[  618.243463] thunderbolt 0000:05:00.0:   Config:
[  618.243463] thunderbolt 0000:05:00.0:    Upstream Port Number: 7 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[  618.243465] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[  618.248577] thunderbolt 0000:05:00.0: initializing Switch at 0x0 (depth: 0, up port: 7)
[  618.288517] thunderbolt 0000:05:00.0: 0: uid: 0xedd9a650496900
[  618.290436] thunderbolt 0000:05:00.0:  Port 1: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[  618.290438] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[  618.290439] thunderbolt 0000:05:00.0:   Max counters: 16
[  618.290440] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[  618.290441] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[  618.292352] thunderbolt 0000:05:00.0:  Port 2: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[  618.292354] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[  618.292354] thunderbolt 0000:05:00.0:   Max counters: 16
[  618.292355] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[  618.292355] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[  618.294277] thunderbolt 0000:05:00.0:  Port 3: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[  618.294277] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[  618.294278] thunderbolt 0000:05:00.0:   Max counters: 16
[  618.294278] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[  618.294279] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[  618.296197] thunderbolt 0000:05:00.0:  Port 4: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[  618.296198] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[  618.296198] thunderbolt 0000:05:00.0:   Max counters: 16
[  618.296199] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[  618.296199] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[  618.296449] thunderbolt 0000:05:00.0:  Port 5: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[  618.296450] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[  618.296450] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.296451] thunderbolt 0000:05:00.0:   NFC Credits: 0x180000c
[  618.296451] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[  618.296764] thunderbolt 0000:05:00.0:  Port 6: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[  618.296765] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[  618.296766] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.296766] thunderbolt 0000:05:00.0:   NFC Credits: 0x180000c
[  618.296767] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[  618.297477] thunderbolt 0000:05:00.0:  Port 7: 8086:15ea (Revision: 6, TB Version: 1, Type: NHI (0x2))
[  618.297478] thunderbolt 0000:05:00.0:   Max hop id (in/out): 11/11
[  618.297478] thunderbolt 0000:05:00.0:   Max counters: 16
[  618.297479] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[  618.297479] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[  618.297730] thunderbolt 0000:05:00.0:  Port 8: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[  618.297731] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[  618.297731] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.297732] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[  618.297732] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[  618.297992] thunderbolt 0000:05:00.0:  Port 9: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[  618.297993] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[  618.297993] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.297994] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[  618.297994] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[  618.298496] thunderbolt 0000:05:00.0:  Port 10: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[  618.298497] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[  618.298498] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.298498] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[  618.298499] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[  618.299012] thunderbolt 0000:05:00.0:  Port 11: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[  618.299013] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[  618.299014] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.299014] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[  618.299015] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[  618.299269] thunderbolt 0000:05:00.0:  Port 12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[  618.299270] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[  618.299270] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.299271] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[  618.299271] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[  618.299524] thunderbolt 0000:05:00.0:  Port 13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[  618.299525] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[  618.299526] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.299526] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[  618.299527] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[  618.299527] thunderbolt 0000:05:00.0: 0: linked ports 1 <-> 2
[  618.299528] thunderbolt 0000:05:00.0: 0: linked ports 3 <-> 4
[  618.304645] thunderbolt 0000:05:00.0: 0: TMU: supports uni-directional mode
[  618.304645] thunderbolt 0000:05:00.0: 0: TMU: current mode: HiFi
[  618.304769] thunderbolt 0000:05:00.0: 0:1: is unplugged (state: 7)
[  618.304897] thunderbolt 0000:05:00.0: 0:3: is connected, link is up (state: 2)
[  618.305182] thunderbolt 0000:05:00.0: current switch config:
[  618.305183] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[  618.305184] thunderbolt 0000:05:00.0:   Max Port Number: 13
[  618.305184] thunderbolt 0000:05:00.0:   Config:
[  618.305184] thunderbolt 0000:05:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3 Enabled: 1, PlugEventsDelay: 255ms
[  618.305186] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[  618.309761] thunderbolt 0000:05:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[  618.327174] thunderbolt 0000:05:00.0: 3: reading drom (length: 0x97)
[  618.820874] thunderbolt 0000:05:00.0: 3: DROM version: 1
[  618.821902] thunderbolt 0000:05:00.0: 3: uid: 0x1000100189170
[  618.824842] thunderbolt 0000:05:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[  618.824845] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[  618.824845] thunderbolt 0000:05:00.0:   Max counters: 32
[  618.824846] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c0000c
[  618.824847] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[  618.827786] thunderbolt 0000:05:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[  618.827787] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[  618.827788] thunderbolt 0000:05:00.0:   Max counters: 32
[  618.827788] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c0000c
[  618.827789] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[  618.830731] thunderbolt 0000:05:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[  618.830732] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[  618.830732] thunderbolt 0000:05:00.0:   Max counters: 32
[  618.830733] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[  618.830733] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[  618.833678] thunderbolt 0000:05:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[  618.833680] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[  618.833680] thunderbolt 0000:05:00.0:   Max counters: 32
[  618.833681] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[  618.833681] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[  618.833682] thunderbolt 0000:05:00.0: 3:5: disabled by eeprom
[  618.833683] thunderbolt 0000:05:00.0: 3:6: disabled by eeprom
[  618.834570] thunderbolt 0000:05:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[  618.834572] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[  618.834573] thunderbolt 0000:05:00.0:   Max counters: 1
[  618.834573] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[  618.834574] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[  618.835468] thunderbolt 0000:05:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[  618.835469] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[  618.835469] thunderbolt 0000:05:00.0:   Max counters: 1
[  618.835470] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[  618.835470] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[  618.835471] thunderbolt 0000:05:00.0: 3:9: disabled by eeprom
[  618.836360] thunderbolt 0000:05:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[  618.836361] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[  618.836362] thunderbolt 0000:05:00.0:   Max counters: 1
[  618.836363] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[  618.836363] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[  618.837518] thunderbolt 0000:05:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[  618.837519] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[  618.837520] thunderbolt 0000:05:00.0:   Max counters: 2
[  618.837520] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[  618.837521] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[  618.837521] thunderbolt 0000:05:00.0: 3:c: disabled by eeprom
[  618.837522] thunderbolt 0000:05:00.0: 3:d: disabled by eeprom
[  618.855589] thunderbolt 0000:05:00.0: 3: TMU: current mode: bi-directional, HiFi
[  618.855600] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[  618.855602] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[  618.856101] thunderbolt 0000:05:00.0: 3:3: is connected, link is up (state: 2)
[  618.856357] thunderbolt 0000:05:00.0: current switch config:
[  618.856357] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[  618.856359] thunderbolt 0000:05:00.0:   Max Port Number: 13
[  618.856359] thunderbolt 0000:05:00.0:   Config:
[  618.856360] thunderbolt 0000:05:00.0:    Upstream Port Number: 3 Depth: 2 Route String: 0x303 Enabled: 1, PlugEventsDelay: 255ms
[  618.856361] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[  618.860965] thunderbolt 0000:05:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[  618.878375] thunderbolt 0000:05:00.0: 303: reading drom (length: 0x97)
[  620.072070] pcieport 0000:2a:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[  620.676124] pcieport 0000:2a:05.0: pciehp: pcie_do_write_cmd: no response from device
[  621.903381] hrtimer: interrupt took 604006559 ns
[  622.296070] pcieport 0000:2a:05.0: pciehp: pcie_do_write_cmd: no response from device
[  622.698769] pcieport 0000:31:05.0: can't change power state from D3cold to D0 (config space inaccessible)
[  623.302796] pcieport 0000:31:05.0: pciehp: pcie_do_write_cmd: no response from device
[  623.906840] pcieport 0000:31:04.0: can't change power state from D3cold to D0 (config space inaccessible)
[  624.511090] pcieport 0000:31:04.0: pciehp: pcie_do_write_cmd: no response from device
[  625.115091] pcieport 0000:04:01.0: can't change power state from D3cold to D0 (config space inaccessible)
[  625.719304] pcieport 0000:04:01.0: pciehp: pcie_do_write_cmd: no response from device
[  625.920747] thunderbolt 0000:05:00.0: 303: timeout writing config space 2 to 0x28
[  625.920752] thunderbolt 0-303: reading DROM failed: -5
[  625.920753] thunderbolt 0000:05:00.0: 303: uid: 0x0
[  626.524964] pcieport 0000:31:05.0: pciehp: pcie_do_write_cmd: no response from device
[  626.726306] pcieport 0000:31:04.0: pciehp: pcie_do_write_cmd: no response from device
[  626.927661] pcieport 0000:04:01.0: pciehp: pcie_do_write_cmd: no response from device
[  627.330332] pcieport 0000:04:02.0: can't change power state from D3cold to D0 (config space inaccessible)
[  627.837000] thunderbolt 0000:05:00.0: 303: timeout reading config space 1 from 0x0
[  627.837005] thunderbolt 0-303: failed to initialize port 1
[  628.277015] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x3b
[  628.716825] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x3b
[  629.156976] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x3b
[  629.597002] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
[  630.037013] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
[  630.477032] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
[  630.916994] thunderbolt 0000:05:00.0: 0: timeout reading config space 1 from 0x39
[  631.356836] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x39
[  631.806792] thunderbolt 0000:05:00.0: 3: timeout reading config space 1 from 0x39
[  632.246828] thunderbolt 0000:05:00.0: 0: timeout reading config space 2 from 0x10f
[  632.686977] thunderbolt 0000:05:00.0: 0: timeout reading config space 2 from 0x10f

I'm dangerously *assuming* that when trying to configure an already configured system the thunderbolt
driver is getting stuck because booting without trying to load the driver works fine.

If I try and warm boot when its in this state, the machine doesn't reach the EFI and I have to
hard reset or power cycle.

My questions are :
A) Since I have a viable but hacky work-around, is this something you'd be interested in helping chase down?
B) If so, what debugging information can I supply?

I have made up a serial console cable, but as I can reproduce the fault by loading the module
I thought perhaps it'd be easier to debug.

Regards,
Brad
