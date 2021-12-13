Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18F472E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhLMOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:09:56 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37687 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231394AbhLMOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:09:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 59C6E5801C6;
        Mon, 13 Dec 2021 09:09:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 13 Dec 2021 09:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=VCeSqHRowXDwNfr8+gvSIOJad9A
        1kkby+tub0oRqUMQ=; b=bWPevrnPHisRHzc0EJ5cI7uTMLofz4nrrSMW4344ZKH
        xfhynbf/Fqd82xAb3yDLgC/slsF4p8DikAisNywSNa47XtnvlGuqg0ODtdx+QYw7
        otTB+jpzJGhyN9AlUQcdoGXh2NEUqEPuMsNZB1mhCRr1td+W0Df312AfIg/nj4KM
        NS4E2xgWwV0swXvG3F+p4cX+xKYR4GSzlyD+wimJAI4xSjZQ/43yitcEfJFOQlJP
        TYkcH+OIfWpMCCMMKD+bWy0cw2EuR3d2/vywx5e8hz63v2jRwNBkLYmd8D7kM80d
        ERrgoipzDc2aNMnhuMlHUv54EA8GF2MmWu8DnkU7Dag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VCeSqH
        RowXDwNfr8+gvSIOJad9A1kkby+tub0oRqUMQ=; b=OiqX2KsdN/fF1azSQuzCP3
        L2EO9OBCU16JhO6JCgToypOYsiTLRekYe+YBo0IA1+VLs7KOi0AqEK5yeAw61w6e
        KAuIhYHZ28Lhc1xqXmcA9io6oBw4W0Ia6+dvDEhSWSiuOmJY4uDGUTOu4FcaDnmY
        sxrsr4JEaVUQkoE55kVidpfDwHwlEEMdzE+cbxir0UiXci2X46d2k9leFyhLk02a
        +U+poVWNj3yZXOIDplbFXpL7UcbTaHBYA3cXfVVDy6ufJa8l/cns8g1Hf3rQBLvz
        k/AdYq2ESVJiyaARwYBMgpKJ4cybax4o2/fw/Y2DP+yqH3tyEmmHHDh9YolwyTHA
        ==
X-ME-Sender: <xms:MlS3YYj2QWFWZjWsKiSc144qYsu3uTMnCCyDuPBMmTdc3SLygZ7r9w>
    <xme:MlS3YRBE6ikBnTayE59hqinpvE8uAmaIomGmWgxkPFLguLluRPivjcHf4_n-RDbHc
    XBG1ZKLXRR-_w>
X-ME-Received: <xmr:MlS3YQGzBegK2R08UIsPlAHfjjv4pmXDgvab3hU1q51eGAZRC5fwOS06henmMfG2uI5CF-wZjFok6ZI2XC6K-BEeCQa0elZZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeekgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:MlS3YZSJDxHmQXDVM-IaciNarVBzUkW-kvoLcB6Wc4-T3r39Q16WYw>
    <xmx:MlS3YVxQ7KHsCmanBu90ClwHdQsep2oAN6b5CGqGe4d8GCMQVTXvcA>
    <xmx:MlS3YX57h59iUxwKtLrkFxTh-_dvr9W1uNS3uIxp01004Ouh4v7ToA>
    <xmx:M1S3YYo9zyFkmuep8Crp71-cdsGVQ91xh05Wzx5FXGhvTgv7CF1Hqw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Dec 2021 09:09:53 -0500 (EST)
Date:   Mon, 13 Dec 2021 15:09:51 +0100
From:   Greg KH <greg@kroah.com>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: check the return value of kmemdup()
Message-ID: <YbdULyzjOq0hUi8Q@kroah.com>
References: <tencent_8268B88CD2F7BF04083AF35D6E2C87158506@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8268B88CD2F7BF04083AF35D6E2C87158506@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 04:27:15PM +0800, Xiaoke Wang wrote:
> Note: Compare with the last email, this one is using my full name.
> kmemdup() return NULL when some internal memory errors happen, it is
> better to check the return value of it. Otherwise, some memory errors
> will not be catched in time and may further result in wrong memory
> access.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/thunderbolt/icm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index 6255f1e..fff0c74 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -1741,8 +1741,13 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
>  	if (!n)
>  		return;
>  
> -	INIT_WORK(&n->work, icm_handle_notification);
>  	n->pkg = kmemdup(buf, size, GFP_KERNEL);
> +	if (!n->pkg) {
> +		kfree(n);
> +		return;
> +	}
> +
> +	INIT_WORK(&n->work, icm_handle_notification);
>  	n->tb = tb;
>  
>  	queue_work(tb->wq, &n->work);
> -- 

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
