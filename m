Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6E4AC439
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385464AbiBGPn6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Feb 2022 10:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383516AbiBGPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:41:46 -0500
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 07:41:44 PST
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 300C5C0401C1;
        Mon,  7 Feb 2022 07:41:44 -0800 (PST)
Received: from smtpclient.apple (p4ff9f3e5.dip0.t-ipconnect.de [79.249.243.229])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5DBD6CECF3;
        Mon,  7 Feb 2022 16:41:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Edup BT5.1 Class1
 Adapter (RTL8761B)
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220201124134.806135-1-joern.koerner@ijwo.de>
Date:   Mon, 7 Feb 2022 16:41:43 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <041EC239-C0F9-43A0-BC12-CFA9810EF65A@holtmann.org>
References: <20220201124134.806135-1-joern.koerner@ijwo.de>
To:     Joern Koerner <joern.koerner@ijwo.de>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joern,

> $ cat /sys/kernel/debug/usb/devices. T:  Bus=02 Lev=02
> Prnt=02 Port=00 Cnt=01 Dev#=  7 Spd=12   MxCh= 0 D:  Ver= 1.10 Cls=e0(wlcon)
> Sub=01 Prot=01 MxPS=64 #Cfgs=  1 P:  Vendor=2550 ProdID=8761 Rev= 2.00 S: 
> Manufacturer=Realtek S:  Product=Bluetooth Radio S: 
> SerialNumber=00E04C239987 C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA I:* If#= 0
> Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=81(I)
> Atr=03(Int.) MxPS=  16 Ivl=1ms E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms E:
>  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms I:* If#= 1 Alt= 0 #EPs= 2
> Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=   0
> Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms I:  If#= 1 Alt= 1 #EPs= 2
> Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=   9
> Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms I:  If#= 1 Alt= 2 #EPs= 2
> Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=  17
> Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms I:  If#= 1 Alt= 3 #EPs= 2
> Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=  25
> Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms I:  If#= 1 Alt= 4 #EPs= 2
> Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=  33
> Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms I:  If#= 1 Alt= 5 #EPs= 2
> Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=  49
> Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Joern Koerner <joern.koerner@ijwo.de>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)

please fix the commit message or use a proper mailer so that no line wrap happens.

Regards

Marcel

