Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5665A65E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiH3OD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiH3ODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:03:55 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DE94CB5E5F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:03:48 -0700 (PDT)
Received: (qmail 158045 invoked by uid 1000); 30 Aug 2022 10:03:47 -0400
Date:   Tue, 30 Aug 2022 10:03:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hu Xiaoying <huxiaoying@kylinos.cn>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Hu Xiaoying <huxiaoying@gmail.com>
Subject: Re: [PATCH] usb: Improves USB2.0 write performance
Message-ID: <Yw4Yw5yXgybl9j6J@rowland.harvard.edu>
References: <20220830084325.752655-1-huxiaoying@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830084325.752655-1-huxiaoying@kylinos.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:43:25PM +0800, Hu Xiaoying wrote:
> USB external storage device(0x0b05:1932), use gnome-disk-utility tools
> to test usb write  < 30MB/s. if does not to load module of uas for this device
> , can increase the write speed from 20MB/s to more than 40MB/s.
> 
> Signed-off-by: Hu Xiaoying <huxiaoying@gmail.com>

This email address "@gmail.com" is different from the address you used 
when you submitted the patch "@kylinos.cn".  The two addresses must be 
the same.

> ---

You should put here (just after the "---" line) a description of how 
this patch version is different from all the earlier versions.  Do that 
and submit it as [PATCH v4], and make sure you explain how it is 
different from versions 1, 2, and 3.

There are lots of examples of patches like this in the mailing list 
archives.  Look at some of them to see what they do.

Alan Stern

>  drivers/usb/storage/unusual_uas.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
> index 4051c8cd0cd8..3925c7c67915 100644
> --- a/drivers/usb/storage/unusual_uas.h
> +++ b/drivers/usb/storage/unusual_uas.h
> @@ -62,6 +62,13 @@ UNUSUAL_DEV(0x0984, 0x0301, 0x0128, 0x0128,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_IGNORE_UAS),
>  
> +/* Reported-by: Tom Hu <huxiaoying@gmail.com> */
> +UNUSUAL_DEV(0x0b05, 0x1932, 0x0000, 0x9999,
> +		"ASUS",
> +		"External HDD",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_IGNORE_UAS),
> +
>  /* Reported-by: David Webb <djw@noc.ac.uk> */
>  UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
>  		"Seagate",
> -- 
> 2.25.1
> 
