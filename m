Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC5572E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiGMGn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGMGnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F14B1956;
        Tue, 12 Jul 2022 23:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A979661CB1;
        Wed, 13 Jul 2022 06:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EACC34114;
        Wed, 13 Jul 2022 06:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657694634;
        bh=3rSvIgfrRGUff8uhqno+zIOUPvaxio6fZrEetbnQaq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnfjBIZYKdmuZTAQK7qTdkUzgd6Dps2mZ7MFzd5s2uhFw166I7t9+tXH0T+AxfUb7
         PY6OzquFxA6ZW41gIYUl7R48tx7/11xGk16I2xs70RWjvxlVnEAqQqUhBILrx4lbml
         OF3P74KKU+S3Xsphjs9BEU9WyBZfy7sxu+0NT/zhVVGv6DF+SuQ0OytcTmCAXchKed
         Nz6BK5oTCH7UIkDe112vw8w2L1C4SwiQa5+yLDi9bvLzv7yEYNSlnojjY3Q1bvs3JM
         9EkWgvx6IdDl+XkygDvhdotQU/YUyphrA6zQcppLKcdQRbntYipHQ567R85BEkRTem
         DwbShDm5JOzRA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBW6G-0002GK-47; Wed, 13 Jul 2022 08:43:56 +0200
Date:   Wed, 13 Jul 2022 08:43:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cypress_m8: drop unexpected word "the" in
 the comments
Message-ID: <Ys5prITWZSfLcZjp@hovoldconsulting.com>
References: <20220622104608.8871-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622104608.8871-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 06:46:08PM +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/usb/serial/cypress_m8.c
> line: 259
> 
>      * chose to use the the general purpose firmware or not), if you
> changed to:
>      * chose to use the general purpose firmware or not), if you
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/usb/serial/cypress_m8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
> index 6924fa95f6bd..da8913683104 100644
> --- a/drivers/usb/serial/cypress_m8.c
> +++ b/drivers/usb/serial/cypress_m8.c
> @@ -256,7 +256,7 @@ static int analyze_baud_rate(struct usb_serial_port *port, speed_t new_rate)
>  		/*
>  		 * Mike Isely <isely@pobox.com> 2-Feb-2008: The
>  		 * Cypress app note that describes this mechanism
> -		 * states the the low-speed part can't handle more
> +		 * states the low-speed part can't handle more

I believe the first "the" should be replaced with "that" here.

>  		 * than 800 bytes/sec, in which case 4800 baud is the
>  		 * safest speed for a part like that.
>  		 */

I've fixed up the above, merged this patch with the other one for
mos7720 and amended the commit message.

The result can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next

Johan
