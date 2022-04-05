Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EC4F5068
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841706AbiDFBZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453872AbiDEP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:57:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD63141D9D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47A26B81E56
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C21EC385A1;
        Tue,  5 Apr 2022 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649170943;
        bh=Ra/03EFX5mzh6Q7bAuF5V7b3yZhKCzD8UNsg2MKHH24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIgEKXlspNbXek7p1WoN/d+mkKu3Nfa8cBFmmXaa3zM1MOzJHAaNrX2XOMt6AL4Se
         aKsuIqXU0jX9K9qb8rMRxLGXiIEhBcE7+x4B2gNTygCfF7EV5iBQztirOljQWwzHdg
         I+prIHrsuwc9fuHnZIEAV15TtdOGCgpdTXTrk9oY=
Date:   Tue, 5 Apr 2022 17:02:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: fix indentation
Message-ID: <YkxZ/NMSNPQ59tRc@kroah.com>
References: <20220405145424.GA623343@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405145424.GA623343@euclid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:54:24AM -0400, Sevinj Aghayeva wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: suspect code indent for conditional statements
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 04e29e228c1e..1bdbd0971f73 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -5143,17 +5143,9 @@ void link_timer_hdl(struct timer_list *t)
>  	} else if (pmlmeinfo->state & WIFI_FW_AUTH_STATE) {
>  		/* re-auth timer */
>  		if (++pmlmeinfo->reauth_count > REAUTH_LIMIT) {
> -			/* if (pmlmeinfo->auth_algo != dot11AuthAlgrthm_Auto) */
> -			/*  */
> -				pmlmeinfo->state = 0;
> -				report_join_res(padapter, -1);
> -				return;
> -			/*  */
> -			/* else */
> -			/*  */
> -			/* 	pmlmeinfo->auth_algo = dot11AuthAlgrthm_Shared; */
> -			/* 	pmlmeinfo->reauth_count = 0; */
> -			/*  */
> +			pmlmeinfo->state = 0;
> +			report_join_res(padapter, -1);
> +			return;
>  		}
>  
>  		pmlmeinfo->auth_seq = 1;
> -- 
> 2.25.1
> 
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

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
