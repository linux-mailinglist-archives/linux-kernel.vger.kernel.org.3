Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EEF4A4088
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbiAaKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:55:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45498 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiAaKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:55:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A3FAB82A5A;
        Mon, 31 Jan 2022 10:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538DBC340E8;
        Mon, 31 Jan 2022 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643626538;
        bh=ZFijXYZeA8Sx8Dqr0g78Ity9WlbxMZadItAKk6t+V9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ec7xxarGg8npkeLLxb2KZkx1zs/DUFgyyNkAwkoCkwz+CZ07zAB+WQ2hmyRPWlKaA
         +dnwMbnoMa1lpSvJ/gxa4BTxrrKdpZCqgepOcAO6gjamOEMKwQvWvFiDNHql8mU0tM
         SK4VkE+HbqCklVdVC7taEX9H3tPBmGZ/sy9tgaoKaFCtsGF0ywJKXxIog1k5n5IYwn
         6VaptzThZJ09QLYYV3zs42D0JrnAggO0pNjDd3WRxzndgmKsOrB8DCZ+RksPbHCQTF
         3NEW1aw1CDf9Oq+ldtE/Gjpo5GpA6uIGoA86mGStmp6r4vl/pY62jc7g6ZnVQBXrEe
         2VC2taVVMqsow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nEULD-0006rQ-WD; Mon, 31 Jan 2022 11:55:24 +0100
Date:   Mon, 31 Jan 2022 11:55:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add ZTE MF286D modem
Message-ID: <YffAG4uBD2y1zjV2@hovoldconsulting.com>
References: <20220111221205.14662-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111221205.14662-1-paweldembicki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:12:05PM +0100, Pawel Dembicki wrote:
> Modem from ZTE MF286D is an Qualcomm MDM9250 based 3G/4G modem.
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
> D:  Ver= 3.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=19d2 ProdID=1485 Rev=52.87
> S:  Manufacturer=ZTE,Incorporated
> S:  Product=ZTE Technologies MSM
> S:  SerialNumber=MF286DZTED000000
> C:* #Ifs= 7 Cfg#= 1 Atr=80 MxPwr=896mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=ff Driver=rndis_host
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Now applied, thanks.

Johan
