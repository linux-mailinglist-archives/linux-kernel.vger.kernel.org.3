Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8BF47B156
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhLTQkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:40:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60350 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhLTQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:40:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEF1761227
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 16:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06651C36AE2;
        Mon, 20 Dec 2021 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640018401;
        bh=i9FEoFyw4FOzJj5FUbVCZL9hvTq00AQkmMJ9j89AFA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJBjzJ3wi6so7WnEhI+oZulxWBNpWpXfZE8Ix12168TQWW5Q5LARYr6855FjYCuq3
         U9bTy8jFyKSxqW+P5c+lXSRibZIi0u3zqgtw/rLKhupa4YEE/eeWu2OSua4Uufuxyw
         hfMXIBEHMvN3NOI+a9/vJ1BhjyzzTY4PZZNT4qXw=
Date:   Mon, 20 Dec 2021 17:39:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ismayil Mirzali <ismayilmirzeli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com, paskripkin@gmail.com, linux@roeck-us.net
Subject: Re: [PATCH v2] staging: rtl8723bs: Fix styling issues
Message-ID: <YcCx3/bQBY6vKQmf@kroah.com>
References: <20211219163318.84300-1-ismayilmirzeli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219163318.84300-1-ismayilmirzeli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 06:33:18PM +0200, Ismayil Mirzali wrote:
> Removed extra whitespaces and brackets for oneline if statements
> 
> Removed commented code as suggested per reviewer.
> Added blank line after declarations according to styling guide.
> 
> Signed-off-by: Ismayil Mirzali <ismayilmirzeli@gmail.com>
> ---
>  .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 23 +++++++------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> index 7fe3df863fe1..fdefb72047f0 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> @@ -31,9 +31,6 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
>  
>  	pHalData->SdioTxOQTFreeSpace -= agg_num;
>  
> -	/* if (n > 1) */
> -	/* 	++priv->pshare->nr_out_of_txoqt_space; */
> -
>  	return true;
>  }
>  
> @@ -147,13 +144,12 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
>  		return _SUCCESS;
>  
>  	ret = rtw_register_tx_alive(padapter);
> -	if (ret != _SUCCESS) {
> +	if (ret != _SUCCESS)
>  		return _SUCCESS;
> -	}
>  
>  	do {
>  		queue_empty = rtl8723_dequeue_writeport(padapter);
> -/* 	dump secondary adapter xmitbuf */
> +		/*	dump secondary adapter xmitbuf */
>  	} while (!queue_empty);
>  
>  	rtw_unregister_tx_alive(padapter);
> @@ -247,6 +243,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>  						if (pxmitbuf->len > 0 &&
>  						    pxmitbuf->priv_data) {
>  							struct xmit_frame *pframe;
> +
>  							pframe = (struct xmit_frame *)pxmitbuf->priv_data;
>  							pframe->agg_num = k;
>  							pxmitbuf->agg_num = k;
> @@ -310,8 +307,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>  					txlen = txdesc_size + pxmitframe->attrib.last_txcmdsz;
>  					pxmitframe->pg_num = (txlen + 127) / 128;
>  					pxmitbuf->pg_num += (txlen + 127) / 128;
> -				    /* if (k != 1) */
> -					/* 	((struct xmit_frame*)pxmitbuf->priv_data)->pg_num += pxmitframe->pg_num; */
>  					pxmitbuf->ptail += _RND(txlen, 8); /*  round to 8 bytes alignment */
>  					pxmitbuf->len = _RND(pxmitbuf->len, 8) + txlen;
>  				}
> @@ -333,6 +328,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>  		if (pxmitbuf) {
>  			if (pxmitbuf->len > 0) {
>  				struct xmit_frame *pframe;
> +
>  				pframe = (struct xmit_frame *)pxmitbuf->priv_data;
>  				pframe->agg_num = k;
>  				pxmitbuf->agg_num = k;
> @@ -385,9 +381,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
>  	spin_lock_bh(&pxmitpriv->lock);
>  	ret = rtw_txframes_pending(padapter);
>  	spin_unlock_bh(&pxmitpriv->lock);
> -	if (ret == 0) {
> +	if (ret == 0)
>  		return _SUCCESS;
> -	}
>  
>  	/*  dequeue frame and write to hardware */
>  
> @@ -405,9 +400,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
>  	spin_lock_bh(&pxmitpriv->lock);
>  	ret = rtw_txframes_pending(padapter);
>  	spin_unlock_bh(&pxmitpriv->lock);
> -	if (ret == 1) {
> +	if (ret == 1)
>  		goto next;
> -	}
>  
>  	return _SUCCESS;
>  }
> @@ -428,10 +422,9 @@ int rtl8723bs_xmit_thread(void *context)
>  
>  	do {
>  		ret = rtl8723bs_xmit_handler(padapter);
> -		if (signal_pending(current)) {
> +		if (signal_pending(current))
>  			flush_signals(current);
> -		}
> -	} while (_SUCCESS == ret);
> +	} while (ret == _SUCCESS);
>  
>  	complete(&pxmitpriv->SdioXmitTerminate);
>  
> -- 
> 2.25.1
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

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
