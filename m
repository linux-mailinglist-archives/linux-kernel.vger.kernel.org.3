Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD24C9CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiCBFMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCBFMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:12:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10901A1472
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 21:11:48 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o8so676403pgf.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 21:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/BU7EM+1ECfG3HM0ADtKSKbzzFmhc5Hk8AlcEtjFOQ=;
        b=FN+H1Esj1huQ9Ot41lfzGyEl6wv0FS0qCyjetYhtKwv63PFsaX/S7UTpam0YW2PmZk
         /ZCbdgxqKhV8BqF3ag1Ph53LTf3mPGXYOcZKNLNTTZcUgDW1xHN4Gd3sOBpf4Oo6AhOJ
         xRAHy8JKUmGbUH3kWTOnsZcPn8trIc/Qy++JjRQlBABK2XzyC9OVfybuYdmifq8GZ+6/
         hgxOYgi1MyEZI8YGGN9dCsJ/v0bi/q2YMpoyKNVceilx0pqXFm5Mk7HOgm6NE2Aagla1
         Zc4SB7eajz8GzMKKgf0PLySsdrPtttd8R8xOVVw9xUdsZPg+AuFI3NhlBrm6CXpOXizI
         L5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/BU7EM+1ECfG3HM0ADtKSKbzzFmhc5Hk8AlcEtjFOQ=;
        b=mIgWqytSGj3Y/8sz1A6Ame2Be2MzE/ZqwD/I+rCCHfWkuiPwB86+/0UD/isOB33Px+
         aOeVnJkYc0Jqvbfp+vEUs+PZnrXkQhchIZ+RtryEpVKsqOsg438L25eQYoiDGhBSRbIh
         KB952iWMboDx/YGGDwvLMoHkeuLnsuQ2J5D9tHESW6Iu5hHW+BDetSAl6D+om/of+bho
         2/f4cRLWwSBlr+V/c+UkKVlfOU9TitLncRBkU3xHnnig+gOg5v/G0oF4uf/70BP5dqbu
         umxUKR3cYZprm1wGIVFXKGvh0i9jruOCUrducL6BAr6CItbMxWObjvRjQrxsKOeyR8Wg
         RTnw==
X-Gm-Message-State: AOAM531u9zODBjhan3aPHNnV2S/koAsFznmHJVvSP/Zj2VCst4R3PF9I
        6hLv3qUzsilLEd4baGU4jgM=
