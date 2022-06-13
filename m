Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08861549D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349534AbiFMTWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348780AbiFMTVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4113E00
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8443660C2D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA7FC3411B;
        Mon, 13 Jun 2022 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655140672;
        bh=I7zhquTCHiU1cX/QcueveyTLeLXa1KVMfppA/Uw7T/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPiC/l7YP0+P/Mq8byhVCgleFNHCwBwkQ06tyF9EwDKxDuvXwxYZcQHQYCUMNl72g
         9nHiKGCdhdyvZgUuJ00I7EnJYvex2i+aP3/H1FCWagRgG8iBIyXHhpPEDQpGBVOgrk
         I+nW+gNC+CtYnuehTs6i6QGWnFR9fOeHwgEsEAa77hl0uomcvxIl0Ewx6js2oqfNUY
         SWWPu2PDT0VJAJ0NmW8EGJ4FBLzPydvKPAD7KKrEwXJ5qRUwfoIydOnOMS7a2rXyhI
         fw/g9aQDjOiu2AdO3WaQuI/W8DO8CW+tbdxwgiAD0oVlstvZEZYoOg4DX5vOJ5Lvt4
         6mYgTTXHdpfPA==
Date:   Mon, 13 Jun 2022 10:17:51 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Liu <chaoliu719@gmail.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH] f2fs: refine comments for inline flags
Message-ID: <YqdxP411VW4Egxgu@google.com>
References: <20220602072449.998303-1-chaoliu719@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602072449.998303-1-chaoliu719@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> Currently, we use f2fs_has_inline_xattr() to check whether the
> inode can store inline xattr. However, it might be misinterpreted
> as the inode has at least one inline xattr.
> 
> The same is true for f2fs_has_inline_data() and
> f2fs_has_inline_dentry(). To be more intuitive and specific,
> refine comments of inline flags.

I don't see a big benefit to get this patch, but will lose the history.

> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>
> ---
>  fs/f2fs/f2fs.h          | 6 +++---
>  include/linux/f2fs_fs.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e10838879538..e0205d42588d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -730,9 +730,9 @@ enum {
>  	FI_NO_ALLOC,		/* should not allocate any blocks */
>  	FI_FREE_NID,		/* free allocated nide */
>  	FI_NO_EXTENT,		/* not to use the extent cache */
> -	FI_INLINE_XATTR,	/* used for inline xattr */
> -	FI_INLINE_DATA,		/* used for inline data*/
> -	FI_INLINE_DENTRY,	/* used for inline dentry */
> +	FI_INLINE_XATTR,	/* inode can store inline xattr */
> +	FI_INLINE_DATA,		/* inode can store inline data */
> +	FI_INLINE_DENTRY,	/* inode can store inline dentry */
>  	FI_APPEND_WRITE,	/* inode has appended data */
>  	FI_UPDATE_WRITE,	/* inode has in-place-update data */
>  	FI_NEED_IPU,		/* used for ipu per file */
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index d445150c5350..a3c6750a66ae 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -223,9 +223,9 @@ struct f2fs_extent {
>  #define	NODE_IND2_BLOCK		(DEF_ADDRS_PER_INODE + 4)
>  #define	NODE_DIND_BLOCK		(DEF_ADDRS_PER_INODE + 5)
>  
> -#define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
> -#define F2FS_INLINE_DATA	0x02	/* file inline data flag */
> -#define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
> +#define F2FS_INLINE_XATTR	0x01	/* file can store inline xattr */
> +#define F2FS_INLINE_DATA	0x02	/* file can store inline data */
> +#define F2FS_INLINE_DENTRY	0x04	/* file can store inline dentry */
>  #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
>  #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
>  #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
> -- 
> 2.36.1
