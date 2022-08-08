Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6144258C890
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiHHMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiHHMqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:46:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DDB89
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659962809; x=1691498809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1QQN37SW5TKRIe0Qa5jVXRJ+/zLpgMiFHSZHCPN/xUA=;
  b=TNx9wTjWCG6RAcqxOIe/bJFiQVMebCxxJ9McUvkTCDWNgb0ixsoA9yVH
   ygk71sSU3NqJqX9JEt+rZA9JKl9Fmh4sfW/fPCzVp5pYn1eBDTfRwEfh1
   OBBL4dDrz5qIPsXhWUwNhlTwCS2M/uSKcPT1/+WBrxCrfTAXK400AJm31
   fhmHPNOiyH7RM+14KUJXiPzu7Ke3Hah3xJn28lNapX8Qai45PYPZ7rtV9
   QW71upv63lqrbeFjd3wew5ui1RfYHbh1vIPobTNF2k6zXnPT5lECB2yIH
   D7tlzTzMWWnMW+7HB35Z0Nr3rYi9fC4YbprOwD7vj6LCP0zWe/tWyfF80
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="288146392"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="288146392"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 05:46:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="604352508"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 05:46:47 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 08 Aug 2022 15:46:44 +0300
Date:   Mon, 8 Aug 2022 15:46:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvEFtPF7SBIwNG/o@lahna>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 08:25:56PM +0800, Brad Campbell wrote:
> root@bkd:/sys/bus/pci/devices/0000:31:04.0# modprobe thunderbolt
> root@bkd:/sys/bus/pci/devices/0000:31:04.0# time cat config | hexdump
> 
> <slowdown/lockup/reboot>
> 
> This on the serial console : 
> [  160.248275] ACPI: bus type thunderbolt registered
> [  160.253386] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
> [  160.872438] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
> [  160.879398] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
> [  161.436984] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
> [  161.444108] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
> [  165.324982] hrtimer: interrupt took 604007930 ns
> [  169.744439] xhci_hcd 0000:28:00.0: Unable to change power state from D3hot to D0, device inaccessible
> [  223.912783] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  229.741463] rcu:     9-....: (126 ticks this GP) idle=0d44/1/0x4000000000000000 softirq=1935/1935 fqs=76
> [  237.593512]  (t=7349 jiffies g=1537 q=264 ncpus=12)
> [  242.425503] NMI backtrace for cpu 9
> [  244.640203] CPU: 9 PID: 57 Comm: ksoftirqd/9 Tainted: G           O       5.19.0+ #57
> [  251.082940] Hardware name: Gigabyte Technology Co., Ltd. B550 VISION D-P/B550 VISION D-P, BIOS F15d 07/20/2022
> [  258.532330] Call Trace:
> [  260.545693]  <IRQ>
> [  262.156386]  dump_stack_lvl+0x34/0x44
> [  264.985085]  nmi_cpu_backtrace.cold+0x30/0x70
> [  268.800445]  ? lapic_can_unplug_cpu+0x90/0x90
> [  273.028459]  nmi_trig

Yeah, the link (PCIe tunnel) seems not to be functional and that causes
the hang. In addition to what I asked in my previous email, let's block
runtime PM from xHCI too in drivers/usb/host/xhci-pci.c::xhci_pci_quirks():

Comment out this block:

        if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
            (pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI ||
             pdev->device == PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI))
                xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