X-Google-Smtp-Source: ABdhPJyrsPh7IDwapRtg9882hCgv8BrYCto8NPBOSPuEJXar31ikGOvbvL+ZG6K/jGecms+r2ERD9Q==
X-Received: by 2002:a63:4006:0:b0:375:7cc7:3622 with SMTP id n6-20020a634006000000b003757cc73622mr24659624pga.436.1646197907303;
        Tue, 01 Mar 2022 21:11:47 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id nl12-20020a17090b384c00b001bc1bb5449bsm3887335pjb.2.2022.03.01.21.11.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Mar 2022 21:11:47 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:10:20 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 1/2] erofs: get rid of `struct z_erofs_collector'
Message-ID: <20220302131020.00000c7b.zbestahu@gmail.com>
In-Reply-To: <Yh77X5NWnsHiPKIu@B-P7TQMD6M-0146.local>
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
        <20220302122203.000046f5.zbestahu@gmail.com>
        <Yh77X5NWnsHiPKIu@B-P7TQMD6M-0146.local>
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

On Wed, 2 Mar 2022 13:06:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Wed, Mar 02, 2022 at 12:22:03PM +0800, Yue Hu wrote:
> > Hi Xiang,
> > 
> > On Wed,  2 Mar 2022 03:49:50 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > Avoid `struct z_erofs_collector' since there is another context
> > > structure called "struct z_erofs_decompress_frontend".
> > > 
> > > No logic changes.
> > > 
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > >  fs/erofs/zdata.c | 163 ++++++++++++++++++++++-------------------------
> > >  1 file changed, 77 insertions(+), 86 deletions(-)
> > > 
> > > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > > index 423bc1a61da5..2673fc105861 100644
> > > --- a/fs/erofs/zdata.c
> > > +++ b/fs/erofs/zdata.c
> > > @@ -192,7 +192,10 @@ enum z_erofs_collectmode {
> > >  	COLLECT_PRIMARY_FOLLOWED,
> > >  };
> > >  
> > > -struct z_erofs_collector {
> > > +struct z_erofs_decompress_frontend {
> > > +	struct inode *const inode;
> > > +	struct erofs_map_blocks map;
> > > +
> > >  	struct z_erofs_pagevec_ctor vector;
> > >  
> > >  	struct z_erofs_pcluster *pcl, *tailpcl;
> > > @@ -202,13 +205,6 @@ struct z_erofs_collector {
> > >  	z_erofs_next_pcluster_t owned_head;
> > >  
> > >  	enum z_erofs_collectmode mode;
> > > -};
> > > -
> > > -struct z_erofs_decompress_frontend {
> > > -	struct inode *const inode;
> > > -
> > > -	struct z_erofs_collector clt;
> > > -	struct erofs_map_blocks map;
> > >  
> > >  	bool readahead;
> > >  	/* used for applying cache strategy on the fly */
> > > @@ -216,30 +212,26 @@ struct z_erofs_decompress_frontend {
> > >  	erofs_off_t headoffset;
> > >  };
> > >  
> > > -#define COLLECTOR_INIT() { \
> > > -	.owned_head = Z_EROFS_PCLUSTER_TAIL, \
> > > -	.mode = COLLECT_PRIMARY_FOLLOWED }
> > > -
> > >  #define DECOMPRESS_FRONTEND_INIT(__i) { \
> > > -	.inode = __i, .clt = COLLECTOR_INIT(), \
> > > -	.backmost = true, }
> > > +	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> > > +	.mode = COLLECT_PRIMARY_FOLLOWED }
> > >  
> > >  static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
> > >  static DEFINE_MUTEX(z_pagemap_global_lock);
> > >  
> > > -static void preload_compressed_pages(struct z_erofs_collector *clt,
> > > +static void preload_compressed_pages(struct z_erofs_decompress_frontend *fe,
> > >  				     struct address_space *mc,
> > >  				     enum z_erofs_cache_alloctype type,
> > >  				     struct page **pagepool)
> > >  {
> > > -	struct z_erofs_pcluster *pcl = clt->pcl;
> > > +	struct z_erofs_pcluster *pcl = fe->pcl;
> > >  	bool standalone = true;
> > >  	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
> > >  			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
> > >  	struct page **pages;
> > >  	pgoff_t index;
> > >  
> > > -	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
> > > +	if (fe->mode < COLLECT_PRIMARY_FOLLOWED)
> > >  		return;
> > >  
> > >  	pages = pcl->compressed_pages;
> > > @@ -288,7 +280,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
> > >  	 * managed cache since it can be moved to the bypass queue instead.
> > >  	 */
> > >  	if (standalone)
> > > -		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
> > > +		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
> > >  }
> > >  
> > >  /* called by erofs_shrinker to get rid of all compressed_pages */
> > > @@ -350,47 +342,47 @@ int erofs_try_to_free_cached_page(struct page *page)
> > >  }
> > >  
> > >  /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
> > > -static bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
> > > +static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
> > >  				   struct page *page)
> > >  {
> > > -	struct z_erofs_pcluster *const pcl = clt->pcl;
> > > +	struct z_erofs_pcluster *const pcl = fe->pcl;
> > >  
> > > -	while (clt->icpage_ptr > pcl->compressed_pages)
> > > -		if (!cmpxchg(--clt->icpage_ptr, NULL, page))
> > > +	while (fe->icpage_ptr > pcl->compressed_pages)
> > > +		if (!cmpxchg(--fe->icpage_ptr, NULL, page))
> > >  			return true;
> > >  	return false;
> > >  }
> > >  
> > >  /* callers must be with collection lock held */
> > > -static int z_erofs_attach_page(struct z_erofs_collector *clt,
> > > +static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
> > >  			       struct page *page, enum z_erofs_page_type type,
> > >  			       bool pvec_safereuse)
> > >  {
> > >  	int ret;
> > >  
> > >  	/* give priority for inplaceio */
> > > -	if (clt->mode >= COLLECT_PRIMARY &&
> > > +	if (fe->mode >= COLLECT_PRIMARY &&
> > >  	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
> > > -	    z_erofs_try_inplace_io(clt, page))
> > > +	    z_erofs_try_inplace_io(fe, page))
> > >  		return 0;
> > >  
> > > -	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type,
> > > +	ret = z_erofs_pagevec_enqueue(&fe->vector, page, type,
> > >  				      pvec_safereuse);
> > > -	clt->cl->vcnt += (unsigned int)ret;
> > > +	fe->cl->vcnt += (unsigned int)ret;
> > >  	return ret ? 0 : -EAGAIN;
> > >  }
> > >  
> > > -static void z_erofs_try_to_claim_pcluster(struct z_erofs_collector *clt)
> > > +static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
> > >  {
> > > -	struct z_erofs_pcluster *pcl = clt->pcl;
> > > -	z_erofs_next_pcluster_t *owned_head = &clt->owned_head;
> > > +	struct z_erofs_pcluster *pcl = f->pcl;
> > > +	z_erofs_next_pcluster_t *owned_head = &f->owned_head;
> > >  
> > >  	/* type 1, nil pcluster (this pcluster doesn't belong to any chain.) */
> > >  	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
> > >  		    *owned_head) == Z_EROFS_PCLUSTER_NIL) {
> > >  		*owned_head = &pcl->next;
> > >  		/* so we can attach this pcluster to our submission chain. */
> > > -		clt->mode = COLLECT_PRIMARY_FOLLOWED;
> > > +		f->mode = COLLECT_PRIMARY_FOLLOWED;
> > >  		return;
> > >  	}
> > >  
> > > @@ -401,24 +393,24 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_collector *clt)
> > >  	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
> > >  		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
> > >  		*owned_head = Z_EROFS_PCLUSTER_TAIL;
> > > -		clt->mode = COLLECT_PRIMARY_HOOKED;
> > > -		clt->tailpcl = NULL;
> > > +		f->mode = COLLECT_PRIMARY_HOOKED;
> > > +		f->tailpcl = NULL;
> > >  		return;
> > >  	}
> > >  	/* type 3, it belongs to a chain, but it isn't the end of the chain */
> > > -	clt->mode = COLLECT_PRIMARY;
> > > +	f->mode = COLLECT_PRIMARY;
> > >  }
> > >  
> > > -static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
> > > +static int z_erofs_lookup_collection(struct z_erofs_decompress_frontend *fe,
> > >  				     struct inode *inode,
> > >  				     struct erofs_map_blocks *map)
> > >  {
> > > -	struct z_erofs_pcluster *pcl = clt->pcl;
> > > +	struct z_erofs_pcluster *pcl = fe->pcl;
> > >  	struct z_erofs_collection *cl;
> > >  	unsigned int length;
> > >  
> > >  	/* to avoid unexpected loop formed by corrupted images */
> > > -	if (clt->owned_head == &pcl->next || pcl == clt->tailpcl) {
> > > +	if (fe->owned_head == &pcl->next || pcl == fe->tailpcl) {
> > >  		DBG_BUGON(1);
> > >  		return -EFSCORRUPTED;
> > >  	}
> > > @@ -449,15 +441,15 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
> > >  	}
> > >  	mutex_lock(&cl->lock);
> > >  	/* used to check tail merging loop due to corrupted images */
> > > -	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
> > > -		clt->tailpcl = pcl;
> > > +	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
> > > +		fe->tailpcl = pcl;
> > >  
> > > -	z_erofs_try_to_claim_pcluster(clt);
> > > -	clt->cl = cl;
> > > +	z_erofs_try_to_claim_pcluster(fe);
> > > +	fe->cl = cl;
> > >  	return 0;
> > >  }
> > >  
> > > -static int z_erofs_register_collection(struct z_erofs_collector *clt,
> > > +static int z_erofs_register_collection(struct z_erofs_decompress_frontend *fe,
> > >  				       struct inode *inode,
> > >  				       struct erofs_map_blocks *map)
> > >  {
> > > @@ -485,8 +477,8 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> > >  			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);
> > >  
> > >  	/* new pclusters should be claimed as type 1, primary and followed */
> > > -	pcl->next = clt->owned_head;
> > > -	clt->mode = COLLECT_PRIMARY_FOLLOWED;
> > > +	pcl->next = fe->owned_head;
> > > +	fe->mode = COLLECT_PRIMARY_FOLLOWED;
> > >  
> > >  	cl = z_erofs_primarycollection(pcl);
> > >  	cl->pageofs = map->m_la & ~PAGE_MASK;
> > > @@ -512,18 +504,18 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> > >  		}
> > >  
> > >  		if (grp != &pcl->obj) {
> > > -			clt->pcl = container_of(grp,
> > > +			fe->pcl = container_of(grp,
> > >  					struct z_erofs_pcluster, obj);
> > >  			err = -EEXIST;
> > >  			goto err_out;
> > >  		}
> > >  	}
> > >  	/* used to check tail merging loop due to corrupted images */
> > > -	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
> > > -		clt->tailpcl = pcl;
> > > -	clt->owned_head = &pcl->next;
> > > -	clt->pcl = pcl;
> > > -	clt->cl = cl;
> > > +	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
> > > +		fe->tailpcl = pcl;
> > > +	fe->owned_head = &pcl->next;
> > > +	fe->pcl = pcl;
> > > +	fe->cl = cl;
> > >  	return 0;
> > >  
> > >  err_out:
> > > @@ -532,18 +524,18 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> > >  	return err;
> > >  }
> > >  
> > > -static int z_erofs_collector_begin(struct z_erofs_collector *clt,
> > > +static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
> > >  				   struct inode *inode,
> > >  				   struct erofs_map_blocks *map)
> > >  {
> > >  	struct erofs_workgroup *grp;
> > >  	int ret;
> > >  
> > > -	DBG_BUGON(clt->cl);
> > > +	DBG_BUGON(fe->cl);
> > >  
> > >  	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous collection */
> > > -	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
> > > -	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
> > > +	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
> > > +	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
> > >  
> > >  	if (map->m_flags & EROFS_MAP_META) {
> > >  		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> > > @@ -555,28 +547,28 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
> > >  
> > >  	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
> > >  	if (grp) {
> > > -		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> > > +		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> > >  	} else {
> > >  tailpacking:
> > > -		ret = z_erofs_register_collection(clt, inode, map);
> > > +		ret = z_erofs_register_collection(fe, inode, map);
> > >  		if (!ret)
> > >  			goto out;
> > >  		if (ret != -EEXIST)
> > >  			return ret;
> > >  	}
> > >  
> > > -	ret = z_erofs_lookup_collection(clt, inode, map);
> > > +	ret = z_erofs_lookup_collection(fe, inode, map);
> > >  	if (ret) {
> > > -		erofs_workgroup_put(&clt->pcl->obj);
> > > +		erofs_workgroup_put(&fe->pcl->obj);
> > >  		return ret;
> > >  	}
> > >  
> > >  out:
> > > -	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
> > > -				  clt->cl->pagevec, clt->cl->vcnt);
> > > +	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
> > > +				  fe->cl->pagevec, fe->cl->vcnt);
> > >  	/* since file-backed online pages are traversed in reverse order */
> > > -	clt->icpage_ptr = clt->pcl->compressed_pages +
> > > -			z_erofs_pclusterpages(clt->pcl);
> > > +	fe->icpage_ptr = fe->pcl->compressed_pages +
> > > +			z_erofs_pclusterpages(fe->pcl);
> > >  	return 0;
> > >  }
> > >  
> > > @@ -610,24 +602,24 @@ static void z_erofs_collection_put(struct z_erofs_collection *cl)
> > >  	erofs_workgroup_put(&pcl->obj);
> > >  }
> > >  
> > > -static bool z_erofs_collector_end(struct z_erofs_collector *clt)
> > > +static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
> > >  {
> > > -	struct z_erofs_collection *cl = clt->cl;
> > > +	struct z_erofs_collection *cl = fe->cl;
> > >  
> > >  	if (!cl)
> > >  		return false;
> > >  
> > > -	z_erofs_pagevec_ctor_exit(&clt->vector, false);
> > > +	z_erofs_pagevec_ctor_exit(&fe->vector, false);
> > >  	mutex_unlock(&cl->lock);
> > >  
> > >  	/*
> > >  	 * if all pending pages are added, don't hold its reference
> > >  	 * any longer if the pcluster isn't hosted by ourselves.
> > >  	 */
> > > -	if (clt->mode < COLLECT_PRIMARY_FOLLOWED_NOINPLACE)
> > > +	if (fe->mode < COLLECT_PRIMARY_FOLLOWED_NOINPLACE)
> > >  		z_erofs_collection_put(cl);
> > >  
> > > -	clt->cl = NULL;
> > > +	fe->cl = NULL;
> > >  	return true;
> > >  }
> > >  
> > > @@ -651,7 +643,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > >  	struct inode *const inode = fe->inode;
> > >  	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> > >  	struct erofs_map_blocks *const map = &fe->map;
> > > -	struct z_erofs_collector *const clt = &fe->clt;
> > >  	const loff_t offset = page_offset(page);
> > >  	bool tight = true;
> > >  
> > > @@ -672,7 +663,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > >  	if (offset + cur >= map->m_la &&
> > >  	    offset + cur < map->m_la + map->m_llen) {
> > >  		/* didn't get a valid collection previously (very rare) */
> > > -		if (!clt->cl)
> > > +		if (!fe->cl)
> > >  			goto restart_now;
> > >  		goto hitted;
> > >  	}
> > > @@ -680,7 +671,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > >  	/* go ahead the next map_blocks */
> > >  	erofs_dbg("%s: [out-of-range] pos %llu", __func__, offset + cur);
> > >  
> > > -	if (z_erofs_collector_end(clt))
> > > +	if (z_erofs_collector_end(fe))
> > >  		fe->backmost = false;
> > >  
> > >  	map->m_la = offset + cur;
> > > @@ -693,11 +684,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > >  	if (!(map->m_flags & EROFS_MAP_MAPPED))
> > >  		goto hitted;
> > >  
> > > -	err = z_erofs_collector_begin(clt, inode, map);
> > > +	err = z_erofs_collector_begin(fe, inode, map);  
> > 
> > now, we can get 'inode' and 'map' from 'fe'. so, it should be z_erofs_collector_begin(fe)?
> > if it's, need to change z_erofs_{register | lookup}_collection() correspondingly.   
> 
> This is just a trivial cleanup (just merge `collector' into `frontend').
> 
> We can update them in the following patches. Also I'd like to rename
> `collection' concept as well. However, since I'm not a native English
> speaker, I didn't find a more proper name though.
> 
> Thanks,
> Gao Xiang

understood.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

