Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48E59870A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbiHRPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbiHRPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B2FBD4F5;
        Thu, 18 Aug 2022 08:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5625A61387;
        Thu, 18 Aug 2022 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9C6C433D7;
        Thu, 18 Aug 2022 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660835422;
        bh=TFT981KA1z88bdfmVM6dWKjQo4+fr9d18AcL6r2aUkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7mdPuercpoeoSSesI+jL2yDTSLEGB9hSyprievGFNm8dcjGrDOJO+X6y31GciGct
         BXJzgxjuDMAqZEjdXPwr9RvUhKporhaOLdgt27mRQF118NgfmWSSJZbPOzkO77Yf+A
         wDuF/Z6CFQzxjNrAQAKrvqIBYTm8VwpdALfFO2wo=
Date:   Thu, 18 Aug 2022 17:10:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: usbtest: Fix typo in comments
Message-ID: <Yv5WW7vuLskqwP4c@kroah.com>
References: <20220810103000.8721-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810103000.8721-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 06:30:00AM -0400, shaomin Deng wrote:
> Delete the rebundant word "with" in comments.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/usb/misc/usbtest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
> index 150090ee4ec1..ac0d75ac2d2f 100644
> --- a/drivers/usb/misc/usbtest.c
> +++ b/drivers/usb/misc/usbtest.c
> @@ -2638,7 +2638,7 @@ usbtest_do_ioctl(struct usb_interface *intf, struct usbtest_param_32 *param)
>   * different busses) to use when testing, and allocate one thread per
>   * test.  So discovery is simplified, and we have no device naming issues.
>   *
> - * Don't use these only as stress/load tests.  Use them along with with
> + * Don't use these only as stress/load tests.  Use them along with
>   * other USB bus activity:  plugging, unplugging, mousing, mp3 playback,
>   * video capture, and so on.  Run different tests at different times, in
>   * different sequences.  Nothing here should interact with other devices,
> -- 
> 2.35.1
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

- Your patch did not apply to any known trees that Greg is in control
  of.  Possibly this is because you made it against Linus's tree, not
  the linux-next tree, which is where all of the development for the
  next version of the kernel is at.  Please refresh your patch against
  the linux-next tree, or even better yet, the development tree
  specified in the MAINTAINERS file for the subsystem you are submitting
  a patch for, and resend it.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
