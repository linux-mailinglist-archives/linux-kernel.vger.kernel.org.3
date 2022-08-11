Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7300F58FE22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiHKOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiHKOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:17:26 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB26D55C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:17:22 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oM8zu-0005Ki-1Q; Fri, 12 Aug 2022 00:17:18 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I1YYSfO3C3idi/76XhE0hFnRJelIefXx9vfneMBsx5A=; b=aplCqA1mkHbuBzeyTrCqoG+iJf
        HMxRwPKgRPGyNIOC3JcDq7t0AFjG58fbMF2cVfgBq5G3fLWLPbxTtNHd1TnMsNjA+p6NbePGVQdhG
        BuRvEktTWez9LiMStXAj8qoCEDJnYoP7TbwNGlxluSku/e0GphKYBiCNsmI4I23D0GWw=;
Message-ID: <baf0f38a-27ac-ec2c-129d-c9430fc40dd0@fnarfbargle.com>
Date:   Thu, 11 Aug 2022 22:17:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
 <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
 <YvI9Cbin4OKQwZ05@lahna>
 <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
 <YvJyZ51H+YkceKJP@lahna>
 <39268cc6-4e05-b83c-ff73-3056925eeb76@fnarfbargle.com>
 <YvKCRPtoN6m2rMr2@lahna>
 <2c4420ac-d988-9dd8-c223-4243b9a6881e@fnarfbargle.com>
 <YvTQ0N2Py4rc4k3Z@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YvTQ0N2Py4rc4k3Z@lahna>
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


