Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3067B52E740
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346972AbiETIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiETIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C5614043F;
        Fri, 20 May 2022 01:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BFCD60B59;
        Fri, 20 May 2022 08:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B9EC385AA;
        Fri, 20 May 2022 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653035110;
        bh=UAdZwN8be1t34m8aBWmzp4YnwhsRlz2HwOJvoZl90hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRLTq7M7COEg2r7XPLEHRjRvsfb6x99fJJympg16g5lU5z9Qy+UjluEGesVsBIJHx
         U4p8/4SbkGDMnBoA07FIvj4y2zrgvzwQsipZRW/tSz6vY2mHEmUs6ICZINYFXKWpPV
         eDn8ddyKrqA7q75Swxxdrqo9godixofY3yKEZngE=
Date:   Fri, 20 May 2022 10:25:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kushagra Verma <kushagra765@outlook.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: dwc3: Fix multiple checkpatch warnings and typos
Message-ID: <YodQZAkaI3eJMOeE@kroah.com>
References: <HK0PR01MB28010DE795B6733D3DDF6EECF8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB28010DE795B6733D3DDF6EECF8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 01:43:38PM +0530, Kushagra Verma wrote:
> This series fixes 3 checkpatch warnings and 2 typos in the dwc3 driver. All
> of these changes are minor fixes.
> 
> Patch 1 fixes a bare use of 'unsigned' checkpatch warning.
> Patch 2 fixes a repeated word checkpatch warning.
> Patch 3 fixes 2 typos in Kconfig.
> 
> Kushagra Verma (3):
>   usb: dwc3: Fix bare use of unsigned checkpatch warning
>   usb: dwc3: Fix a repeated word checkpatch warning
>   usb: dwc3: Fix typos in Kconfig
> 
>  drivers/usb/dwc3/Kconfig | 4 ++--
>  drivers/usb/dwc3/core.c  | 4 ++--
>  drivers/usb/dwc3/ep0.c   | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> -- 
> 2.36.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
