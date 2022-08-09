Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D978358DAEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiHIPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244829AbiHIPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:16:47 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7548D14D30
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:16:39 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oLQyB-0004R0-Oz; Wed, 10 Aug 2022 01:16:36 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cEbg7Wyv9ZdQkDBOOoFKgRHaeYBuO5uccTIVkxKImek=; b=bzmlqNYZ5abmD416COpznenL0d
        0u8L7KqOsCW3TJ8T5hxmBo0vqsbcMFmYjP6Ng1dIELQro207E13rDkDsMWdUtOkV6JEBjdndA8tr8
        GZ6uOsXR9qmFEOYvjNtvVhpmL75PlL0CTTHs1DixgLjhh6GxVCTNqHP9a0kpJNXgu+Ks=;
Message-ID: <39268cc6-4e05-b83c-ff73-3056925eeb76@fnarfbargle.com>
Date:   Tue, 9 Aug 2022 23:16:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
 <YvDcudE5BRtZAtfM@lahna>
 <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
 <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
 <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
 <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
 <YvI9Cbin4OKQwZ05@lahna>
 <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
 <YvJyZ51H+YkceKJP@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YvJyZ51H+YkceKJP@lahna>
Content-Type: text/plain; charset=UTF-8
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

G'day Mika,


On 9/8/22 22:42, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Aug 09, 2022 at 07:08:42PM +0800, Brad Campbell wrote:
>>
>>
>> On 9/8/22 18:55, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Tue, Aug 09, 2022 at 06:40:54PM +0800, Brad Campbell wrote:
>>>> G'day Mika,
>>>>
>>>>
>>>> On 9/8/22 18:23, Mika Westerberg wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Aug 08, 2022 at 09:27:24PM +0800, Brad Campbell wrote:
>>>>>> If I don't authorize the PCIe tunnels and just leave the DP enabled it
>>>>>> works fine also.
>>>>>
>>>>> But you say that it fails on boot when the driver discovers the tunnels,
>>>>> right? So there is really nothing to authorize (they should be already
>>>>> "authorized" by the boot firmware).
>>>>>
>>>>> If I understand correctly this is how it reproduces (the simplest):
>>>>>
>>>>>   1. Connect a single Apple TB1 display to the system
>>>>>   2. Boot it up
>>>>>   3. Wait a while and it hangs
>>>>>
>>>>> If this is the case, then the driver certainly is not creating any
>>>>> PCIe tunnels itself unless there is a bug somewhere.
>>>>>
>>>>> An additional question, does it reproduce with either TB1 display
>>>>> connected or just with specific TB1 display?
>>>>>
>>>>
>>>> No, I've not been clear enough, I'm sorry. I've re-read what I've written below and
>>>> I'm still not sure I'm clear enough.
>>>>
>>>> The firmware never sets anything up. 
>>>>
>>>> When I cold boot the machine (from power on), the thunderbolt displays and tunnels
>>>> remain dark until linux initializes the thunderbolt driver the first time. 
>>>>  
>>>> If I compile the thunderbolt driver into the kernel, or let the initramfs load it
>>>> the displays come up, all PCIe tunnels are established and everything works.
>>>>
>>>> When I reboot the machine (reset button or warm boot), the firmware continues to
>>>> do nothing and all the tunnels remain in place. The machine dies when the thunderbolt 
>>>> driver is loaded for a second time.
>>>>
>>>> That might be a reset/warm boot with it compiled in or loaded from iniramfs.
>>>> It may also be me loading it from the command line after booting with it as a
>>>> module and blacklisted.
>>>>
>>>> The problem comes about when the thunderbolt module is loaded while the PCIe tunnels
>>>> are already established.
>>>>
>>>> To reproduce in the easiest manner I compile the thunderbolt driver as a module and
>>>> blacklist it. This prevents it from auto-loading.
>>>>
>>>> I cold boot the machine, let it boot completely then modprobe thunderbolt and authorize
>>>> the tunnels. I then warm boot which lets the kernel detect and init the DP displays
>>>> and detect/configure all the PCIe devices. The thunderbolt driver is not loaded.
>>>>
>>>> The machine comes up, all tunnels are established and all devices work.
>>>>
>>>> If I then modprobe the thunderbolt driver, things break.
>>>>
>>>> This is the hack in my boot script :
>>>>
>>>> # Spark up thunderbolt
>>>> if [ -z "`grep notb /proc/cmdline`" -a -z "`lsusb | grep '05ac:9227'`" ] ; then
>>>> 	modprobe thunderbolt
>>>> 	sleep 1
>>>> 	echo 1 > /sys/bus/thunderbolt/devices/0-3/authorized
>>>> 	echo 1 > /sys/bus/thunderbolt/devices/0-303/authorized
>>>> 	reboot
>>>> fi
>>>
>>> Thanks for the clarification! How about on macOS side, does it work (I
>>> would expect yes)?
>>>
>>
>> Ahh, forgot about the laptop I'm typing this on. Yes, works fine in MacOS.
> 
> Right. Okay does it reproduce with these steps?
> 
> 1. Boot the system up, nothing connected
> 2. Plug in a TB1 display (just one)
> 3. Authorize the PCIe tunnel
> 
>   # echo 1 > /sys/bus/thunderbolt/...
> 
> 4. Unload the TBT driver
> 
>   # rmmod thunderbolt
> 
> 5. Load it back
> 
>   # modprobe thunderbolt dyndbg
> 
> This should be pretty much the same as with the reboot case.
> 