On 11/8/22 17:50, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Aug 10, 2022 at 03:40:08PM +0800, Brad Campbell wrote:
>> G'day Mika,
>>
>> On 9/8/22 23:50, Mika Westerberg wrote:
>>> Hi,
>>>
>>> On Tue, Aug 09, 2022 at 11:16:27PM +0800, Brad Campbell wrote:
>>>> If I then reboot and load the driver it fails.
>>>>
>>>> The only thing I could think of doing was an lspci -vvv after the boot and module load
>>>> and an lspci -vvv after a warm reboot and diff them, because there are changes around the
>>>> thunderbolt bridge devices. I've done a diff -u50 to try and keep as much context as possible.
>>>>
>>>> On the first boot I can unload/reload the thunderbolt module repeatedly and there's no issue
>>>> but loading it after a reboot locks up. There are no lspci changes on the first boot after the
>>>> initial module load unless I rescan the PCI bus, but they're minor and it doesn't cause an issue
>>>> with loading the thunderbolt module.
>>>>
>>>> The firmware *must* be doing something on reboot I suppose or the PCIe configs wouldn't change.
>>>
>>> Okay, let's try a bigger hammer and reset all the ports upon load. That
>>> should hopefully clear out the "bad state" too. This is completely
>>> untested but it should trigger reset and then re-initialize the TBT
>>> links.
>>>
>>> diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
>>> index 633970fbe9b0..c419c2568de4 100644
>>> --- a/drivers/thunderbolt/lc.c
>>> +++ b/drivers/thunderbolt/lc.c
>>> @@ -6,6 +6,8 @@
>>>    * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>    */
>>> +#include <linux/delay.h>
>>> +
>>>   #include "tb.h"
>>>   /**
>>> @@ -327,6 +329,34 @@ void tb_lc_xhci_disconnect(struct tb_port *port)
>>>   	tb_port_dbg(port, "xHCI disconnected\n");
>>>   }
>>> +int tb_lc_reset_port(struct tb_port *port)
>>> +{
>>> +	struct tb_switch *sw = port->sw;
>>> +	int cap, ret;
>>> +	u32 val;
>>> +
>>> +	if (sw->generation != 3)
>>> +		return -EINVAL;
>>> +
>>> +	cap = find_port_lc_cap(port);
>>> +	if (cap < 0)
>>> +		return cap;
>>> +
>>> +	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	val |= TB_LC_PORT_MODE_DPR;
>>> +	ret = tb_sw_write(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	msleep(20);
>>> +
>>> +	val &= ~TB_LC_PORT_MODE_DPR;
>>> +	return tb_sw_write(sw, &val, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
>>> +}
>>> +
>>>   static int tb_lc_set_wake_one(struct tb_switch *sw, unsigned int offset,
>>>   			      unsigned int flags)
>>>   {
>>> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
>>> index 0ae8a7ec7c9c..21ac3ccf1cf9 100644
>>> --- a/drivers/thunderbolt/switch.c
>>> +++ b/drivers/thunderbolt/switch.c
>>> @@ -740,6 +740,11 @@ int tb_port_disable(struct tb_port *port)
>>>   	return __tb_port_enable(port, false);
>>>   }
>>> +int tb_port_reset(struct tb_port *port)
>>> +{
>>> +	return tb_lc_reset_port(port);
>>> +}
>>> +
>>>   /*
>>>    * tb_init_port() - initialize a port
>>>    *
>>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>>> index 8030fc544c5e..48a7396994ef 100644
>>> --- a/drivers/thunderbolt/tb.c
>>> +++ b/drivers/thunderbolt/tb.c
>>> @@ -1875,6 +1875,7 @@ static int tb_scan_finalize_switch(struct device *dev, void *data)
>>>   static int tb_start(struct tb *tb)
>>>   {
>>>   	struct tb_cm *tcm = tb_priv(tb);
>>> +	struct tb_port *p;
>>>   	int ret;
>>>   	tb->root_switch = tb_switch_alloc(tb, &tb->dev, 0);
>>> @@ -1911,6 +1912,12 @@ static int tb_start(struct tb *tb)
>>>   				false);
>>>   	/* Enable TMU if it is off */
>>>   	tb_switch_tmu_enable(tb->root_switch);
>>> +
>>> +	tb_switch_for_each_port(tb->root_switch, p) {
>>> +		if (tb_port_is_null(p))
>>> +			tb_port_reset(p);
>>> +	}
>>> +
>>>   	/* Full scan to discover devices added before the driver was loaded. */
>>>   	tb_scan_switch(tb->root_switch);
>>>   	/* Find out tunnels created by the boot firmware */
>>> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
>>> index 28bb80d967d6..fe5edefec712 100644
>>> --- a/drivers/thunderbolt/tb.h
>>> +++ b/drivers/thunderbolt/tb.h
>>> @@ -1028,6 +1028,7 @@ int tb_port_clear_counter(struct tb_port *port, int counter);
>>>   int tb_port_unlock(struct tb_port *port);
>>>   int tb_port_enable(struct tb_port *port);
>>>   int tb_port_disable(struct tb_port *port);
>>> +int tb_port_reset(struct tb_port *port);
>>>   int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
>>>   void tb_port_release_in_hopid(struct tb_port *port, int hopid);
>>>   int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
>>> @@ -1121,6 +1122,7 @@ bool tb_lc_is_usb_plugged(struct tb_port *port);
>>>   bool tb_lc_is_xhci_connected(struct tb_port *port);
>>>   int tb_lc_xhci_connect(struct tb_port *port);
>>>   void tb_lc_xhci_disconnect(struct tb_port *port);
>>> +int tb_lc_reset_port(struct tb_port *port);
>>>   int tb_lc_set_wake(struct tb_switch *sw, unsigned int flags);
>>>   int tb_lc_set_sleep(struct tb_switch *sw);
>>>   bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
>>> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
>>> index f8c1ca3464d9..8fd12bc2d500 100644
>>> --- a/drivers/thunderbolt/tb_regs.h
>>> +++ b/drivers/thunderbolt/tb_regs.h
>>> @@ -555,6 +555,9 @@ struct tb_regs_hop {
>>>   #define TB_LC_POWER				0x740
>>>   /* Link controller registers */
>>> +#define TB_LC_PORT_MODE				0x26
>>> +#define TB_LC_PORT_MODE_DPR			BIT(6)
>>> +
>>>   #define TB_LC_CS_42				0x2a
>>>   #define TB_LC_CS_42_USB_PLUGGED			BIT(31)
>>>
>>
>> Yep, that certainly solves the lockup/reboot issues and all PCIe devices are
>> discovered and appear to work. I can reboot repeatedly and that seems to be ok.
>>
>> It causes some peculiarity in the DP tunnel however where one or both will fail to come up
>> leaving this in dmesg (in this instance both failed) :
>>
>> [   10.550439] [drm] Adding stream 00000000a5b9bb95 to context failed with err 28!
>> [   10.551032] [drm:handle_hpd_irq_helper [amdgpu]] *ERROR* Restoring old state failed with -22
>> [   11.180398] [drm] Adding stream 00000000a5b9bb95 to context failed with err 28!
>> [   11.180830] [drm:handle_hpd_irq_helper [amdgpu]] *ERROR* Restoring old state failed with -22
>>
>> Oddly enough X thinks the displays are there and is pretending to display on them, but they
>> remain black. This can be one, the other or both depending on the boot.
>>
>> I have probably cold/warm booted 50 times now with varying combinations of activation to attempt
>> to pin some form of determinism on this behaviour, but I've got nothing at this point.
> 
> Okay, do you see in the dmesg whether the DP tunnels are actually
> created when you see the issue?
> 

Yes, the DP tunnels appear to be created. Xorg sees them and believes they are there :

brad@bkd:~$ grep -A1 EDID  /var/log/Xorg.0.log.old 
[    29.377] (II) AMDGPU(0): EDID for output HDMI-A-0
[    29.377] (II) AMDGPU(0): Manufacturer: DEL  Model: a19d  Serial#: 810240841
--
[    29.377] (II) AMDGPU(0): EDID Version: 1.3
[    29.377] (II) AMDGPU(0): Digital Display Input
--
[    29.377] (II) AMDGPU(0): Number of EDID sections to follow: 1
[    29.377] (II) AMDGPU(0): EDID (in hex):
[    29.377] (II) AMDGPU(0): 	00ffffffffffff0010ac9da1494b4b30
--
[    29.377] (II) AMDGPU(0): EDID for output DisplayPort-0
[    29.377] (II) AMDGPU(0): Manufacturer: APP  Model: 9227  Serial#: 354616281
--
[    29.377] (II) AMDGPU(0): EDID Version: 1.4
[    29.377] (II) AMDGPU(0): Digital Display Input
--
[    29.378] (II) AMDGPU(0): Number of EDID sections to follow: 1
[    29.378] (II) AMDGPU(0): EDID (in hex):
[    29.378] (II) AMDGPU(0): 	00ffffffffffff0006102792d9032315
--
[    29.378] (II) AMDGPU(0): EDID for output DisplayPort-1
[    29.378] (II) AMDGPU(0): Manufacturer: APP  Model: 9227  Serial#: 437126968
--
[    29.378] (II) AMDGPU(0): EDID Version: 1.4
[    29.378] (II) AMDGPU(0): Digital Display Input
--
[    29.378] (II) AMDGPU(0): Number of EDID sections to follow: 1
[    29.378] (II) AMDGPU(0): EDID (in hex):
[    29.378] (II) AMDGPU(0): 	00ffffffffffff000610279238070e1a

This test was done with thunderbolt compiled in just to demonstrate, but any load sequence or combination
winds up with the same issue.

This is the full dmesg for completeness :

[    0.000000] Linux version 5.19.0+ (brad@bkd) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #71 SMP PREEMPT_DYNAMIC Thu Aug 11 21:44:47 AWST 2022
[    0.000000] Command line: ro root=UUID=c6cf971d-5412-4826-851d-5677ad7997c0 libata.allow_tpm=1 thunderbolt.dyndbg acpi_enforce_resources=lax drm.edid_firmware=DP-1:edid.bin,DP-2:edid1.bin video=DP-1:e video=DP-2:e usb-storage.quirks=0x0bc2:0x331a: initrd=\initrd.img-5.19.0+
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3376
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009c3efff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009c3f000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a20d000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x000000007a076fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a077000-0x000000007a077fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a078000-0x000000007a098fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a099000-0x000000007a099fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a09a000-0x000000009754cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000009754d000-0x000000009a086fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009a087000-0x000000009a0ddfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009a0de000-0x000000009bb5bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009bb5c000-0x000000009cdfefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009cdff000-0x000000009dffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000009e000000-0x000000009fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd600000-0x00000000fd6fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083e2fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000083e300000-0x000000085fffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x93710018-0x9371d857] usable ==> usable
[    0.000000] e820: update [mem 0x93710018-0x9371d857] usable ==> usable
[    0.000000] e820: update [mem 0x936cf018-0x936de057] usable ==> usable
[    0.000000] e820: update [mem 0x936cf018-0x936de057] usable ==> usable
[    0.000000] e820: update [mem 0x936c1018-0x936ce857] usable ==> usable
[    0.000000] e820: update [mem 0x936c1018-0x936ce857] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009c3efff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009c3f000-0x0000000009ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a20cfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000a20d000-0x000000000affffff] usable
[    0.000000] reserve setup_data: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000b020000-0x000000007a076fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007a077000-0x000000007a077fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007a078000-0x000000007a098fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007a099000-0x000000007a099fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007a09a000-0x00000000936c1017] usable
[    0.000000] reserve setup_data: [mem 0x00000000936c1018-0x00000000936ce857] usable
[    0.000000] reserve setup_data: [mem 0x00000000936ce858-0x00000000936cf017] usable
[    0.000000] reserve setup_data: [mem 0x00000000936cf018-0x00000000936de057] usable
[    0.000000] reserve setup_data: [mem 0x00000000936de058-0x0000000093710017] usable
[    0.000000] reserve setup_data: [mem 0x0000000093710018-0x000000009371d857] usable
[    0.000000] reserve setup_data: [mem 0x000000009371d858-0x000000009754cfff] usable
[    0.000000] reserve setup_data: [mem 0x000000009754d000-0x000000009a086fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009a087000-0x000000009a0ddfff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000009a0de000-0x000000009bb5bfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000009bb5c000-0x000000009cdfefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009cdff000-0x000000009dffffff] usable
[    0.000000] reserve setup_data: [mem 0x000000009e000000-0x000000009fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd600000-0x00000000fd6fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000083e2fffff] usable
[    0.000000] reserve setup_data: [mem 0x000000083e300000-0x000000085fffffff] reserved
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi: ACPI=0x9bb45000 ACPI 2.0=0x9bb45014 SMBIOS=0x9cc2b000 SMBIOS 3.0=0x9cc2a000 MEMATTR=0x93c90018 ESRT=0x96088c18 RNG=0x9cc27498 
[    0.000000] efi: seeding entropy pool
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. B550 VISION D-P/B550 VISION D-P, BIOS F15d 07/20/2022
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3899.951 MHz processor
[    0.000126] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000127] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000132] last_pfn = 0x83e300 max_arch_pfn = 0x400000000
[    0.000265] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000383] e820: update [mem 0xa0000000-0xffffffff] usable ==> reserved
[    0.000386] last_pfn = 0x9e000 max_arch_pfn = 0x400000000
[    0.000392] esrt: Reserving ESRT space from 0x0000000096088c18 to 0x0000000096088c50.
[    0.000398] e820: update [mem 0x96088000-0x96088fff] usable ==> reserved
[    0.000440] Using GB pages for direct mapping
[    0.001029] Secure boot disabled
[    0.001029] RAMDISK: [mem 0x7f197000-0x7fffffff]
[    0.001031] ACPI: Early table checksum verification disabled
[    0.001033] ACPI: RSDP 0x000000009BB45014 000024 (v02 ALASKA)
[    0.001035] ACPI: XSDT 0x000000009BB44728 0000D4 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.001037] ACPI: FACP 0x000000009A0C5000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.001040] ACPI: DSDT 0x000000009A096000 006227 (v02 ALASKA A M I    01072009 INTL 20190509)
[    0.001041] ACPI: FACS 0x000000009AB3F000 000040
[    0.001042] ACPI: SSDT 0x000000009A0D4000 009FFD (v02 GBT    GSWApp   00000001 INTL 20190509)
[    0.001043] ACPI: IVRS 0x000000009A0D3000 0000D0 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.001044] ACPI: SSDT 0x000000009A0CB000 0072B0 (v02 AMD    Artic    00000002 MSFT 04000000)
[    0.001045] ACPI: SSDT 0x000000009A0C7000 003D74 (v01 AMD    AMD AOD  00000001 INTL 20190509)
[    0.001046] ACPI: SSDT 0x000000009A0C6000 0001AD (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.001047] ACPI: FIDT 0x000000009A0BE000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001048] ACPI: MCFG 0x000000009A0BD000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.001049] ACPI: HPET 0x000000009A0BC000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.001050] ACPI: FPDT 0x000000009A0BB000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.001051] ACPI: VFCT 0x000000009A0AD000 00D884 (v01 ALASKA A M I    00000001 AMD  31504F47)
[    0.001052] ACPI: SSDT 0x000000009A0A9000 003E88 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.001053] ACPI: CRAT 0x000000009A0A8000 000B68 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.001054] ACPI: CDIT 0x000000009A0A7000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.001055] ACPI: SSDT 0x000000009A0A5000 001486 (v01 AMD    ArticIG2 00000001 INTL 20190509)
[    0.001056] ACPI: SSDT 0x000000009A0A3000 0014FD (v01 AMD    ArticTPX 00000001 INTL 20190509)
[    0.001057] ACPI: SSDT 0x000000009A09F000 0039F7 (v01 AMD    ArticN   00000001 INTL 20190509)
[    0.001058] ACPI: WSMT 0x000000009A09E000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001059] ACPI: APIC 0x000000009A09D000 00015E (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.001060] ACPI: SSDT 0x000000009A0C4000 0008A4 (v01 AMD    ArticPRN 00000001 INTL 20190509)
[    0.001061] ACPI: SSDT 0x000000009A0C2000 00147F (v01 AMD    ArticC   00000001 INTL 20190509)
[    0.001062] ACPI: SSDT 0x000000009A0C1000 0000BF (v01 AMD    AmdTable 00001000 INTL 20190509)
[    0.001063] ACPI: Reserving FACP table memory at [mem 0x9a0c5000-0x9a0c5113]
[    0.001064] ACPI: Reserving DSDT table memory at [mem 0x9a096000-0x9a09c226]
[    0.001064] ACPI: Reserving FACS table memory at [mem 0x9ab3f000-0x9ab3f03f]
[    0.001065] ACPI: Reserving SSDT table memory at [mem 0x9a0d4000-0x9a0ddffc]
[    0.001065] ACPI: Reserving IVRS table memory at [mem 0x9a0d3000-0x9a0d30cf]
[    0.001066] ACPI: Reserving SSDT table memory at [mem 0x9a0cb000-0x9a0d22af]
[    0.001066] ACPI: Reserving SSDT table memory at [mem 0x9a0c7000-0x9a0cad73]
[    0.001066] ACPI: Reserving SSDT table memory at [mem 0x9a0c6000-0x9a0c61ac]
[    0.001067] ACPI: Reserving FIDT table memory at [mem 0x9a0be000-0x9a0be09b]
[    0.001067] ACPI: Reserving MCFG table memory at [mem 0x9a0bd000-0x9a0bd03b]
[    0.001067] ACPI: Reserving HPET table memory at [mem 0x9a0bc000-0x9a0bc037]
[    0.001068] ACPI: Reserving FPDT table memory at [mem 0x9a0bb000-0x9a0bb043]
[    0.001068] ACPI: Reserving VFCT table memory at [mem 0x9a0ad000-0x9a0ba883]
[    0.001069] ACPI: Reserving SSDT table memory at [mem 0x9a0a9000-0x9a0ace87]
[    0.001069] ACPI: Reserving CRAT table memory at [mem 0x9a0a8000-0x9a0a8b67]
[    0.001069] ACPI: Reserving CDIT table memory at [mem 0x9a0a7000-0x9a0a7028]
[    0.001070] ACPI: Reserving SSDT table memory at [mem 0x9a0a5000-0x9a0a6485]
[    0.001070] ACPI: Reserving SSDT table memory at [mem 0x9a0a3000-0x9a0a44fc]
[    0.001070] ACPI: Reserving SSDT table memory at [mem 0x9a09f000-0x9a0a29f6]
[    0.001071] ACPI: Reserving WSMT table memory at [mem 0x9a09e000-0x9a09e027]
[    0.001071] ACPI: Reserving APIC table memory at [mem 0x9a09d000-0x9a09d15d]
[    0.001072] ACPI: Reserving SSDT table memory at [mem 0x9a0c4000-0x9a0c48a3]
[    0.001072] ACPI: Reserving SSDT table memory at [mem 0x9a0c2000-0x9a0c347e]
[    0.001073] ACPI: Reserving SSDT table memory at [mem 0x9a0c1000-0x9a0c10be]
[    0.001089] No NUMA configuration found
[    0.001090] Faking a node at [mem 0x0000000000000000-0x000000083e2fffff]
[    0.001092] NODE_DATA(0) allocated [mem 0x83e2fe000-0x83e2fffff]
[    0.001106] Zone ranges:
[    0.001107]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001108]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001108]   Normal   [mem 0x0000000100000000-0x000000083e2fffff]
[    0.001109] Movable zone start for each node
[    0.001109] Early memory node ranges
[    0.001109]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.001110]   node   0: [mem 0x0000000000100000-0x0000000009c3efff]
[    0.001111]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.001111]   node   0: [mem 0x000000000a20d000-0x000000000affffff]
[    0.001111]   node   0: [mem 0x000000000b020000-0x000000007a076fff]
[    0.001112]   node   0: [mem 0x000000007a078000-0x000000007a098fff]
[    0.001112]   node   0: [mem 0x000000007a09a000-0x000000009754cfff]
[    0.001112]   node   0: [mem 0x000000009cdff000-0x000000009dffffff]
[    0.001113]   node   0: [mem 0x0000000100000000-0x000000083e2fffff]
[    0.001114] Initmem setup node 0 [mem 0x0000000000001000-0x000000083e2fffff]
[    0.001116] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001125] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.001203] On node 0, zone DMA32: 961 pages in unavailable ranges
[    0.001211] On node 0, zone DMA32: 13 pages in unavailable ranges
[    0.002579] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.002580] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.003056] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.003177] On node 0, zone DMA32: 22706 pages in unavailable ranges
[    0.032388] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.032423] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.035600] ACPI: PM-Timer IO Port: 0x808
[    0.035605] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.035614] IOAPIC[0]: apic_id 13, version 33, address 0xfec00000, GSI 0-23
[    0.035619] IOAPIC[1]: apic_id 14, version 33, address 0xfec01000, GSI 24-55
[    0.035621] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.035622] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.035624] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.035624] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.035627] smpboot: 32 Processors exceeds NR_CPUS limit of 16
[    0.035627] smpboot: Allowing 16 CPUs, 4 hotplug CPUs
[    0.035647] [mem 0xa0000000-0xefffffff] available for PCI devices
[    0.035651] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.036985] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.037216] percpu: Embedded 44 pages/cpu s139816 r8192 d32216 u262144
[    0.037220] pcpu-alloc: s139816 r8192 d32216 u262144 alloc=1*2097152
[    0.037221] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.037236] Fallback order for Node 0: 0 
[    0.037237] Built 1 zonelists, mobility grouping on.  Total pages: 8089540
[    0.037238] Policy zone: Normal
[    0.037238] Kernel command line: ro root=UUID=c6cf971d-5412-4826-851d-5677ad7997c0 libata.allow_tpm=1 thunderbolt.dyndbg acpi_enforce_resources=lax drm.edid_firmware=DP-1:edid.bin,DP-2:edid1.bin video=DP-1:e video=DP-2:e usb-storage.quirks=0x0bc2:0x331a: initrd=\initrd.img-5.19.0+
[    0.037928] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.038261] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.038284] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.038285] software IO TLB: area num 16.
[    0.075796] Memory: 32128180K/32872436K available (8192K kernel code, 2323K rwdata, 1896K rodata, 952K init, 904K bss, 744000K reserved, 0K cma-reserved)
[    0.075819] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.076016] Dynamic Preempt: voluntary
[    0.076038] rcu: Preemptible hierarchical RCU implementation.
[    0.076040] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.076052] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    0.076210] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.076261] Console: colour dummy device 80x25
[    0.076413] printk: console [tty0] enabled
[    0.076424] ACPI: Core revision 20220331
[    0.076584] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.076601] APIC: Switch to symmetric I/O mode setup
[    0.076602] Switched APIC routing to physical flat.
[    0.077171] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.126606] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x706e5a0f9d3, max_idle_ns: 881591001681 ns
[    0.126611] Calibrating delay loop (skipped), value calculated using timer frequency.. 7799.90 BogoMIPS (lpj=38999510)
[    0.126614] pid_max: default: 32768 minimum: 301
[    0.127731] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.127765] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.127852] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.127870] LVT offset 1 assigned for vector 0xf9
[    0.127927] LVT offset 2 assigned for vector 0xf4
[    0.127943] process: using mwait in idle threads
[    0.127944] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.127945] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.127948] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.127950] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.127950] Spectre V2 : Vulnerable
[    0.127952] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.127953] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.127954] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.127956] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.127957] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.128116] Freeing SMP alternatives memory: 24K
[    0.248313] smpboot: CPU0: AMD Ryzen 5 5600G with Radeon Graphics (family: 0x19, model: 0x50, stepping: 0x0)
[    0.248402] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.248405] ... version:                0
[    0.248406] ... bit width:              48
[    0.248407] ... generic registers:      6
[    0.248408] ... value mask:             0000ffffffffffff
[    0.248409] ... max period:             00007fffffffffff
[    0.248409] ... fixed-purpose events:   0
[    0.248410] ... event mask:             000000000000003f
[    0.248449] rcu: Hierarchical SRCU implementation.
[    0.248450] rcu: 	Max phase no-delay instances is 1000.
[    0.248789] smp: Bringing up secondary CPUs ...
[    0.248843] x86: Booting SMP configuration:
[    0.248844] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6
[    0.258759] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.258759]   #7  #8  #9 #10 #11
[    0.268760] smp: Brought up 1 node, 12 CPUs
[    0.268760] smpboot: Max logical packages: 3
[    0.268760] smpboot: Total of 12 processors activated (93598.82 BogoMIPS)
[    0.268760] devtmpfs: initialized
[    0.268760] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20cfff] (53248 bytes)
[    0.268760] ACPI: PM: Registering ACPI NVS region [mem 0x9a0de000-0x9bb5bfff] (27779072 bytes)
[    0.268760] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.268760] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.268760] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.268760] thermal_sys: Registered thermal governor 'step_wise'
[    0.268760] thermal_sys: Registered thermal governor 'user_space'
[    0.268760] cpuidle: using governor ladder
[    0.268760] cpuidle: using governor menu
[    0.268760] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.268760] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.268760] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    0.268760] PCI: Using configuration type 1 for base access
[    0.268760] ACPI: Added _OSI(Module Device)
[    0.268760] ACPI: Added _OSI(Processor Device)
[    0.268760] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.268760] ACPI: Added _OSI(Processor Aggregator Device)
[    0.268760] ACPI: Added _OSI(Linux-Dell-Video)
[    0.268760] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.268760] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.278287] ACPI: 12 ACPI AML tables successfully acquired and loaded
[    0.278864] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.282976] ACPI: Interpreter enabled
[    0.282976] ACPI: PM: (supports S0 S3 S5)
[    0.282976] ACPI: Using IOAPIC for interrupt routing
[    0.282976] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.282976] PCI: Using E820 reservations for host bridge windows
[    0.282976] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.287077] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.287082] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.287135] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
[    0.287141] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-7f] only partially covers this bridge
[    0.287251] PCI host bridge to bus 0000:00
[    0.287253] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.287254] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.287256] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.287257] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.287258] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    0.287259] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xefffffff window]
[    0.287260] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.287269] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000
[    0.287324] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600
[    0.287385] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000
[    0.287424] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000
[    0.287457] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400
[    0.287478] pci 0000:00:02.1: enabling Extended Tags
[    0.287507] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.287548] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400
[    0.287594] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.287639] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000
[    0.287672] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400
[    0.287691] pci 0000:00:08.1: enabling Extended Tags
[    0.287717] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.287778] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.287869] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.287966] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000
[    0.287983] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000
[    0.287999] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000
[    0.288015] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000
[    0.288031] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000
[    0.288047] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000
[    0.288063] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000
[    0.288079] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000
[    0.288140] pci 0000:01:00.0: [1022:43ee] type 00 class 0x0c0330
[    0.288157] pci 0000:01:00.0: reg 0x10: [mem 0xef7a0000-0xef7a7fff 64bit]
[    0.288193] pci 0000:01:00.0: enabling Extended Tags
[    0.288242] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.288303] pci 0000:01:00.1: [1022:43eb] type 00 class 0x010601
[    0.288347] pci 0000:01:00.1: reg 0x24: [mem 0xef780000-0xef79ffff]
[    0.288354] pci 0000:01:00.1: reg 0x30: [mem 0xef700000-0xef77ffff pref]
[    0.288360] pci 0000:01:00.1: enabling Extended Tags
[    0.288397] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.288443] pci 0000:01:00.2: [1022:43e9] type 01 class 0x060400
[    0.288484] pci 0000:01:00.2: enabling Extended Tags
[    0.288525] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.288576] pci 0000:00:02.1: PCI bridge to [bus 01-51]
[    0.288579] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    0.288581] pci 0000:00:02.1:   bridge window [mem 0xdf000000-0xef7fffff]
[    0.288584] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.288640] pci 0000:02:00.0: [1022:43ea] type 01 class 0x060400
[    0.288683] pci 0000:02:00.0: enabling Extended Tags
[    0.288733] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.288792] pci 0000:02:04.0: [1022:43ea] type 01 class 0x060400
[    0.288835] pci 0000:02:04.0: enabling Extended Tags
[    0.288885] pci 0000:02:04.0: PME# supported from D3hot D3cold
[    0.288942] pci 0000:02:08.0: [1022:43ea] type 01 class 0x060400
[    0.288986] pci 0000:02:08.0: enabling Extended Tags
[    0.289036] pci 0000:02:08.0: PME# supported from D3hot D3cold
[    0.289093] pci 0000:02:09.0: [1022:43ea] type 01 class 0x060400
[    0.289137] pci 0000:02:09.0: enabling Extended Tags
[    0.289187] pci 0000:02:09.0: PME# supported from D3hot D3cold
[    0.289251] pci 0000:01:00.2: PCI bridge to [bus 02-51]
[    0.289256] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.289258] pci 0000:01:00.2:   bridge window [mem 0xdf000000-0xef6fffff]
[    0.289263] pci 0000:01:00.2:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.289318] pci 0000:03:00.0: [8086:15ea] type 01 class 0x060400
[    0.289386] pci 0000:03:00.0: enabling Extended Tags
[    0.289516] pci 0000:03:00.0: supports D1 D2
[    0.289517] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.289608] pci 0000:02:00.0: PCI bridge to [bus 03-4a]
[    0.289614] pci 0000:02:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    0.289619] pci 0000:02:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.289690] pci 0000:04:00.0: [8086:15ea] type 01 class 0x060400
[    0.289761] pci 0000:04:00.0: enabling Extended Tags
[    0.289894] pci 0000:04:00.0: supports D1 D2
[    0.289895] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.289992] pci 0000:04:01.0: [8086:15ea] type 01 class 0x060400
[    0.290063] pci 0000:04:01.0: enabling Extended Tags
[    0.290194] pci 0000:04:01.0: supports D1 D2
[    0.290195] pci 0000:04:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.290294] pci 0000:04:02.0: [8086:15ea] type 01 class 0x060400
[    0.290365] pci 0000:04:02.0: enabling Extended Tags
[    0.290495] pci 0000:04:02.0: supports D1 D2
[    0.290496] pci 0000:04:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.290597] pci 0000:04:04.0: [8086:15ea] type 01 class 0x060400
[    0.290668] pci 0000:04:04.0: enabling Extended Tags
[    0.290799] pci 0000:04:04.0: supports D1 D2
[    0.290800] pci 0000:04:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.290909] pci 0000:03:00.0: PCI bridge to [bus 04-4a]
[    0.290919] pci 0000:03:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    0.290926] pci 0000:03:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.291004] pci 0000:05:00.0: [8086:15eb] type 00 class 0x088000
[    0.291028] pci 0000:05:00.0: reg 0x10: [mem 0xef100000-0xef13ffff]
[    0.291038] pci 0000:05:00.0: reg 0x14: [mem 0xef140000-0xef140fff]
[    0.291095] pci 0000:05:00.0: enabling Extended Tags
[    0.291226] pci 0000:05:00.0: supports D1 D2
[    0.291227] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.291340] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.291351] pci 0000:04:00.0:   bridge window [mem 0xef100000-0xef1fffff]
[    0.291404] pci 0000:04:01.0: PCI bridge to [bus 06-27]
[    0.291414] pci 0000:04:01.0:   bridge window [mem 0xe7000000-0xeeffffff]
[    0.291421] pci 0000:04:01.0:   bridge window [mem 0xb0000000-0xb1ffffff 64bit pref]
[    0.291503] pci 0000:28:00.0: [8086:15ec] type 00 class 0x0c0330
[    0.291531] pci 0000:28:00.0: reg 0x10: [mem 0xef000000-0xef00ffff]
[    0.291625] pci 0000:28:00.0: enabling Extended Tags
[    0.291773] pci 0000:28:00.0: supports D1 D2
[    0.291774] pci 0000:28:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.291837] pci 0000:28:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:04:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    0.291893] pci 0000:04:02.0: PCI bridge to [bus 28]
[    0.291904] pci 0000:04:02.0:   bridge window [mem 0xef000000-0xef0fffff]
[    0.292009] pci 0000:29:00.0: [8086:1513] type 01 class 0x060400
[    0.292131] pci 0000:29:00.0: enabling Extended Tags
[    0.292311] pci 0000:29:00.0: supports D1 D2
[    0.292312] pci 0000:29:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.292456] pci 0000:04:04.0: PCI bridge to [bus 29-4a]
[    0.292466] pci 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[    0.292473] pci 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[    0.292591] pci 0000:2a:00.0: [8086:1513] type 01 class 0x060400
[    0.292717] pci 0000:2a:00.0: enabling Extended Tags
[    0.292899] pci 0000:2a:00.0: supports D1 D2
[    0.292900] pci 0000:2a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.293054] pci 0000:2a:01.0: [8086:1513] type 01 class 0x060400
[    0.293181] pci 0000:2a:01.0: enabling Extended Tags
[    0.293360] pci 0000:2a:01.0: supports D1 D2
[    0.293361] pci 0000:2a:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.293515] pci 0000:2a:02.0: [8086:1513] type 01 class 0x060400
[    0.293641] pci 0000:2a:02.0: enabling Extended Tags
[    0.293822] pci 0000:2a:02.0: supports D1 D2
[    0.293823] pci 0000:2a:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.293982] pci 0000:2a:04.0: [8086:1513] type 01 class 0x060400
[    0.294108] pci 0000:2a:04.0: enabling Extended Tags
[    0.294291] pci 0000:2a:04.0: supports D1 D2
[    0.294292] pci 0000:2a:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.294451] pci 0000:2a:05.0: [8086:1513] type 01 class 0x060400
[    0.294577] pci 0000:2a:05.0: enabling Extended Tags
[    0.294760] pci 0000:2a:05.0: supports D1 D2
[    0.294761] pci 0000:2a:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.294940] pci 0000:29:00.0: PCI bridge to [bus 2a-39]
[    0.294958] pci 0000:29:00.0:   bridge window [mem 0xdf000000-0xdf3fffff]
[    0.294971] pci 0000:29:00.0:   bridge window [mem 0xa0000000-0xa01fffff 64bit pref]
[    0.295090] pci 0000:2b:00.0: [12d8:400c] type 01 class 0x060400
[    0.295483] pci 0000:2b:00.0: supports D1 D2
[    0.295484] pci 0000:2b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.295662] pci 0000:2a:00.0: PCI bridge to [bus 2b-2d]
[    0.295681] pci 0000:2a:00.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.295863] pci 0000:2c:03.0: [12d8:400c] type 01 class 0x060400
[    0.296203] pci 0000:2c:03.0: supports D1 D2
[    0.296204] pci 0000:2c:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.296398] pci 0000:2b:00.0: PCI bridge to [bus 2c-2d]
[    0.296422] pci 0000:2b:00.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.296589] pci 0000:2d:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.296637] pci 0000:2d:00.0: reg 0x10: [mem 0xdf302000-0xdf302fff]
[    0.296906] pci 0000:2d:00.0: supports D1 D2
[    0.296907] pci 0000:2d:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.297056] pci 0000:2d:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.297103] pci 0000:2d:00.1: reg 0x10: [mem 0xdf301000-0xdf301fff]
[    0.297370] pci 0000:2d:00.1: supports D1 D2
[    0.297371] pci 0000:2d:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.297490] pci 0000:2d:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.297544] pci 0000:2d:00.2: reg 0x10: [mem 0xdf300000-0xdf3000ff]
[    0.297857] pci 0000:2d:00.2: supports D1 D2
[    0.297858] pci 0000:2d:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.298111] pci 0000:2c:03.0: PCI bridge to [bus 2d]
[    0.298135] pci 0000:2c:03.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.298309] pci 0000:2e:00.0: [14e4:16b0] type 00 class 0x020000
[    0.298374] pci 0000:2e:00.0: reg 0x10: [mem 0xa0110000-0xa011ffff 64bit pref]
[    0.298411] pci 0000:2e:00.0: reg 0x18: [mem 0xa0100000-0xa010ffff 64bit pref]
[    0.298731] pci 0000:2e:00.0: PME# supported from D0 D3hot D3cold
[    0.298949] pci 0000:2a:01.0: PCI bridge to [bus 2e]
[    0.298979] pci 0000:2a:01.0:   bridge window [mem 0xa0100000-0xa01fffff 64bit pref]
[    0.299095] pci 0000:2f:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.299160] pci 0000:2f:00.0: reg 0x10: [mem 0xdf200000-0xdf200fff 64bit]
[    0.299465] pci 0000:2f:00.0: supports D1 D2
[    0.299466] pci 0000:2f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.299659] pci 0000:2a:02.0: PCI bridge to [bus 2f]
[    0.299677] pci 0000:2a:02.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.299830] pci 0000:30:00.0: [8086:1513] type 01 class 0x060400
[    0.300005] pci 0000:30:00.0: enabling Extended Tags
[    0.300263] pci 0000:30:00.0: supports D1 D2
[    0.300264] pci 0000:30:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.300476] pci 0000:2a:04.0: PCI bridge to [bus 30-38]
[    0.300494] pci 0000:2a:04.0:   bridge window [mem 0xdf000000-0xdf1fffff]
[    0.300507] pci 0000:2a:04.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.300676] pci 0000:31:00.0: [8086:1513] type 01 class 0x060400
[    0.300859] pci 0000:31:00.0: enabling Extended Tags
[    0.301120] pci 0000:31:00.0: supports D1 D2
[    0.301121] pci 0000:31:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.301340] pci 0000:31:01.0: [8086:1513] type 01 class 0x060400
[    0.301522] pci 0000:31:01.0: enabling Extended Tags
[    0.301783] pci 0000:31:01.0: supports D1 D2
[    0.301784] pci 0000:31:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.302003] pci 0000:31:02.0: [8086:1513] type 01 class 0x060400
[    0.302185] pci 0000:31:02.0: enabling Extended Tags
[    0.302445] pci 0000:31:02.0: supports D1 D2
[    0.302446] pci 0000:31:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.302672] pci 0000:31:04.0: [8086:1513] type 01 class 0x060400
[    0.302854] pci 0000:31:04.0: enabling Extended Tags
[    0.303119] pci 0000:31:04.0: supports D1 D2
[    0.303120] pci 0000:31:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.303346] pci 0000:31:05.0: [8086:1513] type 01 class 0x060400
[    0.303529] pci 0000:31:05.0: enabling Extended Tags
[    0.303794] pci 0000:31:05.0: supports D1 D2
[    0.303795] pci 0000:31:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.304050] pci 0000:30:00.0: PCI bridge to [bus 31-38]
[    0.304075] pci 0000:30:00.0:   bridge window [mem 0xdf000000-0xdf1fffff]
[    0.304093] pci 0000:30:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.304256] pci 0000:32:00.0: [12d8:400c] type 01 class 0x060400
[    0.304782] pci 0000:32:00.0: supports D1 D2
[    0.304783] pci 0000:32:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.305027] pci 0000:31:00.0: PCI bridge to [bus 32-34]
[    0.305054] pci 0000:31:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.305296] pci 0000:33:03.0: [12d8:400c] type 01 class 0x060400
[    0.305749] pci 0000:33:03.0: supports D1 D2
[    0.305750] pci 0000:33:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.306005] pci 0000:32:00.0: PCI bridge to [bus 33-34]
[    0.306037] pci 0000:32:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.306259] pci 0000:34:00.0: [12d8:400e] type 00 class 0x0c0310
[    0.306321] pci 0000:34:00.0: reg 0x10: [mem 0xdf102000-0xdf102fff]
[    0.306687] pci 0000:34:00.0: supports D1 D2
[    0.306688] pci 0000:34:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.306890] pci 0000:34:00.1: [12d8:400e] type 00 class 0x0c0310
[    0.306952] pci 0000:34:00.1: reg 0x10: [mem 0xdf101000-0xdf101fff]
[    0.307308] pci 0000:34:00.1: supports D1 D2
[    0.307309] pci 0000:34:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.307464] pci 0000:34:00.2: [12d8:400f] type 00 class 0x0c0320
[    0.307536] pci 0000:34:00.2: reg 0x10: [mem 0xdf100000-0xdf1000ff]
[    0.307953] pci 0000:34:00.2: supports D1 D2
[    0.307954] pci 0000:34:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.308302] pci 0000:33:03.0: PCI bridge to [bus 34]
[    0.308334] pci 0000:33:03.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.308571] pci 0000:35:00.0: [14e4:16b0] type 00 class 0x020000
[    0.308656] pci 0000:35:00.0: reg 0x10: [mem 0xa0010000-0xa001ffff 64bit pref]
[    0.308704] pci 0000:35:00.0: reg 0x18: [mem 0xa0000000-0xa000ffff 64bit pref]
[    0.309130] pci 0000:35:00.0: PME# supported from D0 D3hot D3cold
[    0.309426] pci 0000:31:01.0: PCI bridge to [bus 35]
[    0.309469] pci 0000:31:01.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.309629] pci 0000:36:00.0: [11c1:5901] type 00 class 0x0c0010
[    0.309714] pci 0000:36:00.0: reg 0x10: [mem 0xdf000000-0xdf000fff 64bit]
[    0.310131] pci 0000:36:00.0: supports D1 D2
[    0.310132] pci 0000:36:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.310408] pci 0000:31:02.0: PCI bridge to [bus 36]
[    0.310434] pci 0000:31:02.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[    0.310547] pci 0000:31:04.0: PCI bridge to [bus 37]
[    0.310683] pci 0000:31:05.0: PCI bridge to [bus 38]
[    0.310898] pci 0000:2a:05.0: PCI bridge to [bus 39]
[    0.311080] pci 0000:4b:00.0: [2646:2262] type 00 class 0x010802
[    0.311108] pci 0000:4b:00.0: reg 0x10: [mem 0xef600000-0xef603fff 64bit]
[    0.311328] pci 0000:02:04.0: PCI bridge to [bus 4b]
[    0.311334] pci 0000:02:04.0:   bridge window [mem 0xef600000-0xef6fffff]
[    0.311397] pci 0000:4c:00.0: [1b21:1806] type 01 class 0x060400
[    0.311468] pci 0000:4c:00.0: enabling Extended Tags
[    0.311575] pci 0000:4c:00.0: PME# supported from D0 D3hot D3cold
[    0.311618] pci 0000:4c:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:02:08.0 (capable of 15.752 Gb/s with 8.0 GT/s PCIe x2 link)
[    0.311668] pci 0000:02:08.0: PCI bridge to [bus 4c-50]
[    0.311673] pci 0000:02:08.0:   bridge window [io  0xf000-0xffff]
[    0.311676] pci 0000:02:08.0:   bridge window [mem 0xef500000-0xef5fffff]
[    0.311739] pci 0000:4d:00.0: [1b21:1806] type 01 class 0x060400
[    0.311813] pci 0000:4d:00.0: enabling Extended Tags
[    0.311919] pci 0000:4d:00.0: PME# supported from D0 D3hot D3cold
[    0.312017] pci 0000:4d:06.0: [1b21:1806] type 01 class 0x060400
[    0.312090] pci 0000:4d:06.0: enabling Extended Tags
[    0.312197] pci 0000:4d:06.0: PME# supported from D0 D3hot D3cold
[    0.312285] pci 0000:4d:0e.0: [1b21:1806] type 01 class 0x060400
[    0.312358] pci 0000:4d:0e.0: enabling Extended Tags
[    0.312465] pci 0000:4d:0e.0: PME# supported from D0 D3hot D3cold
[    0.312549] pci 0000:4c:00.0: PCI bridge to [bus 4d-50]
[    0.312557] pci 0000:4c:00.0:   bridge window [io  0xf000-0xffff]
[    0.312561] pci 0000:4c:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    0.312635] pci 0000:4e:00.0: [10ec:8125] type 00 class 0x020000
[    0.312668] pci 0000:4e:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    0.312709] pci 0000:4e:00.0: reg 0x18: [mem 0xef500000-0xef50ffff 64bit]
[    0.312734] pci 0000:4e:00.0: reg 0x20: [mem 0xef510000-0xef513fff 64bit]
[    0.312920] pci 0000:4e:00.0: supports D1 D2
[    0.312921] pci 0000:4e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.313073] pci 0000:4d:00.0: PCI bridge to [bus 4e]
[    0.313080] pci 0000:4d:00.0:   bridge window [io  0xf000-0xffff]
[    0.313084] pci 0000:4d:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    0.313133] pci 0000:4d:06.0: PCI bridge to [bus 4f]
[    0.313191] pci 0000:4d:0e.0: PCI bridge to [bus 50]
[    0.313294] pci 0000:51:00.0: [8086:15f3] type 00 class 0x020000
[    0.313318] pci 0000:51:00.0: reg 0x10: [mem 0xef300000-0xef3fffff]
[    0.313353] pci 0000:51:00.0: reg 0x1c: [mem 0xef400000-0xef403fff]
[    0.313495] pci 0000:51:00.0: PME# supported from D0 D3hot D3cold
[    0.313591] pci 0000:02:09.0: PCI bridge to [bus 51]
[    0.313597] pci 0000:02:09.0:   bridge window [mem 0xef300000-0xef4fffff]
[    0.313650] pci 0000:52:00.0: [c0a9:540a] type 00 class 0x010802
[    0.313667] pci 0000:52:00.0: reg 0x10: [mem 0xefd00000-0xefd03fff 64bit]
[    0.313795] pci 0000:00:02.2: PCI bridge to [bus 52]
[    0.313799] pci 0000:00:02.2:   bridge window [mem 0xefd00000-0xefdfffff]
[    0.313833] pci 0000:53:00.0: [1002:1638] type 00 class 0x030000
[    0.313843] pci 0000:53:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.313850] pci 0000:53:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    0.313855] pci 0000:53:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.313860] pci 0000:53:00.0: reg 0x24: [mem 0xefc00000-0xefc7ffff]
[    0.313867] pci 0000:53:00.0: enabling Extended Tags
[    0.313876] pci 0000:53:00.0: BAR 0: assigned to efifb
[    0.313911] pci 0000:53:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.313924] pci 0000:53:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.313953] pci 0000:53:00.1: [1002:1637] type 00 class 0x040300
[    0.313960] pci 0000:53:00.1: reg 0x10: [mem 0xefc88000-0xefc8bfff]
[    0.313979] pci 0000:53:00.1: enabling Extended Tags
[    0.314004] pci 0000:53:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.314035] pci 0000:53:00.2: [1022:15df] type 00 class 0x108000
[    0.314047] pci 0000:53:00.2: reg 0x18: [mem 0xefb00000-0xefbfffff]
[    0.314055] pci 0000:53:00.2: reg 0x24: [mem 0xefc8c000-0xefc8dfff]
[    0.314062] pci 0000:53:00.2: enabling Extended Tags
[    0.314118] pci 0000:53:00.3: [1022:1639] type 00 class 0x0c0330
[    0.314128] pci 0000:53:00.3: reg 0x10: [mem 0xefa00000-0xefafffff 64bit]
[    0.314149] pci 0000:53:00.3: enabling Extended Tags
[    0.314176] pci 0000:53:00.3: PME# supported from D0 D3hot D3cold
[    0.314209] pci 0000:53:00.4: [1022:1639] type 00 class 0x0c0330
[    0.314219] pci 0000:53:00.4: reg 0x10: [mem 0xef900000-0xef9fffff 64bit]
[    0.314240] pci 0000:53:00.4: enabling Extended Tags
[    0.314267] pci 0000:53:00.4: PME# supported from D0 D3hot D3cold
[    0.314300] pci 0000:53:00.6: [1022:15e3] type 00 class 0x040300
[    0.314307] pci 0000:53:00.6: reg 0x10: [mem 0xefc80000-0xefc87fff]
[    0.314326] pci 0000:53:00.6: enabling Extended Tags
[    0.314351] pci 0000:53:00.6: PME# supported from D0 D3hot D3cold
[    0.314396] pci 0000:00:08.1: PCI bridge to [bus 53]
[    0.314398] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.314400] pci 0000:00:08.1:   bridge window [mem 0xef900000-0xefcfffff]
[    0.314403] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.314656] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.314681] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.314701] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.314727] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.314750] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.314769] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.314788] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.314807] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.315132] SCSI subsystem initialized
[    0.315136] libata version 3.00 loaded.
[    0.315157] Registered efivars operations
[    0.315200] PCI: Using ACPI for IRQ routing
[    0.319807] PCI: pci_cache_line_size set to 64 bytes
[    0.320102] e820: reserve RAM buffer [mem 0x09c3f000-0x0bffffff]
[    0.320103] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.320104] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.320104] e820: reserve RAM buffer [mem 0x7a077000-0x7bffffff]
[    0.320105] e820: reserve RAM buffer [mem 0x7a099000-0x7bffffff]
[    0.320105] e820: reserve RAM buffer [mem 0x936c1018-0x93ffffff]
[    0.320105] e820: reserve RAM buffer [mem 0x936cf018-0x93ffffff]
[    0.320106] e820: reserve RAM buffer [mem 0x93710018-0x93ffffff]
[    0.320106] e820: reserve RAM buffer [mem 0x96088000-0x97ffffff]
[    0.320107] e820: reserve RAM buffer [mem 0x9754d000-0x97ffffff]
[    0.320107] e820: reserve RAM buffer [mem 0x9e000000-0x9fffffff]
[    0.320108] e820: reserve RAM buffer [mem 0x83e300000-0x83fffffff]
[    0.320113] pci 0000:53:00.0: vgaarb: setting as boot VGA device
[    0.320113] pci 0000:53:00.0: vgaarb: bridge control possible
[    0.320113] pci 0000:53:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.320113] vgaarb: loaded
[    0.320113] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.320113] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.320113] clocksource: Switched to clocksource tsc-early
[    0.320113] VFS: Disk quotas dquot_6.6.0
[    0.320113] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.320113] pnp: PnP ACPI init
[    0.320113] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.320113] system 00:01: [mem 0x840000000-0x85fffffff window] has been reserved
[    0.320113] system 00:03: [io  0x0a00-0x0a2f] has been reserved
[    0.320113] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    0.320113] system 00:03: [io  0x0a40-0x0a4f] has been reserved
[    0.320113] system 00:03: [mem 0xfe000000-0xfe00ffff] has been reserved
[    0.320113] pnp 00:05: [dma 0 disabled]
[    0.320113] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.320113] system 00:06: [io  0x040b] has been reserved
[    0.320113] system 00:06: [io  0x04d6] has been reserved
[    0.320113] system 00:06: [io  0x0c00-0x0c01] has been reserved
[    0.320113] system 00:06: [io  0x0c14] has been reserved
[    0.320113] system 00:06: [io  0x0c50-0x0c51] has been reserved
[    0.320113] system 00:06: [io  0x0c52] has been reserved
[    0.320113] system 00:06: [io  0x0c6c] has been reserved
[    0.320113] system 00:06: [io  0x0c6f] has been reserved
[    0.320113] system 00:06: [io  0x0cd8-0x0cdf] has been reserved
[    0.320113] system 00:06: [io  0x0800-0x089f] has been reserved
[    0.320113] system 00:06: [io  0x0b00-0x0b0f] has been reserved
[    0.320113] system 00:06: [io  0x0b20-0x0b3f] has been reserved
[    0.320113] system 00:06: [io  0x0900-0x090f] has been reserved
[    0.320113] system 00:06: [io  0x0910-0x091f] has been reserved
[    0.320113] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.320113] system 00:06: [mem 0xfec01000-0xfec01fff] could not be reserved
[    0.320113] system 00:06: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.320113] system 00:06: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.320113] system 00:06: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    0.320113] system 00:06: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.320113] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    0.320113] pnp: PnP ACPI: found 7 devices
[    0.322811] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.322839] NET: Registered PF_INET protocol family
[    0.322964] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.324942] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.324957] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.324960] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.325089] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.325139] TCP: Hash tables configured (established 262144 bind 65536)
[    0.325151] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.325183] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.325231] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.325237] pci 0000:04:01.0: bridge window [io  0x1000-0x0fff] to [bus 06-27] add_size 1000
[    0.325241] pci 0000:31:04.0: bridge window [io  0x1000-0x0fff] to [bus 37] add_size 1000
[    0.325243] pci 0000:31:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 37] add_size 200000 add_align 100000
[    0.325246] pci 0000:31:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 37] add_size 200000 add_align 100000
[    0.325247] pci 0000:31:05.0: bridge window [io  0x1000-0x0fff] to [bus 38] add_size 1000
[    0.325249] pci 0000:31:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 38] add_size 200000 add_align 100000
[    0.325250] pci 0000:31:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 38] add_size 200000 add_align 100000
[    0.325252] pci 0000:30:00.0: bridge window [io  0x1000-0x0fff] to [bus 31-38] add_size 2000
[    0.325254] pci 0000:2a:04.0: bridge window [io  0x1000-0x0fff] to [bus 30-38] add_size 3000
[    0.325255] pci 0000:2a:05.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
[    0.325257] pci 0000:2a:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
[    0.325258] pci 0000:2a:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 39] add_size 200000 add_align 100000
[    0.325260] pci 0000:29:00.0: bridge window [io  0x1000-0x0fff] to [bus 2a-39] add_size 4000
[    0.325262] pci 0000:04:04.0: bridge window [io  0x1000-0x0fff] to [bus 29-4a] add_size 5000
[    0.325263] pci 0000:03:00.0: bridge window [io  0x1000-0x0fff] to [bus 04-4a] add_size 6000
[    0.325265] pci 0000:02:00.0: bridge window [io  0x1000-0x0fff] to [bus 03-4a] add_size 6000
[    0.325269] pci 0000:02:00.0: BAR 7: no space for [io  size 0x6000]
[    0.325271] pci 0000:02:00.0: BAR 7: failed to assign [io  size 0x6000]
[    0.325272] pci 0000:02:00.0: BAR 7: no space for [io  size 0x6000]
[    0.325273] pci 0000:02:00.0: BAR 7: failed to assign [io  size 0x6000]
[    0.325275] pci 0000:03:00.0: BAR 7: no space for [io  size 0x6000]
[    0.325276] pci 0000:03:00.0: BAR 7: failed to assign [io  size 0x6000]
[    0.325277] pci 0000:03:00.0: BAR 7: no space for [io  size 0x6000]
[    0.325278] pci 0000:03:00.0: BAR 7: failed to assign [io  size 0x6000]
[    0.325280] pci 0000:04:01.0: BAR 7: no space for [io  size 0x1000]
[    0.325281] pci 0000:04:01.0: BAR 7: failed to assign [io  size 0x1000]
[    0.325282] pci 0000:04:04.0: BAR 7: no space for [io  size 0x5000]
[    0.325283] pci 0000:04:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.325284] pci 0000:04:04.0: BAR 7: no space for [io  size 0x5000]
[    0.325285] pci 0000:04:04.0: BAR 7: failed to assign [io  size 0x5000]
[    0.325286] pci 0000:04:01.0: BAR 7: no space for [io  size 0x1000]
[    0.325287] pci 0000:04:01.0: BAR 7: failed to assign [io  size 0x1000]
[    0.325289] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.325299] pci 0000:04:00.0:   bridge window [mem 0xef100000-0xef1fffff]
[    0.325309] pci 0000:04:01.0: PCI bridge to [bus 06-27]
[    0.325315] pci 0000:04:01.0:   bridge window [mem 0xe7000000-0xeeffffff]
[    0.325319] pci 0000:04:01.0:   bridge window [mem 0xb0000000-0xb1ffffff 64bit pref]
[    0.325327] pci 0000:04:02.0: PCI bridge to [bus 28]
[    0.325332] pci 0000:04:02.0:   bridge window [mem 0xef000000-0xef0fffff]
[    0.325343] pci 0000:29:00.0: BAR 7: no space for [io  size 0x4000]
[    0.325344] pci 0000:29:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.325345] pci 0000:29:00.0: BAR 7: no space for [io  size 0x4000]
[    0.325346] pci 0000:29:00.0: BAR 7: failed to assign [io  size 0x4000]
[    0.325348] pci 0000:2a:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.325349] pci 0000:2a:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.325351] pci 0000:2a:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.325352] pci 0000:2a:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.325353] pci 0000:2a:04.0: BAR 7: no space for [io  size 0x3000]
[    0.325355] pci 0000:2a:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.325356] pci 0000:2a:05.0: BAR 7: no space for [io  size 0x1000]
[    0.325357] pci 0000:2a:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.325358] pci 0000:2a:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.325359] pci 0000:2a:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.325361] pci 0000:2a:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.325362] pci 0000:2a:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.325363] pci 0000:2a:05.0: BAR 7: no space for [io  size 0x1000]
[    0.325364] pci 0000:2a:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.325365] pci 0000:2a:04.0: BAR 7: no space for [io  size 0x3000]
[    0.325366] pci 0000:2a:04.0: BAR 7: failed to assign [io  size 0x3000]
[    0.325368] pci 0000:2c:03.0: PCI bridge to [bus 2d]
[    0.325380] pci 0000:2c:03.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.325404] pci 0000:2b:00.0: PCI bridge to [bus 2c-2d]
[    0.325417] pci 0000:2b:00.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.325440] pci 0000:2a:00.0: PCI bridge to [bus 2b-2d]
[    0.325449] pci 0000:2a:00.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.325468] pci 0000:2a:01.0: PCI bridge to [bus 2e]
[    0.325483] pci 0000:2a:01.0:   bridge window [mem 0xa0100000-0xa01fffff 64bit pref]
[    0.325496] pci 0000:2a:02.0: PCI bridge to [bus 2f]
[    0.325505] pci 0000:2a:02.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.325524] pci 0000:30:00.0: BAR 7: no space for [io  size 0x2000]
[    0.325525] pci 0000:30:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.325526] pci 0000:30:00.0: BAR 7: no space for [io  size 0x2000]
[    0.325527] pci 0000:30:00.0: BAR 7: failed to assign [io  size 0x2000]
[    0.325529] pci 0000:31:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.325530] pci 0000:31:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.325532] pci 0000:31:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.325533] pci 0000:31:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.325535] pci 0000:31:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.325536] pci 0000:31:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.325537] pci 0000:31:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.325538] pci 0000:31:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.325540] pci 0000:31:04.0: BAR 7: no space for [io  size 0x1000]
[    0.325541] pci 0000:31:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.325542] pci 0000:31:05.0: BAR 7: no space for [io  size 0x1000]
[    0.325543] pci 0000:31:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.325544] pci 0000:31:05.0: BAR 8: no space for [mem size 0x00200000]
[    0.325545] pci 0000:31:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.325547] pci 0000:31:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.325548] pci 0000:31:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.325549] pci 0000:31:05.0: BAR 7: no space for [io  size 0x1000]
[    0.325550] pci 0000:31:05.0: BAR 7: failed to assign [io  size 0x1000]
[    0.325552] pci 0000:31:04.0: BAR 8: no space for [mem size 0x00200000]
[    0.325553] pci 0000:31:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    0.325554] pci 0000:31:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    0.325555] pci 0000:31:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    0.325557] pci 0000:31:04.0: BAR 7: no space for [io  size 0x1000]
[    0.325558] pci 0000:31:04.0: BAR 7: failed to assign [io  size 0x1000]
[    0.325559] pci 0000:33:03.0: PCI bridge to [bus 34]
[    0.325575] pci 0000:33:03.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.325607] pci 0000:32:00.0: PCI bridge to [bus 33-34]
[    0.325624] pci 0000:32:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.325655] pci 0000:31:00.0: PCI bridge to [bus 32-34]
[    0.325669] pci 0000:31:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    0.325695] pci 0000:31:01.0: PCI bridge to [bus 35]
[    0.325716] pci 0000:31:01.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.325734] pci 0000:31:02.0: PCI bridge to [bus 36]
[    0.325747] pci 0000:31:02.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[    0.325773] pci 0000:31:04.0: PCI bridge to [bus 37]
[    0.325811] pci 0000:31:05.0: PCI bridge to [bus 38]
[    0.325850] pci 0000:30:00.0: PCI bridge to [bus 31-38]
[    0.325863] pci 0000:30:00.0:   bridge window [mem 0xdf000000-0xdf1fffff]
[    0.325872] pci 0000:30:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.325890] pci 0000:2a:04.0: PCI bridge to [bus 30-38]
[    0.325899] pci 0000:2a:04.0:   bridge window [mem 0xdf000000-0xdf1fffff]
[    0.325906] pci 0000:2a:04.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.325919] pci 0000:2a:05.0: PCI bridge to [bus 39]
[    0.325945] pci 0000:29:00.0: PCI bridge to [bus 2a-39]
[    0.325954] pci 0000:29:00.0:   bridge window [mem 0xdf000000-0xdf3fffff]
[    0.325961] pci 0000:29:00.0:   bridge window [mem 0xa0000000-0xa01fffff 64bit pref]
[    0.325974] pci 0000:04:04.0: PCI bridge to [bus 29-4a]
[    0.325979] pci 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[    0.325983] pci 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[    0.325991] pci 0000:03:00.0: PCI bridge to [bus 04-4a]
[    0.325996] pci 0000:03:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    0.326000] pci 0000:03:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.326008] pci 0000:02:00.0: PCI bridge to [bus 03-4a]
[    0.326011] pci 0000:02:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    0.326014] pci 0000:02:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.326019] pci 0000:02:04.0: PCI bridge to [bus 4b]
[    0.326023] pci 0000:02:04.0:   bridge window [mem 0xef600000-0xef6fffff]
[    0.326029] pci 0000:4d:00.0: PCI bridge to [bus 4e]
[    0.326032] pci 0000:4d:00.0:   bridge window [io  0xf000-0xffff]
[    0.326038] pci 0000:4d:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    0.326048] pci 0000:4d:06.0: PCI bridge to [bus 4f]
[    0.326063] pci 0000:4d:0e.0: PCI bridge to [bus 50]
[    0.326078] pci 0000:4c:00.0: PCI bridge to [bus 4d-50]
[    0.326080] pci 0000:4c:00.0:   bridge window [io  0xf000-0xffff]
[    0.326086] pci 0000:4c:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    0.326096] pci 0000:02:08.0: PCI bridge to [bus 4c-50]
[    0.326098] pci 0000:02:08.0:   bridge window [io  0xf000-0xffff]
[    0.326102] pci 0000:02:08.0:   bridge window [mem 0xef500000-0xef5fffff]
[    0.326108] pci 0000:02:09.0: PCI bridge to [bus 51]
[    0.326112] pci 0000:02:09.0:   bridge window [mem 0xef300000-0xef4fffff]
[    0.326119] pci 0000:01:00.2: PCI bridge to [bus 02-51]
[    0.326120] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.326124] pci 0000:01:00.2:   bridge window [mem 0xdf000000-0xef6fffff]
[    0.326127] pci 0000:01:00.2:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.326131] pci 0000:00:02.1: PCI bridge to [bus 01-51]
[    0.326133] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    0.326135] pci 0000:00:02.1:   bridge window [mem 0xdf000000-0xef7fffff]
[    0.326137] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.326140] pci 0000:00:02.2: PCI bridge to [bus 52]
[    0.326142] pci 0000:00:02.2:   bridge window [mem 0xefd00000-0xefdfffff]
[    0.326146] pci 0000:00:08.1: PCI bridge to [bus 53]
[    0.326148] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    0.326150] pci 0000:00:08.1:   bridge window [mem 0xef900000-0xefcfffff]
[    0.326152] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.326155] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.326156] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.326158] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.326159] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.326160] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    0.326161] pci_bus 0000:00: resource 9 [mem 0xa0000000-0xefffffff window]
[    0.326162] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.326163] pci_bus 0000:01: resource 1 [mem 0xdf000000-0xef7fffff]
[    0.326164] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.326166] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.326167] pci_bus 0000:02: resource 1 [mem 0xdf000000-0xef6fffff]
[    0.326168] pci_bus 0000:02: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.326169] pci_bus 0000:03: resource 1 [mem 0xdf000000-0xef1fffff]
[    0.326170] pci_bus 0000:03: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.326171] pci_bus 0000:04: resource 1 [mem 0xdf000000-0xef1fffff]
[    0.326172] pci_bus 0000:04: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.326174] pci_bus 0000:05: resource 1 [mem 0xef100000-0xef1fffff]
[    0.326175] pci_bus 0000:06: resource 1 [mem 0xe7000000-0xeeffffff]
[    0.326176] pci_bus 0000:06: resource 2 [mem 0xb0000000-0xb1ffffff 64bit pref]
[    0.326177] pci_bus 0000:28: resource 1 [mem 0xef000000-0xef0fffff]
[    0.326178] pci_bus 0000:29: resource 1 [mem 0xdf000000-0xe6ffffff]
[    0.326179] pci_bus 0000:29: resource 2 [mem 0xa0000000-0xa1ffffff 64bit pref]
[    0.326180] pci_bus 0000:2a: resource 1 [mem 0xdf000000-0xdf3fffff]
[    0.326181] pci_bus 0000:2a: resource 2 [mem 0xa0000000-0xa01fffff 64bit pref]
[    0.326183] pci_bus 0000:2b: resource 1 [mem 0xdf300000-0xdf3fffff]
[    0.326184] pci_bus 0000:2c: resource 1 [mem 0xdf300000-0xdf3fffff]
[    0.326185] pci_bus 0000:2d: resource 1 [mem 0xdf300000-0xdf3fffff]
[    0.326186] pci_bus 0000:2e: resource 2 [mem 0xa0100000-0xa01fffff 64bit pref]
[    0.326187] pci_bus 0000:2f: resource 1 [mem 0xdf200000-0xdf2fffff]
[    0.326188] pci_bus 0000:30: resource 1 [mem 0xdf000000-0xdf1fffff]
[    0.326189] pci_bus 0000:30: resource 2 [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.326190] pci_bus 0000:31: resource 1 [mem 0xdf000000-0xdf1fffff]
[    0.326191] pci_bus 0000:31: resource 2 [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.326193] pci_bus 0000:32: resource 1 [mem 0xdf100000-0xdf1fffff]
[    0.326194] pci_bus 0000:33: resource 1 [mem 0xdf100000-0xdf1fffff]
[    0.326195] pci_bus 0000:34: resource 1 [mem 0xdf100000-0xdf1fffff]
[    0.326196] pci_bus 0000:35: resource 2 [mem 0xa0000000-0xa00fffff 64bit pref]
[    0.326197] pci_bus 0000:36: resource 1 [mem 0xdf000000-0xdf0fffff]
[    0.326198] pci_bus 0000:4b: resource 1 [mem 0xef600000-0xef6fffff]
[    0.326199] pci_bus 0000:4c: resource 0 [io  0xf000-0xffff]
[    0.326200] pci_bus 0000:4c: resource 1 [mem 0xef500000-0xef5fffff]
[    0.326201] pci_bus 0000:4d: resource 0 [io  0xf000-0xffff]
[    0.326202] pci_bus 0000:4d: resource 1 [mem 0xef500000-0xef5fffff]
[    0.326203] pci_bus 0000:4e: resource 0 [io  0xf000-0xffff]
[    0.326204] pci_bus 0000:4e: resource 1 [mem 0xef500000-0xef5fffff]
[    0.326206] pci_bus 0000:51: resource 1 [mem 0xef300000-0xef4fffff]
[    0.326207] pci_bus 0000:52: resource 1 [mem 0xefd00000-0xefdfffff]
[    0.326208] pci_bus 0000:53: resource 0 [io  0xe000-0xefff]
[    0.326209] pci_bus 0000:53: resource 1 [mem 0xef900000-0xefcfffff]
[    0.326210] pci_bus 0000:53: resource 2 [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.326447] pci 0000:2d:00.0: MSI is not implemented on this device, disabling it
[    0.326449] pci 0000:2d:00.0: PME# is unreliable, disabling it
[    0.326543] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[    0.326604] pci 0000:2d:00.1: MSI is not implemented on this device, disabling it
[    0.326605] pci 0000:2d:00.1: PME# is unreliable, disabling it
[    0.326614] pci 0000:2d:00.1: enabling device (0000 -> 0002)
[    0.326670] pci 0000:2d:00.2: MSI is not implemented on this device, disabling it
[    0.326671] pci 0000:2d:00.2: PME# is unreliable, disabling it
[    0.326712] pci 0000:2d:00.2: EHCI: unrecognized capability 00
[    0.326784] pci 0000:34:00.0: MSI is not implemented on this device, disabling it
[    0.326786] pci 0000:34:00.0: PME# is unreliable, disabling it
[    0.326912] pci 0000:34:00.0: enabling device (0000 -> 0002)
[    0.326983] pci 0000:34:00.1: MSI is not implemented on this device, disabling it
[    0.326985] pci 0000:34:00.1: PME# is unreliable, disabling it
[    0.326995] pci 0000:34:00.1: enabling device (0000 -> 0002)
[    0.327063] pci 0000:34:00.2: MSI is not implemented on this device, disabling it
[    0.327064] pci 0000:34:00.2: PME# is unreliable, disabling it
[    0.327113] pci 0000:34:00.2: EHCI: unrecognized capability 00
[    0.327178] pci 0000:53:00.1: D0 power state depends on 0000:53:00.0
[    0.327182] pci 0000:53:00.3: extending delay after power-on from D3hot to 20 msec
[    0.327244] pci 0000:53:00.4: extending delay after power-on from D3hot to 20 msec
[    0.327272] PCI: CLS 64 bytes, default 64
[    0.327275] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.327277] software IO TLB: mapped [mem 0x000000008d000000-0x0000000091000000] (64MB)
[    0.327281] ACPI: bus type thunderbolt registered
[    0.327313] Trying to unpack rootfs image as initramfs...
[    0.327326] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[    0.327345] thunderbolt 0000:05:00.0: total paths: 12
[    0.327347] thunderbolt 0000:05:00.0: IOMMU DMA protection is disabled
[    0.327468] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[    0.327479] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[    0.327489] thunderbolt 0000:05:00.0: control channel created
[    0.327491] thunderbolt 0000:05:00.0: ICM not supported on this controller
[    0.327497] thunderbolt 0000:05:00.0: freeing RX ring 0
[    0.327503] thunderbolt 0000:05:00.0: freeing TX ring 0
[    0.327507] thunderbolt 0000:05:00.0: allocating TX ring 0 of size 10
[    0.327514] thunderbolt 0000:05:00.0: allocating RX ring 0 of size 10
[    0.327520] thunderbolt 0000:05:00.0: control channel created
[    0.327521] thunderbolt 0000:05:00.0: using software connection manager
[    0.327521] thunderbolt 0000:05:00.0: NHI initialized, starting thunderbolt
[    0.327522] thunderbolt 0000:05:00.0: control channel starting...
[    0.327522] thunderbolt 0000:05:00.0: starting TX ring 0
[    0.327530] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[    0.327531] thunderbolt 0000:05:00.0: starting RX ring 0
[    0.327538] thunderbolt 0000:05:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[    0.327542] thunderbolt 0000:05:00.0: security level set to user
[    0.327688] thunderbolt 0000:05:00.0: current switch config:
[    0.327689] thunderbolt 0000:05:00.0:  Thunderbolt 3 Switch: 8086:15ea (Revision: 6, TB Version: 16)
[    0.327691] thunderbolt 0000:05:00.0:   Max Port Number: 13
[    0.327691] thunderbolt 0000:05:00.0:   Config:
[    0.327691] thunderbolt 0000:05:00.0:    Upstream Port Number: 7 Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 255ms
[    0.327692] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[    0.332811] thunderbolt 0000:05:00.0: initializing Switch at 0x0 (depth: 0, up port: 7)
[    0.372748] thunderbolt 0000:05:00.0: 0: uid: 0xedd9a650496900
[    0.374667] thunderbolt 0000:05:00.0:  Port 1: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[    0.374669] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[    0.374670] thunderbolt 0000:05:00.0:   Max counters: 16
[    0.374670] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    0.374671] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    0.376587] thunderbolt 0000:05:00.0:  Port 2: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[    0.376588] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[    0.376589] thunderbolt 0000:05:00.0:   Max counters: 16
[    0.376590] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    0.376590] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    0.378507] thunderbolt 0000:05:00.0:  Port 3: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[    0.378508] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[    0.378509] thunderbolt 0000:05:00.0:   Max counters: 16
[    0.378509] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    0.378510] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    0.380427] thunderbolt 0000:05:00.0:  Port 4: 8086:15ea (Revision: 6, TB Version: 1, Type: Port (0x1))
[    0.380428] thunderbolt 0000:05:00.0:   Max hop id (in/out): 19/19
[    0.380429] thunderbolt 0000:05:00.0:   Max counters: 16
[    0.380429] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    0.380430] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    0.380683] thunderbolt 0000:05:00.0:  Port 5: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.380684] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[    0.380685] thunderbolt 0000:05:00.0:   Max counters: 2
[    0.380686] thunderbolt 0000:05:00.0:   NFC Credits: 0x180000c
[    0.380686] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[    0.380939] thunderbolt 0000:05:00.0:  Port 6: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0101))
[    0.380940] thunderbolt 0000:05:00.0:   Max hop id (in/out): 255/255
[    0.380941] thunderbolt 0000:05:00.0:   Max counters: 2
[    0.380941] thunderbolt 0000:05:00.0:   NFC Credits: 0x180000c
[    0.380942] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[    0.381707] thunderbolt 0000:05:00.0:  Port 7: 8086:15ea (Revision: 6, TB Version: 1, Type: NHI (0x2))
[    0.381708] thunderbolt 0000:05:00.0:   Max hop id (in/out): 11/11
[    0.381709] thunderbolt 0000:05:00.0:   Max counters: 16
[    0.381709] thunderbolt 0000:05:00.0:   NFC Credits: 0x1800000
[    0.381710] thunderbolt 0000:05:00.0:   Credits (total/control): 24/0
[    0.381963] thunderbolt 0000:05:00.0:  Port 8: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[    0.381964] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    0.381965] thunderbolt 0000:05:00.0:   Max counters: 2
[    0.381965] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[    0.381966] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[    0.382219] thunderbolt 0000:05:00.0:  Port 9: 8086:15ea (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
[    0.382220] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    0.382221] thunderbolt 0000:05:00.0:   Max counters: 2
[    0.382221] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[    0.382222] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[    0.382731] thunderbolt 0000:05:00.0:  Port 10: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[    0.382732] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[    0.382733] thunderbolt 0000:05:00.0:   Max counters: 2
[    0.382733] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[    0.382734] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[    0.383243] thunderbolt 0000:05:00.0:  Port 11: 8086:15ea (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[    0.383244] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[    0.383245] thunderbolt 0000:05:00.0:   Max counters: 2
[    0.383245] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[    0.383246] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[    0.383499] thunderbolt 0000:05:00.0:  Port 12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[    0.383500] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    0.383501] thunderbolt 0000:05:00.0:   Max counters: 2
[    0.383501] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[    0.383502] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[    0.383755] thunderbolt 0000:05:00.0:  Port 13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
[    0.383756] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    0.383757] thunderbolt 0000:05:00.0:   Max counters: 2
[    0.383757] thunderbolt 0000:05:00.0:   NFC Credits: 0x800000
[    0.383758] thunderbolt 0000:05:00.0:   Credits (total/control): 8/0
[    0.383758] thunderbolt 0000:05:00.0: 0: linked ports 1 <-> 2
[    0.383759] thunderbolt 0000:05:00.0: 0: linked ports 3 <-> 4
[    0.388876] thunderbolt 0000:05:00.0: 0: TMU: supports uni-directional mode
[    0.388876] thunderbolt 0000:05:00.0: 0: TMU: current mode: HiFi
[    0.389388] thunderbolt 0000:05:00.0: 0: TMU: mode set to: normal
[    0.389644] thunderbolt 0000:05:00.0: 0:1: Resetting Port
[    0.421061] thunderbolt 0000:05:00.0: 0:2: Resetting Port
[    0.434545] Freeing initrd memory: 14756K
[    0.461062] thunderbolt 0000:05:00.0: 0:3: Resetting Port
[    0.463181] thunderbolt 0000:05:00.0: acking hot unplug event on 0:3
[    0.463309] thunderbolt 0000:05:00.0: acking hot unplug event on 0:4
[    0.501065] thunderbolt 0000:05:00.0: 0:4: Resetting Port
[    0.544153] thunderbolt 0000:05:00.0: 0:1: is unplugged (state: 7)
[    0.544280] thunderbolt 0000:05:00.0: 0:3: is unplugged (state: 7)
[    0.544793] thunderbolt 0000:05:00.0: discovering Video path starting from 0:5
[    0.544921] thunderbolt 0000:05:00.0: 0:5:  In HopID: 9 => Out port: 4 Out HopID: 8
[    0.544922] thunderbolt 0000:05:00.0: 0:5:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    0.544923] thunderbolt 0000:05:00.0: 0:5:    Counter enabled: 0 Counter index: 2047
[    0.544924] thunderbolt 0000:05:00.0: 0:5:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    0.544925] thunderbolt 0000:05:00.0: 0:5:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    0.544927] thunderbolt 0000:05:00.0: path discovery complete
[    0.545048] thunderbolt 0000:05:00.0: discovering AUX TX path starting from 0:5
[    0.545177] thunderbolt 0000:05:00.0: 0:5:  In HopID: 8 => Out port: 4 Out HopID: 9
[    0.545178] thunderbolt 0000:05:00.0: 0:5:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    0.545178] thunderbolt 0000:05:00.0: 0:5:    Counter enabled: 0 Counter index: 2047
[    0.545179] thunderbolt 0000:05:00.0: 0:5:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    0.545180] thunderbolt 0000:05:00.0: 0:5:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    0.545181] thunderbolt 0000:05:00.0: path discovery complete
[    0.545432] thunderbolt 0000:05:00.0: discovering AUX RX path starting from 0:4
[    0.545560] thunderbolt 0000:05:00.0: 0:4:  In HopID: 8 => Out port: 5 Out HopID: 8
[    0.545561] thunderbolt 0000:05:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    0.545562] thunderbolt 0000:05:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[    0.545563] thunderbolt 0000:05:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    0.545564] thunderbolt 0000:05:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    0.545565] thunderbolt 0000:05:00.0: path discovery complete
[    0.545566] thunderbolt 0000:05:00.0: 0:5: path does not end on a DP adapter, cleaning up
[    0.545568] thunderbolt 0000:05:00.0: 0:5 <-> 0:4 (DP): deactivating
[    0.546328] thunderbolt 0000:05:00.0: deactivating Video path from 0:5 to 0:4
[    0.546712] thunderbolt 0000:05:00.0: 0:5: adding -12 NFC credits to 12
[    0.546840] thunderbolt 0000:05:00.0: deactivating AUX TX path from 0:5 to 0:4
[    0.547224] thunderbolt 0000:05:00.0: deactivating AUX RX path from 0:4 to 0:5
[    0.547864] thunderbolt 0000:05:00.0: discovering Video path starting from 0:6
[    0.547993] thunderbolt 0000:05:00.0: 0:6:  In HopID: 9 => Out port: 3 Out HopID: 9
[    0.547994] thunderbolt 0000:05:00.0: 0:6:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    0.547995] thunderbolt 0000:05:00.0: 0:6:    Counter enabled: 0 Counter index: 2047
[    0.547995] thunderbolt 0000:05:00.0: 0:6:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    0.547996] thunderbolt 0000:05:00.0: 0:6:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    0.547997] thunderbolt 0000:05:00.0: path discovery complete
[    0.548120] thunderbolt 0000:05:00.0: discovering AUX TX path starting from 0:6
[    0.548248] thunderbolt 0000:05:00.0: 0:6:  In HopID: 8 => Out port: 3 Out HopID: 10
[    0.548250] thunderbolt 0000:05:00.0: 0:6:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    0.548250] thunderbolt 0000:05:00.0: 0:6:    Counter enabled: 0 Counter index: 2047
[    0.548251] thunderbolt 0000:05:00.0: 0:6:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    0.548252] thunderbolt 0000:05:00.0: 0:6:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    0.548253] thunderbolt 0000:05:00.0: path discovery complete
[    0.548632] thunderbolt 0000:05:00.0: discovering AUX RX path starting from 0:3
[    0.548761] thunderbolt 0000:05:00.0: 0:3:  In HopID: 9 => Out port: 6 Out HopID: 8
[    0.548761] thunderbolt 0000:05:00.0: 0:3:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    0.548762] thunderbolt 0000:05:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[    0.548763] thunderbolt 0000:05:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    0.548764] thunderbolt 0000:05:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    0.548765] thunderbolt 0000:05:00.0: path discovery complete
[    0.548765] thunderbolt 0000:05:00.0: 0:6: path does not end on a DP adapter, cleaning up
[    0.548767] thunderbolt 0000:05:00.0: 0:6 <-> 0:3 (DP): deactivating
[    0.549528] thunderbolt 0000:05:00.0: deactivating Video path from 0:6 to 0:3
[    0.549912] thunderbolt 0000:05:00.0: 0:6: adding -12 NFC credits to 12
[    0.550040] thunderbolt 0000:05:00.0: deactivating AUX TX path from 0:6 to 0:3
[    0.550425] thunderbolt 0000:05:00.0: deactivating AUX RX path from 0:3 to 0:6
[    0.551192] thunderbolt 0000:05:00.0: 0:5: DP IN resource available
[    0.551320] thunderbolt 0000:05:00.0: 0:6: DP IN resource available
[    0.551324] thunderbolt 0000:05:00.0: 0:3: got unplug event for disconnected port, ignoring
[    0.551326] thunderbolt 0000:05:00.0: 0:4: got unplug event for disconnected port, ignoring
[    0.551390] LVT offset 0 assigned for vector 0x400
[    0.551443] perf: AMD IBS detected (0x000003ff)
[    0.551686] workingset: timestamp_bits=60 max_order=23 bucket_order=0
[    0.554292] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.554295] io scheduler mq-deadline registered
[    0.554382] pcieport 0000:00:02.1: PME: Signaling with IRQ 43
[    0.554460] pcieport 0000:00:02.2: PME: Signaling with IRQ 44
[    0.554525] pcieport 0000:00:08.1: PME: Signaling with IRQ 45
[    0.555338] pcieport 0000:04:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.555724] pcieport 0000:04:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.555769] pcieport 0000:04:04.0: pciehp: Slot(4): Card not present
[    0.555939] pcieport 0000:2a:01.0: Unable to change power state from D3cold to D0, device inaccessible
[    0.555946] pci_bus 0000:2d: busn_res: [bus 2d] is released
[    0.555969] pci_bus 0000:2c: busn_res: [bus 2c-2d] is released
[    0.555993] pcieport 0000:2a:02.0: Unable to change power state from D3cold to D0, device inaccessible
[    0.556033] pcieport 0000:2a:04.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise- Interlock- NoCompl+ IbPresDis- LLActRep- (with Cmd Compl erratum)
[    0.556084] pci_bus 0000:2b: busn_res: [bus 2b-2d] is released
[    0.556115] pcieport 0000:2a:05.0: Unable to change power state from D3cold to D0, device inaccessible
[    0.556169] pcieport 0000:2a:05.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise- Interlock- NoCompl+ IbPresDis- LLActRep- (with Cmd Compl erratum)
[    0.556231] pci_bus 0000:2e: busn_res: [bus 2e] is released
[    0.556299] pcieport 0000:31:01.0: Unable to change power state from D3cold to D0, device inaccessible
[    0.556336] pcieport 0000:31:02.0: Unable to change power state from D3cold to D0, device inaccessible
[    0.556369] pcieport 0000:31:04.0: Unable to change power state from D3cold to D0, device inaccessible
[    0.556370] pci_bus 0000:2f: busn_res: [bus 2f] is released
[    0.556395] pcieport 0000:31:04.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise- Interlock- NoCompl+ IbPresDis- LLActRep- (with Cmd Compl erratum)
[    0.556465] pcieport 0000:31:05.0: Unable to change power state from D3cold to D0, device inaccessible
[    0.556488] pci_bus 0000:34: busn_res: [bus 34] is released
[    0.556494] pcieport 0000:31:05.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise- Interlock- NoCompl+ IbPresDis- LLActRep- (with Cmd Compl erratum)
[    0.556507] pci_bus 0000:33: busn_res: [bus 33-34] is released
[    0.556602] pci_bus 0000:32: busn_res: [bus 32-34] is released
[    0.556739] pci_bus 0000:35: busn_res: [bus 35] is released
[    0.556856] pci_bus 0000:36: busn_res: [bus 36] is released
[    0.556892] pci_bus 0000:37: busn_res: [bus 37] is released
[    0.556990] pci_bus 0000:38: busn_res: [bus 38] is released
[    0.557055] pci_bus 0000:31: busn_res: [bus 31-38] is released
[    0.557166] pci_bus 0000:30: busn_res: [bus 30-38] is released
[    0.557229] pci_bus 0000:39: busn_res: [bus 39] is released
[    0.557343] pci_bus 0000:2a: busn_res: [bus 2a-39] is released
[    0.557478] Estimated ratio of average max frequency by base frequency (times 1024): 1098
[    0.557487] Monitor-Mwait will be used to enter C-1 state
[    0.557491] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    0.557541] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    0.557580] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    0.557617] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    0.557653] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    0.557690] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    0.557738] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    0.557787] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    0.557835] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    0.557882] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    0.557930] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    0.557964] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    0.565868] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.586499] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.588007] brd: module loaded
[    0.588136] nvme nvme0: pci function 0000:4b:00.0
[    0.588183] nvme nvme1: pci function 0000:52:00.0
[    0.588267] Intel(R) 2.5G Ethernet Linux Driver
[    0.588269] Copyright(c) 2018 Intel Corporation.
[    0.588319] igc 0000:51:00.0: PCIe PTM not supported by PCIe bus/controller
[    0.609445] nvme nvme0: missing or invalid SUBNQN field.
[    0.612158] nvme nvme0: 15/0/0 default/read/poll queues
[    0.616356]  nvme0n1: p1 p2 p3
[    0.625896] nvme nvme1: missing or invalid SUBNQN field.
[    0.684240] nvme nvme1: allocated 128 MiB host memory buffer.
[    0.722829] igc 0000:51:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    0.722838] igc 0000:51:00.0 eth0: MAC: d8:5e:d3:86:cc:c8
[    0.764551] r8169 0000:4e:00.0 eth1: RTL8125B, d8:5e:d3:86:cc:c6, XID 641, IRQ 92
[    0.764563] r8169 0000:4e:00.0 eth1: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    0.764604] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.764606] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    0.764733] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.764786] rtc_cmos 00:02: RTC can wake from S4
[    0.765007] rtc_cmos 00:02: registered as rtc0
[    0.765039] rtc_cmos 00:02: setting system clock to 2022-08-11T13:45:50 UTC (1660225550)
[    0.765046] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.765553] efifb: probing for efifb
[    0.765560] efifb: framebuffer at 0xc0000000, using 3072k, total 3072k
[    0.765561] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    0.765563] efifb: scrolling: redraw
[    0.765563] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.766047] Console: switching to colour frame buffer device 128x48
[    0.766496] fb0: EFI VGA frame buffer device
[    0.766521] ccp 0000:53:00.2: enabling device (0000 -> 0002)
[    0.782689] ccp 0000:53:00.2: tee enabled
[    0.782698] ccp 0000:53:00.2: psp enabled
[    0.783553] microcode: CPU0: patch_level=0x0a50000d
[    0.783570] microcode: CPU1: patch_level=0x0a50000d
[    0.783583] microcode: CPU2: patch_level=0x0a50000d
[    0.783595] microcode: CPU3: patch_level=0x0a50000d
[    0.783621] microcode: CPU4: patch_level=0x0a50000d
[    0.783637] microcode: CPU5: patch_level=0x0a50000d
[    0.783660] microcode: CPU6: patch_level=0x0a50000d
[    0.783674] microcode: CPU7: patch_level=0x0a50000d
[    0.783687] microcode: CPU8: patch_level=0x0a50000d
[    0.783707] microcode: CPU9: patch_level=0x0a50000d
[    0.783730] microcode: CPU10: patch_level=0x0a50000d
[    0.783741] microcode: CPU11: patch_level=0x0a50000d
[    0.783751] microcode: Microcode Update Driver: v2.2.
[    0.783754] IPI shorthand broadcast: enabled
[    0.783776] sched_clock: Marking stable (783108559, 377413)->(790753224, -7267252)
[    0.783879] registered taskstats version 1
[    0.789365] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.835539] nvme nvme1: 8/0/0 default/read/poll queues
[    0.843286] nvme nvme1: Ignoring bogus Namespace Identifiers
[    0.847863]  nvme1n1: p1 p3 p4 p5
[    0.848512] Freeing unused kernel image (initmem) memory: 952K
[    0.898288] Write protecting the kernel read-only data: 12288k
[    0.898803] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    0.899113] Freeing unused kernel image (rodata/data gap) memory: 152K
[    0.899357] Run /init as init process
[    0.899568]   with arguments:
[    0.899569]     /init
[    0.899569]   with environment:
[    0.899570]     HOME=/
[    0.899570]     TERM=linux
[    0.930376] udevd[1078]: starting version 3.2.9
[    1.586630] tsc: Refined TSC clocksource calibration: 3926.746 MHz
[    1.586851] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x7134176e58f, max_idle_ns: 881590613118 ns
[    1.587221] clocksource: Switched to clocksource tsc
[    1.678371] thunderbolt 0000:05:00.0: acking hot plug event on 0:4
[    1.678392] thunderbolt 0000:05:00.0: 0:4: hotplug: scanning
[    1.678394] thunderbolt 0000:05:00.0: 0:4: hotplug: no switch found
[    1.681077] thunderbolt 0000:05:00.0: acking hot plug event on 0:3
[    1.681093] thunderbolt 0000:05:00.0: 0:3: hotplug: scanning
[    1.681215] thunderbolt 0000:05:00.0: 0:3: is connected, link is up (state: 2)
[    1.681469] thunderbolt 0000:05:00.0: current switch config:
[    1.681471] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    1.681473] thunderbolt 0000:05:00.0:   Max Port Number: 13
[    1.681474] thunderbolt 0000:05:00.0:   Config:
[    1.681475] thunderbolt 0000:05:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[    1.681476] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[    1.686039] thunderbolt 0000:05:00.0: initializing Switch at 0x3 (depth: 1, up port: 1)
[    1.703327] thunderbolt 0000:05:00.0: 3: reading drom (length: 0x97)
[    1.757989] thunderbolt 0000:05:00.0: acking hot plug event on 3:3
[    1.774516] thunderbolt 0000:05:00.0: acking hot plug event on 3:4
[    2.126610] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc' as unstable because the skew is too large:
[    2.126869] clocksource:                       'hpet' wd_nsec: 503415867 wd_now: 1c0bc7c wd_last: 152c03d mask: ffffffff
[    2.127125] clocksource:                       'tsc' cs_nsec: 499987231 cs_now: 12f9037050 cs_last: 1283fd8394 mask: ffffffffffffffff
[    2.127656] clocksource:                       'tsc' is current clocksource.
[    2.127922] tsc: Marking TSC unstable due to clocksource watchdog
[    2.128188] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
[    2.128454] sched_clock: Marking unstable (2127814703, 377439)<-(2135455434, -7267252)
[    2.128837] clocksource: Checking clocksource tsc synchronization from CPU 4 to CPUs 0-3,6-7.
[    2.129126] clocksource: Switched to clocksource hpet
[    2.196148] thunderbolt 0000:05:00.0: 3: DROM version: 1
[    2.197175] thunderbolt 0000:05:00.0: 3: uid: 0x1000100189170
[    2.200117] thunderbolt 0000:05:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    2.200119] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[    2.200120] thunderbolt 0000:05:00.0:   Max counters: 32
[    2.200120] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    2.200121] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    2.203062] thunderbolt 0000:05:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    2.203063] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[    2.203064] thunderbolt 0000:05:00.0:   Max counters: 32
[    2.203064] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    2.203065] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    2.206007] thunderbolt 0000:05:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    2.206008] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[    2.206009] thunderbolt 0000:05:00.0:   Max counters: 32
[    2.206009] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    2.206010] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    2.208948] thunderbolt 0000:05:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    2.208949] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[    2.208950] thunderbolt 0000:05:00.0:   Max counters: 32
[    2.208950] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    2.208951] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    2.208951] thunderbolt 0000:05:00.0: 3:5: disabled by eeprom
[    2.208952] thunderbolt 0000:05:00.0: 3:6: disabled by eeprom
[    2.209849] thunderbolt 0000:05:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    2.209850] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    2.209850] thunderbolt 0000:05:00.0:   Max counters: 1
[    2.209851] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[    2.209851] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[    2.210744] thunderbolt 0000:05:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    2.210745] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    2.210745] thunderbolt 0000:05:00.0:   Max counters: 1
[    2.210746] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[    2.210746] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[    2.210747] thunderbolt 0000:05:00.0: 3:9: disabled by eeprom
[    2.211639] thunderbolt 0000:05:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    2.211640] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    2.211641] thunderbolt 0000:05:00.0:   Max counters: 1
[    2.211641] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[    2.211642] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[    2.212792] thunderbolt 0000:05:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    2.212793] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[    2.212793] thunderbolt 0000:05:00.0:   Max counters: 2
[    2.212794] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[    2.212794] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[    2.212795] thunderbolt 0000:05:00.0: 3:12: disabled by eeprom
[    2.212796] thunderbolt 0000:05:00.0: 3:13: disabled by eeprom
[    2.231453] thunderbolt 0000:05:00.0: 3: TMU: current mode: bi-directional, HiFi
[    2.231472] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[    2.231714] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[    2.232400] thunderbolt 0000:05:00.0: 3:3: is connected, link is up (state: 2)
[    2.232655] thunderbolt 0000:05:00.0: current switch config:
[    2.232655] thunderbolt 0000:05:00.0:  Thunderbolt 1 Switch: 8086:1513 (Revision: 2, TB Version: 1)
[    2.232657] thunderbolt 0000:05:00.0:   Max Port Number: 13
[    2.232657] thunderbolt 0000:05:00.0:   Config:
[    2.232658] thunderbolt 0000:05:00.0:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[    2.232659] thunderbolt 0000:05:00.0:    unknown1: 0x0 unknown4: 0x0
[    2.237260] thunderbolt 0000:05:00.0: initializing Switch at 0x303 (depth: 2, up port: 3)
[    2.254674] thunderbolt 0000:05:00.0: 303: reading drom (length: 0x97)
[    2.396620] random: crng init done
[    2.397207] udevd[1080]: starting eudev-3.2.9
[    2.405662] ACPI: \_TZ_.UAD0: Invalid passive threshold
[    2.405984] thermal LNXTHERM:00: registered as thermal_zone0
[    2.406218] ACPI: thermal: Thermal Zone [UAD0] (17 C)
[    2.407182] ACPI: bus type USB registered
[    2.407443] usbcore: registered new interface driver usbfs
[    2.407723] usbcore: registered new interface driver hub
[    2.407987] usbcore: registered new device driver usb
[    2.408821] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\GSA1.SMBI) (20220331/utaddress-204)
[    2.409347] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    2.409629] ACPI: OSL: Resource conflict: System may be unstable or behave erratically
[    2.409931] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    2.410215] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    2.410548] ACPI Warning: SystemIO range 0x0000000000000B20-0x0000000000000B28 conflicts with OpRegion 0x0000000000000B20-0x0000000000000B3F (\GSA1.SMG0) (20220331/utaddress-204)
[    2.411199] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    2.411517] ACPI: OSL: Resource conflict: System may be unstable or behave erratically
[    2.411875] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    2.412349] ACPI: bus type drm_connector registered
[    2.412383] cryptd: max_cpu_qlen set to 1000
[    2.412424] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.412429] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    2.414488] AVX2 version of gcm_enc/dec engaged.
[    2.414859] AES CTR mode by8 optimization enabled
[    2.428996] [drm] amdgpu kernel modesetting enabled.
[    2.431734] amdgpu: CRAT table disabled by module option
[    2.432009] amdgpu: Virtual CRAT table created for CPU
[    2.432298] amdgpu: Topology: Add CPU node
[    2.432642] Console: switching to colour dummy device 80x25
[    2.432660] amdgpu 0000:53:00.0: vgaarb: deactivate vga console
[    2.432682] amdgpu 0000:53:00.0: enabling device (0006 -> 0007)
[    2.432702] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1638 0x1458:0xD000 0xC9).
[    2.432709] [drm] register mmio base: 0xEFC00000
[    2.432710] [drm] register mmio size: 524288
[    2.433640] [drm] add ip block number 0 <soc15_common>
[    2.433641] [drm] add ip block number 1 <gmc_v9_0>
[    2.433642] [drm] add ip block number 2 <vega10_ih>
[    2.433643] [drm] add ip block number 3 <psp>
[    2.433644] [drm] add ip block number 4 <smu>
[    2.433645] [drm] add ip block number 5 <dm>
[    2.433646] [drm] add ip block number 6 <gfx_v9_0>
[    2.433646] [drm] add ip block number 7 <sdma_v4_0>
[    2.433647] [drm] add ip block number 8 <vcn_v2_0>
[    2.433648] [drm] add ip block number 9 <jpeg_v2_0>
[    2.433655] amdgpu 0000:53:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.433656] amdgpu: ATOM BIOS: 13-CEZANNE-019
[    2.433674] [drm] VCN decode is enabled in VM mode
[    2.433675] [drm] VCN encode is enabled in VM mode
[    2.433676] [drm] JPEG decode is enabled in VM mode
[    2.433677] amdgpu 0000:53:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
[    2.433680] amdgpu 0000:53:00.0: amdgpu: PCIE atomic ops is not supported
[    2.433684] amdgpu 0000:53:00.0: amdgpu: MODE2 reset
[    2.433957] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    2.433961] amdgpu 0000:53:00.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[    2.433963] amdgpu 0000:53:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[    2.433965] amdgpu 0000:53:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[    2.433970] [drm] Detected VRAM RAM=512M, BAR=512M
[    2.433971] [drm] RAM width 128bits DDR4
[    2.433992] [drm] amdgpu: 512M of VRAM memory ready
[    2.433993] [drm] amdgpu: 15733M of GTT memory ready.
[    2.433999] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.434072] [drm] PCIE GART of 1024M enabled.
[    2.434075] [drm] PTB located at 0x000000F400A00000
[    2.434141] amdgpu 0000:53:00.0: amdgpu: PSP runtime database doesn't exist
[    2.434143] amdgpu 0000:53:00.0: amdgpu: PSP runtime database doesn't exist
[    2.434187] [drm] Loading DMUB firmware via PSP: version=0x0101001F
[    2.434509] [drm] Found VCN firmware Version ENC: 1.17 DEC: 5 VEP: 0 Revision: 2
[    2.434514] amdgpu 0000:53:00.0: amdgpu: Will use PSP to load VCN firmware
[    2.467700] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000410
[    2.467844] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    2.467847] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    2.467850] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    2.467896] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    2.467899] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.467900] usb usb1: Product: xHCI Host Controller
[    2.467902] usb usb1: Manufacturer: Linux 5.19.0+ xhci-hcd
[    2.467903] usb usb1: SerialNumber: 0000:01:00.0
[    2.467970] hub 1-0:1.0: USB hub found
[    2.467980] hub 1-0:1.0: 10 ports detected
[    2.468158] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.468166] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    2.468168] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.468169] usb usb2: Product: xHCI Host Controller
[    2.468170] usb usb2: Manufacturer: Linux 5.19.0+ xhci-hcd
[    2.468172] usb usb2: SerialNumber: 0000:01:00.0
[    2.468215] hub 2-0:1.0: USB hub found
[    2.468220] hub 2-0:1.0: 4 ports detected
[    2.468342] xhci_hcd 0000:28:00.0: xHCI Host Controller
[    2.468345] xhci_hcd 0000:28:00.0: new USB bus registered, assigned bus number 3
[    2.469474] xhci_hcd 0000:28:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
[    2.469720] xhci_hcd 0000:28:00.0: xHCI Host Controller
[    2.469722] xhci_hcd 0000:28:00.0: new USB bus registered, assigned bus number 4
[    2.469724] xhci_hcd 0000:28:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    2.469742] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    2.469744] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.469746] usb usb3: Product: xHCI Host Controller
[    2.469747] usb usb3: Manufacturer: Linux 5.19.0+ xhci-hcd
[    2.469748] usb usb3: SerialNumber: 0000:28:00.0
[    2.469801] hub 3-0:1.0: USB hub found
[    2.469807] hub 3-0:1.0: 2 ports detected
[    2.469869] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    2.469871] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.469873] usb usb4: Product: xHCI Host Controller
[    2.469874] usb usb4: Manufacturer: Linux 5.19.0+ xhci-hcd
[    2.469875] usb usb4: SerialNumber: 0000:28:00.0
[    2.469918] hub 4-0:1.0: USB hub found
[    2.469925] hub 4-0:1.0: 2 ports detected
[    2.470003] xhci_hcd 0000:53:00.3: xHCI Host Controller
[    2.470006] xhci_hcd 0000:53:00.3: new USB bus registered, assigned bus number 5
[    2.470098] xhci_hcd 0000:53:00.3: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000410
[    2.470227] xhci_hcd 0000:53:00.3: xHCI Host Controller
[    2.470229] xhci_hcd 0000:53:00.3: new USB bus registered, assigned bus number 6
[    2.470231] xhci_hcd 0000:53:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    2.470257] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    2.470259] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.470260] usb usb5: Product: xHCI Host Controller
[    2.470261] usb usb5: Manufacturer: Linux 5.19.0+ xhci-hcd
[    2.470263] usb usb5: SerialNumber: 0000:53:00.3
[    2.470309] hub 5-0:1.0: USB hub found
[    2.470315] hub 5-0:1.0: 4 ports detected
[    2.470431] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.470440] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    2.470442] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.470444] usb usb6: Product: xHCI Host Controller
[    2.470445] usb usb6: Manufacturer: Linux 5.19.0+ xhci-hcd
[    2.470446] usb usb6: SerialNumber: 0000:53:00.3
[    2.470486] hub 6-0:1.0: USB hub found
[    2.470489] hub 6-0:1.0: 2 ports detected
[    2.470567] xhci_hcd 0000:53:00.4: xHCI Host Controller
[    2.470570] xhci_hcd 0000:53:00.4: new USB bus registered, assigned bus number 7
[    2.470658] xhci_hcd 0000:53:00.4: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000410
[    2.470790] xhci_hcd 0000:53:00.4: xHCI Host Controller
[    2.470792] xhci_hcd 0000:53:00.4: new USB bus registered, assigned bus number 8
[    2.470793] xhci_hcd 0000:53:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    2.470808] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    2.470810] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.470811] usb usb7: Product: xHCI Host Controller
[    2.470812] usb usb7: Manufacturer: Linux 5.19.0+ xhci-hcd
[    2.470813] usb usb7: SerialNumber: 0000:53:00.4
[    2.470851] hub 7-0:1.0: USB hub found
[    2.470856] hub 7-0:1.0: 4 ports detected
[    2.470962] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.470969] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    2.470970] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.470972] usb usb8: Product: xHCI Host Controller
[    2.470972] usb usb8: Manufacturer: Linux 5.19.0+ xhci-hcd
[    2.470973] usb usb8: SerialNumber: 0000:53:00.4
[    2.471014] hub 8-0:1.0: USB hub found
[    2.471017] hub 8-0:1.0: 2 ports detected
[    2.753577] thunderbolt 0000:05:00.0: 303: DROM version: 1
[    2.754601] thunderbolt 0000:05:00.0: 303: uid: 0x100010102a740
[    2.757545] thunderbolt 0000:05:00.0:  Port 1: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    2.757547] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[    2.757547] thunderbolt 0000:05:00.0:   Max counters: 32
[    2.757548] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    2.757549] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    2.760489] thunderbolt 0000:05:00.0:  Port 2: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    2.760490] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[    2.760491] thunderbolt 0000:05:00.0:   Max counters: 32
[    2.760491] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    2.760492] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    2.763432] thunderbolt 0000:05:00.0:  Port 3: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    2.763433] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[    2.763434] thunderbolt 0000:05:00.0:   Max counters: 32
[    2.763434] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    2.763435] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    2.766376] thunderbolt 0000:05:00.0:  Port 4: 8086:1513 (Revision: 2, TB Version: 1, Type: Port (0x1))
[    2.766377] thunderbolt 0000:05:00.0:   Max hop id (in/out): 63/63
[    2.766378] thunderbolt 0000:05:00.0:   Max counters: 32
[    2.766378] thunderbolt 0000:05:00.0:   NFC Credits: 0x3c00000
[    2.766379] thunderbolt 0000:05:00.0:   Credits (total/control): 60/2
[    2.766380] thunderbolt 0000:05:00.0: 303:5: disabled by eeprom
[    2.766380] thunderbolt 0000:05:00.0: 303:6: disabled by eeprom
[    2.767273] thunderbolt 0000:05:00.0:  Port 7: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    2.767274] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    2.767274] thunderbolt 0000:05:00.0:   Max counters: 1
[    2.767275] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[    2.767275] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[    2.768168] thunderbolt 0000:05:00.0:  Port 8: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100101))
[    2.768169] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    2.768170] thunderbolt 0000:05:00.0:   Max counters: 1
[    2.768170] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[    2.768171] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[    2.768171] thunderbolt 0000:05:00.0: 303:9: disabled by eeprom
[    2.769064] thunderbolt 0000:05:00.0:  Port 10: 8086:1513 (Revision: 2, TB Version: 1, Type: PCIe (0x100102))
[    2.769065] thunderbolt 0000:05:00.0:   Max hop id (in/out): 8/8
[    2.769066] thunderbolt 0000:05:00.0:   Max counters: 1
[    2.769066] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[    2.769067] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[    2.770216] thunderbolt 0000:05:00.0:  Port 11: 8086:1513 (Revision: 2, TB Version: 1, Type: DP/HDMI (0xe0102))
[    2.770217] thunderbolt 0000:05:00.0:   Max hop id (in/out): 9/9
[    2.770218] thunderbolt 0000:05:00.0:   Max counters: 2
[    2.770218] thunderbolt 0000:05:00.0:   NFC Credits: 0x700000
[    2.770219] thunderbolt 0000:05:00.0:   Credits (total/control): 7/0
[    2.770219] thunderbolt 0000:05:00.0: 303:12: disabled by eeprom
[    2.770220] thunderbolt 0000:05:00.0: 303:13: disabled by eeprom
[    2.776635] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    2.788300] thunderbolt 0000:05:00.0: 303: TMU: current mode: bi-directional, HiFi
[    2.788314] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[    2.788317] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[    2.788430] thunderbolt 0000:05:00.0: 303:1: is unplugged (state: 7)
[    2.788698] thunderbolt 0000:05:00.0: 3:3: got plug event for connected port, ignoring
[    2.788702] thunderbolt 0000:05:00.0: 3:4: got plug event for connected port, ignoring
[    2.998257] usb 1-2: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.54
[    2.998261] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.998264] usb 1-2: Product: USB2.1 Hub
[    2.998265] usb 1-2: Manufacturer: GenesysLogic
[    3.005284] hub 1-2:1.0: USB hub found
[    3.009261] hub 1-2:1.0: 4 ports detected
[    3.127734] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[    3.151902] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
[    3.159551] usb 2-2: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.54
[    3.159555] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.159557] usb 2-2: Product: USB3.1 Hub
[    3.159559] usb 2-2: Manufacturer: GenesysLogic
[    3.165977] hub 2-2:1.0: USB hub found
[    3.166270] hub 2-2:1.0: 4 ports detected
[    3.232018] amdgpu 0000:53:00.0: amdgpu: RAS: optional ras ta ucode is not available
[    3.235062] thunderbolt 0000:05:00.0: acking hot plug event on 303:b
[    3.235066] thunderbolt 0000:05:00.0: acking hot plug event on 303:b
[    3.235197] thunderbolt 0000:05:00.0: 303:11: DP OUT resource available
[    3.235200] thunderbolt 0000:05:00.0: looking for DP IN <-> DP OUT pairs:
[    3.235324] thunderbolt 0000:05:00.0: 0:5: DP IN available
[    3.235452] thunderbolt 0000:05:00.0: 303:11: DP OUT available
[    3.235836] thunderbolt 0000:05:00.0: 0:5: sink 0 allocated
[    3.235838] thunderbolt 0000:05:00.0: 0: allocated DP resource for port 5
[    3.235840] thunderbolt 0000:05:00.0: 303:11: calculating available bandwidth
[    3.235963] thunderbolt 0000:05:00.0: 0:3: link total bandwidth 9000 Mb/s
[    3.235964] thunderbolt 0000:05:00.0: 3:1: link total bandwidth 9000 Mb/s
[    3.236093] thunderbolt 0000:05:00.0: 3:3: link total bandwidth 9000 Mb/s
[    3.236093] thunderbolt 0000:05:00.0: 303:3: link total bandwidth 9000 Mb/s
[    3.236094] thunderbolt 0000:05:00.0: available bandwidth for new DP tunnel 9000/9000 Mb/s
[    3.236099] thunderbolt 0000:05:00.0: 0:5 <-> 303:b (DP): activating
[    3.236101] thunderbolt 0000:05:00.0: activating Video path from 0:5 to 303:11
[    3.236102] thunderbolt 0000:05:00.0: 303:4: adding 12 NFC credits to 0
[    3.236220] thunderbolt 0000:05:00.0: 3:2: adding 12 NFC credits to 0
[    3.236338] thunderbolt 0000:05:00.0: 0:5: adding 12 NFC credits to 0
[    3.236593] thunderbolt 0000:05:00.0: 303:4: Writing hop 2
[    3.236594] thunderbolt 0000:05:00.0: 303:4:  In HopID: 8 => Out port: 11 Out HopID: 9
[    3.236595] thunderbolt 0000:05:00.0: 303:4:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    3.236597] thunderbolt 0000:05:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[    3.236598] thunderbolt 0000:05:00.0: 303:4:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    3.236599] thunderbolt 0000:05:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.236850] thunderbolt 0000:05:00.0: 3:2: Writing hop 1
[    3.236851] thunderbolt 0000:05:00.0: 3:2:  In HopID: 8 => Out port: 4 Out HopID: 8
[    3.236852] thunderbolt 0000:05:00.0: 3:2:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    3.236852] thunderbolt 0000:05:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[    3.236853] thunderbolt 0000:05:00.0: 3:2:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    3.236854] thunderbolt 0000:05:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.237106] thunderbolt 0000:05:00.0: 0:5: Writing hop 0
[    3.237106] thunderbolt 0000:05:00.0: 0:5:  In HopID: 9 => Out port: 4 Out HopID: 8
[    3.237107] thunderbolt 0000:05:00.0: 0:5:   Weight: 1 Priority: 1 Credits: 0 Drop: 0
[    3.237108] thunderbolt 0000:05:00.0: 0:5:    Counter enabled: 0 Counter index: 2047
[    3.237108] thunderbolt 0000:05:00.0: 0:5:   Flow Control (In/Eg): 0/0 Shared Buffer (In/Eg): 0/0
[    3.237109] thunderbolt 0000:05:00.0: 0:5:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.237233] thunderbolt 0000:05:00.0: path activation complete
[    3.237233] thunderbolt 0000:05:00.0: activating AUX TX path from 0:5 to 303:11
[    3.237361] thunderbolt 0000:05:00.0: 303:4: Writing hop 2
[    3.237361] thunderbolt 0000:05:00.0: 303:4:  In HopID: 9 => Out port: 11 Out HopID: 8
[    3.237362] thunderbolt 0000:05:00.0: 303:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    3.237363] thunderbolt 0000:05:00.0: 303:4:    Counter enabled: 0 Counter index: 2047
[    3.237363] thunderbolt 0000:05:00.0: 303:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    3.237364] thunderbolt 0000:05:00.0: 303:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.237617] thunderbolt 0000:05:00.0: 3:2: Writing hop 1
[    3.237617] thunderbolt 0000:05:00.0: 3:2:  In HopID: 9 => Out port: 4 Out HopID: 9
[    3.237618] thunderbolt 0000:05:00.0: 3:2:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    3.237619] thunderbolt 0000:05:00.0: 3:2:    Counter enabled: 0 Counter index: 2047
[    3.237619] thunderbolt 0000:05:00.0: 3:2:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    3.237620] thunderbolt 0000:05:00.0: 3:2:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.237873] thunderbolt 0000:05:00.0: 0:5: Writing hop 0
[    3.237873] thunderbolt 0000:05:00.0: 0:5:  In HopID: 8 => Out port: 4 Out HopID: 9
[    3.237874] thunderbolt 0000:05:00.0: 0:5:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    3.237874] thunderbolt 0000:05:00.0: 0:5:    Counter enabled: 0 Counter index: 2047
[    3.237875] thunderbolt 0000:05:00.0: 0:5:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    3.237875] thunderbolt 0000:05:00.0: 0:5:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.238001] thunderbolt 0000:05:00.0: path activation complete
[    3.238001] thunderbolt 0000:05:00.0: activating AUX RX path from 303:11 to 0:5
[    3.238129] thunderbolt 0000:05:00.0: 0:4: Writing hop 2
[    3.238130] thunderbolt 0000:05:00.0: 0:4:  In HopID: 8 => Out port: 5 Out HopID: 8
[    3.238131] thunderbolt 0000:05:00.0: 0:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    3.238131] thunderbolt 0000:05:00.0: 0:4:    Counter enabled: 0 Counter index: 2047
[    3.238132] thunderbolt 0000:05:00.0: 0:4:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[    3.238133] thunderbolt 0000:05:00.0: 0:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.238385] thunderbolt 0000:05:00.0: 3:4: Writing hop 1
[    3.238385] thunderbolt 0000:05:00.0: 3:4:  In HopID: 8 => Out port: 2 Out HopID: 8
[    3.238386] thunderbolt 0000:05:00.0: 3:4:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    3.238387] thunderbolt 0000:05:00.0: 3:4:    Counter enabled: 0 Counter index: 2047
[    3.238387] thunderbolt 0000:05:00.0: 3:4:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    3.238388] thunderbolt 0000:05:00.0: 3:4:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.238641] thunderbolt 0000:05:00.0: 303:11: Writing hop 0
[    3.238641] thunderbolt 0000:05:00.0: 303:11:  In HopID: 8 => Out port: 4 Out HopID: 8
[    3.238642] thunderbolt 0000:05:00.0: 303:11:   Weight: 1 Priority: 2 Credits: 1 Drop: 0
[    3.238642] thunderbolt 0000:05:00.0: 303:11:    Counter enabled: 0 Counter index: 2047
[    3.238643] thunderbolt 0000:05:00.0: 303:11:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[    3.238644] thunderbolt 0000:05:00.0: 303:11:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[    3.238769] thunderbolt 0000:05:00.0: path activation complete
[    3.242587] amdgpu 0000:53:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    3.242589] amdgpu 0000:53:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[    3.243099] amdgpu 0000:53:00.0: amdgpu: SMU is initialized successfully!
[    3.243326] [drm] Display Core initialized with v3.2.196!
[    3.243871] [drm] DMUB hardware initialized: version=0x0101001F
[    3.289139] [drm] forcing DP-1 connector on
[    3.289170] [drm] Got external EDID base block and 1 extension from "edid.bin" for connector "DP-1"
[    3.289181] [drm] forcing DP-2 connector on
[    3.289200] [drm] Got external EDID base block and 1 extension from "edid1.bin" for connector "DP-2"
[    3.290925] [drm] kiq ring mec 2 pipe 1 q 0
[    3.293198] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[    3.293209] [drm] JPEG decode initialized successfully.
[    3.294461] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    3.294505] amdgpu: sdma_bitmap: 3
[    3.294520] amdgpu: SRAT table not found
[    3.294521] amdgpu: Virtual CRAT table created for GPU
[    3.295046] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[    3.295048] kfd kfd: amdgpu: added device 1002:1638
[    3.295103] amdgpu 0000:53:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 7
[    3.295135] amdgpu 0000:53:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[    3.295138] amdgpu 0000:53:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    3.295141] amdgpu 0000:53:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    3.295143] amdgpu 0000:53:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[    3.295145] amdgpu 0000:53:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[    3.295146] amdgpu 0000:53:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[    3.295148] amdgpu 0000:53:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[    3.295149] amdgpu 0000:53:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[    3.295150] amdgpu 0000:53:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[    3.295151] amdgpu 0000:53:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[    3.295153] amdgpu 0000:53:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[    3.295154] amdgpu 0000:53:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[    3.295155] amdgpu 0000:53:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[    3.295156] amdgpu 0000:53:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[    3.295157] amdgpu 0000:53:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[    3.295825] [drm] Initialized amdgpu 3.48.0 20150101 for 0000:53:00.0 on minor 0
[    3.298513] fbcon: amdgpudrmfb (fb0) is primary device
[    3.298567] [drm] DSC precompute is not needed.
[    3.306641] usb 1-6: new high-speed USB device number 3 using xhci_hcd
[    3.453347] Console: switching to colour frame buffer device 320x90
[    3.470458] amdgpu 0000:53:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    3.506410] usb 1-6: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
[    3.506425] usb 1-6: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.506432] usb 1-6: Product: USB2.0 Hub
[    3.515254] hub 1-6:1.0: USB hub found
[    3.519232] hub 1-6:1.0: 4 ports detected
[    3.626621] usb 1-2.3: new high-speed USB device number 4 using xhci_hcd
[    3.766773] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    3.828389] usb 1-2.3: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.54
[    3.828404] usb 1-2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.828411] usb 1-2.3: Product: USB2.1 Hub
[    3.828415] usb 1-2.3: Manufacturer: GenesysLogic
[    3.838259] hub 1-2.3:1.0: USB hub found
[    3.842389] hub 1-2.3:1.0: 4 ports detected
[    3.917640] usb 2-2.3: new SuperSpeed USB device number 3 using xhci_hcd
[    3.951403] usb 2-2.3: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.54
[    3.951419] usb 2-2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.951426] usb 2-2.3: Product: USB3.1 Hub
[    3.951430] usb 2-2.3: Manufacturer: GenesysLogic
[    3.960231] hub 2-2.3:1.0: USB hub found
[    3.960722] hub 2-2.3:1.0: 4 ports detected
[    4.106944] usb 1-7: new full-speed USB device number 5 using xhci_hcd
[    4.466950] usb 1-6.3: new high-speed USB device number 6 using xhci_hcd
[    4.620368] usb 1-6.3: New USB device found, idVendor=2109, idProduct=2812, bcdDevice= b.e0
[    4.620383] usb 1-6.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.620390] usb 1-6.3: Product: USB2.0 Hub             
[    4.620395] usb 1-6.3: Manufacturer: VIA Labs, Inc.         
[    4.630496] hub 1-6.3:1.0: USB hub found
[    4.633366] hub 1-6.3:1.0: 4 ports detected
[    4.722124] [drm] Adding stream 0000000048d45044 to context failed with err 28!
[    4.722143] [drm:handle_hpd_irq_helper [amdgpu]] *ERROR* Restoring old state failed with -22
[    4.986833] usb 1-6.3.2: new high-speed USB device number 7 using xhci_hcd
[    5.153353] usb 1-6.3.2: New USB device found, idVendor=05ac, idProduct=1006, bcdDevice=96.15
[    5.153369] usb 1-6.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.153377] usb 1-6.3.2: Product: Keyboard Hub
[    5.153381] usb 1-6.3.2: Manufacturer: Apple, Inc.
[    5.153386] usb 1-6.3.2: SerialNumber: 000000000000
[    5.164484] hub 1-6.3.2:1.0: USB hub found
[    5.167346] hub 1-6.3.2:1.0: 3 ports detected
[    5.336823] usb 1-6.3.3: new low-speed USB device number 8 using xhci_hcd
[    5.658354] usb 1-6.3.3: New USB device found, idVendor=047d, idProduct=1020, bcdDevice= 1.06
[    5.658369] usb 1-6.3.3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    5.658376] usb 1-6.3.3: Product: Kensington Expert Mouse
[    5.674210] hid: raw HID events driver (C) Jiri Kosina
[    5.696200] usbcore: registered new interface driver usbhid
[    5.696217] usbhid: USB HID core driver
[    5.696676] input: Kensington Expert Mouse as /devices/pci0000:00/0000:00:02.1/0000:01:00.0/usb1/1-6/1-6.3/1-6.3.3/1-6.3.3:1.0/0003:047D:1020.0001/input/input1
[    5.696736] hid-generic 0003:047D:1020.0001: input,hidraw0: USB HID v1.11 Mouse [Kensington Expert Mouse] on usb-0000:01:00.0-6.3.3/input0
[    5.766799] usb 1-6.3.2.2: new low-speed USB device number 9 using xhci_hcd
[    6.038334] usb 1-6.3.2.2: New USB device found, idVendor=05ac, idProduct=0220, bcdDevice= 0.71
[    6.038350] usb 1-6.3.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.038358] usb 1-6.3.2.2: Product: Apple Keyboard
[    6.038363] usb 1-6.3.2.2: Manufacturer: Apple, Inc
[    6.110380] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:02.1/0000:01:00.0/usb1/1-6/1-6.3/1-6.3.2/1-6.3.2.2/1-6.3.2.2:1.0/0003:05AC:0220.0002/input/input2
[    6.176943] apple 0003:05AC:0220.0002: input,hidraw1: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:01:00.0-6.3.2.2/input0
[    6.177458] apple 0003:05AC:0220.0003: Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling
[    6.177901] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:02.1/0000:01:00.0/usb1/1-6/1-6.3/1-6.3.2/1-6.3.2.2/1-6.3.2.2:1.1/0003:05AC:0220.0003/input/input3
[    6.186836] usb 1-6.3.4: new high-speed USB device number 10 using xhci_hcd
[    6.256918] apple 0003:05AC:0220.0003: input,hidraw2: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:01:00.0-6.3.2.2/input1
[    6.381323] usb 1-6.3.4: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
[    6.381773] usb 1-6.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    6.382175] usb 1-6.3.4: Product: USB 10/100/1000 LAN
[    6.382560] usb 1-6.3.4: Manufacturer: Realtek
[    6.382932] usb 1-6.3.4: SerialNumber: F01E341F8303
[    9.481141] usb 1-7: New USB device found, idVendor=048d, idProduct=5702, bcdDevice= 0.01
[    9.481580] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    9.482001] usb 1-7: Product: ITE Device
[    9.482376] usb 1-7: Manufacturer: ITE Tech. Inc.
[    9.500894] hid-generic 0003:048D:5702.0004: hiddev96,hidraw3: USB HID v1.12 Device [ITE Tech. Inc. ITE Device] on usb-0000:01:00.0-7/input0
[    9.646856] usb 1-10: new high-speed USB device number 11 using xhci_hcd
[    9.846217] usb 1-10: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
[    9.846670] usb 1-10: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    9.847091] usb 1-10: Product: USB2.0 Hub
[    9.862270] hub 1-10:1.0: USB hub found
[    9.866201] hub 1-10:1.0: 4 ports detected
[    9.926858] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-4e00:00: attached PHY driver (mii_bus:phy_addr=r8169-0-4e00:00, irq=MAC)
[   10.207002] r8169 0000:4e:00.0 eth1: Link is Down
[   13.345028] r8169 0000:4e:00.0 eth1: Link is Up - 1Gbps/Full - flow control off
[   14.725324] r8169 0000:4e:00.0 eth1: Link is Down
[   17.255804] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
[   17.531014] udevd[1547]: starting version 3.2.9
[   17.565943] udevd[1548]: starting eudev-3.2.9
[   17.583433] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input4
[   17.584050] ACPI: button: Power Button [PWRB]
[   17.584744] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[   17.592493] thunderbolt 0000:05:00.0: 0:9 <-> 3:a (PCI): activating
[   17.592498] thunderbolt 0000:05:00.0: activating PCIe Down path from 0:9 to 3:10
[   17.592619] thunderbolt 0000:05:00.0: 3:1: Writing hop 1
[   17.592621] thunderbolt 0000:05:00.0: 3:1:  In HopID: 8 => Out port: 10 Out HopID: 8
[   17.592622] thunderbolt 0000:05:00.0: 3:1:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   17.592623] thunderbolt 0000:05:00.0: 3:1:    Counter enabled: 0 Counter index: 2047
[   17.592623] thunderbolt 0000:05:00.0: 3:1:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   17.592624] thunderbolt 0000:05:00.0: 3:1:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   17.593143] thunderbolt 0000:05:00.0: 0:9: Writing hop 0
[   17.593145] thunderbolt 0000:05:00.0: 0:9:  In HopID: 8 => Out port: 3 Out HopID: 8
[   17.593146] thunderbolt 0000:05:00.0: 0:9:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   17.593147] thunderbolt 0000:05:00.0: 0:9:    Counter enabled: 0 Counter index: 2047
[   17.593149] thunderbolt 0000:05:00.0: 0:9:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   17.593150] thunderbolt 0000:05:00.0: 0:9:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   17.593256] thunderbolt 0000:05:00.0: path activation complete
[   17.593257] thunderbolt 0000:05:00.0: activating PCIe Up path from 3:10 to 0:9
[   17.593640] thunderbolt 0000:05:00.0: 0:3: Writing hop 1
[   17.593642] thunderbolt 0000:05:00.0: 0:3:  In HopID: 8 => Out port: 9 Out HopID: 8
[   17.593644] thunderbolt 0000:05:00.0: 0:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   17.593646] thunderbolt 0000:05:00.0: 0:3:    Counter enabled: 0 Counter index: 2047
[   17.593647] thunderbolt 0000:05:00.0: 0:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   17.593648] thunderbolt 0000:05:00.0: 0:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   17.594011] thunderbolt 0000:05:00.0: 3:10: Writing hop 0
[   17.594013] thunderbolt 0000:05:00.0: 3:10:  In HopID: 8 => Out port: 1 Out HopID: 8
[   17.594013] thunderbolt 0000:05:00.0: 3:10:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   17.594014] thunderbolt 0000:05:00.0: 3:10:    Counter enabled: 0 Counter index: 2047
[   17.594015] thunderbolt 0000:05:00.0: 3:10:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   17.594015] thunderbolt 0000:05:00.0: 3:10:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   17.594034] thunderbolt 0000:05:00.0: path activation complete
[   17.594761] thunderbolt 0000:05:00.0: 3:7 <-> 303:a (PCI): activating
[   17.594764] thunderbolt 0000:05:00.0: activating PCIe Down path from 3:7 to 303:10
[   17.594888] thunderbolt 0000:05:00.0: 303:3: Writing hop 1
[   17.594889] thunderbolt 0000:05:00.0: 303:3:  In HopID: 8 => Out port: 10 Out HopID: 8
[   17.594891] thunderbolt 0000:05:00.0: 303:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   17.594892] thunderbolt 0000:05:00.0: 303:3:    Counter enabled: 0 Counter index: 2047
[   17.594893] thunderbolt 0000:05:00.0: 303:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   17.594894] thunderbolt 0000:05:00.0: 303:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   17.595144] thunderbolt 0000:05:00.0: 3:7: Writing hop 0
[   17.595145] thunderbolt 0000:05:00.0: 3:7:  In HopID: 8 => Out port: 3 Out HopID: 8
[   17.595146] thunderbolt 0000:05:00.0: 3:7:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   17.595147] thunderbolt 0000:05:00.0: 3:7:    Counter enabled: 0 Counter index: 2047
[   17.595148] thunderbolt 0000:05:00.0: 3:7:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   17.595149] thunderbolt 0000:05:00.0: 3:7:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   17.595272] thunderbolt 0000:05:00.0: path activation complete
[   17.595273] thunderbolt 0000:05:00.0: activating PCIe Up path from 303:10 to 3:7
[   17.595397] thunderbolt 0000:05:00.0: 3:3: Writing hop 1
[   17.595399] thunderbolt 0000:05:00.0: 3:3:  In HopID: 8 => Out port: 7 Out HopID: 8
[   17.595400] thunderbolt 0000:05:00.0: 3:3:   Weight: 1 Priority: 3 Credits: 16 Drop: 0
[   17.595401] thunderbolt 0000:05:00.0: 3:3:    Counter enabled: 0 Counter index: 2047
[   17.595402] thunderbolt 0000:05:00.0: 3:3:   Flow Control (In/Eg): 1/0 Shared Buffer (In/Eg): 0/0
[   17.595403] thunderbolt 0000:05:00.0: 3:3:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   17.595657] thunderbolt 0000:05:00.0: 303:10: Writing hop 0
[   17.595658] thunderbolt 0000:05:00.0: 303:10:  In HopID: 8 => Out port: 3 Out HopID: 8
[   17.595659] thunderbolt 0000:05:00.0: 303:10:   Weight: 1 Priority: 3 Credits: 7 Drop: 0
[   17.595661] thunderbolt 0000:05:00.0: 303:10:    Counter enabled: 0 Counter index: 2047
[   17.595662] thunderbolt 0000:05:00.0: 303:10:   Flow Control (In/Eg): 1/1 Shared Buffer (In/Eg): 0/0
[   17.595663] thunderbolt 0000:05:00.0: 303:10:   Unknown1: 0x0 Unknown2: 0x0 Unknown3: 0x0
[   17.595788] thunderbolt 0000:05:00.0: path activation complete
[   17.612605] mousedev: PS/2 mouse device common for all mice
[   17.614397] SVM: TSC scaling supported
[   17.614763] kvm: Nested Virtualization enabled
[   17.615126] SVM: kvm: Nested Paging enabled
[   17.615490] SVM: Virtual VMLOAD VMSAVE supported
[   17.615858] SVM: Virtual GIF supported
[   17.616218] SVM: LBR virtualization supported
[   17.616645] ACPI: button: Power Button [PWRF]
[   17.616844] pcieport 0000:04:04.0: pciehp: Slot(4): Card present
[   17.624951] snd_hda_intel 0000:53:00.1: enabling device (0000 -> 0002)
[   17.625492] snd_hda_intel 0000:53:00.6: enabling device (0000 -> 0002)
[   17.630486] snd_hda_intel 0000:53:00.1: bound 0000:53:00.0 (ops amdgpu_exit [amdgpu])
[   17.631547] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:53:00.1/sound/card0/input6
[   17.631948] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:53:00.1/sound/card0/input7
[   17.632330] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:53:00.1/sound/card0/input8
[   17.632708] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:53:00.1/sound/card0/input9
[   17.642270] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1220: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   17.642653] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   17.643023] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   17.643372] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   17.643727] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
[   17.644078] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   17.644079] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[   17.644080] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[   17.644080] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[   17.727287] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input10
[   17.727725] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input11
[   17.728134] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input12
[   17.728537] input: HD-Audio Generic Line Out Front as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input13
[   17.728872] input: HD-Audio Generic Line Out Surround as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input14
[   17.729309] input: HD-Audio Generic Line Out CLFE as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input15
[   17.729724] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input16
[   17.786946] pci 0000:29:00.0: [8086:1513] type 01 class 0x060400
[   17.787533] pci 0000:29:00.0: enabling Extended Tags
[   17.788054] pci 0000:29:00.0: supports D1 D2
[   17.788360] pci 0000:29:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.788817] pcieport 0000:04:04.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[   17.816885] pci 0000:29:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.817446] pci 0000:2a:00.0: [8086:1513] type 01 class 0x060400
[   17.817884] pci 0000:2a:00.0: enabling Extended Tags
[   17.818372] pci 0000:2a:00.0: supports D1 D2
[   17.818676] pci 0000:2a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.819147] pci 0000:2a:01.0: [8086:1513] type 01 class 0x060400
[   17.819567] pci 0000:2a:01.0: enabling Extended Tags
[   17.820046] pci 0000:2a:01.0: supports D1 D2
[   17.820343] pci 0000:2a:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.820795] pci 0000:2a:02.0: [8086:1513] type 01 class 0x060400
[   17.821204] pci 0000:2a:02.0: enabling Extended Tags
[   17.821673] pci 0000:2a:02.0: supports D1 D2
[   17.821959] pci 0000:2a:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.822410] pci 0000:2a:04.0: [8086:1513] type 01 class 0x060400
[   17.822816] pci 0000:2a:04.0: enabling Extended Tags
[   17.823279] pci 0000:2a:04.0: supports D1 D2
[   17.823564] pci 0000:2a:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.824015] pci 0000:2a:05.0: [8086:1513] type 01 class 0x060400
[   17.824420] pci 0000:2a:05.0: enabling Extended Tags
[   17.824889] pci 0000:2a:05.0: supports D1 D2
[   17.825176] pci 0000:2a:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.825640] pci 0000:29:00.0: PCI bridge to [bus 2a-4a]
[   17.825948] pci 0000:29:00.0:   bridge window [io  0x0000-0x0fff]
[   17.826243] pci 0000:29:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.826541] pci 0000:29:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.826908] pci 0000:2a:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.827205] pci 0000:2a:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.827502] pci 0000:2a:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.827796] pci 0000:2a:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.828089] pci 0000:2a:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.828512] pci 0000:2b:00.0: [12d8:400c] type 01 class 0x060400
[   17.829155] pci 0000:2b:00.0: supports D1 D2
[   17.829429] pci 0000:2b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.856697] pci 0000:2a:00.0: PCI bridge to [bus 2b-4a]
[   17.857035] pci 0000:2a:00.0:   bridge window [io  0x0000-0x0fff]
[   17.857366] pci 0000:2a:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.857664] pci 0000:2a:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.857962] pci 0000:2b:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.858471] pci 0000:2c:03.0: [12d8:400c] type 01 class 0x060400
[   17.859077] pci 0000:2c:03.0: supports D1 D2
[   17.859352] pci 0000:2c:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.859839] pci 0000:2b:00.0: PCI bridge to [bus 2c-4a]
[   17.860137] pci 0000:2b:00.0:   bridge window [io  0x0000-0x0fff]
[   17.860428] pci 0000:2b:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.860725] pci 0000:2b:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.861010] pci 0000:2c:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.861486] pci 0000:2d:00.0: [12d8:400e] type 00 class 0x0c0310
[   17.861819] pci 0000:2d:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   17.862354] pci 0000:2d:00.0: supports D1 D2
[   17.862631] pci 0000:2d:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.863052] pci 0000:2d:00.1: [12d8:400e] type 00 class 0x0c0310
[   17.863371] pci 0000:2d:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   17.863919] pci 0000:2d:00.1: supports D1 D2
[   17.864191] pci 0000:2d:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   17.864577] pci 0000:2d:00.2: [12d8:400f] type 00 class 0x0c0320
[   17.864896] pci 0000:2d:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   17.865423] pci 0000:2d:00.2: supports D1 D2
[   17.865691] pci 0000:2d:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   17.866332] pci 0000:2c:03.0: PCI bridge to [bus 2d-4a]
[   17.866640] pci 0000:2c:03.0:   bridge window [io  0x0000-0x0fff]
[   17.866936] pci 0000:2c:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.867232] pci 0000:2c:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.867506] pci_bus 0000:2d: busn_res: [bus 2d-4a] end is updated to 2d
[   17.867785] pci_bus 0000:2c: busn_res: [bus 2c-4a] end is updated to 2d
[   17.868063] pci_bus 0000:2b: busn_res: [bus 2b-4a] end is updated to 2d
[   17.868468] pci 0000:2e:00.0: [14e4:16b0] type 00 class 0x020000
[   17.868794] pci 0000:2e:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   17.869110] pci 0000:2e:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   17.869687] pci 0000:2e:00.0: PME# supported from D0 D3hot D3cold
[   17.896931] pci 0000:2a:01.0: PCI bridge to [bus 2e-4a]
[   17.897258] pci 0000:2a:01.0:   bridge window [io  0x0000-0x0fff]
[   17.897553] pci 0000:2a:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.897831] pci 0000:2a:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.898096] pci_bus 0000:2e: busn_res: [bus 2e-4a] end is updated to 2e
[   17.898525] pci 0000:2f:00.0: [11c1:5901] type 00 class 0x0c0010
[   17.898868] pci 0000:2f:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   17.899461] pci 0000:2f:00.0: supports D1 D2
[   17.899729] pci 0000:2f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.907234] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   17.907875] ehci-pci: EHCI PCI platform driver
[   17.908319] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   17.909018] ohci-pci: OHCI PCI platform driver
[   17.926698] pci 0000:2a:02.0: PCI bridge to [bus 2f-4a]
[   17.927108] pci 0000:2a:02.0:   bridge window [io  0x0000-0x0fff]
[   17.927412] pci 0000:2a:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.927732] pci 0000:2a:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.927990] pci_bus 0000:2f: busn_res: [bus 2f-4a] end is updated to 2f
[   17.928433] pci 0000:30:00.0: [8086:1513] type 01 class 0x060400
[   17.928843] pci 0000:30:00.0: enabling Extended Tags
[   17.929358] pci 0000:30:00.0: supports D1 D2
[   17.929609] pci 0000:30:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.956914] pci 0000:2a:04.0: PCI bridge to [bus 30-4a]
[   17.957229] pci 0000:2a:04.0:   bridge window [io  0x0000-0x0fff]
[   17.957519] pci 0000:2a:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.957789] pci 0000:2a:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.958048] pci 0000:30:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.958542] pci 0000:31:00.0: [8086:1513] type 01 class 0x060400
[   17.958958] pci 0000:31:00.0: enabling Extended Tags
[   17.959472] pci 0000:31:00.0: supports D1 D2
[   17.959719] pci 0000:31:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.960210] pci 0000:31:01.0: [8086:1513] type 01 class 0x060400
[   17.960622] pci 0000:31:01.0: enabling Extended Tags
[   17.961128] pci 0000:31:01.0: supports D1 D2
[   17.961376] pci 0000:31:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.961849] pci 0000:31:02.0: [8086:1513] type 01 class 0x060400
[   17.962267] pci 0000:31:02.0: enabling Extended Tags
[   17.962772] pci 0000:31:02.0: supports D1 D2
[   17.963019] pci 0000:31:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.963500] pci 0000:31:04.0: [8086:1513] type 01 class 0x060400
[   17.963908] pci 0000:31:04.0: enabling Extended Tags
[   17.964418] pci 0000:31:04.0: supports D1 D2
[   17.964664] pci 0000:31:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.965144] pci 0000:31:05.0: [8086:1513] type 01 class 0x060400
[   17.965555] pci 0000:31:05.0: enabling Extended Tags
[   17.966061] pci 0000:31:05.0: supports D1 D2
[   17.966309] pci 0000:31:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.966901] pci 0000:30:00.0: PCI bridge to [bus 31-4a]
[   17.967180] pci 0000:30:00.0:   bridge window [io  0x0000-0x0fff]
[   17.967444] pci 0000:30:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.967727] pci 0000:30:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.967990] pci 0000:31:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.968270] pci 0000:31:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.968548] pci 0000:31:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.968824] pci 0000:31:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.969097] pci 0000:31:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.969555] pci 0000:32:00.0: [12d8:400c] type 01 class 0x060400
[   17.970305] pci 0000:32:00.0: supports D1 D2
[   17.970557] pci 0000:32:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.971081] pci 0000:31:00.0: PCI bridge to [bus 32-4a]
[   17.971371] pci 0000:31:00.0:   bridge window [io  0x0000-0x0fff]
[   17.971642] pci 0000:31:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.971919] pci 0000:31:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.972186] pci 0000:32:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.972735] pci 0000:33:03.0: [12d8:400c] type 01 class 0x060400
[   17.973408] pci 0000:33:03.0: supports D1 D2
[   17.973657] pci 0000:33:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.974166] pci 0000:32:00.0: PCI bridge to [bus 33-4a]
[   17.974448] pci 0000:32:00.0:   bridge window [io  0x0000-0x0fff]
[   17.974710] pci 0000:32:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.974981] pci 0000:32:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.975238] pci 0000:33:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   17.975751] pci 0000:34:00.0: [12d8:400e] type 00 class 0x0c0310
[   17.976071] pci 0000:34:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   17.976785] pci 0000:34:00.0: supports D1 D2
[   17.977035] pci 0000:34:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.977834] pci 0000:34:00.1: [12d8:400e] type 00 class 0x0c0310
[   17.978149] pci 0000:34:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   17.978757] pci 0000:34:00.1: supports D1 D2
[   17.979004] pci 0000:34:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   17.979412] pci 0000:34:00.2: [12d8:400f] type 00 class 0x0c0320
[   17.979724] pci 0000:34:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   17.980333] pci 0000:34:00.2: supports D1 D2
[   17.980581] pci 0000:34:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   17.981339] pci 0000:33:03.0: PCI bridge to [bus 34-4a]
[   17.981615] pci 0000:33:03.0:   bridge window [io  0x0000-0x0fff]
[   17.981880] pci 0000:33:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.982153] pci 0000:33:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.982403] pci_bus 0000:34: busn_res: [bus 34-4a] end is updated to 34
[   17.982672] pci_bus 0000:33: busn_res: [bus 33-4a] end is updated to 34
[   17.982931] pci_bus 0000:32: busn_res: [bus 32-4a] end is updated to 34
[   17.983371] pci 0000:35:00.0: [14e4:16b0] type 00 class 0x020000
[   17.983706] pci 0000:35:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   17.984006] pci 0000:35:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   17.984666] pci 0000:35:00.0: PME# supported from D0 D3hot D3cold
[   17.985238] pci 0000:31:01.0: PCI bridge to [bus 35-4a]
[   17.985512] pci 0000:31:01.0:   bridge window [io  0x0000-0x0fff]
[   17.985780] pci 0000:31:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.986053] pci 0000:31:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.986308] pci_bus 0000:35: busn_res: [bus 35-4a] end is updated to 35
[   17.986804] pci 0000:36:00.0: [11c1:5901] type 00 class 0x0c0010
[   17.987139] pci 0000:36:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   17.987787] pci 0000:36:00.0: supports D1 D2
[   17.988034] pci 0000:36:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   17.988581] pci 0000:31:02.0: PCI bridge to [bus 36-4a]
[   17.988860] pci 0000:31:02.0:   bridge window [io  0x0000-0x0fff]
[   17.989125] pci 0000:31:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.989397] pci 0000:31:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.989652] pci_bus 0000:36: busn_res: [bus 36-4a] end is updated to 36
[   17.990020] pci 0000:31:04.0: PCI bridge to [bus 37-4a]
[   17.990299] pci 0000:31:04.0:   bridge window [io  0x0000-0x0fff]
[   17.990566] pci 0000:31:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.990837] pci 0000:31:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.991096] pci_bus 0000:37: busn_res: [bus 37-4a] end is updated to 3d
[   17.991469] pci 0000:31:05.0: PCI bridge to [bus 3e-4a]
[   17.991746] pci 0000:31:05.0:   bridge window [io  0x0000-0x0fff]
[   17.992014] pci 0000:31:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.992288] pci 0000:31:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.992542] pci_bus 0000:3e: busn_res: [bus 3e-4a] end is updated to 3f
[   17.992797] pci_bus 0000:31: busn_res: [bus 31-4a] end is updated to 3f
[   17.993054] pci_bus 0000:30: busn_res: [bus 30-4a] end is updated to 3f
[   17.993388] pci 0000:2a:05.0: PCI bridge to [bus 40-4a]
[   17.993649] pci 0000:2a:05.0:   bridge window [io  0x0000-0x0fff]
[   17.993902] pci 0000:2a:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   17.994159] pci 0000:2a:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   17.994401] pci_bus 0000:40: busn_res: [bus 40-4a] end is updated to 4a
[   17.994655] pci_bus 0000:2a: busn_res: [bus 2a-4a] end is updated to 4a
[   17.994909] pci 0000:31:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 37-3d] add_size 100000 add_align 100000
[   17.995160] pci 0000:31:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 37-3d] add_size 100000 add_align 100000
[   17.995410] pci 0000:31:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 3e-3f] add_size 100000 add_align 100000
[   17.995662] pci 0000:31:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 3e-3f] add_size 100000 add_align 100000
[   17.995915] pci 0000:30:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 31-3f] add_size 200000 add_align 100000
[   17.996172] pci 0000:30:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 31-3f] add_size 200000 add_align 100000
[   17.996429] pci 0000:2a:04.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 30-3f] add_size 200000 add_align 100000
[   17.996788] pci 0000:2a:04.0: bridge window [mem 0x00100000-0x005fffff] to [bus 30-3f] add_size 200000 add_align 100000
[   17.997050] pci 0000:2a:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 40-4a] add_size 100000 add_align 100000
[   17.997312] pci 0000:2a:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 40-4a] add_size 100000 add_align 100000
[   17.997573] pci 0000:29:00.0: bridge window [mem 0x00100000-0x009fffff 64bit pref] to [bus 2a-4a] add_size 300000 add_align 100000
[   17.997830] pci 0000:29:00.0: bridge window [mem 0x00100000-0x009fffff] to [bus 2a-4a] add_size 300000 add_align 100000
[   17.998091] pcieport 0000:04:04.0: BAR 7: no space for [io  size 0x9000]
[   17.998352] pcieport 0000:04:04.0: BAR 7: failed to assign [io  size 0x9000]
[   17.998613] pci 0000:29:00.0: BAR 8: assigned [mem 0xdf000000-0xe6ffffff]
[   17.998879] pci 0000:29:00.0: BAR 9: assigned [mem 0xa0000000-0xa1ffffff 64bit pref]
[   17.999144] pci 0000:29:00.0: BAR 7: no space for [io  size 0x9000]
[   17.999412] pci 0000:29:00.0: BAR 7: failed to assign [io  size 0x9000]
[   17.999683] pci 0000:2a:00.0: BAR 8: assigned [mem 0xdf000000-0xdf0fffff]
[   17.999950] pci 0000:2a:00.0: BAR 9: assigned [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.000219] pci 0000:2a:01.0: BAR 8: assigned [mem 0xdf100000-0xdf1fffff]
[   18.000487] pci 0000:2a:01.0: BAR 9: assigned [mem 0xa0100000-0xa01fffff 64bit pref]
[   18.000752] pci 0000:2a:02.0: BAR 8: assigned [mem 0xdf200000-0xdf2fffff]
[   18.001018] pci 0000:2a:02.0: BAR 9: assigned [mem 0xa0200000-0xa02fffff 64bit pref]
[   18.001285] pci 0000:2a:04.0: BAR 8: assigned [mem 0xdf300000-0xe317ffff]
[   18.001552] pci 0000:2a:04.0: BAR 9: assigned [mem 0xa0300000-0xa117ffff 64bit pref]
[   18.001818] pci 0000:2a:05.0: BAR 8: assigned [mem 0xe3200000-0xe6ffffff]
[   18.002082] pci 0000:2a:05.0: BAR 9: assigned [mem 0xa1200000-0xa1ffffff 64bit pref]
[   18.002348] pci 0000:2a:00.0: BAR 7: no space for [io  size 0x1000]
[   18.002611] pci 0000:2a:00.0: BAR 7: failed to assign [io  size 0x1000]
[   18.002873] pci 0000:2a:01.0: BAR 7: no space for [io  size 0x1000]
[   18.003135] pci 0000:2a:01.0: BAR 7: failed to assign [io  size 0x1000]
[   18.003400] pci 0000:2a:02.0: BAR 7: no space for [io  size 0x1000]
[   18.003664] pci 0000:2a:02.0: BAR 7: failed to assign [io  size 0x1000]
[   18.003926] pci 0000:2a:04.0: BAR 7: no space for [io  size 0x3000]
[   18.004188] pci 0000:2a:04.0: BAR 7: failed to assign [io  size 0x3000]
[   18.004449] pci 0000:2a:05.0: BAR 7: no space for [io  size 0x3000]
[   18.004710] pci 0000:2a:05.0: BAR 7: failed to assign [io  size 0x3000]
[   18.004971] pci 0000:2b:00.0: BAR 8: assigned [mem 0xdf000000-0xdf0fffff]
[   18.005234] pci 0000:2b:00.0: BAR 9: assigned [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.005495] pci 0000:2b:00.0: BAR 7: no space for [io  size 0x1000]
[   18.005757] pci 0000:2b:00.0: BAR 7: failed to assign [io  size 0x1000]
[   18.006018] pci 0000:2c:03.0: BAR 8: assigned [mem 0xdf000000-0xdf0fffff]
[   18.006279] pci 0000:2c:03.0: BAR 9: assigned [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.006540] pci 0000:2c:03.0: BAR 7: no space for [io  size 0x1000]
[   18.006893] pci 0000:2c:03.0: BAR 7: failed to assign [io  size 0x1000]
[   18.007156] pci 0000:2d:00.0: BAR 0: assigned [mem 0xdf000000-0xdf000fff]
[   18.007432] pci 0000:2d:00.1: BAR 0: assigned [mem 0xdf001000-0xdf001fff]
[   18.007705] pci 0000:2d:00.2: BAR 0: assigned [mem 0xdf002000-0xdf0020ff]
[   18.007976] pci 0000:2c:03.0: PCI bridge to [bus 2d]
[   18.008260] pci 0000:2c:03.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   18.008529] pci 0000:2c:03.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.008808] pci 0000:2b:00.0: PCI bridge to [bus 2c-2d]
[   18.009085] pci 0000:2b:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   18.009360] pci 0000:2b:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.009639] pci 0000:2a:00.0: PCI bridge to [bus 2b-2d]
[   18.009911] pci 0000:2a:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   18.010183] pci 0000:2a:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.010460] pci 0000:2e:00.0: BAR 0: assigned [mem 0xa0100000-0xa010ffff 64bit pref]
[   18.010752] pci 0000:2e:00.0: BAR 2: assigned [mem 0xa0110000-0xa011ffff 64bit pref]
[   18.011044] pci 0000:2a:01.0: PCI bridge to [bus 2e]
[   18.011317] pci 0000:2a:01.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[   18.011588] pci 0000:2a:01.0:   bridge window [mem 0xa0100000-0xa01fffff 64bit pref]
[   18.011863] pci 0000:2f:00.0: BAR 0: assigned [mem 0xdf200000-0xdf200fff 64bit]
[   18.012154] pci 0000:2a:02.0: PCI bridge to [bus 2f]
[   18.012425] pci 0000:2a:02.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[   18.012690] pci 0000:2a:02.0:   bridge window [mem 0xa0200000-0xa02fffff 64bit pref]
[   18.012964] pci 0000:30:00.0: BAR 8: assigned [mem 0xdf300000-0xe317ffff]
[   18.013223] pci 0000:30:00.0: BAR 9: assigned [mem 0xa0300000-0xa117ffff 64bit pref]
[   18.013483] pci 0000:30:00.0: BAR 7: no space for [io  size 0x3000]
[   18.013745] pci 0000:30:00.0: BAR 7: failed to assign [io  size 0x3000]
[   18.014006] pci 0000:31:00.0: BAR 8: assigned [mem 0xdf300000-0xdf3fffff]
[   18.014265] pci 0000:31:00.0: BAR 9: assigned [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.014524] pci 0000:31:01.0: BAR 8: assigned [mem 0xdf400000-0xdf4fffff]
[   18.014784] pci 0000:31:01.0: BAR 9: assigned [mem 0xa0400000-0xa04fffff 64bit pref]
[   18.015045] pci 0000:31:02.0: BAR 8: assigned [mem 0xdf500000-0xdf5fffff]
[   18.015304] pci 0000:31:02.0: BAR 9: assigned [mem 0xa0500000-0xa05fffff 64bit pref]
[   18.015561] pci 0000:31:04.0: BAR 8: assigned [mem 0xdf600000-0xe13bffff]
[   18.015818] pci 0000:31:04.0: BAR 9: assigned [mem 0xa0600000-0xa0bbffff 64bit pref]
[   18.016075] pci 0000:31:05.0: BAR 8: assigned [mem 0xe1400000-0xe317ffff]
[   18.016333] pci 0000:31:05.0: BAR 9: assigned [mem 0xa0c00000-0xa117ffff 64bit pref]
[   18.016671] pci 0000:31:00.0: BAR 7: no space for [io  size 0x1000]
[   18.016936] pci 0000:31:00.0: BAR 7: failed to assign [io  size 0x1000]
[   18.017196] pci 0000:31:01.0: BAR 7: no space for [io  size 0x1000]
[   18.017454] pci 0000:31:01.0: BAR 7: failed to assign [io  size 0x1000]
[   18.017713] pci 0000:31:02.0: BAR 7: no space for [io  size 0x1000]
[   18.017973] pci 0000:31:02.0: BAR 7: failed to assign [io  size 0x1000]
[   18.018233] pci 0000:31:04.0: BAR 7: no space for [io  size 0x1000]
[   18.018491] pci 0000:31:04.0: BAR 7: failed to assign [io  size 0x1000]
[   18.018751] pci 0000:31:05.0: BAR 7: no space for [io  size 0x1000]
[   18.019007] pci 0000:31:05.0: BAR 7: failed to assign [io  size 0x1000]
[   18.019263] pci 0000:32:00.0: BAR 8: assigned [mem 0xdf300000-0xdf3fffff]
[   18.019516] pci 0000:32:00.0: BAR 9: assigned [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.019769] pci 0000:32:00.0: BAR 7: no space for [io  size 0x1000]
[   18.020024] pci 0000:32:00.0: BAR 7: failed to assign [io  size 0x1000]
[   18.020274] pci 0000:33:03.0: BAR 8: assigned [mem 0xdf300000-0xdf3fffff]
[   18.020525] pci 0000:33:03.0: BAR 9: assigned [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.020775] pci 0000:33:03.0: BAR 7: no space for [io  size 0x1000]
[   18.021022] pci 0000:33:03.0: BAR 7: failed to assign [io  size 0x1000]
[   18.021271] pci 0000:34:00.0: BAR 0: assigned [mem 0xdf300000-0xdf300fff]
[   18.021533] pci 0000:34:00.1: BAR 0: assigned [mem 0xdf301000-0xdf301fff]
[   18.021792] pci 0000:34:00.2: BAR 0: assigned [mem 0xdf302000-0xdf3020ff]
[   18.022046] pci 0000:33:03.0: PCI bridge to [bus 34]
[   18.022302] pci 0000:33:03.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[   18.022561] pci 0000:33:03.0:   bridge window [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.022826] pci 0000:32:00.0: PCI bridge to [bus 33-34]
[   18.023077] pci 0000:32:00.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[   18.023329] pci 0000:32:00.0:   bridge window [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.023591] pci 0000:31:00.0: PCI bridge to [bus 32-34]
[   18.023845] pci 0000:31:00.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[   18.024095] pci 0000:31:00.0:   bridge window [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.024357] pci 0000:35:00.0: BAR 0: assigned [mem 0xa0400000-0xa040ffff 64bit pref]
[   18.024636] pci 0000:35:00.0: BAR 2: assigned [mem 0xa0410000-0xa041ffff 64bit pref]
[   18.024914] pci 0000:31:01.0: PCI bridge to [bus 35]
[   18.025166] pci 0000:31:01.0:   bridge window [mem 0xdf400000-0xdf4fffff]
[   18.025417] pci 0000:31:01.0:   bridge window [mem 0xa0400000-0xa04fffff 64bit pref]
[   18.025677] pci 0000:36:00.0: BAR 0: assigned [mem 0xdf500000-0xdf500fff 64bit]
[   18.025958] pci 0000:31:02.0: PCI bridge to [bus 36]
[   18.026212] pci 0000:31:02.0:   bridge window [mem 0xdf500000-0xdf5fffff]
[   18.026465] pci 0000:31:02.0:   bridge window [mem 0xa0500000-0xa05fffff 64bit pref]
[   18.026806] pci 0000:31:04.0: PCI bridge to [bus 37-3d]
[   18.027064] pci 0000:31:04.0:   bridge window [mem 0xdf600000-0xe13bffff]
[   18.027317] pci 0000:31:04.0:   bridge window [mem 0xa0600000-0xa0bbffff 64bit pref]
[   18.027579] pci 0000:31:05.0: PCI bridge to [bus 3e-3f]
[   18.027834] pci 0000:31:05.0:   bridge window [mem 0xe1400000-0xe317ffff]
[   18.028088] pci 0000:31:05.0:   bridge window [mem 0xa0c00000-0xa117ffff 64bit pref]
[   18.028346] pci 0000:30:00.0: PCI bridge to [bus 31-3f]
[   18.028604] pci 0000:30:00.0:   bridge window [mem 0xdf300000-0xe317ffff]
[   18.028858] pci 0000:30:00.0:   bridge window [mem 0xa0300000-0xa117ffff 64bit pref]
[   18.029120] pci 0000:2a:04.0: PCI bridge to [bus 30-3f]
[   18.029373] pci 0000:2a:04.0:   bridge window [mem 0xdf300000-0xe317ffff]
[   18.029625] pci 0000:2a:04.0:   bridge window [mem 0xa0300000-0xa117ffff 64bit pref]
[   18.029882] pci 0000:2a:05.0: PCI bridge to [bus 40-4a]
[   18.030135] pci 0000:2a:05.0:   bridge window [mem 0xe3200000-0xe6ffffff]
[   18.030387] pci 0000:2a:05.0:   bridge window [mem 0xa1200000-0xa1ffffff 64bit pref]
[   18.030644] pci 0000:29:00.0: PCI bridge to [bus 2a-4a]
[   18.030893] pci 0000:29:00.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[   18.031139] pci 0000:29:00.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[   18.031399] pcieport 0000:04:04.0: PCI bridge to [bus 29-4a]
[   18.031656] pcieport 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[   18.031912] pcieport 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[   18.032170] PCI: No. 2 try to assign unassigned res
[   18.032175] pcieport 0000:04:04.0: BAR 7: no space for [io  size 0xb000]
[   18.032420] pcieport 0000:04:04.0: BAR 7: failed to assign [io  size 0xb000]
[   18.032664] pci 0000:29:00.0: BAR 7: no space for [io  size 0xb000]
[   18.032909] pci 0000:29:00.0: BAR 7: failed to assign [io  size 0xb000]
[   18.033155] pci 0000:2a:00.0: BAR 7: no space for [io  size 0x1000]
[   18.033400] pci 0000:2a:00.0: BAR 7: failed to assign [io  size 0x1000]
[   18.033644] pci 0000:2a:01.0: BAR 7: no space for [io  size 0x1000]
[   18.033890] pci 0000:2a:01.0: BAR 7: failed to assign [io  size 0x1000]
[   18.034135] pci 0000:2a:02.0: BAR 7: no space for [io  size 0x1000]
[   18.034380] pci 0000:2a:02.0: BAR 7: failed to assign [io  size 0x1000]
[   18.034623] pci 0000:2a:04.0: BAR 7: no space for [io  size 0x4000]
[   18.034867] pci 0000:2a:04.0: BAR 7: failed to assign [io  size 0x4000]
[   18.035112] pci 0000:2a:05.0: BAR 7: no space for [io  size 0x4000]
[   18.035355] pci 0000:2a:05.0: BAR 7: failed to assign [io  size 0x4000]
[   18.035599] pci 0000:2b:00.0: BAR 7: no space for [io  size 0x1000]
[   18.035844] pci 0000:2b:00.0: BAR 7: failed to assign [io  size 0x1000]
[   18.036087] pci 0000:2c:03.0: BAR 7: no space for [io  size 0x1000]
[   18.036332] pci 0000:2c:03.0: BAR 7: failed to assign [io  size 0x1000]
[   18.036655] pci 0000:2c:03.0: PCI bridge to [bus 2d]
[   18.036912] pci 0000:2c:03.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   18.037166] pci 0000:2c:03.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.037429] pci 0000:2b:00.0: PCI bridge to [bus 2c-2d]
[   18.037690] pci 0000:2b:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   18.037947] pci 0000:2b:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.038211] pci 0000:2a:00.0: PCI bridge to [bus 2b-2d]
[   18.038469] pci 0000:2a:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   18.038726] pci 0000:2a:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   18.038990] pci 0000:2a:01.0: PCI bridge to [bus 2e]
[   18.039248] pci 0000:2a:01.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[   18.039506] pci 0000:2a:01.0:   bridge window [mem 0xa0100000-0xa01fffff 64bit pref]
[   18.039770] pci 0000:2a:02.0: PCI bridge to [bus 2f]
[   18.040027] pci 0000:2a:02.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[   18.040285] pci 0000:2a:02.0:   bridge window [mem 0xa0200000-0xa02fffff 64bit pref]
[   18.040548] pci 0000:30:00.0: BAR 7: no space for [io  size 0x4000]
[   18.040797] pci 0000:30:00.0: BAR 7: failed to assign [io  size 0x4000]
[   18.041048] pci 0000:31:00.0: BAR 7: no space for [io  size 0x1000]
[   18.041296] pci 0000:31:00.0: BAR 7: failed to assign [io  size 0x1000]
[   18.041544] pci 0000:31:01.0: BAR 7: no space for [io  size 0x1000]
[   18.041795] pci 0000:31:01.0: BAR 7: failed to assign [io  size 0x1000]
[   18.042043] pci 0000:31:02.0: BAR 7: no space for [io  size 0x1000]
[   18.042291] pci 0000:31:02.0: BAR 7: failed to assign [io  size 0x1000]
[   18.042540] pci 0000:31:04.0: BAR 7: no space for [io  size 0x0800]
[   18.042789] pci 0000:31:04.0: BAR 7: failed to assign [io  size 0x0800]
[   18.043036] pci 0000:31:05.0: BAR 7: no space for [io  size 0x1000]
[   18.043282] pci 0000:31:05.0: BAR 7: failed to assign [io  size 0x1000]
[   18.043529] pci 0000:32:00.0: BAR 7: no space for [io  size 0x1000]
[   18.043775] pci 0000:32:00.0: BAR 7: failed to assign [io  size 0x1000]
[   18.044021] pci 0000:33:03.0: BAR 7: no space for [io  size 0x1000]
[   18.044270] pci 0000:33:03.0: BAR 7: failed to assign [io  size 0x1000]
[   18.044520] pci 0000:33:03.0: PCI bridge to [bus 34]
[   18.044787] pci 0000:33:03.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[   18.045051] pci 0000:33:03.0:   bridge window [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.045325] pci 0000:32:00.0: PCI bridge to [bus 33-34]
[   18.045593] pci 0000:32:00.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[   18.045856] pci 0000:32:00.0:   bridge window [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.046129] pci 0000:31:00.0: PCI bridge to [bus 32-34]
[   18.046394] pci 0000:31:00.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[   18.046732] pci 0000:31:00.0:   bridge window [mem 0xa0300000-0xa03fffff 64bit pref]
[   18.047004] pci 0000:31:01.0: PCI bridge to [bus 35]
[   18.047270] pci 0000:31:01.0:   bridge window [mem 0xdf400000-0xdf4fffff]
[   18.047534] pci 0000:31:01.0:   bridge window [mem 0xa0400000-0xa04fffff 64bit pref]
[   18.047807] pci 0000:31:02.0: PCI bridge to [bus 36]
[   18.048074] pci 0000:31:02.0:   bridge window [mem 0xdf500000-0xdf5fffff]
[   18.048337] pci 0000:31:02.0:   bridge window [mem 0xa0500000-0xa05fffff 64bit pref]
[   18.048609] pci 0000:31:04.0: PCI bridge to [bus 37-3d]
[   18.048876] pci 0000:31:04.0:   bridge window [mem 0xdf600000-0xe13bffff]
[   18.049138] pci 0000:31:04.0:   bridge window [mem 0xa0600000-0xa0bbffff 64bit pref]
[   18.049410] pci 0000:31:05.0: PCI bridge to [bus 3e-3f]
[   18.049677] pci 0000:31:05.0:   bridge window [mem 0xe1400000-0xe317ffff]
[   18.049941] pci 0000:31:05.0:   bridge window [mem 0xa0c00000-0xa117ffff 64bit pref]
[   18.050213] pci 0000:30:00.0: PCI bridge to [bus 31-3f]
[   18.050481] pci 0000:30:00.0:   bridge window [mem 0xdf300000-0xe317ffff]
[   18.050746] pci 0000:30:00.0:   bridge window [mem 0xa0300000-0xa117ffff 64bit pref]
[   18.051019] pci 0000:2a:04.0: PCI bridge to [bus 30-3f]
[   18.051282] pci 0000:2a:04.0:   bridge window [mem 0xdf300000-0xe317ffff]
[   18.051544] pci 0000:2a:04.0:   bridge window [mem 0xa0300000-0xa117ffff 64bit pref]
[   18.051811] pci 0000:2a:05.0: PCI bridge to [bus 40-4a]
[   18.052075] pci 0000:2a:05.0:   bridge window [mem 0xe3200000-0xe6ffffff]
[   18.052336] pci 0000:2a:05.0:   bridge window [mem 0xa1200000-0xa1ffffff 64bit pref]
[   18.052603] pci 0000:29:00.0: PCI bridge to [bus 2a-4a]
[   18.052867] pci 0000:29:00.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[   18.053127] pci 0000:29:00.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[   18.053399] pcieport 0000:04:04.0: PCI bridge to [bus 29-4a]
[   18.053660] pcieport 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[   18.053928] pcieport 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[   18.054219] pcieport 0000:29:00.0: enabling device (0000 -> 0002)
[   18.054806] pcieport 0000:2a:00.0: enabling device (0000 -> 0002)
[   18.055483] pcieport 0000:2a:01.0: enabling device (0000 -> 0002)
[   18.056066] pcieport 0000:2a:02.0: enabling device (0000 -> 0002)
[   18.056666] pcieport 0000:2a:04.0: enabling device (0000 -> 0002)
[   18.056983] pcieport 0000:2a:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   18.057480] pcieport 0000:2a:05.0: enabling device (0000 -> 0002)
[   18.057843] pcieport 0000:2a:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   18.058357] pcieport 0000:2b:00.0: enabling device (0000 -> 0002)
[   18.058711] pcieport 0000:2c:03.0: enabling device (0000 -> 0002)
[   18.059105] pci 0000:2d:00.0: MSI is not implemented on this device, disabling it
[   18.059373] pci 0000:2d:00.0: PME# is unreliable, disabling it
[   18.059655] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[   18.060033] ohci-pci 0000:2d:00.0: OHCI PCI host controller
[   18.060302] ohci-pci 0000:2d:00.0: new USB bus registered, assigned bus number 9
[   18.060599] ohci-pci 0000:2d:00.0: irq 121, io mem 0xdf000000
[   18.140704] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
[   18.141025] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.141337] usb usb9: Product: OHCI PCI host controller
[   18.141613] usb usb9: Manufacturer: Linux 5.19.0+ ohci_hcd
[   18.141885] usb usb9: SerialNumber: 0000:2d:00.0
[   18.142263] hub 9-0:1.0: USB hub found
[   18.142643] hub 9-0:1.0: 2 ports detected
[   18.143255] pci 0000:2d:00.1: MSI is not implemented on this device, disabling it
[   18.143685] pci 0000:2d:00.1: PME# is unreliable, disabling it
[   18.144117] pci 0000:2d:00.1: enabling device (0000 -> 0002)
[   18.144750] ohci-pci 0000:2d:00.1: OHCI PCI host controller
[   18.145156] ohci-pci 0000:2d:00.1: new USB bus registered, assigned bus number 10
[   18.145458] ohci-pci 0000:2d:00.1: irq 25, io mem 0xdf001000
[   18.210950] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
[   18.211277] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.211573] usb usb10: Product: OHCI PCI host controller
[   18.211850] usb usb10: Manufacturer: Linux 5.19.0+ ohci_hcd
[   18.212128] usb usb10: SerialNumber: 0000:2d:00.1
[   18.212538] hub 10-0:1.0: USB hub found
[   18.212915] hub 10-0:1.0: 2 ports detected
[   18.213482] pci 0000:2d:00.2: MSI is not implemented on this device, disabling it
[   18.213922] pci 0000:2d:00.2: PME# is unreliable, disabling it
[   18.214589] pci 0000:2d:00.2: enabling device (0000 -> 0002)
[   18.215096] pci 0000:2d:00.2: EHCI: unrecognized capability 00
[   18.215612] ehci-pci 0000:2d:00.2: EHCI Host Controller
[   18.216020] ehci-pci 0000:2d:00.2: new USB bus registered, assigned bus number 11
[   18.216389] ehci-pci 0000:2d:00.2: irq 50, io mem 0xdf002000
[   18.256869] ehci-pci 0000:2d:00.2: USB 2.0 started, EHCI 1.00
[   18.257239] usb usb11: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[   18.257549] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.257836] usb usb11: Product: EHCI Host Controller
[   18.258119] usb usb11: Manufacturer: Linux 5.19.0+ ehci_hcd
[   18.258402] usb usb11: SerialNumber: 0000:2d:00.2
[   18.258786] hub 11-0:1.0: USB hub found
[   18.259161] hub 11-0:1.0: 4 ports detected
[   18.376744] hub 9-0:1.0: USB hub found
[   18.377244] hub 9-0:1.0: 2 ports detected
[   18.496900] hub 10-0:1.0: USB hub found
[   18.497394] hub 10-0:1.0: 2 ports detected
[   18.497765] tg3 0000:2e:00.0: enabling device (0000 -> 0002)
[   18.550464] tg3 0000:2e:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[   18.550831] tg3 0000:2e:00.0 eth2: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   18.551119] tg3 0000:2e:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   18.551407] tg3 0000:2e:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   18.551924] pcieport 0000:30:00.0: enabling device (0000 -> 0002)
[   18.552751] tg3 0000:2e:00.0 eth4: renamed from eth2
[   18.552753] pcieport 0000:31:00.0: enabling device (0000 -> 0002)
[   18.553875] pcieport 0000:31:01.0: enabling device (0000 -> 0002)
[   18.554559] pcieport 0000:31:02.0: enabling device (0000 -> 0002)
[   18.555232] pcieport 0000:31:04.0: enabling device (0000 -> 0002)
[   18.555613] pcieport 0000:31:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   18.556271] pcieport 0000:31:05.0: enabling device (0000 -> 0002)
[   18.556707] pcieport 0000:31:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   18.557016] usb 11-1: new high-speed USB device number 2 using ehci-pci
[   18.557639] pcieport 0000:32:00.0: enabling device (0000 -> 0002)
[   18.558037] pcieport 0000:33:03.0: enabling device (0000 -> 0002)
[   18.558513] pci 0000:34:00.0: MSI is not implemented on this device, disabling it
[   18.558820] pci 0000:34:00.0: PME# is unreliable, disabling it
[   18.559148] pci 0000:34:00.0: enabling device (0000 -> 0002)
[   18.559574] ohci-pci 0000:34:00.0: OHCI PCI host controller
[   18.559885] ohci-pci 0000:34:00.0: new USB bus registered, assigned bus number 12
[   18.560216] ohci-pci 0000:34:00.0: irq 121, io mem 0xdf300000
[   18.630739] usb usb12: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
[   18.631102] usb usb12: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.631450] usb usb12: Product: OHCI PCI host controller
[   18.631756] usb usb12: Manufacturer: Linux 5.19.0+ ohci_hcd
[   18.632062] usb usb12: SerialNumber: 0000:34:00.0
[   18.632483] hub 12-0:1.0: USB hub found
[   18.632807] hub 12-0:1.0: 2 ports detected
[   18.633206] pci 0000:34:00.1: MSI is not implemented on this device, disabling it
[   18.633523] pci 0000:34:00.1: PME# is unreliable, disabling it
[   18.633859] pci 0000:34:00.1: enabling device (0000 -> 0002)
[   18.634333] ohci-pci 0000:34:00.1: OHCI PCI host controller
[   18.634676] ohci-pci 0000:34:00.1: new USB bus registered, assigned bus number 13
[   18.635007] ohci-pci 0000:34:00.1: irq 25, io mem 0xdf301000
[   18.700956] usb usb13: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
[   18.701327] usb usb13: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.701656] usb usb13: Product: OHCI PCI host controller
[   18.701974] usb usb13: Manufacturer: Linux 5.19.0+ ohci_hcd
[   18.702285] usb usb13: SerialNumber: 0000:34:00.1
[   18.702733] hub 13-0:1.0: USB hub found
[   18.703152] hub 13-0:1.0: 2 ports detected
[   18.703777] pci 0000:34:00.2: MSI is not implemented on this device, disabling it
[   18.704252] pci 0000:34:00.2: PME# is unreliable, disabling it
[   18.704736] pci 0000:34:00.2: enabling device (0000 -> 0002)
[   18.705298] pci 0000:34:00.2: EHCI: unrecognized capability 00
[   18.705947] ehci-pci 0000:34:00.2: EHCI Host Controller
[   18.706393] ehci-pci 0000:34:00.2: new USB bus registered, assigned bus number 14
[   18.706850] ehci-pci 0000:34:00.2: irq 50, io mem 0xdf302000
[   18.746856] ehci-pci 0000:34:00.2: USB 2.0 started, EHCI 1.00
[   18.747243] usb usb14: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[   18.747569] usb usb14: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   18.747868] usb usb14: Product: EHCI Host Controller
[   18.748165] usb usb14: Manufacturer: Linux 5.19.0+ ehci_hcd
[   18.748461] usb usb14: SerialNumber: 0000:34:00.2
[   18.748861] hub 14-0:1.0: USB hub found
[   18.749261] hub 14-0:1.0: 4 ports detected
[   18.777325] usb 11-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[   18.777650] usb 11-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   18.778225] hub 11-1:1.0: USB hub found
[   18.779037] hub 11-1:1.0: 7 ports detected
[   18.866960] hub 12-0:1.0: USB hub found
[   18.867505] hub 12-0:1.0: 2 ports detected
[   18.996921] hub 13-0:1.0: USB hub found
[   18.997464] hub 13-0:1.0: 2 ports detected
[   18.997861] tg3 0000:35:00.0: enabling device (0000 -> 0002)
[   19.046635] usb 14-1: new high-speed USB device number 2 using ehci-pci
[   19.078200] tg3 0000:35:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address 38:c9:86:48:0c:c8
[   19.078608] tg3 0000:35:00.0 eth2: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   19.078914] tg3 0000:35:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   19.079216] tg3 0000:35:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   19.079637] tg3 0000:35:00.0 eth3: renamed from eth2
[   19.096639] usb 11-1.4: new full-speed USB device number 3 using ehci-pci
[   19.257530] usb 14-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[   19.257918] usb 14-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   19.258547] hub 14-1:1.0: USB hub found
[   19.259138] hub 14-1:1.0: 7 ports detected
[   19.266473] usb 11-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[   19.266853] usb 11-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   19.267205] usb 11-1.4: Product: Display Audio
[   19.267545] usb 11-1.4: Manufacturer: Apple Inc.
[   19.267849] usb 11-1.4: SerialNumber: 152303D9
[   19.279301] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:02.1/0000:01:00.2/0000:02:00.0/0000:03:00.0/0000:04:04.0/0000:29:00.0/0000:2a:00.0/0000:2b:00.0/0000:2c:03.0/0000:2d:00.2/usb11/11-1/11-1.4/11-1.4:1.3/0003:05AC:1107.0005/input/input17
[   19.279876] hid-generic 0003:05AC:1107.0005: input,hidraw4: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:2d:00.2-1.4/input3
[   19.310229] usb 11-1.4: 1:1: cannot get freq at ep 0x4
[   19.386808] usb 11-1.5: new high-speed USB device number 4 using ehci-pci
[   19.478257] usb 11-1.4: 1:2: cannot get freq at ep 0x4
[   19.486270] usb 11-1.4: 2:1: cannot get freq at ep 0x84
[   19.524313] usb 11-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   19.524706] usb 11-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   19.555080] usb 11-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[   19.555479] usb 11-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   19.555817] usb 11-1.5: Product: FaceTime HD Camera (Display)
[   19.556146] usb 11-1.5: Manufacturer: Apple Inc.
[   19.556473] usb 11-1.5: SerialNumber: CCGB690CKUDJ9DFX
[   19.559272] usb 11-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   19.559655] usb 11-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   19.560181] usbcore: registered new interface driver snd-usb-audio
[   19.586808] usb 14-1.4: new full-speed USB device number 3 using ehci-pci
[   19.747708] usb 14-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[   19.748104] usb 14-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   19.748484] usb 14-1.4: Product: Display Audio
[   19.748815] usb 14-1.4: Manufacturer: Apple Inc.
[   19.749133] usb 14-1.4: SerialNumber: 1A0E0738
[   19.763202] usb 14-1.4: 1:1: cannot get freq at ep 0x4
[   19.796835] usb 11-1.7: new full-speed USB device number 5 using ehci-pci
[   19.931378] usb 14-1.4: 1:2: cannot get freq at ep 0x4
[   19.939377] usb 14-1.4: 2:1: cannot get freq at ep 0x84
[   19.949423] usb 11-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.37
[   19.949834] usb 11-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   19.950191] usb 11-1.7: Product: Apple Thunderbolt Display
[   19.950512] usb 11-1.7: Manufacturer: Apple Inc.
[   19.950829] usb 11-1.7: SerialNumber: 152303D9
[   19.952950] hid-generic 0003:05AC:9227.0006: hiddev97,hidraw5: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:2d:00.2-1.7/input0
[   19.977296] usb 14-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   19.977684] usb 14-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   20.014395] usb 14-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   20.014785] usb 14-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   20.026203] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:02.1/0000:01:00.2/0000:02:00.0/0000:03:00.0/0000:04:04.0/0000:29:00.0/0000:2a:04.0/0000:30:00.0/0000:31:00.0/0000:32:00.0/0000:33:03.0/0000:34:00.2/usb14/14-1/14-1.4/14-1.4:1.3/0003:05AC:1107.0007/input/input18
[   20.026691] hid-generic 0003:05AC:1107.0007: input,hidraw6: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:34:00.2-1.4/input3
[   20.126671] usb 14-1.5: new high-speed USB device number 4 using ehci-pci
[   20.293789] usb 14-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[   20.294210] usb 14-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   20.294606] usb 14-1.5: Product: FaceTime HD Camera (Display)
[   20.294961] usb 14-1.5: Manufacturer: Apple Inc.
[   20.295313] usb 14-1.5: SerialNumber: CC2G3101FFDJ9FLP
[   20.491973] EXT4-fs (dm-0): re-mounted. Quota mode: none.
[   20.526641] usb 14-1.7: new full-speed USB device number 5 using ehci-pci
[   20.688756] usb 14-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.39
[   20.689146] usb 14-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   20.689516] usb 14-1.7: Product: Apple Thunderbolt Display
[   20.689889] usb 14-1.7: Manufacturer: Apple Inc.
[   20.690258] usb 14-1.7: SerialNumber: 1A0E0738
[   20.692364] hid-generic 0003:05AC:9227.0008: hiddev98,hidraw7: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:34:00.2-1.7/input0
[   20.792902] it87: loading out-of-tree module taints kernel.
[   20.793581] it87: it87 driver version v1.0-48-g40bec4b
[   20.794018] it87: Found IT8688E chip at 0xa40, revision 1
[   20.794438] it87: Beeping is supported
[   20.794840] ACPI Warning: SystemIO range 0x0000000000000A45-0x0000000000000A46 conflicts with OpRegion 0x0000000000000A45-0x0000000000000A46 (\GSA1.SIO1) (20220331/utaddress-204)
[   20.795241] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   20.795638] ACPI: OSL: Resource conflict: System may be unstable or behave erratically
[   20.796779] it87: Found IT8792E/IT8795E chip at 0xa60, revision 3
[   20.797204] it87: Beeping is supported
[   20.799461] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Quota mode: none.
[   20.804412] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Quota mode: none.
[   20.813458] Adding 134217724k swap on /dev/mapper/swap.  Priority:-2 extents:1 across:134217724k SS
[   20.905600] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   20.907623] br1: port 1(eth0) entered blocking state
[   20.908121] br1: port 1(eth0) entered disabled state
[   20.908609] device eth0 entered promiscuous mode
[   20.985378] br1: port 2(eth1) entered blocking state
[   20.985849] br1: port 2(eth1) entered disabled state
[   20.986360] device eth1 entered promiscuous mode
[   21.026874] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-4e00:00: attached PHY driver (mii_bus:phy_addr=r8169-0-4e00:00, irq=MAC)
[   21.306992] r8169 0000:4e:00.0 eth1: Link is Down
[   21.330810] NET: Registered PF_PACKET protocol family
[   24.151289] r8169 0000:4e:00.0 eth1: Link is Up - 1Gbps/Full - flow control off
[   24.151758] br1: port 2(eth1) entered blocking state
[   24.152156] br1: port 2(eth1) entered forwarding state
[   26.479169] RPC: Registered named UNIX socket transport module.
[   26.479573] RPC: Registered udp transport module.
[   26.479969] RPC: Registered tcp transport module.
[   26.480360] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   26.483077] FS-Cache: Loaded
[   26.501063] Key type dns_resolver registered
[   26.504228] NFS: Registering the id_resolver key type
[   26.504621] Key type id_resolver registered
[   26.505004] Key type id_legacy registered

Regards,
Brad
