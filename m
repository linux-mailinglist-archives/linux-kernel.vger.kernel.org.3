Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760FA575B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiGOGTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiGOGTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:19:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EE2316E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:19:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z1so2403160plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMVwwltACNc6monef/AHodt8BdNnm+vUW23Zo1dbsV4=;
        b=An8s0dotOcucer5lOaB8bEsBQxHb6V1tNxM+gPNpGVivXCn41Y3QFlr8CHPm8UzEfm
         Ob0mT7Ec4xc5KCgdk+VvzSas475PzPLW+ElthlYuSjRxlSVEArSd8vGkqMPBl3YTJUcD
         HDXai127x3c5O5g7Ex7tNzG17kfFfoKXwP3/4RLWvYL2WeEr1MXG0WHM406CE+gR0HRp
         II3mAd0TyvfLyfrg9ryEPjUMZb+UcWti+uSNnIFYaJsG4DrpM4Fs9Zb5ou53Uw29vU0I
         fFMCoqtRPTbGRDoiz0UOgFoUQLZo88V8Iau5mWuSUTfYev0lS1romqXvxYgZCW4pJ3Wk
         UJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMVwwltACNc6monef/AHodt8BdNnm+vUW23Zo1dbsV4=;
        b=gTk+XyUvuYzTEAe0v0gWj5bDI5KoqfDxSHb9GKaF9LR4V/h1fddwzRNnFy8tuULnPG
         rW5uR0blqYohB59WpV+MlAhjiCaAQtQkxEFK0p4rXmGrUxjoekv1KhBzWuH74AkY/tFY
         oM4UU5G03BVv0iW2j/EJTB/rhXBUYA9VlrS3IXeAN8FrcHygN4oxrcfLP9gclFZo9POd
         egFAekQ84w+HYsJ63Ewk265H9WHwAaDDf6+2izhSYTZR6HjlF1ayxJHgfGyiCSI6u6vT
         7JkEIJtSxfSnDI4DZOwcAOefiP3c/J2lW/jzNHbVHcTmUAPFv3OUjKxDxDNig2wjS6gL
         KTTA==
X-Gm-Message-State: AJIora8w2Su6I7NSq6T8tpt1p7zdumaGDspQ9u7XgBZRfjpJKNhZrAsX
        NCSnMj7C74nQ3zyBSx1pFy/gVBRF5CM=
