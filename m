Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB246E091
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhLICCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhLICCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:02:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14077C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:58:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v19so2793018plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avQ6zouIiN9yCAxnJyjc2BEAENz7yIsL27blUDqPD6s=;
        b=JGAbRkaYN5fsHQKueBsFMUoELiDEq3dqyTc+SLnHD7g2GuC5TE/6on2JWfRiBJReEo
         UjRZKMgpBnX7qf7hnfKqjQgnnopjXi3EzIUR0a9pFmVNGWTJaYTk3AlXMJuq5T/xAQmr
         mixde3nA+yhgweK0TmDp37CUBbTGCI4nHQecucj77SHxUmLBnJR7b1J1zefHdZ05hZee
         S3lyxSip9BVgqrskDzzCQD1jVGYE3RwMMwHv+hAxBl3Fl6toYaI1aidOdB+Z4naClln6
         Y1KZShl1SH6lkVp1dyog6MiKvt1T0e5ycFTs4Y1lCT7pCdKQCax6IbrVoOlE1UWzoI/1
         WU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avQ6zouIiN9yCAxnJyjc2BEAENz7yIsL27blUDqPD6s=;
        b=FZ13vyZbxssUC0CF6DJRvI8o+3m8QYRLk3qbJymQwTmUYkYUhX9/p4u/JSWj+7CxZE
         REEH0iLoJFg0f1LSd4O26GeRl8ekQrywdOtNbOg8JWe02qSeSRISs+7o9gbIt8ms1Qab
         MIBhMro2IFQlgCeYkaWYCxXZge1oRBXbmEhf94ovPrGRqdYneoSd2og+mKegLDoTiG+M
         v8Gv7Je3lrNUDsagfxvH0SpYLQLCTSYSsZhDnbYMKZdEbRMGII1LbVXXIfOz961ill0C
         6qmHmmYxLz6gqC5g97sgxxC5txmLmsi2XvFj+xPZgJwvYNQYDwz6KRBUrzHUYdmaqvyQ
         +6aw==
X-Gm-Message-State: AOAM533lpdLzi/g15DSbCO8IS7f9Rwg3PEsCeU7IWdcmx7Srf5n/lOXt
        pCePmzPuq04PUsRfrs4e8cs=
X-Google-Smtp-Source: ABdhPJwlIE1PXQQI/w1u/lQW1i2uiXM5GSlwruVROb0fFETmzi7avVQ3qMGxbFKCo02w2ckhDbTTWA==
X-Received: by 2002:a17:90b:4b01:: with SMTP id lx1mr12007824pjb.38.1639015114562;
        Wed, 08 Dec 2021 17:58:34 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id t12sm7189747pjo.44.2021.12.08.17.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Dec 2021 17:58:34 -0800 (PST)
