Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB1E4BE6FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiBUKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:18:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353232AbiBUKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:17:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CADCF6;
        Mon, 21 Feb 2022 01:37:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DC32B80EB5;
        Mon, 21 Feb 2022 09:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB07C340E9;
        Mon, 21 Feb 2022 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645436250;
        bh=2nbjOpE9zmPxYH13Z1D0YQfu2xXpZIXk2Ir5r88/Ckk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9hy0puJZI5Bm7ywRlVCyRWBMQDR+AcNBlH5CmjyoUwUsNjRh7nhTdaYlc79Y9WXh
         uK/SLH/rJbpK+XhHzULudnZGpw0TQKZRoN+0LsLnaITPHwjaEbyyt+EfWSOgmn20ZR
         VJzYBtCa46mtgb/Hn4TriItD/+AxE5v/y+XW8DYirNIHLgJwVJd/rhUQ16Y1f9t2Ok
         CeJsmAntWCEuc9raor8TtJhZZUvV9/Cmb0aASnhaElo+4lHdlrt9yUCpfQxbQIBonc
         mfmAKos1TBkYLdnyUizI2KToM3IjL/O79POFKpWuwLLneLVxzfSnM2/ffINB64aXq0
         JwPgFUrELVz8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nM58I-00079Y-HK; Mon, 21 Feb 2022 10:37:27 +0100
Date:   Mon, 21 Feb 2022 10:37:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Husni Faiz <ahamedhusni73@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: serial: Fix Space Prohibited Coding Style
 Errors
Message-ID: <YhNdVtrXnIehZzfy@hovoldconsulting.com>
References: <20220212175510.521072-1-ahamedhusni73@gmail.com>
 <20220220131339.179648-1-ahamedhusni73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220131339.179648-1-ahamedhusni73@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 06:43:39PM +0530, Husni Faiz wrote:
> This patch fixes "space prohibited before that ','"  checkpatch error.
> Removed the space after the function argument value "8".
> 
> Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
> ---
> V1->V2 : Separated the style changes into multiple patches.

As Greg mentioned, please work in drivers/staging if you want to submit
these kind of patches.

checkpatch.pl is great for checking your own patches before submission,
but it shouldn't be run on code that's already in the tree, and where
fixing a white space issue like this one has essentially no value.

And as your staging/greybus submission showed, using the output of tools
like checkpatch.pl even risks breaking things if you take it too
literally and don't use your own judgement.

>  drivers/usb/serial/iuu_phoenix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
> index 0be3b5e1eaf3..2f7784572c4d 100644
> --- a/drivers/usb/serial/iuu_phoenix.c
> +++ b/drivers/usb/serial/iuu_phoenix.c
> @@ -360,7 +360,7 @@ static void iuu_led_activity_on(struct urb *urb)
>  	usb_fill_bulk_urb(port->write_urb, port->serial->dev,
>  			  usb_sndbulkpipe(port->serial->dev,
>  					  port->bulk_out_endpointAddress),
> -			  port->write_urb->transfer_buffer, 8 ,
> +			  port->write_urb->transfer_buffer, 8,
>  			  iuu_rxcmd, port);
>  	usb_submit_urb(port->write_urb, GFP_ATOMIC);
>  }
> @@ -380,7 +380,7 @@ static void iuu_led_activity_off(struct urb *urb)
>  	usb_fill_bulk_urb(port->write_urb, port->serial->dev,
>  			  usb_sndbulkpipe(port->serial->dev,
>  					  port->bulk_out_endpointAddress),
> -			  port->write_urb->transfer_buffer, 8 ,
> +			  port->write_urb->transfer_buffer, 8,
>  			  iuu_rxcmd, port);
>  	usb_submit_urb(port->write_urb, GFP_ATOMIC);
>  }

Johan