You'd have thought so, but it's not.

That works fine.

If I then reboot and load the driver it fails.

The only thing I could think of doing was an lspci -vvv after the boot and module load
and an lspci -vvv after a warm reboot and diff them, because there are changes around the
thunderbolt bridge devices. I've done a diff -u50 to try and keep as much context as possible.

On the first boot I can unload/reload the thunderbolt module repeatedly and there's no issue
but loading it after a reboot locks up. There are no lspci changes on the first boot after the
initial module load unless I rescan the PCI bus, but they're minor and it doesn't cause an issue
with loading the thunderbolt module.

The firmware *must* be doing something on reboot I suppose or the PCIe configs wouldn't change.

Regards,
Brad

--- lspci.010	2022-08-09 23:03:04.708406538 +0800
+++ lspci.012	2022-08-09 23:04:49.751098566 +0800
@@ -1,96 +1,96 @@
 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
 	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 
 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
 	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
 	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
 	Interrupt: pin A routed to IRQ 255
 	Capabilities: [40] Secure device <?>
 	Capabilities: [64] MSI: Enable- Count=1/4 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+
 
 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 
 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 
 00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin ? routed to IRQ 27
 	Bus: primary=00, secondary=01, subordinate=51, sec-latency=0
 	I/O behind bridge: 0000f000-0000ffff [size=4K]
 	Memory behind bridge: df000000-ef7fffff [size=264M]
 	Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff [size=288M]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [50] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
 		DevCap:	MaxPayload 512 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
