Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B234F9083
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiDHIQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiDHIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DCA5AEC1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 570C061272
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB26C385A1;
        Fri,  8 Apr 2022 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649405641;
        bh=XDlebbqKT3weA3tUvZioQrpxHAe1YfgeHmh4ZAqmS7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X771eGmwW1BYwZByt5brTrTHkhtD3qJ95KfehH5uHrE3yUNFpnqJK8Zr24reL1Qjs
         TFYkmQBveyH5adrH3iv6ejpW3bjUpDjUBOmV1zrIzgdHSREyH1YySuAwPgSgYmApcJ
         AXMDaKpwy3bzNPwNJ/mxH/wgLCEqCb+qUb/VX5cw=
Date:   Fri, 8 Apr 2022 10:13:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Artur Bujdoso <artur.bujdoso@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-usb: remove unnecessary parentheses
Message-ID: <Yk/uxoi4VUaR9OpO@kroah.com>
References: <Yk/knRtaujd/PzK7@crux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk/knRtaujd/PzK7@crux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 09:30:37AM +0200, Artur Bujdoso wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses
> 
> Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 62 ++++++++++++-------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> index a1cd81d4a114..32bcd6c582f5 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.c
> +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> @@ -1101,9 +1101,9 @@ static struct cvmx_usb_pipe *cvmx_usb_open_pipe(struct octeon_hcd *usb,
>  	pipe = kzalloc(sizeof(*pipe), GFP_ATOMIC);
>  	if (!pipe)
>  		return NULL;
> -	if ((device_speed == CVMX_USB_SPEED_HIGH) &&
> -	    (transfer_dir == CVMX_USB_DIRECTION_OUT) &&
> -	    (transfer_type == CVMX_USB_TRANSFER_BULK))
> +	if (device_speed == CVMX_USB_SPEED_HIGH &&
> +	    transfer_dir == CVMX_USB_DIRECTION_OUT &&
> +	    transfer_type == CVMX_USB_TRANSFER_BULK)
>  		pipe->flags |= CVMX_USB_PIPE_FLAGS_NEED_PING;

Nah, the original is fine, no need to change this.

Unless, do you have this hardware?  If so, getting this out of staging
would be nice to have happen one day.

thanks,

greg k-h
