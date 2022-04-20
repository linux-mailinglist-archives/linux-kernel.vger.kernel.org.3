Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085C5081DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359661AbiDTHTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359653AbiDTHTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:19:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDC83AA44;
        Wed, 20 Apr 2022 00:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEA6DB81D44;
        Wed, 20 Apr 2022 07:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71440C385A0;
        Wed, 20 Apr 2022 07:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650438974;
        bh=qJfRoNnYDJdWlP5627RGAnviK+epD8YlGgj0TvPRgqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPNaqzUyDqtnqtjnsZGseSCxzNxONxqRb5EEo9516O16INig9hEtQ2xeqhat9NcNh
         jdFynQBST6N5+qPoB5UXaxmPDRfnlpZ/ndk37eNh4PXuUp+ZbYuws2dLE+YK4IKaUk
         4SaRoLA18GTjAhAWqhO5rynx1JZdAtBAr5GmTLprMY7qP/0f59z6/w0E49ngazlpp8
         MN3TO3yVdnNKEoyCpafAGGD4T9zNcaVk7JpDPTd7oPe6ew5JjwCsRU4VW2pNJ4ncvD
         TxG6GM7yA7PAKIUcWQMEzQRiSAUJFtJ9ZOiw9ltCgZCgzOp/xEnruNLtljuKtaWPV2
         XNidPGm3/XCiA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nh4ZK-0007kt-9s; Wed, 20 Apr 2022 09:16:07 +0200
Date:   Wed, 20 Apr 2022 09:16:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: Adding support for Cinterion
 MV32-WA/MV32-WB
Message-ID: <Yl+zNlWflAzLMcPA@hovoldconsulting.com>
References: <20220414074434.5699-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414074434.5699-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:44:34PM +0800, Slark Xiao wrote:
> Adding support for Cinterion device MV32-WA/MV32-WB.

Nit: Please use imperative mood in your commit message (e.g. use "add"
instead of "adding").

> MV32-WA PID is 0x00F1, and MV32-WB PID is 0x00F2.
> 
> Test evidence as below:
> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=1e2d ProdID=00f1 Rev=05.04
> S:  Manufacturer=Cinterion
> S:  Product=Cinterion PID 0x00F1 USB Mobile Broadband
> S:  SerialNumber=78ada8c4
> C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> 
> T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=1e2d ProdID=00f2 Rev=05.04
> S:  Manufacturer=Cinterion
> S:  Product=Cinterion PID 0x00F2 USB Mobile Broadband
> S:  SerialNumber=cdd06a78
> C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> 
> Interface 0&1: MBIM, 2:Modem, 3: GNSS, 4: NMEA, 5: Diag
> GNSS port don't use serial driver.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/usb/serial/option.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index e7755d9cfc61..d947357881c3 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -432,7 +432,8 @@ static void option_instat_callback(struct urb *urb);
>  #define CINTERION_PRODUCT_CLS8			0x00b0
>  #define CINTERION_PRODUCT_MV31_MBIM		0x00b3
>  #define CINTERION_PRODUCT_MV31_RMNET		0x00b7
> -

Why remove the section separating newline?

> +#define CINTERION_PRODUCT_MV32_WA		0x00f1
> +#define CINTERION_PRODUCT_MV32_WB		0x00f2
>  /* Olivetti products */
>  #define OLIVETTI_VENDOR_ID			0x0b3c
>  #define OLIVETTI_PRODUCT_OLICARD100		0xc000
> @@ -1969,6 +1970,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(3)},
>  	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV31_RMNET, 0xff),
>  	  .driver_info = RSVD(0)},
> +	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WA, 0xff),
> +	  .driver_info = RSVD(3)},
> +	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB, 0xff),
> +	  .driver_info = RSVD(3)},
>  	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD100),
>  	  .driver_info = RSVD(4) },
>  	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD120),

Looks good otherwise. I've fixed up the issues pointed out above, but
please keep it in mind for next time.

Johan