-		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
+		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 		LnkCap:	Port #2, Speed 8GT/s, Width x4, ASPM not supported
 			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 			Slot #0, PowerLimit 75.000W; Interlock- NoCompl+
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet- LinkState+
 		RootCap: CRSVisible+
 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
 			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
 		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: ReqEn- EgressBlck-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
 			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
 		Address: 00000000fee04000  Data: 0021
 	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
 	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
 	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
 	Capabilities: [270 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [2a0 v1] Access Control Services
 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 	Capabilities: [3c4 v1] Designated Vendor-Specific: Vendor=1022 ID=0001 Rev=1 Len=44 <?>
 	Kernel driver in use: pcieport
 
 00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin ? routed to IRQ 28
 	Bus: primary=00, secondary=52, subordinate=52, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
@@ -280,105 +280,105 @@
 	Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <64us
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <32us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
 			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [200 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [300 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Kernel driver in use: xhci_hcd
 	Kernel modules: xhci_pci
 
 01:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] Device 43eb (prog-if 01 [AHCI 1.0])
 	Subsystem: ASMedia Technology Inc. Device 1062
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin B routed to IRQ 79
+	Interrupt: pin B routed to IRQ 83
 	Region 5: Memory at ef780000 (32-bit, non-prefetchable) [size=128K]
 	Expansion ROM at ef700000 [disabled] [size=512K]
 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
-		Address: 00000000fee00000  Data: 0024
+		Address: 00000000fee01000  Data: 0025
 	Capabilities: [78] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <64us
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <32us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Kernel driver in use: ahci
 	Kernel modules: ahci
 
 01:00.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43e9 (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin C routed to IRQ 30
 	Bus: primary=01, secondary=02, subordinate=51, sec-latency=0
 	I/O behind bridge: 0000f000-0000ffff [size=4K]
 	Memory behind bridge: df000000-ef6fffff [size=263M]
 	Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff [size=288M]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
@@ -681,101 +681,101 @@
 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [200 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Kernel driver in use: pcieport
 
 03:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 36
 	Bus: primary=03, secondary=04, subordinate=4a, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
 	Memory behind bridge: df000000-ef1fffff [size=258M]
 	Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff [size=288M]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
 		Address: 00000000fee09000  Data: 0021
 	Capabilities: [ac] Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018]
 	Capabilities: [c0] Express (v2) Upstream Port, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 26.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <2us
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
 			 AtomicOpsCtl: EgressBlck-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
-		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
+		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
 			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
 	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
 	Capabilities: [700 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [800 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [a00 v1] L1 PM Substates
 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 			  PortCommonModeRestoreTime=0us PortTPowerOnTime=10us
 		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
 			   T_CommonMode=0us LTR1.2_Threshold=0ns
 		L1SubCtl2: T_PwrOn=10us
 	Capabilities: [b00 v1] Precision Time Measurement
 		PTMCap: Requester:- Responder:- Root:-
 		PTMClockGranularity: Unimplemented
 		PTMControl: Enabled:- RootSelected:-
 		PTMEffectiveGranularity: Unknown
 	Kernel driver in use: pcieport
 
 04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 37
 	Bus: primary=04, secondary=05, subordinate=05, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
@@ -989,1371 +989,1369 @@
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [50] Capability ID 0x15 [0000]
 	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
 	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
 	Capabilities: [700 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [900 v1] Access Control Services
 		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 	Kernel driver in use: pcieport
 
 04:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 40
 	Bus: primary=04, secondary=29, subordinate=4a, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
 	Memory behind bridge: df000000-e6ffffff [size=128M]
 	Prefetchable memory behind bridge: 00000000a0000000-00000000a1ffffff [size=32M]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
-		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME+
+		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
 		Address: 00000000fee04000  Data: 0022
 	Capabilities: [ac] Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018]
 	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #4, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
 			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
 			Slot #4, PowerLimit 0.000W; Interlock- NoCompl+
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet- LinkState-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [50] Capability ID 0x15 [0000]
 	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
 	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
 	Capabilities: [700 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [900 v1] Access Control Services
 		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 	Kernel driver in use: pcieport
 
 05:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] (rev 06)
 	Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018]
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin A routed to IRQ 25
-	Region 0: Memory at ef100000 (32-bit, non-prefetchable) [size=256K]
-	Region 1: Memory at ef140000 (32-bit, non-prefetchable) [size=4K]
+	Interrupt: pin A routed to IRQ 255
+	Region 0: Memory at ef100000 (32-bit, non-prefetchable) [disabled] [size=256K]
+	Region 1: Memory at ef140000 (32-bit, non-prefetchable) [disabled] [size=4K]
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [88] MSI: Enable- Count=1/1 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [c0] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
-	Capabilities: [a0] MSI-X: Enable+ Count=16 Masked-
+	Capabilities: [a0] MSI-X: Enable- Count=16 Masked-
 		Vector table: BAR=1 offset=00000000
 		PBA: BAR=1 offset=00000fa0
 	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
 	Capabilities: [600 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
-	Kernel driver in use: thunderbolt
 	Kernel modules: thunderbolt
 
 28:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] (rev 06) (prog-if 30 [XHCI])
 	Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018]
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin A routed to IRQ 89
+	Interrupt: pin A routed to IRQ 93
 	Region 0: Memory at ef000000 (32-bit, non-prefetchable) [size=64K]
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [88] MSI: Enable+ Count=1/8 Maskable- 64bit+
-		Address: 00000000fee09000  Data: 0025
+		Address: 00000000fee06000  Data: 0026
 	Capabilities: [c0] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
 	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
 	Capabilities: [700 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [800 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Kernel driver in use: xhci_hcd
 	Kernel modules: xhci_pci
 
 29:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
 	Physical Slot: 4
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
-	Interrupt: pin A routed to IRQ 125
-	Bus: primary=29, secondary=2a, subordinate=4a, sec-latency=0
+	Latency: 0, Cache Line Size: 64 bytes
+	Interrupt: pin A routed to IRQ 41
+	Bus: primary=29, secondary=2a, subordinate=31, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: df000000-e6ffffff [size=128M]
-	Prefetchable memory behind bridge: 00000000a0000000-00000000a1ffffff [size=32M]
+	Memory behind bridge: df000000-df1fffff [size=2M]
+	Prefetchable memory behind bridge: 00000000a0000000-00000000a00fffff [size=1M]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [88] MSI: Enable+ Count=1/32 Maskable- 64bit+
-		Address: 00000000fee02000  Data: 0028
+		Address: 00000000fee06000  Data: 0022
 	Capabilities: [c0] Express (v2) Upstream Port, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
 			 AtomicOpsCtl: EgressBlck-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
-			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
 	Kernel driver in use: pcieport
 
 2a:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
-	Interrupt: pin A routed to IRQ 126
+	Latency: 0, Cache Line Size: 64 bytes
+	Interrupt: pin A routed to IRQ 42
 	Bus: primary=2a, secondary=2b, subordinate=2d, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: df000000-df0fffff [size=1M]
-	Prefetchable memory behind bridge: 00000000a0000000-00000000a00fffff [size=1M]
+	Memory behind bridge: df100000-df1fffff [size=1M]
+	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [88] MSI: Enable+ Count=1/32 Maskable- 64bit+
-		Address: 00000000fee04000  Data: 0028
+		Address: 00000000fee08000  Data: 0022
 	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
 			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (downgraded)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet+ LinkState-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
-			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
 	Kernel driver in use: pcieport
 
 2a:01.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
-	Interrupt: pin A routed to IRQ 127
+	Latency: 0, Cache Line Size: 64 bytes
+	Interrupt: pin A routed to IRQ 43
 	Bus: primary=2a, secondary=2e, subordinate=2e, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: df100000-df1fffff [size=1M]
-	Prefetchable memory behind bridge: 00000000a0100000-00000000a01fffff [size=1M]
+	Memory behind bridge: fff00000-000fffff [disabled]
+	Prefetchable memory behind bridge: 00000000a0000000-00000000a00fffff [size=1M]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [88] MSI: Enable+ Count=1/32 Maskable- 64bit+
-		Address: 00000000fee06000  Data: 0028
+		Address: 00000000fee0a000  Data: 0022
 	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
 			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (downgraded)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet+ LinkState-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
-			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
 	Kernel driver in use: pcieport
 
 2a:02.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
-	Interrupt: pin A routed to IRQ 128
+	Latency: 0, Cache Line Size: 64 bytes
+	Interrupt: pin A routed to IRQ 44
 	Bus: primary=2a, secondary=2f, subordinate=2f, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: df200000-df2fffff [size=1M]
-	Prefetchable memory behind bridge: 00000000a0200000-00000000a02fffff [size=1M]
+	Memory behind bridge: df000000-df0fffff [size=1M]
+	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [88] MSI: Enable+ Count=1/32 Maskable- 64bit+
-		Address: 00000000fee08000  Data: 0028
+		Address: 00000000fee01000  Data: 0022
 	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
 			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (downgraded)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet+ LinkState-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
-			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
 	Kernel driver in use: pcieport
 
 2a:04.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
+	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 25
-	Bus: primary=2a, secondary=30, subordinate=3f, sec-latency=0
+	Bus: primary=2a, secondary=30, subordinate=30, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: df300000-e31fffff [size=63M]
-	Prefetchable memory behind bridge: 00000000a0300000-00000000a11fffff [size=15M]
+	Memory behind bridge: fff00000-000fffff [disabled]
+	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #4, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
 			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
 			Slot #4, PowerLimit 0.000W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
 			Changed: MRL- PresDet- LinkState-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
 			Status:	NegoPending+ InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
 	Kernel driver in use: pcieport
 
 2a:05.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
+	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 34
-	Bus: primary=2a, secondary=40, subordinate=4a, sec-latency=0
+	Bus: primary=2a, secondary=31, subordinate=31, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: e3200000-e6ffffff [size=62M]
-	Prefetchable memory behind bridge: 00000000a1200000-00000000a1ffffff [size=14M]
+	Memory behind bridge: fff00000-000fffff [disabled]
+	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #5, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
 			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
 			Slot #5, PowerLimit 0.000W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
 			Changed: MRL- PresDet- LinkState-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
 	Capabilities: [200 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [300 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
 			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
 			Status:	NegoPending+ InProgress-
 	Capabilities: [400 v1] Power Budgeting <?>
 	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
 	Kernel driver in use: pcieport
 
 2b:00.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02) (prog-if 00 [Normal decode])
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
+	Latency: 0, Cache Line Size: 64 bytes
 	Bus: primary=2b, secondary=2c, subordinate=2d, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: df000000-df0fffff [size=1M]
-	Prefetchable memory behind bridge: 00000000a0000000-00000000a00fffff [size=1M]
+	Memory behind bridge: df100000-df1fffff [size=1M]
+	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
-	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
+	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [9c] Vital Product Data
 		Not readable
 	Capabilities: [a4] Vendor Specific Information: Len=0c <?>
 	Capabilities: [c4] Subsystem: Device 0000:0000
 	Capabilities: [e0] Express (v1) Upstream Port, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [140 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=04 MaxTimeSlots=64 RejSnoopTrans-
 			Arb:	Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
-			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 			Port Arbitration Table <?>
 	Capabilities: [20c v1] Power Budgeting <?>
 
 2c:03.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02) (prog-if 00 [Normal decode])
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
+	Latency: 0, Cache Line Size: 64 bytes
 	Bus: primary=2c, secondary=2d, subordinate=2d, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
-	Memory behind bridge: df000000-df0fffff [size=1M]
-	Prefetchable memory behind bridge: 00000000a0000000-00000000a00fffff [size=1M]
+	Memory behind bridge: df100000-df1fffff [size=1M]
+	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
-	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
+	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [a4] Vendor Specific Information: Len=0c <?>
 	Capabilities: [c4] Subsystem: Device 0000:0000
 	Capabilities: [e0] Express (v1) Downstream Port (Slot-), MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
 			ExtTag- RBE+
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #3, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 	Kernel driver in use: pcieport
 
 2d:00.0 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01) (prog-if 10 [OHCI])
 	Subsystem: Pericom Semiconductor PI7C9X442SL USB OHCI Controller
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
-	Interrupt: pin A routed to IRQ 106
-	Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=4K]
+	Latency: 0, Cache Line Size: 64 bytes
+	Interrupt: pin A routed to IRQ 84
+	Region 0: Memory at df102000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit-
 		Address: 00000000  Data: 0000
 	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
 	Kernel driver in use: ohci-pci
 	Kernel modules: ohci_pci
 
 2d:00.1 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01) (prog-if 10 [OHCI])
 	Subsystem: Pericom Semiconductor PI7C9X442SL USB OHCI Controller
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
+	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin B routed to IRQ 25
-	Region 0: Memory at df001000 (32-bit, non-prefetchable) [size=4K]
+	Region 0: Memory at df101000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit-
 		Address: 00000000  Data: 0000
 	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
 	Kernel driver in use: ohci-pci
 	Kernel modules: ohci_pci
 
 2d:00.2 USB controller: Pericom Semiconductor PI7C9X442SL USB EHCI Controller (rev 01) (prog-if 20 [EHCI])
 	Subsystem: Pericom Semiconductor PI7C9X442SL USB EHCI Controller
-	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin C routed to IRQ 34
-	Region 0: Memory at df002000 (32-bit, non-prefetchable) [size=256]
+	Region 0: Memory at df100000 (32-bit, non-prefetchable) [size=256]
 	Capabilities: [80] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit-
 		Address: 00000000  Data: 0000
 	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 128 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
 	Kernel driver in use: ehci-pci
 	Kernel modules: ehci_pci
 
 2e:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM57761 Gigabit Ethernet PCIe (rev 10)
 	Subsystem: Apple Inc. NetXtreme BCM57761 Gigabit Ethernet PCIe
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
+	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 34
-	Region 0: Memory at a0100000 (64-bit, prefetchable) [size=64K]
-	Region 2: Memory at a0110000 (64-bit, prefetchable) [size=64K]
+	Region 0: Memory at a0010000 (64-bit, prefetchable) [size=64K]
+	Region 2: Memory at a0000000 (64-bit, prefetchable) [size=64K]
 	Capabilities: [48] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [a0] MSI-X: Enable+ Count=6 Masked-
 		Vector table: BAR=2 offset=00000000
 		PBA: BAR=2 offset=00000120
 	Capabilities: [ac] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <64us
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [13c v1] Device Serial Number 00-00-c8-2a-14-4f-80-3e
 	Capabilities: [150 v1] Power Budgeting <?>
 	Capabilities: [160 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
-			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 	Kernel driver in use: tg3
 	Kernel modules: tg3
 
 2f:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe 1394b Controller (rev 08) (prog-if 10 [OHCI])
 	Subsystem: Device c111:0159
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Interrupt: pin A routed to IRQ 255
-	Region 0: Memory at df200000 (64-bit, non-prefetchable) [disabled] [size=4K]
+	Region 0: Memory at df000000 (64-bit, non-prefetchable) [disabled] [size=4K]
 	Capabilities: [44] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [4c] MSI: Enable- Count=1/1 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [60] Express (v1) Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 2048 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <64us
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [140 v1] Virtual Channel
 		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
 		Arb:	Fixed- WRR32- WRR64- WRR128-
 		Ctrl:	ArbSelect=Fixed
 		Status:	InProgress-
 		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
-			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
 			Status:	NegoPending- InProgress-
 		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
 			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
-			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
+			Ctrl:	Enable- ID=1 ArbSelect=Fixed TC/VC=00
 			Status:	NegoPending- InProgress-
 	Capabilities: [170 v1] Device Serial Number 00-0a-27-02-00-40-c4-ba
 
 4b:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. Device 2262 (rev 03) (prog-if 02 [NVM Express])
 	Subsystem: Kingston Technology Company, Inc. Device 2262
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 25
 	NUMA node: 0
 	Region 0: Memory at ef600000 (64-bit, non-prefetchable) [size=16K]
 	Capabilities: [40] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
 		Address: 0000000000000000  Data: 0000
 		Masking: 00000000  Pending: 00000000
 	Capabilities: [70] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 26.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <8us
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
 			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [b0] MSI-X: Enable+ Count=16 Masked-
 		Vector table: BAR=0 offset=00002000
 		PBA: BAR=0 offset=00002100
 	Capabilities: [100 v2] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [158 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [178 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [180 v1] L1 PM Substates
 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 			  PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
 		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
 			   T_CommonMode=0us LTR1.2_Threshold=0ns
 		L1SubCtl2: T_PwrOn=10us
 	Kernel driver in use: nvme
 
 4c:00.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin A routed to IRQ 41
+	Interrupt: pin A routed to IRQ 45
 	Bus: primary=4c, secondary=4d, subordinate=50, sec-latency=0
 	I/O behind bridge: 0000f000-0000ffff [size=4K]
 	Memory behind bridge: ef500000-ef5fffff [size=1M]
 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Power Management version 3
 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
-		Address: 00000000fee06000  Data: 0022
+		Address: 00000000fee07000  Data: 0022
 	Capabilities: [80] Express (v2) Upstream Port, MSI 00
 		DevCap:	MaxPayload 512 bytes, PhantFunc 0
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 26.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM L1, Exit Latency L1 <64us
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 5GT/s (ok), Width x1 (downgraded)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS-
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
 			 AtomicOpsCtl: EgressBlck-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [c0] Subsystem: Device 0000:0000
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 14, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
-		HeaderLog: 05000001 0000230f 4d08004d 00000000
+		HeaderLog: 05000001 0000200f 4d08004d 00000000
 	Capabilities: [140 v1] Power Budgeting <?>
 	Capabilities: [160 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [180 v1] Multicast
 		McastCap: MaxGroups 64, ECRCRegen-
 		McastCtl: NumGroups 1, Enable-
 		McastBAR: IndexPos 0, BaseAddr 0000000000000000
 		McastReceiveVec:      0000000000000000
 		McastBlockAllVec:     0000000000000000
 		McastBlockUntransVec: 0000000000000000
 		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
 	Capabilities: [1c0 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
 	Kernel driver in use: pcieport
 
 4d:00.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin A routed to IRQ 42
+	Interrupt: pin A routed to IRQ 46
 	Bus: primary=4d, secondary=4e, subordinate=4e, sec-latency=0
 	I/O behind bridge: 0000f000-0000ffff [size=4K]
 	Memory behind bridge: ef500000-ef5fffff [size=1M]
 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Power Management version 3
 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
-		Address: 00000000fee08000  Data: 0022
+		Address: 00000000fee09000  Data: 0022
 	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 512 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM L1, Exit Latency L1 <64us
 			ClockPM+ Surprise+ LLActRep+ BwNot+ ASPMOptComp+
 		LnkCtl:	ASPM Disabled; Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 5GT/s (ok), Width x1 (downgraded)
 			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 			Changed: MRL- PresDet+ LinkState+
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd+
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [c0] Subsystem: Device 0000:0000
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [140 v1] Power Budgeting <?>
 	Capabilities: [160 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [180 v1] Multicast
 		McastCap: MaxGroups 64, ECRCRegen-
 		McastCtl: NumGroups 1, Enable-
 		McastBAR: IndexPos 0, BaseAddr 0000000000000000
 		McastReceiveVec:      0000000000000000
 		McastBlockAllVec:     0000000000000000
 		McastBlockUntransVec: 0000000000000000
 		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
 	Capabilities: [1c0 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
 	Kernel driver in use: pcieport
 
 4d:06.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin A routed to IRQ 43
+	Interrupt: pin A routed to IRQ 47
 	Bus: primary=4d, secondary=4f, subordinate=4f, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
 	Memory behind bridge: fff00000-000fffff [disabled]
 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Power Management version 3
 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
-		Address: 00000000fee0a000  Data: 0022
+		Address: 00000000fee0b000  Data: 0022
 	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 512 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
 		LnkCap:	Port #6, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
 			ClockPM+ Surprise+ LLActRep+ BwNot+ ASPMOptComp+
 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
 			Changed: MRL- PresDet- LinkState-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd+
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [c0] Subsystem: Device 0000:0000
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 14, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
-		HeaderLog: 04000001 0000210f 4f00004f 00000000
+		HeaderLog: 04000001 0000220f 4f00004f 00000000
 	Capabilities: [140 v1] Power Budgeting <?>
 	Capabilities: [160 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [180 v1] Multicast
 		McastCap: MaxGroups 64, ECRCRegen-
 		McastCtl: NumGroups 1, Enable-
 		McastBAR: IndexPos 0, BaseAddr 0000000000000000
 		McastReceiveVec:      0000000000000000
 		McastBlockAllVec:     0000000000000000
 		McastBlockUntransVec: 0000000000000000
 		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
 	Capabilities: [1c0 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
 	Kernel driver in use: pcieport
 
 4d:0e.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin A routed to IRQ 44
+	Interrupt: pin A routed to IRQ 48
 	Bus: primary=4d, secondary=50, subordinate=50, sec-latency=0
 	I/O behind bridge: 0000f000-00000fff [disabled]
 	Memory behind bridge: fff00000-000fffff [disabled]
 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disabled]
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Power Management version 3
 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
-		Address: 00000000fee01000  Data: 0022
+		Address: 00000000fee00000  Data: 0022
 	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
 		DevCap:	MaxPayload 512 bytes, PhantFunc 0
 			ExtTag+ RBE+
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
 		LnkCap:	Port #14, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
 			ClockPM+ Surprise+ LLActRep+ BwNot+ ASPMOptComp+
 		LnkCtl:	ASPM Disabled; Disabled- CommClk-
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
 			Changed: MRL- PresDet- LinkState-
 		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- ARIFwd+
 			 AtomicOpsCap: Routing-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
 			 AtomicOpsCtl: EgressBlck-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [c0] Subsystem: Device 0000:0000
 	Capabilities: [100 v1] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 14, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
-		HeaderLog: 04000001 0000200f 50000050 00000000
+		HeaderLog: 04000001 0000210f 50000050 00000000
 	Capabilities: [140 v1] Power Budgeting <?>
 	Capabilities: [160 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [180 v1] Multicast
 		McastCap: MaxGroups 64, ECRCRegen-
 		McastCtl: NumGroups 1, Enable-
 		McastBAR: IndexPos 0, BaseAddr 0000000000000000
 		McastReceiveVec:      0000000000000000
 		McastBlockAllVec:     0000000000000000
 		McastBlockUntransVec: 0000000000000000
 		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
 	Capabilities: [1c0 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
 	Kernel driver in use: pcieport
 
 4e:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
 	Subsystem: Gigabyte Technology Co., Ltd Device e000
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 25
 	Region 0: I/O ports at f000 [size=256]
 	Region 2: Memory at ef500000 (64-bit, non-prefetchable) [size=64K]
 	Region 4: Memory at ef510000 (64-bit, non-prefetchable) [size=16K]
 	Capabilities: [40] Power Management version 3
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
 		Address: 0000000000000000  Data: 0000
 		Masking: 00000000  Pending: 00000000
 	Capabilities: [70] Express (v2) Endpoint, MSI 01
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 128 bytes, MaxReadReq 4096 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
 			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp+ ExtTPHComp-
@@ -2430,267 +2428,267 @@
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
 		LnkCap:	Port #9, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <4us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [100 v2] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
 	Capabilities: [140 v1] Device Serial Number d8-5e-d3-ff-ff-86-cc-c8
 	Capabilities: [1c0 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [1f0 v1] Precision Time Measurement
 		PTMCap: Requester:+ Responder:- Root:-
 		PTMClockGranularity: 4ns
 		PTMControl: Enabled:+ RootSelected:-
 		PTMEffectiveGranularity: Unknown
 	Capabilities: [1e0 v1] L1 PM Substates
 		L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
 		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
 		L1SubCtl2:
 	Kernel driver in use: igc
 
 52:00.0 Non-Volatile memory controller: Micron/Crucial Technology Device 540a (rev 01) (prog-if 02 [NVM Express])
 	Subsystem: Micron/Crucial Technology Device 540a
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin A routed to IRQ 46
+	Interrupt: pin A routed to IRQ 50
 	NUMA node: 0
 	Region 0: Memory at efd00000 (64-bit, non-prefetchable) [size=16K]
 	Capabilities: [80] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75.000W
 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
 			MaxPayload 256 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
 		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 unlimited
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
 			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: Upstream Port
 	Capabilities: [d0] MSI-X: Enable+ Count=9 Masked-
 		Vector table: BAR=0 offset=00002000
 		PBA: BAR=0 offset=00003000
 	Capabilities: [e0] MSI: Enable- Count=1/8 Maskable+ 64bit+
 		Address: 0000000000000000  Data: 0000
 		Masking: 00000000  Pending: 00000000
 	Capabilities: [f8] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [100 v1] Latency Tolerance Reporting
 		Max snoop latency: 0ns
 		Max no snoop latency: 0ns
 	Capabilities: [110 v1] L1 PM Substates
 		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
 			  PortCommonModeRestoreTime=10us PortTPowerOnTime=220us
 		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
 			   T_CommonMode=0us LTR1.2_Threshold=0ns
 		L1SubCtl2: T_PwrOn=10us
 	Capabilities: [200 v2] Advanced Error Reporting
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
-		HeaderLog: 04000001 0000220f 52070000 18a4170e
+		HeaderLog: 04000001 0000230f 52070000 c87b69e3
 	Capabilities: [300 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Kernel driver in use: nvme
 
 53:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne (rev c9) (prog-if 00 [VGA controller])
 	Subsystem: Gigabyte Technology Co., Ltd Device d000
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 24
 	Region 0: Memory at c0000000 (64-bit, prefetchable) [size=256M]
 	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=2M]
 	Region 4: I/O ports at e000 [size=256]
 	Region 5: Memory at efc00000 (32-bit, non-prefetchable) [size=512K]
 	Capabilities: [48] Vendor Specific Information: Len=08 <?>
 	Capabilities: [50] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 256 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
 		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
 			 Compliance De-emphasis: -6dB
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
 			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [a0] MSI: Enable- Count=1/4 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
 		Vector table: BAR=5 offset=00042000
 		PBA: BAR=5 offset=00043000
 	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
 	Capabilities: [270 v1] Secondary PCI Express
 		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 		LaneErrStat: 0
 	Capabilities: [2a0 v1] Access Control Services
 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 	Capabilities: [2b0 v1] Address Translation Service (ATS)
 		ATSCap:	Invalidate Queue Depth: 00
 		ATSCtl:	Enable-, Smallest Translation Unit: 00
 	Capabilities: [2c0 v1] Page Request Interface (PRI)
 		PRICtl: Enable- Reset-
 		PRISta: RF- UPRGI- Stopped+
 		Page Request Capacity: 00000100, Page Request Allocation: 00000000
 	Capabilities: [2d0 v1] Process Address Space ID (PASID)
 		PASIDCap: Exec+ Priv+, Max PASID Width: 10
 		PASIDCtl: Enable- Exec- Priv-
 	Capabilities: [400 v1] Data Link Feature <?>
 	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
 	Capabilities: [440 v1] Lane Margining at the Receiver <?>
 	Kernel driver in use: amdgpu
 	Kernel modules: amdgpu
 
 53:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
 	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin B routed to IRQ 107
+	Interrupt: pin B routed to IRQ 111
 	Region 0: Memory at efc88000 (32-bit, non-prefetchable) [size=16K]
 	Capabilities: [48] Vendor Specific Information: Len=08 <?>
 	Capabilities: [50] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 256 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
-		Address: 00000000fee06000  Data: 0027
+		Address: 00000000fee09000  Data: 0027
 	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
 	Capabilities: [2a0 v1] Access Control Services
 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 	Kernel driver in use: snd_hda_intel
 	Kernel modules: snd_hda_intel
 
 53:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
 	Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin C routed to IRQ 25
 	Region 2: Memory at efb00000 (32-bit, non-prefetchable) [size=1M]
 	Region 5: Memory at efc8c000 (32-bit, non-prefetchable) [size=8K]
 	Capabilities: [48] Vendor Specific Information: Len=08 <?>
 	Capabilities: [50] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [64] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 256 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [a0] MSI: Enable- Count=1/2 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [c0] MSI-X: Enable+ Count=2 Masked-
 		Vector table: BAR=5 offset=00000000
 		PBA: BAR=5 offset=00001000
 	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
 	Capabilities: [2a0 v1] Access Control Services
 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
@@ -2748,88 +2746,88 @@
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
 	Interrupt: pin A routed to IRQ 24
 	Region 0: Memory at ef900000 (64-bit, non-prefetchable) [size=1M]
 	Capabilities: [48] Vendor Specific Information: Len=08 <?>
 	Capabilities: [50] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [64] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 256 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
 		Vector table: BAR=0 offset=000fe000
 		PBA: BAR=0 offset=000ff000
 	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
 	Capabilities: [2a0 v1] Access Control Services
 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 	Kernel driver in use: xhci_hcd
 	Kernel modules: xhci_pci
 
 53:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) HD Audio Controller
 	DeviceName: Realtek ALC1220
 	Subsystem: Gigabyte Technology Co., Ltd Family 17h (Models 10h-1fh) HD Audio Controller
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0, Cache Line Size: 64 bytes
-	Interrupt: pin C routed to IRQ 108
+	Interrupt: pin C routed to IRQ 112
 	Region 0: Memory at efc80000 (32-bit, non-prefetchable) [size=32K]
 	Capabilities: [48] Vendor Specific Information: Len=08 <?>
 	Capabilities: [50] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
 	Capabilities: [64] Express (v2) Endpoint, MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 			MaxPayload 256 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
 			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 			 FRS- TPHComp- ExtTPHComp-
 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
 			 AtomicOpsCtl: ReqEn-
 		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 			 Retimer- 2Retimers- CrosslinkRes: unsupported
 	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
-		Address: 00000000fee08000  Data: 0027
+		Address: 00000000fee0b000  Data: 0027
 	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
 	Capabilities: [2a0 v1] Access Control Services
 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
 	Kernel driver in use: snd_hda_intel
 	Kernel modules: snd_hda_intel
 
