Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D0486B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243720AbiAFUZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:25:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42304 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243662AbiAFUZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:25:07 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3B6A8CECDD;
        Thu,  6 Jan 2022 21:25:06 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Foxconn QCA 0xe0d0
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211227102950.17968-1-aaron.ma@canonical.com>
Date:   Thu, 6 Jan 2022 21:25:05 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        matthias.bgg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <96661839-37A4-437D-9362-1FCC41CDAD0C@holtmann.org>
References: <20211227102950.17968-1-aaron.ma@canonical.com>
To:     Aaron Ma <aaron.ma@canonical.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

> Add an ID of Qualcomm Bluetooth SoC WCN6855.
> 
> T:  Bus=05 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e0d0 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:* If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)

the patch does not apply to bluetooth-next tree.

Regards

Marcel

