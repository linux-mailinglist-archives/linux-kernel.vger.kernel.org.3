Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571A54FB5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbiDKIT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiDKITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:19:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC2D33A10;
        Mon, 11 Apr 2022 01:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C334B81126;
        Mon, 11 Apr 2022 08:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6571C385A4;
        Mon, 11 Apr 2022 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649665025;
        bh=KbctWk3ZUK1wZi551qde9Yat0ZammFxGAFWOCMFaudE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAwI1ZJqoov1ZMQojzjQ/4fiR1sSnOA7eHVhp6fhfHoPXRlzN7U/uOkvA+iyDxLHS
         8LEEtVxcqWkG6LXIPLnBqcXnmQ5IfiCgH/hzmj2YgObsLk6FiSi7Pc/Bbw2aRn/pSS
         WGOwZz+ZktWGWkpot3QDGhb0OOITroyul+VZfsSfRFv/hlEYJ38BjrB0di/JtzJpiK
         g5FHKWghsqm4EPglmJFHJlkEFZ2tREgOkKm0m2dac98CiVxUSUtXP5LSU/W/vc/VN6
         JQOyaz71TQKys59eeLmdgNX3/w+/79Mz4MH1ZuQ+z97Is47ws0T3y7tQmaiMwvNwWH
         WOWdzGw89/03g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndpEJ-00020I-1n; Mon, 11 Apr 2022 10:16:59 +0200
Date:   Mon, 11 Apr 2022 10:16:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     sven@svenschwermer.de
Cc:     linux-usb@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] usb: serial: option: Add Fibocom MA510 modem
Message-ID: <YlPj++z0CdjABnhz@hovoldconsulting.com>
References: <20220407074945.74449-1-sven@svenschwermer.de>
 <20220407074945.74449-2-sven@svenschwermer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407074945.74449-2-sven@svenschwermer.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 09:49:45AM +0200, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

My comments on patch 1/2 apply here too.
 
> +GTUSBMODE: 31
> --------------
> T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#= 99 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=0106 Rev= 0.00
> S:  Manufacturer=Fibocom MA510 Modem
> S:  Product=Fibocom MA510 Modem
> S:  SerialNumber=55e2695b
> C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 3 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> +GTUSBMODE: 32
> --------------
> T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#=100 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=010a Rev= 0.00
> S:  Manufacturer=Fibocom MA510 Modem
> S:  Product=Fibocom MA510 Modem
> S:  SerialNumber=55e2695b
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 2 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
> E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
>  drivers/usb/serial/option.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 75b62e08b82f..01a12c5d469f 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2118,6 +2118,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(4) | RSVD(5) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
>  	  .driver_info = RSVD(6) },
> +	{ USB_DEVICE(0x2cb7, 0x0106),						/* Fibocom MA510 (+GTUSBMODE=31) */
> +	  .driver_info = RSVD(3) | RSVD(4) },
> +	{ USB_DEVICE(0x2cb7, 0x010a),						/* Fibocom MA510 (+GTUSBMODE=32) */
> +	  .driver_info = RSVD(2) | RSVD(3) },

Please use USB_DEVICE_INTERFACE_CLASS() for both entries.

>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */

Johan
