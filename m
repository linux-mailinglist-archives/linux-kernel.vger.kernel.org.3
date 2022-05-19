Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D1D52D09C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiESKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiESKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:34:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989F56FA8;
        Thu, 19 May 2022 03:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A6A7B82390;
        Thu, 19 May 2022 10:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9ADC385AA;
        Thu, 19 May 2022 10:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652956453;
        bh=F6lMMI9wCT7YEnfx97Rh4IvbWpUerMrAQC7i5+XZHzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gsp6LkeWU3bKxfM9+evAMJQEbhaccx7WAas/qFQUx2uoKdez7z8+01aQGrvr4pBHQ
         kfbBF4NzFCeuaCgkyv/vyAST6IkaweQeDq2ItEwo+mGtZ+oASqRKbAKFJ8iIH6M1ze
         D9MOqeP3d0BppWUzqI0aTGXRtfiCZc6KwoEw1eLU=
Date:   Thu, 19 May 2022 12:34:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kushagra Verma <kushagra765@outlook.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB / image: Fix spacing issues in
 mdc800_endpoint_equals()
Message-ID: <YoYdItGTISO4CxHC@kroah.com>
References: <HK0PR01MB2801F1EE137B9A5196B225D1F8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB2801F1EE137B9A5196B225D1F8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 02:42:31PM +0530, Kushagra Verma wrote:
> This patch fixes the following spacing issues in mdc800_endpoint_equals():
> 	1. (Removed) Space between function name and opening parenthesis.
> 	2. (Removed) Space between variable and opening and closing
>             parenthesis in the return statement.
> 	3. (Added) Space between 2 function arguments.
> 
> This fixes multiple checkpatch warnings for this function.
> 
> Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
> ---
>  drivers/usb/image/mdc800.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
> index fc0e22cc6fda..dc03e0e54fe0 100644
> --- a/drivers/usb/image/mdc800.c
> +++ b/drivers/usb/image/mdc800.c
> @@ -220,12 +220,12 @@ static struct mdc800_data* mdc800;
>  	The USB Part of the driver
>  ****************************************************************************/
>  
> -static int mdc800_endpoint_equals (struct usb_endpoint_descriptor *a,struct usb_endpoint_descriptor *b)
> +static int mdc800_endpoint_equals(struct usb_endpoint_descriptor *a, struct usb_endpoint_descriptor *b)
>  {
>  	return (
> -		   ( a->bEndpointAddress == b->bEndpointAddress )
> -		&& ( a->bmAttributes     == b->bmAttributes     )
> -		&& ( a->wMaxPacketSize   == b->wMaxPacketSize   )
> +		   (a->bEndpointAddress == b->bEndpointAddress)
> +		&& (a->bmAttributes     == b->bmAttributes)
> +		&& (a->wMaxPacketSize   == b->wMaxPacketSize)

As you can see, the original alignments was done for the specific reason
of making this "pretty".  Your changes really do not help anything here,
which is the primary reason to make checkpatch cleanup changes.

So I'll leave this alone, sorry.

thanks,

greg k-h
