Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2635576ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiFWJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFWJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:45:17 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB2A11A34
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:45:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E37133200931;
        Thu, 23 Jun 2022 05:45:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Jun 2022 05:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655977512; x=1656063912; bh=9CJDM0A9Po
        pOEbceLv4YsZ9qKapm4Vh+qLdtKoQ8nko=; b=ii3zNbrv9eQtCgTRBHIB7+oFe0
        FdIXWVGAAVS/qoJgt6aWITIm2SxoTVj/AtND0aL44DQjmL1ze/Q0HFy91hMOy96a
        XZ3WiymvgT3/JMzLBvNTotUGWBRS9BBab3/QAZ2hBIYf7R4sR7szSAGukW6WuQhm
        5u9faG58GLNQZDmyBX9CMgwMaCtf0PQ5AEnwUCASay7doueEVg+VvFNDOqEvHXP+
        zeHPwo8tPALHZr4dxa4ujeMRF+NIfE5LLgj1csQRBoI5vwLPTke3JzU8ECkbOQ2s
        VCwAg6Uy1OJPhk7hc93b+CAF2l7s9vZObabVkGTAKe0Kfz3alb1Vkm8uJ1AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655977512; x=1656063912; bh=9CJDM0A9PopOEbceLv4YsZ9qKapm
        4Vh+qLdtKoQ8nko=; b=tYArWmbka2HIxRs2V4F8nxnIyero7DpCnyASejSThqSA
        Qz5nFmZGFqexNY1rSOMKRf2V4uQdizG0b6BYDm4oqmd4t2EAU84rXEtWjbKNPuci
        ZVooPRczXsvYG4brZaA0QNIq7ZovpPKLi5TxcvGodMn2aMTY2gzaMOZE3cMVwoMQ
        h/CK6l0BB2lV45sQ/oXzRThsUrW736SptLA0I5PpmGw1acYLxU9jo7sRWBGLeTXG
        CV1qXfhom9X5otQWMbT0+y48EYAQDExnV/BV2ttL1FirzAw0NOuIVWlOKBWazdGH
        NxgOnxyYogcj7Kd0HxodXjMsmTryvXQeDcDu8Io18w==
X-ME-Sender: <xms:Jza0Yvu2OcBMpHnmeXV6-BWz_3AujlRV5iH83eiCVkRqxwFVR_Ogmw>
    <xme:Jza0YgeHUlR5eyqTAWZ2rteojySBivEVVJxOGsCZDfcfgJkOX0vlcbTJPkRWD6Zxc
    6UHDzOi84eAbQ>
X-ME-Received: <xmr:Jza0YiwgSJCWFF-sIjX93VATTGjuvAY2kxUm3CFOHJd-110o3MaUmmCapyH-vBxUeQNibdF7LjXz_QX2tg2yKBj-mXNX-aQK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:Jza0YuOmEFGHVFmLlvX6xca72Lnzjxangp6pt5Jm63zXj_7ykVgzww>
    <xmx:Jza0Yv_Ejml3sVu7escx9LpgxexntMs0SI2jG0-K9DWR7iAjfir7xA>
    <xmx:Jza0YuWWwXRznzVYaC4ui6U8SbhSz-lX6IU5IpEzrF2CkWf41-jovA>
    <xmx:KDa0YrRrL36skR1P8dnkDKWZaAEoJYbe1O45RjlpyIi08pxizyHZSg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jun 2022 05:45:11 -0400 (EDT)
Date:   Thu, 23 Jun 2022 11:45:07 +0200
From:   Greg KH <greg@kroah.com>
To:     Chang Yu <marcus.yu.56@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: combine nested if statements into
 one
Message-ID: <YrQ2Izg1b399yJou@kroah.com>
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <20220623051404.410632-1-marcus.yu.56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623051404.410632-1-marcus.yu.56@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:14:04PM -0700, Chang Yu wrote:
> Combine two nested if statements into a single one
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v2:
> Added a pair of parentheses to make operator precedence explicit.
> 
>  drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 6564e82ddd66..020bc212532f 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
>  
>  	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
>  
> -	if (padapter) {
> -		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> -				precvpriv->free_recvframe_cnt++;
> -	}
> +	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
> +		precvpriv->free_recvframe_cnt++;
>  
>  	spin_unlock_bh(&pfree_recv_queue->lock);
>  
> -- 
> 2.36.1
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
