Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F259B917
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiHVGOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiHVGOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C432716C;
        Sun, 21 Aug 2022 23:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55A1860F97;
        Mon, 22 Aug 2022 06:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2BDC433C1;
        Mon, 22 Aug 2022 06:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661148868;
        bh=Z3/HQgKoe6LoarvIl3yFV7/OB4aZi1dFWaMeQkoqdRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVd1Ok/5I07dyyVTqyByGJLTVVhWzSAcIhv0uqTKOZ8sih/0ABjs31c8JeODLMK4x
         HDd2qKSrIP+TNgMBgcl+T8Zr6/5csWLCj6DdY+S71rfhdIn3sCPNvluX6F26UaI+2G
         8b6U5PvwBJCCrtrX+VYmfz+DSXGn4EulQ01laMY0=
Date:   Mon, 22 Aug 2022 08:14:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gadget/udc: fix repeated words in comments
Message-ID: <YwMewdmmxiFdbXV1@kroah.com>
References: <20220821152009.61380-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821152009.61380-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 11:20:09PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'tell'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/usb/gadget/udc/pxa25x_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
> index c593fc383481..176e2b157021 100644
> --- a/drivers/usb/gadget/udc/pxa25x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa25x_udc.c
> @@ -1737,7 +1737,7 @@ static void handle_ep0 (struct pxa25x_udc *dev)
>  				/* hardware automagic preventing STALL... */
>  				if (dev->req_config) {
>  					/* hardware sometimes neglects to tell
> -					 * tell us about config change events,
> +					 * us about config change events,
>  					 * so later ones may fail...
>  					 */
>  					WARNING("config change %02x fail %d?\n",
> -- 
> 2.36.1
> 

You sent 3 patches that do different things, yet have the same exact
subject line :(

Please fix up and resend _ALL_ of your USB patches with a unique subject
line, _AND_ as a patch series as I have now dropped them all from my
review queue.

thanks,

greg k-h
