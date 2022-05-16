Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FFF527ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbiEPHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbiEPHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:49:16 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513DE26117;
        Mon, 16 May 2022 00:49:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1DA4632009CF;
        Mon, 16 May 2022 03:49:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 16 May 2022 03:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1652687348; x=1652773748; bh=MvWMkRk7Zy
        c4cpNnqFAlhhDmpo3d+xkdAkE7OpzFNNw=; b=FNQGKIeZu7bX1Jyot7sQphW2uM
        gTlR61kHy41riM6+QLTiFJhCCu6Jx+lK8XeYkLo0DRRs4ZPs2u8cHDnbuQWR8jnh
        1mNLtdYcWVeZh2QP5IEa4vqMTlPC7iTKSFxg7DQDLRkAT2iGbb7UEGlL7oSpqAKV
        Sup+gY35vE9oHyWrsCnSrhXB9KJOAmIpygFkTRWnCGbTbFXPEDNfeLllKhOzONSN
        GEpRcWXRV1qzRzgjCOZpna4zQlh71Gi/9LJp4eL2qEbgm04f9P45O12wMY1mbluw
        aAOtQn+ib1afR8JxiKPI37hxU2qYp06HQ/Rt1VFCTwHa3BqPBtjs1E/fTKSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652687348; x=
        1652773748; bh=MvWMkRk7Zyc4cpNnqFAlhhDmpo3d+xkdAkE7OpzFNNw=; b=X
        crkwzoFXYtPteasC1bRbHZUmgWxun9BBdC+wtG2Ux4e+NIyk1VpTXH9R96psyrhP
        V2TTWReQHj1eZn03nhCszI4LgBX/dxrMcrfUwebe/GPpoXYa0HKoSutEl3n++z6B
        vyHUhx/sCkd1jDr3T+Btfq+qR0QBH6d/fyiBeVq3kc0PGNX9sM0c4OxG9lxl/5p4
        erJhSkGb0XYNVHV7w564GS+cPCmpAZxi7rEHDDAgV+umXSXy5uw/IM60sAI0671R
        rL9iWpnV1RgOetlqO+0FSPkAhHMne4dnL9I90W+ogcNbzBefgSJ37hrnnX2+FKve
        gPNEuQoglb/LnSJjwdCaw==
X-ME-Sender: <xms:8wGCYo49VntYljbrSHHolORQAcMTijvSD-8eMAMtrA51n-Zj3A8SCg>
    <xme:8wGCYp7l4ymnVsP13m5lb5N19vVptiOQ17XAYvkrhOgmPrxkj3nvTt2eknUmKmaj2
    rpklhGcY0MdDw>
X-ME-Received: <xmr:8wGCYncQXT-bT31WUgqvFCQ4GQMxUUi5JTLobWbSeptCGB8d8ETsuKRxUMtOxf_N4O9weAkkOx1K3ttmSxOmmFNQUFdqnlnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:8wGCYtJYAjz42uxli_nyY7fMNZ7HPVcSIUkFvg9ri-6KkhU7MT-_ig>
    <xmx:8wGCYsJBqOLpm2fnuFFYF7JRtW5Fqb6lQRgBv6vqmq7LqtWndXaOBQ>
    <xmx:8wGCYuzndggJaBpp9HfravyOFKJ_NREg9w7ecb0joqE7dTBkJfSsRw>
    <xmx:9AGCYh56QJ_pe4tQLvwpMD7fB5quyPwgBNYUI1s5PVGfFl0LZRk7-w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 May 2022 03:49:07 -0400 (EDT)
Date:   Mon, 16 May 2022 09:49:05 +0200
From:   Greg KH <greg@kroah.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Carlos Llamas <cmllamas@google.com>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wayne Campbell <wcampbell1995@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the rust tree with the char-misc tree
Message-ID: <YoIB8WCdgHr6Cp+z@kroah.com>
References: <20220516171329.6b10e4e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516171329.6b10e4e5@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 05:13:29PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rust tree got a conflict in:
> 
>   include/uapi/linux/android/binder.h
> 
> between commit:
> 
>   bd32889e841c ("binder: add BINDER_GET_EXTENDED_ERROR ioctl")
> 
> from the char-misc tree and commit:
> 
>   d637f9ec1954 ("[RFC] drivers: android: Binder IPC in Rust")
> 
> from the rust tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc include/uapi/linux/android/binder.h
> index e6ee8cae303b,a982c30dbbf5..000000000000
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@@ -236,35 -236,21 +236,37 @@@ struct binder_frozen_status_info 
>   	__u32            async_recv;
>   };
>   
>  +/* struct binder_extened_error - extended error information
>  + * @id:		identifier for the failed operation
>  + * @command:	command as defined by binder_driver_return_protocol
>  + * @param:	parameter holding a negative errno value
>  + *
>  + * Used with BINDER_GET_EXTENDED_ERROR. This extends the error information
>  + * returned by the driver upon a failed operation. Userspace can pull this
>  + * data to properly handle specific error scenarios.
>  + */
>  +struct binder_extended_error {
>  +	__u32	id;
>  +	__u32	command;
>  +	__s32	param;
>  +};
>  +
> - #define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
> - #define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
> - #define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
> - #define BINDER_SET_IDLE_PRIORITY	_IOW('b', 6, __s32)
> - #define BINDER_SET_CONTEXT_MGR		_IOW('b', 7, __s32)
> - #define BINDER_THREAD_EXIT		_IOW('b', 8, __s32)
> - #define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
> - #define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
> - #define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
> - #define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_object)
> - #define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
> - #define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_status_info)
> - #define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
> - #define BINDER_GET_EXTENDED_ERROR	_IOWR('b', 17, struct binder_extended_error)
> + enum {
> + 	BINDER_WRITE_READ		= _IOWR('b', 1, struct binder_write_read),
> + 	BINDER_SET_IDLE_TIMEOUT		= _IOW('b', 3, __s64),
> + 	BINDER_SET_MAX_THREADS		= _IOW('b', 5, __u32),
> + 	BINDER_SET_IDLE_PRIORITY	= _IOW('b', 6, __s32),
> + 	BINDER_SET_CONTEXT_MGR		= _IOW('b', 7, __s32),
> + 	BINDER_THREAD_EXIT		= _IOW('b', 8, __s32),
> + 	BINDER_VERSION			= _IOWR('b', 9, struct binder_version),
> + 	BINDER_GET_NODE_DEBUG_INFO	= _IOWR('b', 11, struct binder_node_debug_info),
> + 	BINDER_GET_NODE_INFO_FOR_REF	= _IOWR('b', 12, struct binder_node_info_for_ref),
> + 	BINDER_SET_CONTEXT_MGR_EXT	= _IOW('b', 13, struct flat_binder_object),
> + 	BINDER_FREEZE			= _IOW('b', 14, struct binder_freeze_info),
> + 	BINDER_GET_FROZEN_INFO		= _IOWR('b', 15, struct binder_frozen_status_info),
> + 	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	= _IOW('b', 16, __u32),
> ++	BINDER_GET_EXTENDED_ERROR	= _IOWR('b', 17, struct binder_extended_error),
> + };
>   

Odd, why does the Rust binder implementation require the IOCTL
definitions to be in an enum instead of a #define?

If that's required, I can take that type of change now to prevent merge
issues in the future.

thanks,

greg k-h
