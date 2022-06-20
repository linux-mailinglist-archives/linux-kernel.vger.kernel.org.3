Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5155198A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbiFTNDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiFTNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622171A3A3;
        Mon, 20 Jun 2022 05:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E74161532;
        Mon, 20 Jun 2022 12:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3921C3411B;
        Mon, 20 Jun 2022 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655729837;
        bh=sJ5+Jcxwc7SiAwuU77kJgyMCbVcppibpF6wc4udVHtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsnjkRRPzxd2GVdXDEfgdjFL4LoqrN2LUXLE62wNw1BbXBx2RKQgLEJWJhF0NX0/b
         Dm37wso8lNIwZpOQrcShG7CnsDA4sTmFoL60ZpePXKho4ffLgCJBrF9XeIUN2Dck17
         VPHb8MKeq9ZJ9HIxoZINcqeOT7IF0JbYocaSu0z2zqzmBMPITTzHgK3iTTwRxekpL8
         p+z6aA4R0xigVUJC4BH8bgUuWgky+vFRfIgkSia7g6SmNVbvkv7zKNjLJpS5kGegO+
         lCiGBQGMQOgiL/O1xmyBk3wHpG9HC1qW5z7cTkPO8luTlqHTWqAZga+qEe1ukbfDDV
         JSKjrCzZeBFVg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3Gxt-0000tD-O1; Mon, 20 Jun 2022 14:57:14 +0200
Date:   Mon, 20 Jun 2022 14:57:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel EM05-G modem
Message-ID: <YrBuqTQObu7/vAf0@hovoldconsulting.com>
References: <MEYP282MB23740858061FFA19E97E5C0FFDB09@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB23740858061FFA19E97E5C0FFDB09@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 08:16:53PM +0800, Yonglin Tan wrote:
> Add a device-id entry for the Quectel EM05-G module.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=030a Rev= 3.18
> S:  Manufacturer=Quectel
> S:  Product=Quectel EM05-G
> C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Are there any further configurations for this device that you need to
consider?

You reserve interface 6 below which doesn't even exist in the above
configuration.

Can you say something more about what the individual interfaces are used
for, for example, as was done here:

	https://lore.kernel.org/all/TYZPR06MB4270D3394B8E3E0301738F6B86D09@TYZPR06MB4270.apcprd06.prod.outlook.com/

> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
> ---
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
>  mode change 100644 => 100755 drivers/usb/serial/option.c
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> old mode 100644
> new mode 100755
> index ed1e50d..05fc322
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1147,6 +1147,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = ZLP },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
> +	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, 0x030a, 0xff),
> +	  .driver_info = RSVD(6) | ZLP }, /* EM05-G */

As mentioned above RSVD(6) looks wrong here.

Please move the comment to the first line of the entry, and move the
entry to the other Quectel entries using numerical PIDs (i.e. before
EM160R-GL).
  
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },

Johan
