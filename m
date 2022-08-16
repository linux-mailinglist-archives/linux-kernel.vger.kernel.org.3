Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0857596004
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiHPQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiHPQUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:20:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65AA6CD10;
        Tue, 16 Aug 2022 09:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88B2EB819FD;
        Tue, 16 Aug 2022 16:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F9CC433C1;
        Tue, 16 Aug 2022 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660666808;
        bh=j/tkK7z+CXudYU8tJ9PMNpHAcbiLi3yG18BEDtc4aRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k51zYkZK4FI9CZR3ii7XTypvmFymOHo6RnPCPJGSxE0lFuYQnMQ9X31Kg3SeE+j4T
         ipeaea6c9Vnl0k/DJs9Mu73EX1hEwJe/urj9vVRTL1NHZOX7RKnsSh/Xvx/834Mz3o
         iUvrwVRuoXohYELkE43k9qDbttlXWn+e9sTwWaWs=
Date:   Tue, 16 Aug 2022 18:20:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thierry Guibert <thierry.guibert@croix-rouge.fr>
Cc:     oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)
Message-ID: <YvvDtUi7zgrYlopw@kroah.com>
References: <CAEzRux_E+EAEkdr8RVGq4BTJ87G75fwXf4gveLTmk_P3nxizvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzRux_E+EAEkdr8RVGq4BTJ87G75fwXf4gveLTmk_P3nxizvw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:14:21PM +0200, Thierry Guibert wrote:
> >From cf6471caeee7ac7d92bfa4ceaaa16ab461846e65 Mon Sep 17 00:00:00 2001
> From: Thierry GUIBERT <thierry.guibert@croix-rouge.fr>
> Date: Tue, 16 Aug 2022 00:46:01 +0200
> Subject: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)

Why is this in the email body?

Are you using 'git send-email' for this?

> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 9b9aea24d58c..091fcfac3717 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -1813,6 +1813,10 @@ static const struct usb_device_id acm_ids[] = {
>        { USB_DEVICE(0x0ca6, 0xa050), /* Castles VEGA3000 */
>        .driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
>        },
> +       { USB_DEVICE(0x0c26, 0x0020), /* Icom ICF3400 Serie */
> +       .driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
> +       },
> +
> 
>        { USB_DEVICE(0x2912, 0x0001), /* ATOL FPrint */
>        .driver_info = CLEAR_HALT_CONDITIONS,
> --
> 2.37.2

As my bot pointed out many times, this is whitespace corrupted and can
not be applied :(

Please fix up your email client and resend a v2.

thanks,

greg k-h
