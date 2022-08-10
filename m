Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE258EB78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiHJLqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiHJLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:46:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A775C953;
        Wed, 10 Aug 2022 04:46:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so1838133pjf.5;
        Wed, 10 Aug 2022 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc;
        bh=ei1ljbOBBQBSPmSvzrg9QAdPpWtXbrDjFPAODhjUGRU=;
        b=nnYLI9q9ypTlhyS+QqNTEzY0nsk0KbZnJoUAEnjHOgB3VlOLXiPH4zGFOwybvU3y/c
         PtjfQZtMfk48L29BZKe/Kyr/b0dxzTMJID2NvRl6YtSR/ui+LbxWXLpwFrZwwcsVQPzS
         XGM694O9W3ocM+xy9zmJor7U91uvUsvEaS/qRV0wGanE/4y/KkQsLFOw5CZ/NkJ+9WRQ
         J9jm9AUXp0C+k8Sh81dsgsCfzRTjRBu4TytqisfoyfTHps2QVtdBL0uny3XKC55V+PyT
         0wi/1meO1LP+pcD0X7h2zhk7lgFLBX5XDNpmxeYto7Z2bTp7CD7w4IsDmezUZCWCg2Oy
         +gSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc;
        bh=ei1ljbOBBQBSPmSvzrg9QAdPpWtXbrDjFPAODhjUGRU=;
        b=KP08BlYfiQJSLLBGjhONqvGWKsWhUJLwKvXRvs1MDFzl67dkEHkcaBKP6N+DsxQBCO
         ze+pVtOS5PGXGiUGDADJs4l04FjaaFzqwt06xv1nh8iY7MLqNSlwHuqgXdW6nQ1jsgUS
         sIbs8KeXd+srcRGMkVvcg/wmHLya1mZk4s7SbMh+eM3BsoVvlawttb9bKgTcQePNmK2t
         ZeAOVMck+oPaHwsn1jIOHdn7NdlKKHLTuTHf+eWD2TL6DhGpTWhB+q482zLW4MMxTo7I
         NnLJ1MmC9HlZj9nVM65soy4A4ScugfSJL88AlsoG6+7k+6wgAjfDqH5pS7p8el/vEIAQ
         U6Zw==
X-Gm-Message-State: ACgBeo096dHKAwJBrFysFzZsFqK4/0lJ1ZJ2IvVXQhuMOC9jyI+i/nA9
        awCpnb4YOSi+LU/OkVH20Q==
X-Google-Smtp-Source: AA6agR7VtaMkCxIfKdLmKiHOns2CVnpwhFlkABxv/J4LgWQlhoT554XdWQxiS/18TXDdHpvMKxb9wQ==
X-Received: by 2002:a17:90b:4a0a:b0:1f4:e4fc:91d3 with SMTP id kk10-20020a17090b4a0a00b001f4e4fc91d3mr3300479pjb.67.1660131961540;
        Wed, 10 Aug 2022 04:46:01 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79a42000000b0052e0b928c3csm1712112pfj.219.2022.08.10.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:46:01 -0700 (PDT)
Date:   Wed, 10 Aug 2022 20:45:56 +0900 (JST)
Message-Id: <20220810.204556.441522765735488771.shigeru.yoshida@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk
Cc:     pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shigeru.yoshida@gmail.com
Subject: Re: [PATCH] virtio-blk: Avoid use-after-free on suspend/resume
From:   Shigeru Yoshida <shigeru.yoshida@gmail.com>
In-Reply-To: <20220731070951.196831-1-shigeru.yoshida@gmail.com>
References: <20220731070951.196831-1-shigeru.yoshida@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

ping?

On Sun, 31 Jul 2022 16:09:51 +0900, Shigeru Yoshida wrote:
> hctx->user_data is set to vq in virtblk_init_hctx().  However, vq is
> freed on suspend and reallocated on resume.  So, hctx->user_data is
> invalid after resume, and it will cause use-after-free accessing which
> will result in the kernel crash something like below:
> 
> [   22.428391] Call Trace:
> [   22.428899]  <TASK>
> [   22.429339]  virtqueue_add_split+0x3eb/0x620
> [   22.430035]  ? __blk_mq_alloc_requests+0x17f/0x2d0
> [   22.430789]  ? kvm_clock_get_cycles+0x14/0x30
> [   22.431496]  virtqueue_add_sgs+0xad/0xd0
> [   22.432108]  virtblk_add_req+0xe8/0x150
> [   22.432692]  virtio_queue_rqs+0xeb/0x210
> [   22.433330]  blk_mq_flush_plug_list+0x1b8/0x280
> [   22.434059]  __blk_flush_plug+0xe1/0x140
> [   22.434853]  blk_finish_plug+0x20/0x40
> [   22.435512]  read_pages+0x20a/0x2e0
> [   22.436063]  ? folio_add_lru+0x62/0xa0
> [   22.436652]  page_cache_ra_unbounded+0x112/0x160
> [   22.437365]  filemap_get_pages+0xe1/0x5b0
> [   22.437964]  ? context_to_sid+0x70/0x100
> [   22.438580]  ? sidtab_context_to_sid+0x32/0x400
> [   22.439979]  filemap_read+0xcd/0x3d0
> [   22.440917]  xfs_file_buffered_read+0x4a/0xc0
> [   22.441984]  xfs_file_read_iter+0x65/0xd0
> [   22.442970]  __kernel_read+0x160/0x2e0
> [   22.443921]  bprm_execve+0x21b/0x640
> [   22.444809]  do_execveat_common.isra.0+0x1a8/0x220
> [   22.446008]  __x64_sys_execve+0x2d/0x40
> [   22.446920]  do_syscall_64+0x37/0x90
> [   22.447773]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> This patch fixes this issue by getting vq from vblk, and removes
> virtblk_init_hctx().
> 
> Signed-off-by: Shigeru Yoshida <shigeru.yoshida@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6fc7850c2b0a..d756423e0059 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -101,6 +101,14 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
>  	}
>  }
>  
> +static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> +
> +	return vq;
> +}
> +
>  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>  {
>  	struct scatterlist hdr, status, *sgs[3];
> @@ -416,7 +424,7 @@ static void virtio_queue_rqs(struct request **rqlist)
>  	struct request *requeue_list = NULL;
>  
>  	rq_list_for_each_safe(rqlist, req, next) {
> -		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> +		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
>  		bool kick;
>  
>  		if (!virtblk_prep_rq_batch(req)) {
> @@ -837,7 +845,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
>  static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
> -	struct virtio_blk_vq *vq = hctx->driver_data;
> +	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
>  	struct virtblk_req *vbr;
>  	unsigned long flags;
>  	unsigned int len;
> @@ -862,22 +870,10 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  	return found;
>  }
>  
> -static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> -			  unsigned int hctx_idx)
> -{
> -	struct virtio_blk *vblk = data;
> -	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> -
> -	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
> -	hctx->driver_data = vq;
> -	return 0;
> -}
> -
>  static const struct blk_mq_ops virtio_mq_ops = {
>  	.queue_rq	= virtio_queue_rq,
>  	.queue_rqs	= virtio_queue_rqs,
>  	.commit_rqs	= virtio_commit_rqs,
> -	.init_hctx	= virtblk_init_hctx,
>  	.complete	= virtblk_request_done,
>  	.map_queues	= virtblk_map_queues,
>  	.poll		= virtblk_poll,
> -- 
> 2.37.1
> 
