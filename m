Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE7481D44
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhL3OtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:49:10 -0500
Received: from netrider.rowland.org ([192.131.102.5]:60565 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231320AbhL3OtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:49:09 -0500
Received: (qmail 1112213 invoked by uid 1000); 30 Dec 2021 09:49:08 -0500
Date:   Thu, 30 Dec 2021 09:49:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     cgel.zte@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux] usb-storage: Remove redundant assignments
Message-ID: <Yc3G5KnDYxg2PfvP@rowland.harvard.edu>
References: <20211230063819.586428-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230063819.586428-1-luo.penghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 06:38:19AM +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> The assignments in these two places will be overwritten, so they
> should be deleted.
> 
> The clang_analyzer complains as follows:
> 
> drivers/usb/storage/sierra_ms.c:
> 
> Value stored to 'retries' is never read
> Value stored to 'result' is never read
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/sierra_ms.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
> index b9f78ef..0774ba2 100644
> --- a/drivers/usb/storage/sierra_ms.c
> +++ b/drivers/usb/storage/sierra_ms.c
> @@ -130,8 +130,6 @@ int sierra_ms_init(struct us_data *us)
>  	struct swoc_info *swocInfo;
>  	struct usb_device *udev;
>  
> -	retries = 3;
> -	result = 0;
>  	udev = us->pusb_dev;
>  
>  	/* Force Modem mode */
> -- 
> 2.15.2
> 
> 