X-Google-Smtp-Source: AGRyM1trRcOnQ7lQ+XriIfbnO1jIeaPRUywUIOOPYh2v5ddznNGOPTpJHvBXKzG5GwIjDsujiFWC5w==
X-Received: by 2002:a17:902:d50a:b0:16c:3c08:3637 with SMTP id b10-20020a170902d50a00b0016c3c083637mr12735767plg.137.1657865976459;
        Thu, 14 Jul 2022 23:19:36 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id oj4-20020a17090b4d8400b001ef8fb72224sm4765610pjb.53.2022.07.14.23.19.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jul 2022 23:19:36 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:20:58 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 01/16] erofs: get rid of unneeded `inode', `map' and
 `sb'
Message-ID: <20220715142058.00005f60.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-2-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
        <20220714132051.46012-2-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 21:20:36 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Since commit 5c6dcc57e2e5 ("erofs: get rid of
> `struct z_erofs_collector'"), these arguments can be dropped as well.
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 724bb57075f6..1b6816dd235f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -404,10 +404,9 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
>  	f->mode = COLLECT_PRIMARY;
>  }
>  
> -static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe,
> -				   struct inode *inode,
> -				   struct erofs_map_blocks *map)
> +static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe)
>  {
> +	struct erofs_map_blocks *map = &fe->map;
>  	struct z_erofs_pcluster *pcl = fe->pcl;
>  	unsigned int length;
>  
> @@ -449,10 +448,9 @@ static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe,
>  	return 0;
>  }
>  
> -static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
> -				     struct inode *inode,
> -				     struct erofs_map_blocks *map)
> +static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  {
> +	struct erofs_map_blocks *map = &fe->map;
>  	bool ztailpacking = map->m_flags & EROFS_MAP_META;
>  	struct z_erofs_pcluster *pcl;
>  	struct erofs_workgroup *grp;
> @@ -494,7 +492,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
>  	} else {
>  		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
>  
> -		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
> +		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
>  		if (IS_ERR(grp)) {
>  			err = PTR_ERR(grp);
>  			goto err_out;
> @@ -520,10 +518,9 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe,
>  	return err;
>  }
>  
> -static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
> -				   struct inode *inode,
> -				   struct erofs_map_blocks *map)
> +static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  {
> +	struct erofs_map_blocks *map = &fe->map;
>  	struct erofs_workgroup *grp;
>  	int ret;
>  
> @@ -541,19 +538,19 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
>  		goto tailpacking;
>  	}
>  
> -	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
> +	grp = erofs_find_workgroup(fe->inode->i_sb, map->m_pa >> PAGE_SHIFT);
>  	if (grp) {
>  		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
>  	} else {
>  tailpacking:
> -		ret = z_erofs_register_pcluster(fe, inode, map);
> +		ret = z_erofs_register_pcluster(fe);
>  		if (!ret)
>  			goto out;
>  		if (ret != -EEXIST)
>  			return ret;
>  	}
>  
> -	ret = z_erofs_lookup_pcluster(fe, inode, map);
> +	ret = z_erofs_lookup_pcluster(fe);
>  	if (ret) {
>  		erofs_workgroup_put(&fe->pcl->obj);
>  		return ret;
> @@ -663,7 +660,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	if (!(map->m_flags & EROFS_MAP_MAPPED))
>  		goto hitted;
>  
> -	err = z_erofs_collector_begin(fe, inode, map);
> +	err = z_erofs_collector_begin(fe);
>  	if (err)
>  		goto err_out;
>  
> @@ -1259,13 +1256,13 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> -static void z_erofs_submit_queue(struct super_block *sb,
> -				 struct z_erofs_decompress_frontend *f,
> +static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  				 struct page **pagepool,
>  				 struct z_erofs_decompressqueue *fgq,
>  				 bool *force_fg)
>  {
> -	struct erofs_sb_info *const sbi = EROFS_SB(sb);
> +	struct super_block *sb = f->inode->i_sb;
> +	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
>  	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
>  	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
>  	void *bi_private;
> @@ -1317,7 +1314,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
>  			struct page *page;
>  
>  			page = pickup_page_for_submission(pcl, i++, pagepool,
> -							  MNGD_MAPPING(sbi));
> +							  mc);
>  			if (!page)
>  				continue;
>  
> @@ -1369,15 +1366,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
>  	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
>  }
>  
> -static void z_erofs_runqueue(struct super_block *sb,
> -			     struct z_erofs_decompress_frontend *f,
> +static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
>  			     struct page **pagepool, bool force_fg)
>  {
>  	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
>  
>  	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
>  		return;
> -	z_erofs_submit_queue(sb, f, pagepool, io, &force_fg);
> +	z_erofs_submit_queue(f, pagepool, io, &force_fg);
>  
>  	/* handle bypass queue (no i/o pclusters) immediately */
>  	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
> @@ -1475,7 +1471,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>  	(void)z_erofs_collector_end(&f);
>  
>  	/* if some compressed cluster ready, need submit them anyway */
> -	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
> +	z_erofs_runqueue(&f, &pagepool,
>  			 z_erofs_get_sync_decompress_policy(sbi, 0));
>  
>  	if (err)
> @@ -1524,7 +1520,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
>  	(void)z_erofs_collector_end(&f);
>  
> -	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
> +	z_erofs_runqueue(&f, &pagepool,
>  			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
>  	erofs_put_metabuf(&f.map.buf);
>  	erofs_release_pages(&pagepool);

Reviewed-by: Yue Hu <huyue2@coolpad.com>
