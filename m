Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442025A53A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiH2R7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiH2R7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:59:32 -0400
Received: from sonic309-24.consmr.mail.ne1.yahoo.com (sonic309-24.consmr.mail.ne1.yahoo.com [66.163.184.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02077EFDE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1661795968; bh=km3EQikX5QAf4KT+pnBjVR4g+LLFzLO4yBO9CXgPoq0=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=xklo32VtfpCb0iRysN1nqEm/NiBIA9KmDLu4QGCBX38ScEuQmA4qaak5D9T/aWelJ6gous/rU0ZoGm5ymgTffU5VrCnNMWE9s4Er4EzzkeC/RTZQGx/Mndoku24N5SVIBLzsjncJ0RA2qNIylA+HmPPi4ipIPpBJ4d256xhMPpU=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661795968; bh=hj25Vfx3EQ3kK+mWaVeb/uJkS2rHeQ3TCcXaGgqlY5J=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=ZCuxNgwCnck37AIuHvpXUxYFNC5SIH1FQrNoRHkunGrFn4pffeVom4rdqdaL0AZoMbTIVdiq0Ia/HcI8IUVv55243gL931BHf20VAW874AflCj6Sy6mVJnCYBwa+jQDHRc9wuvN0io4WvJGxCFRg3GuRW3zG4t9Cqqk6jytLn5dkpAnClXiVKjvc3IsdMGmUq5JSkeUksW9n2ifwNYMdwD6z6SzYEnffju5rQQBqieiaYM+qRYnaueCfsQ8EC/CJn2QVhdUw9J2QVY+Cx33p9eUK4AuUQYsO9yq4B9VQOyXD+DkITlJfrVBIBSyB8eZKzzIZFHKcjpYVDDpZ9rM/nA==
X-YMail-OSG: HZ2hpyAVM1khbYdGe99NtfmCKMJVPn0A1GxTDyRKptE58nUIJdX2CA0_tlJDx6D
 qNpKskDxenapRPMjVCvmNnut.izwqVvRkd_b8OgORxsBwWWJqx0BcFVo5zJXeQnjaUc_U9EAbMMs
 5TKKeLD7BbdHHtdRrKOhXmWQvZnw6FicmCD8bwcEzYmN5zZ7hOidJeCmJHt86FelwbGPwwSljLDu
 ufPaXUEBJdODVNfuCigkZWNImZxQKf8wzzXbLDQGA7yjY2Z4R.SYpzxV6m__1fTy0YeK6Vfwx3fO
 C6ZbbmZVRw1GGEO3syWoz_L8sHFY90kOMEJhMLilYk5H1psHJgcvgVr2j9dx.CJC0p1_iy.pW_lw
 4IzH_nmzIUH2jHwoMnCLUFDSiDPpYM.M8VPOxz.2sRGtw3nVvi41WdJbOX43fEE3U2SMcq6htyyQ
 0PiN7CiHGp5MbySFaQgoIA0Jvqnu6mY3PuEF2dw6z2kXmot3QTIRWqXdNqFDla3kXLsZa9q_8cse
 suKebX4OlkI6pVC_O4alrn02HNtcRPukV5y5ISp9wN_6lp15sePO4MKq2j8_6iyL5MipawCgQJN4
 aWxbBqFeSl3nBjnaws43DFCtBNttaUg4K.ot2CuED6PNtexbVzt0G8hPhNAKQhXKds17A6Rj_mUV
 TzVjHVfw6JTPXK8ot4NH54L4EzGpJzyiW3KzEyfZBh_KpWJtUbmVE7KgAbn6IYoJmFcmmiv2DyVv
 5nfVobbRIH1da1k7y6EgTFCUBAiMGMQJoiN3EDB7UWGw596KU6BUIAIYLERgJNAo2WzPMbGP4JVU
 spkG1zHUivePrUOHXQVW9DIpmo1bdi78GdZwgthJOlJl.UMWS3woBobldOc4CNP4wj.V3seJsZgZ
 hBehsx4mnIfVZqp7PmvZ15PxVrrjPWCxxTAa4sJq1BVYH9vlUaDMghf3DLA.MMsDQjwYNrNfESWL
 ClN9yZR7YbfNRHAq3U4BU.F2CLfo2jffIyaWOsGjOBnWd5t2qlL33qnPs2Q4vk04YdDRXeu6Bj2m
 3m66_E1GhuaBXyuWiCACBhe42XJJldU7YTl8ip8WkAcv17rFyGXsZP0aBe8kc9gs26bW3eo0RYuE
 1TswquOCFaTYROhryPASRzAXDxHPGlPVJ9TgPyBo0WNBZM84pqC51gKbmzmIegHsK3KFw8wExmE8
 oOayFareTJCzeZk6VdM4h68mTpDwZ1NyynWIJFCdIOqYebmmVyQGDTnlfVSFWRk8Uge4r9du_zOr
 uQ0yys9.hcsQ1GVf.zdqX1enL2NwgY5ILk3r0nHunUKvSn.6IP3lyxL5ibVoGZYbCc5WStMqCInV
 2c.yhwNokLedXugJ65ZTlNZS2MwDSyP6LZawBhgVV4sEbKCN1k4F7CJPDxqeQ0Z3KH.RGqBiZifd
 1W9mCVL9hMuBoKA0411hrLRPBUkrpBxBR1PdLEKqenaJmeRw7Vam7wGzU5B0VLS4YcWf1j_jk6ge
 B5nlUMtUYkrkOsrVq8Yt1L6LFQb344CNDBtosqC0oBJZumUjYgvy51Qn6WfMp8bwmUIR.9QAFXuU
 08uFIrFES1tzFQZ74Rpd7bi07NRCMQw_hugUWDBCTQJY2S.LGQCbhSWuEZdQIYFH2JttLr3oUVYn
 1yL0qcD_oONBQgrDCUso6TgTVSpp5r3yc6fcZ2IgtKAl9GdU1MKPQhO55IYFkDyyAlJltWN8Vn7E
 KgvqS1BozmAg13jtnoybe_NvxYlugzdMq4o.47HgUYll2IPIgDNTYqHnY3V6WezXSLFTPznZhQRU
 GLzU8M6iVPRWkVwRCkNmJH5gzapqvgkgKuz0i9YZHHmPBDbYKJC98yS2fL0RvORDHDO9EqatXiiN
 SM9TUQt1fsK5ln_s0ZPlC6CqKfy9p9r380t39kZ.K2_fLIZhHG34qnk16A83DEAFJfbnkuS8eg4V
 sBRSfgXjTzMqYnw9.ZenIx0Pf8oCVjaDLvNjBRnxD0r2jz0q5XjDdJ6_NbwzSCuJG73h9BoRX_0_
 7XbQJNWlv8MTFYvKu4YirfFexAkdYnI6z.yo_XA3uQLMPQfKq2L6X4duw.x_bReKg_FJYiaWMBON
 ZukC0RpZYta4K1EeSFcOKOJ_EZJicgE13SdovNJBnobMbFI_4SaJEKg3stxGOD6ZwzgiXwrYJheX
 iZPlM5NWKxBPwCAsrmdBH14prNs2z2MBLITBINDEAiqfw6t92Ga1um018DS6qhibFu0ETQEmQItN
 GXCEFWob99cR6
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 29 Aug 2022 17:59:28 +0000
Received: by hermes--production-ne1-6649c47445-vq89d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 856e2a54241f87de2e2d96a9b700da3b;
          Mon, 29 Aug 2022 17:59:24 +0000 (UTC)
Date:   Mon, 29 Aug 2022 13:59:17 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: pcieport bug?
To:     linux-kernel@vger.kernel.org
Message-Id: <TY1EHR.8720BA9PHAKY2@att.net>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <TY1EHR.8720BA9PHAKY2.ref@att.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Building a kernel tailored for AMD 2400g on ASRock B450 using 5.18.12 
as base, OS
is Elementary 6.1 on top of Ubuntu 20.04.5.
In a config I changed some which lead to this query,'cause not sure 
what it means.
So up to you see if it is of concern. Notation igpu# refers to build 
sequence tests.
Also note that pcieport may affect other drivers?

config differences
igpu33
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_IOV is not set
# CONFIG_VGA_ARB is not set
# CONFIG_HOTPLUG_PCI is not set
igpu32
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_IOV=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
# CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
CONFIG_HOTPLUG_PCI_SHPC=y
# CONFIG_RAPIDIO_TSI721 is not set
# CONFIG_EEEPC_LAPTOP is not set

lspci differences:
start with identical:
00:00.0 Host bridge
00:00.2 IOMMU
00:01.0 Host bridge

kernel builds after igpu33 stable flags, only irq differences
kernel builds upto igpu32 flags differ including non-pcieport drivers,
there was a few builds where flags matched out of 32 different builds
I thought was normal that flags changed prior to 33-37 being very 
stable.

under 00:01.1 PCI bridge:
igpu33
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
  Address: 0000000000000000 Data: 0000
RootCmd: CERptEn- NFERptEn- FERptEn-

igpu32
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
Interrupt: pin ? routed to IRQ 26
DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
  Address: 00000000fee00000 Data: 0000
RootCmd: CERptEn+ NFERptEn+ FERptEn+
Kernel driver in use: pcieport

under these, nearly same readout as above (32vs33 use of pcieport)
00:01.6 PCI bridge
00:08.1 PCI bridge
00:08.2 PCI bridge
11:01.0 PCI bridge
11:02.0 PCI bridge
15:00.2 PCI bridge
1d:00.0 PCI bridge
1d:01.0 PCI bridge
1d:04.0 PCI bridge
1d:05.0 PCI bridge
1d:06.0 PCI bridge
1d:07.0 PCI bridge

on non-pcieport drivers minor differences in +- states
on nvme added line:
Physical Slot: 0
but +- state can change like others

dmesg differences (alphabetical):
igu33
acpi PNP0A08:00: PCIe port services disabled; not requesting _OSC 
control
igpu32
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER 
PCIeCapability]
acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
amdgpu 0000:38:00.0: vgaarb: deactivate vga console
pci 0000:38:00.0: vgaarb: bridge control possible
pci 0000:38:00.0: vgaarb: setting as boot VGA device
pci 0000:38:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
pcieport 0000:00:01.1: AER: enabled with IRQ 26
pcieport 0000:00:01.1: PME: Signaling with IRQ 26
pcieport 0000:00:01.2: AER: enabled with IRQ 27
pcieport 0000:00:01.2: PME: Signaling with IRQ 27
pcieport 0000:00:01.6: AER: enabled with IRQ 28
pcieport 0000:00:01.6: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- 
PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
pcieport 0000:00:01.6: PME: Signaling with IRQ 28
pcieport 0000:00:08.1: PME: Signaling with IRQ 29
pcieport 0000:00:08.2: PME: Signaling with IRQ 30
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
vgaarb: loaded

Steve

I wish to be personally CC'ed the answers/comments posted to the list
in response to your posting, please.






