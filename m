Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA4575BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiGOGly convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Jul 2022 02:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiGOGlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:41:21 -0400
X-Greylist: delayed 73113 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 23:39:37 PDT
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7779694
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:39:36 -0700 (PDT)
X-QQ-mid: bizesmtp67t1657867148tcz5m1uz
Received: from smtpclient.apple ( [111.193.9.146])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 15 Jul 2022 14:39:06 +0800 (CST)
X-QQ-SSF: 01400000002000B0U000000A0000000
X-QQ-FEAT: uy3crRmYRWU+wcp35XTR3jXFtYH7pvQ6o2RBeTgVe+6DFnchz8rR0uaBAkNqe
        GEkQBF3ozDQZn4WnCNEnnGhCcKyVGbzoZshTNJ4fZhoK10L1/i7kkt6TDWDuSAz/24B7lmw
        nzNkFPHQ6svcZXViXT1KO/bGMYp4dqw2l8HrLFAlhX7Z4rvTZc3e17vCAheFN7QrCmh7MSE
        rmJ72lFtqo4nybUcB0u6LP++LO1YD4ShDasxPBiUepwpyoYEmAMGC3EQq6S8XYxv2LwlsBT
        xkpZ7B/GIBD+jrZH8WNq/41Px8OB2ZrsILAkk1y1/nxpm2VglqkrVwX/aj/ERZswOGdGZn8
        4Wo1o85eLZsEwwsoLLD1Kfhv3ztNEDm18uvW1CGAzjUiad8KHHW+ctG9rXvgpkLcYr9wnYh
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] USB: serial: option: adding support for OPPO R11 diag
 port
From:   sdlyyxy <sdlyyxy@bupt.edu.cn>
In-Reply-To: <Ys/2dN9ktCirZsd9@kroah.com>
Date:   Fri, 15 Jul 2022 14:39:06 +0800
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5F187A64-2C88-4F7E-98AD-2A52B17B0DA4@bupt.edu.cn>
References: <20220714102037.4113889-1-sdlyyxy@bupt.edu.cn>
 <Ys/2dN9ktCirZsd9@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Thanks for your comments!

> On Jul 14, 2022, at 18:56, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Thu, Jul 14, 2022 at 06:20:37PM +0800, sdlyyxy wrote:
>> From: Yan Xinyu <sdlyyxy@bupt.edu.cn>
>> 
>> This patch adds support for OPPO R11 USB diag serial port to option
>> driver. This phone uses Qualcomm Snapdragon 660 SoC.
>> 
>> usb-devices output:
>> T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
>> D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
>> P: Vendor=22d9 ProdID=276c Rev=04.04
>> S: Manufacturer=OPPO
>> S: Product=SDM660-MTP _SN:09C6BCA7
>> S: SerialNumber=beb2c403
>> C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
>> I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> 
> I do not think this has an option usb-serial chip in the device, this is
> a phone with a debug port instead.
> 
Yeah, this phone uses a Qualcomm chip, not an option usb-serial chip.
It has the functionality to enter into a special mode, which provides 
a QCDM-capable diag port as the same behaviour of USB modems. For
Qualcomm devices, there are several drivers: qcserial, qcaux, and 
option. According to qcserial.c, qcaux.c source code and mailing list
conversations [1], this device with diag+adb layout should be driven
by option.
>> I: If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> 
> What userspace program is bound to this endpoint?
> 
I think it is used by adb via libusb.
>> 
>> Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
>> ---
>> drivers/usb/serial/option.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
>> index de59fa919540..cf65cb84c3ca 100644
>> --- a/drivers/usb/serial/option.c
>> +++ b/drivers/usb/serial/option.c
>> @@ -573,6 +573,10 @@ static void option_instat_callback(struct urb *urb);
>> #define WETELECOM_PRODUCT_6802			0x6802
>> #define WETELECOM_PRODUCT_WMD300		0x6803
>> 
>> +/* OPPO products */
>> +#define OPPO_VENDOR_ID				0x22d9
>> +#define OPPO_PRODUCT_R11			0x276c
>> +
>> 
>> /* Device flags */
>> 
>> @@ -2155,6 +2159,7 @@ static const struct usb_device_id option_ids[] = {
>> 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>> 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
>> 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
>> +	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
> 
> This does not look correct, sorry. Try using the usbserial generic
> driver instead to transmit and recieve?
> 
Yes I have tried using usbserial generic driver. As for the interface
#0x0 diag port, it seems working. However, in the same time the 
generic driver will also be attached to interface #0x1, which causes
nonfunction of adb. Using this patch, diag and adb can run 
simultaneously. So it's better than the generic driver?

[1] https://patchwork.kernel.org/project/linux-usb/patch/20180623212408.15221-1-aleksander@aleksander.es/

Thanks,
Sdlyyxy



