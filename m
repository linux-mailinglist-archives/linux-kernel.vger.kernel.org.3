Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045BC51F3E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiEIFiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiEIFeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:34:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2080381A3;
        Sun,  8 May 2022 22:30:26 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nnvyO-0007xl-7n; Mon, 09 May 2022 07:30:20 +0200
Message-ID: <cbf8a730-a169-f2e9-3041-e530dfe42ad6@leemhuis.info>
Date:   Mon, 9 May 2022 07:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: regression v5.13..v5.15: USB hub stopped working -- DMAR fault
 when connected usb hub
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Piotr_Pi=c3=b3rkowski?= <qba100@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
References: <237660ea-794e-8347-4e1a-869ccef9ba3c@leemhuis.info>
In-Reply-To: <237660ea-794e-8347-4e1a-869ccef9ba3c@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1652074227;303e07b4;
X-HE-SMSGID: 1nnvyO-0007xl-7n
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

@kernel developers: you might want to consider ignoring this, the
reporter provided additional information in the ticket and it looks a
lot like it's not a regression. For details see:
https://bugzilla.kernel.org/show_bug.cgi?id=215906#c4

Sorry for the noise.

Ciao, Thorsten

On 05.05.22 15:31, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago. That's why I decided
> to forward it to a few maintainers and mailing lists. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=215906 :
> 
>> Since kernel 5.15 (with kernel 5.13 I see no problem) I have a problem with my USB hub. The device stops working shortly after starting the system.
>> In dmesg log I see DMAR fault on usb controller
>>
>>
>> [kwi27 22:03] usb 5-1.2: new high-speed USB device number 3 using xhci_hcd
>> [  +0,100440] usb 5-1.2: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
>> [  +0,000004] usb 5-1.2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
>> [  +0,000002] usb 5-1.2: Product: USB 2.0 Hub
>> [  +0,001002] hub 5-1.2:1.0: USB hub found
>> [  +0,000133] hub 5-1.2:1.0: 4 ports detected
>> [  +0,702453] usb 5-1.2.2: new full-speed USB device number 4 using xhci_hcd
>> [  +0,471198] usb 5-1.2.2: New USB device found, idVendor=047f, idProduct=c025, bcdDevice= 1.35
>> [  +0,000004] usb 5-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> [  +0,000002] usb 5-1.2.2: Product: Plantronics C320-M
>> [  +0,000001] usb 5-1.2.2: Manufacturer: Plantronics
>> [  +0,000001] usb 5-1.2.2: SerialNumber: B13D8BE491B04E73AEB4C95E162DBE2B
>> [  +0,255862] mc: Linux media interface: v0.10
>> [  +0,001057] input: Plantronics Plantronics C320-M as /devices/pci0000:00/0000:00:1c.5/0000:04:00.0/usb5/5-1/5-1.2/5-1.2.2/5-1.2.2:1.3/0003:047F:C025.0004/input/input21
>> [  +0,060275] plantronics 0003:047F:C025.0004: input,hiddev1,hidraw3: USB HID v1.11 Device [Plantronics Plantronics C320-M] on usb-0000:04:00.0-1.2.2/input3
>> [  +0,859655] usb 5-1.2.2: Warning! Unlikely big volume range (=8192), cval->res is probably wrong.
>> [  +0,000003] usb 5-1.2.2: [11] FU [Sidetone Playback Volume] ch = 1, val = 0/8192/1
>> [  +0,584234] usbcore: registered new interface driver snd-usb-audio
>> [  +0,229229] xhci_hcd 0000:04:00.0: WARNING: Host System Error
>> [  +0,000014] DMAR: DRHD: handling fault status reg 2
>> [  +0,000004] DMAR: [DMA Read NO_PASID] Request device [04:00.0] fault addr 0xfffca000 [fault reason 0x06] PTE Read access is not set
>> [  +0,031993] xhci_hcd 0000:04:00.0: Host halt failed, -110
>> [kwi27 22:04] xhci_hcd 0000:04:00.0: xHCI host not responding to stop endpoint command.
>> [  +0,000003] xhci_hcd 0000:04:00.0: USBSTS: HSE EINT
>> [  +0,032011] xhci_hcd 0000:04:00.0: Host halt failed, -110
>> [  +0,000002] xhci_hcd 0000:04:00.0: xHCI host controller not responding, assume dead
>> [  +0,000017] xhci_hcd 0000:04:00.0: HC died; cleaning up
>> [  +0,000042] usb 5-1: USB disconnect, device number 2
>> [  +0,000003] usb 5-1.2: USB disconnect, device number 3
>> [  +0,000002] usb 5-1.2.2: USB disconnect, device number 4
>> [  +0,000114] usb 5-1.2.2: 1:0: usb_set_interface failed (-110)
>> [  +0,000016] usb 5-1.2.2: 1:1: usb_set_interface failed (-19)
>> [  +0,000011] usb 5-1.2.2: 1:0: usb_set_interface failed (-19)
> See the ticket for details and further comments. According to the latest
> one the problem is still present in 5.18-rc5.
> 
> Was this issue discussed or even addressed somewhere already? Or does
> anyone at least have a good idea what might be causing this problem?
> @reporter: If neither is the case, you most likely will need to perform
> a bisection with git to identify the change causing the problem.
> 
> Anyway, could one of the kernel developers among the recipients please
> help with this? BTW, I was unsure where to send this to the DMA/IOMMU
> maintainers or the USB/xhci maintainers. I settled for the latter; I
> apologize in advance if that was the wrong choice.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I defsdal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
> 
> P.P.S: to get this tracked by the the Linux kernel regression tracking bot:
> 
> #regzbot introduced: v5.13..v5.15
> #regzbot from: Piotr Piórkowski <qba100@gmail.com>
> #regzbot title: usb/dma/iommu/???: USB hub stopped working -- DMAR fault
> when connected usb hub
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215906
> #regzbot monitor:
> https://lore.kernel.org/all/bug-215906-208809@https.bugzilla.kernel.org%2F/