Date:   Thu, 9 Dec 2021 09:56:35 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@yulong.com
Subject: Re: [PATCH v2] erofs: clean up erofs_map_blocks tracepoints
Message-ID: <20211209095635.000012e8.zbestahu@gmail.com>
In-Reply-To: <20211209012918.30337-1-hsiangkao@linux.alibaba.com>
References: <20211209012918.30337-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Dec 2021 09:29:18 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Since the new type of chunk-based files is introduced, there is no
> need to leave flatmode tracepoints.
> 
> Rename to erofs_map_blocks instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v1: https://lore.kernel.org/r/20210921143531.81356-2-hsiangkao@linux.alibaba.com
> change since v1:
>  - fix m_llen assignment issue pointed out by Chao;
> 
>  fs/erofs/data.c              | 39 ++++++++++++++++--------------------
>  include/trace/events/erofs.h |  4 ++--
>  2 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0e35ef3f9f3d..4f98c76ec043 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -26,20 +26,16 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  				     struct erofs_map_blocks *map,
>  				     int flags)
>  {
> -	int err = 0;
>  	erofs_blk_t nblocks, lastblk;
>  	u64 offset = map->m_la;
>  	struct erofs_inode *vi = EROFS_I(inode);
>  	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
>  
> -	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
> -
>  	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
>  	lastblk = nblocks - tailendpacking;
>  
>  	/* there is no hole in flatmode */
>  	map->m_flags = EROFS_MAP_MAPPED;
> -
>  	if (offset < blknr_to_addr(lastblk)) {
>  		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
>  		map->m_plen = blknr_to_addr(lastblk) - offset;
> @@ -51,30 +47,23 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  			vi->xattr_isize + erofs_blkoff(map->m_la);
>  		map->m_plen = inode->i_size - offset;
>  
> -		/* inline data should be located in one meta block */
> -		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
> +		/* inline data should be located in the same meta block */
> +		if (erofs_blkoff(map->m_pa) + map->m_plen > EROFS_BLKSIZ) {
>  			erofs_err(inode->i_sb,
>  				  "inline data cross block boundary @ nid %llu",
>  				  vi->nid);
>  			DBG_BUGON(1);
> -			err = -EFSCORRUPTED;
> -			goto err_out;
> +			return -EFSCORRUPTED;
>  		}
> -
>  		map->m_flags |= EROFS_MAP_META;
>  	} else {
>  		erofs_err(inode->i_sb,
>  			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
>  			  vi->nid, inode->i_size, map->m_la);
>  		DBG_BUGON(1);
> -		err = -EIO;
> -		goto err_out;
> +		return -EIO;
>  	}
> -
> -	map->m_llen = map->m_plen;
> -err_out:
> -	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
> -	return err;
> +	return 0;
>  }
>  
>  static int erofs_map_blocks(struct inode *inode,
> @@ -89,6 +78,7 @@ static int erofs_map_blocks(struct inode *inode,
>  	erofs_off_t pos;
>  	int err = 0;
>  
> +	trace_erofs_map_blocks_enter(inode, map, flags);
>  	map->m_deviceid = 0;
>  	if (map->m_la >= inode->i_size) {
>  		/* leave out-of-bound access unmapped */
> @@ -97,8 +87,10 @@ static int erofs_map_blocks(struct inode *inode,
>  		goto out;
>  	}
>  
> -	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
> -		return erofs_map_blocks_flatmode(inode, map, flags);
> +	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
> +		err = erofs_map_blocks_flatmode(inode, map, flags);
> +		goto out;
> +	}
>  
>  	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
>  		unit = sizeof(*idx);			/* chunk index */
> @@ -110,9 +102,10 @@ static int erofs_map_blocks(struct inode *inode,
>  		    vi->xattr_isize, unit) + unit * chunknr;
>  
>  	page = erofs_get_meta_page(inode->i_sb, erofs_blknr(pos));
> -	if (IS_ERR(page))
> -		return PTR_ERR(page);
> -
> +	if (IS_ERR(page)) {
> +		err = PTR_ERR(page);
> +		goto out;
> +	}
>  	map->m_la = chunknr << vi->chunkbits;
>  	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
>  			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
> @@ -146,7 +139,9 @@ static int erofs_map_blocks(struct inode *inode,
>  	unlock_page(page);
>  	put_page(page);
>  out:
> -	map->m_llen = map->m_plen;
> +	if (!err)
> +		map->m_llen = map->m_plen;
> +	trace_erofs_map_blocks_exit(inode, map, flags, 0);
>  	return err;
>  }
>  
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index 16ae7b666810..57de057bd503 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -169,7 +169,7 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_enter,
>  		  __entry->flags ? show_map_flags(__entry->flags) : "NULL")
>  );
>  
> -DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_flatmode_enter,
> +DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_enter,
>  	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
>  		 unsigned flags),
>  
> @@ -221,7 +221,7 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
>  		  show_mflags(__entry->mflags), __entry->ret)
>  );
>  
> -DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_flatmode_exit,
> +DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_exit,
>  	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
>  		 unsigned flags, int ret),
>  

Reviewed-by: Yue Hu <huyue2@yulong.com>


