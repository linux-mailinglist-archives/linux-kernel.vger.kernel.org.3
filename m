Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADC58C965
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbiHHN1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiHHN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:27:33 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999B06362
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:27:31 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oL2n3-00041L-Ej; Mon, 08 Aug 2022 23:27:29 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uYDRQa7gCEqvAQfhuSDQN5OR2N3kUZJKAVzOQka17Qo=; b=IOch8p+iTXqVx1TUcT+SGE9Jis
        t0PykPLfDqu2D2o6ksrKWAc6eqRvrJobBpD/SWPEGqL6xEHsVmF4pREjD1PKfByFXMxwAUfvcpxsV
        h/Y6+x4kZPxDL1EKoS0B5ofNH5gSKilL1FeWappH7RxBHEFIV1MXDMxxHmZn9J4rXmsk=;
Message-ID: <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
Date:   Mon, 8 Aug 2022 21:27:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
 <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
 <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
 <Yu4Gmkous7asng6h@lahna>
 <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
 <YvDcudE5BRtZAtfM@lahna>
 <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
 <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
 <YvEFtPF7SBIwNG/o@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YvEFtPF7SBIwNG/o@lahna>
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

On 8/8/22 20:46, Mika Westerberg wrote:
> On Mon, Aug 08, 2022 at 08:25:56PM +0800, Brad Campbell wrote:
>> root@bkd:/sys/bus/pci/devices/0000:31:04.0# modprobe thunderbolt
>> root@bkd:/sys/bus/pci/devices/0000:31:04.0# time cat config | hexdump
>>
>> <slowdown/lockup/reboot>
>>
>> This on the serial console : 
>> [  160.248275] ACPI: bus type thunderbolt registered
>> [  160.253386] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
>> [  160.872438] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
>> [  160.879398] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
>> [  161.436984] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
>> [  161.444108] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
>> [  165.324982] hrtimer: interrupt took 604007930 ns
>> [  169.744439] xhci_hcd 0000:28:00.0: Unable to change power state from D3hot to D0, device inaccessible
>> [  223.912783] rcu: INFO: rcu_preempt self-detected stall on CPU
>> [  229.741463] rcu:     9-....: (126 ticks this GP) idle=0d44/1/0x4000000000000000 softirq=1935/1935 fqs=76
>> [  237.593512]  (t=7349 jiffies g=1537 q=264 ncpus=12)
>> [  242.425503] NMI backtrace for cpu 9
>> [  244.640203] CPU: 9 PID: 57 Comm: ksoftirqd/9 Tainted: G           O       5.19.0+ #57
>> [  251.082940] Hardware name: Gigabyte Technology Co., Ltd. B550 VISION D-P/B550 VISION D-P, BIOS F15d 07/20/2022
>> [  258.532330] Call Trace:
>> [  260.545693]  <IRQ>
>> [  262.156386]  dump_stack_lvl+0x34/0x44
>> [  264.985085]  nmi_cpu_backtrace.cold+0x30/0x70
>> [  268.800445]  ? lapic_can_unplug_cpu+0x90/0x90
>> [  273.028459]  nmi_trig
> 
> Yeah, the link (PCIe tunnel) seems not to be functional and that causes
> the hang. In addition to what I asked in my previous email, let's block
> runtime PM from xHCI too in drivers/usb/host/xhci-pci.c::xhci_pci_quirks():
> 
> Comment out this block:
> 
>         if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
>             (pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI ||
>              pdev->device == PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI))
>                 xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> 

No change I'm afraid.

For completness, the current diff is :
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..9250a3f50d90 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2989,6 +2989,7 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
+#if 0
 	if (!pci_is_pcie(bridge))
 		return false;
 
@@ -3036,8 +3037,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return true;
 		break;
 	}
-
+#else
 	return false;
+#endif
 }
 
 static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 9853f6c7e81d..c40f9a91a379 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -886,7 +886,7 @@ static void tb_tunnel_dp(struct tb *tb)
 	struct tb_cm *tcm = tb_priv(tb);
 	struct tb_port *port, *in, *out;
 	struct tb_tunnel *tunnel;
-
+	return;
 	if (!tb_acpi_may_tunnel_dp()) {
 		tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
 		return;
@@ -1712,6 +1712,10 @@ static void tb_apple_add_links(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		break;
 	default:
 		return;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d34..dd3af1b2554e 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -256,7 +256,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_DNV_XHCI))
 		xhci->quirks |= XHCI_MISSING_CAS;
-
+/*
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI ||
@@ -275,7 +275,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-
+*/
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ168) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;



[  148.322958] ACPI: bus type thunderbolt registered
[  148.327725] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[  148.947310] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[  148.953997] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[  149.511086] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[  149.517878] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[  167.598661] hrtimer: interrupt took 604001513 ns
[  167.598661] hrtimer: interrupt took 604001513 ns
[  167.598661] hrtimer: interrupt took 604001513 ns

Those last 3 lines come out at about 2 characters per second.
Something happens in the kernel that causes console input and output to slow to a crawl
then it eventually reboots. Tried it with tg3 & usb drivers loaded, and unloaded.

The peculiar thing is this only happens after the thunderbolt module is loaded when the tunnels
are already established. If I don't load the thunderbolt module it all works perfectly.

My workaround is to blacklist the module. In the boot scripts it looks for the thunderbolt displays
If it can't find them it loads the module, authorizes the devices and reboots. When it reboots 
it doesn't load the module and everything works perfectly.

If I don't authorize the PCIe tunnels and just leave the DP enabled it works fine also.

Regards,
Brad
