Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B535784AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiGROC1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jul 2022 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiGROCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:02:25 -0400
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6121A13E8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:02:23 -0700 (PDT)
X-QQ-mid: bizesmtp89t1658152926t3mn2cfa
Received: from smtpclient.apple ( [111.193.9.146])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 22:02:05 +0800 (CST)
X-QQ-SSF: 01400000002000B0V000B00A0000000
X-QQ-FEAT: D6RqbDSxuq5xgiVzKotCrCzg2lhpBA/M9CkNTCFeKshpCf0niC8i016/BezUu
        wVyw/wd8SnwuKY8vO1kksH/HrNXksmEI9repRvvu+UAxozVwKYD5Pl3v6qw4iTKtMr5oInX
        q1FeaC7pOfkOe+R0zapigpx8q7eViSPdWsc+et7kLeBa3bOww2tR32BNQTpX++86YZOjDSd
        HmNS8hdu/fLfeKAxb2SCkDHP21Puh1ZwxYhK0udH5hjhIC6UL3K/Qz/rQxBULAl5mFeFdTE
        wpSIu2D++bsCouEHrYeTpOIe1Z3bVb4EwSs6ngxMr5Xer0eKJlrVzl301sVasrRtxxrMjyF
        B0vFT3KpaNfGODtUAvxzNwwDOpJtaG0ma0lBNWrC89MtW0LPnnbG2OELL5dKT5C2kRiHA6R
        1IEZj7iDj9g=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
From:   Yan Xinyu <sdlyyxy@bupt.edu.cn>
In-Reply-To: <YtQuMJz+0MCxMAPk@arcor.de>
Date:   Mon, 18 Jul 2022 22:02:04 +0800
Cc:     johan@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DA894279-AFBC-45A0-851B-3B6EDACB8581@bupt.edu.cn>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
 <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
 <YtKrbucYNulPEKUp@arcor.de>
 <333E5B85-7534-4CE5-8AB6-464571CBF61E@bupt.edu.cn>
 <YtQuMJz+0MCxMAPk@arcor.de>
To:     Reinhard Speyerer <rspmn@arcor.de>
X-Mailer: Apple Mail (2.3696.100.31)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 17, 2022, at 23:48, Reinhard Speyerer <rspmn@arcor.de> wrote:
> 
> Hi Yan,
> 
> On Sat, Jul 16, 2022 at 09:36:27PM +0800, sdlyyxy wrote:
>> Hi Reinhard,
>> 
>>> On Jul 16, 2022, at 20:13, Reinhard Speyerer <rspmn@arcor.de> wrote:
>>> 
>>> On Fri, Jul 15, 2022 at 10:59:13PM +0800, sdlyyxy wrote:
>>>> 
>>>>> On Jul 15, 2022, at 22:24, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>>>> 
>>>>> The Oppo R11 diagnostic USB connection needs to be bound to the
>>>>> usb-serial-simple driver as it just wants to use a dumb pipe to
>>>>> communicate to the host.
>>>>> 
>>>>> usb-devices output:
>>>>> T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
>>>>> D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
>>>>> P: Vendor=22d9 ProdID=276c Rev=04.04
>>>>> S: Manufacturer=OPPO
>>>>> S: Product=SDM660-MTP _SN:09C6BCA7
>>>>> S: SerialNumber=beb2c403
>>>>> C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
>>>>> I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
>>>>> 
>>>>> Reported-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
>>>>> Cc: Johan Hovold <johan@kernel.org>
>>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> ---
>>>>> drivers/usb/serial/usb-serial-simple.c | 4 +++-
>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
>>>>> index 4c6747889a19..eb832b94aa3a 100644
>>>>> --- a/drivers/usb/serial/usb-serial-simple.c
>>>>> +++ b/drivers/usb/serial/usb-serial-simple.c
>>>>> @@ -60,7 +60,9 @@ DEVICE(flashloader, FLASHLOADER_IDS);
>>>>> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
>>>>> 					USB_CLASS_VENDOR_SPEC,	\
>>>>> 					0x50,			\
>>>>> -					0x01) }
>>>>> +					0x01) },		\
>>>>> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x22d9, 0x276c,		\
>>>>> +					0xff, 0xff, 0x30) }
>>>>> DEVICE(google, GOOGLE_IDS);
>>>>> 
>>>>> /* Libtransistor USB console */
>>>>> -- 
>>>>> 2.37.1
>>>> Tested-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
>>> 
>>> While this may work sufficiently well for real low-volume diag traffic I'd
>>> expect a significant percentage of diag messages to be lost in practice
>>> with the usb-serial-simple driver.
>>> 
>>> According to the usb-devices output this looks like the Qualcomm USB gadget
>>> in the DIAG + ADB composition to me.
>>> 
>>> Since the option driver uses the usb-wwan framework my suggestion would be
>>> for the original patch to be applied instead similar to what has been done
>>> e.g. for the Quectel RM500Q diag port.
>>> 
>>> Regards,
>>> Reinhard
>>> 
>> I tested the diag port using two userspace programs: QCSuper[1] 
>> and scat[2]. Both option and usb-serial-simple drivers generate
>> similar output, so I cannot comfirm diag message loss. Do you
>> have any test method suggestions to generate high-volume diag 
>> traffic and detect message loss?
>> 
> 
> in my experience activating all message logs on the device with a
> mask value like 0xf or 0x1f is a good way to generate more diag traffic.
> Please refer to https://source.codeaurora.org/quic/imm/imm/sources/diag
> (DIAG_CMD_OP_SET_ALL_MSG_MASK) for details.
> 
> Regards,
> Reinhard
> 

Thank you very much for your advice! I'll try to understand the diag
protocol and experiment with different USB drivers to figure out their
difference :)

Regards,
sdlyyxy



