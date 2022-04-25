Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B650DAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiDYIUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiDYIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:20:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92085DDF;
        Mon, 25 Apr 2022 01:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C784B81133;
        Mon, 25 Apr 2022 08:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E127FC385A4;
        Mon, 25 Apr 2022 08:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650874611;
        bh=FayFAUSz5bqwCJWpaceqLYKGKKoGKJUh2CLGNEr2u4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZKidCZGUAMANW86hNIvXoJuDe+ngtkeCsx4VsoaOxDz/l58rEKt+O82+85e+Qc4/
         K0gwkIyH3Wb72kOWUvHh70QyAMYkz0UkJ4nUtAGIQATdLyoT6tLCtjb7BMzA0lTpI0
         38orWvFbEpAI/lWZ2d+1O/OeRBHwrHww6jQRGOmc=
Date:   Mon, 25 Apr 2022 10:16:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, roger@labau.com.tw,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: add device id for HP LM930 Display
Message-ID: <YmZY8HAezroMkNbj@kroah.com>
References: <20220425072454.33126-1-scott@labau.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425072454.33126-1-scott@labau.com.tw>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:24:52PM +0800, Scott Chen wrote:
> Add the device id for the HPLM930Display which is a PL2303GC based device
> 
> Signed-off-by: Scott Chen <scott@labau.com.tw>
> ---
>  drivers/usb/serial/pl2303.c | 1 +
>  drivers/usb/serial/pl2303.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index 88b284d61681..1d878d05a658 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -106,6 +106,7 @@ static const struct usb_device_id id_table[] = {
>  	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM220_PRODUCT_ID) },
>  	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM960_PRODUCT_ID) },
>  	{ USB_DEVICE(HP_VENDOR_ID, HP_LM920_PRODUCT_ID) },
> +	{ USB_DEVICE(HP_VENDOR_ID, HP_LM930_PRODUCT_ID) },
>  	{ USB_DEVICE(HP_VENDOR_ID, HP_LM940_PRODUCT_ID) },
>  	{ USB_DEVICE(HP_VENDOR_ID, HP_TD620_PRODUCT_ID) },
>  	{ USB_DEVICE(CRESSI_VENDOR_ID, CRESSI_EDY_PRODUCT_ID) },
> diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
> index c5406452b774..9d8102639e16 100644
> --- a/drivers/usb/serial/pl2303.h
> +++ b/drivers/usb/serial/pl2303.h
> @@ -135,6 +135,7 @@
>  #define HP_TD620_PRODUCT_ID	0x0956
>  #define HP_LD960_PRODUCT_ID	0x0b39
>  #define HP_LD381_PRODUCT_ID	0x0f7f
> +#define HP_LM930_PRODUCT_ID     0x0f9b

Please use a tab here too.

thanks,

greg k-h
