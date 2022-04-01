Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB104EF8A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349519AbiDARIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbiDARIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:08:36 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478EE17DCAA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=jFGqPDhlqc8KEIpDKFpuOlQuvuFYmdqjb8dDnetXz3A=; b=aoJUV8eIqztrA7sMTQarMWXhCg
        x5/pEgywEa4S/5QDlcHYV0XU8CwmSJ/1mYnw9fxlBaBJDY+glbfChpWtECPNvT8lw5IUteoc0E0z8
        gDeuqqWByLGeME2C59nlScbt72lFY9QdKwb2njxpBCisi7yh36sl0nPFPpq2n5j+oA40qyHZmD2WE
        sWyEvKQxJDExr/ytEGIygp8mjFSIzEf6dvoTNYwImH5K0NgiGSP26VifSaSFxBwlyrHVS3ZaRwM2L
        uHfqi3OT/PhH+FpMAnwgQ7XhMKZZ4y4jbbTJMt5z82PCGfkT1ujHkkHJuPlaJKKMMNaQk8M9DFsa4
        T1EiGGeAz8SRlt9+fXIOnhbW53RD5LN9czbmUIis4wVVhfCGwj2w0veRHsBnRxLxM6NVfQd/fo2ln
        lLLBrB1cJt3O/wgXw1wqp2wLyPjYxfTimQrJEhY/BOPX1/kJEIXIO5aRNgK/UUvbOPAIgXUNI99SM
        s5OR9UYxB30PswvFvlW95TcHNzBm9YfP4EgyN6ovosfhLbdSt1sQqO49IkL0gqKeKHwjgfJlCah9Z
        nSPb0Mi5ilSTaTddF2ClyJaK+33fmubR5l9o2SDdzRleCRr0vuCcL6JC+0l1EXnLMPOiftjGQyJ4i
        90vg03U/nyYF7WyLDWIrKzUCAXEt7mg/4kBWCS+dE=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH] 9p: remove unnecessary type castings
Date:   Fri, 01 Apr 2022 19:06:39 +0200
Message-ID: <2411905.eXaiZ4YaiN@silver>
In-Reply-To: <20220401070545.50577-1-yuzhe@nfschina.com>
References: <20220401070545.50577-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 1. April 2022 09:05:45 CEST Yu Zhe wrote:
> remove unnecessary void* type castings.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  fs/9p/fid.c            | 2 +-
>  fs/9p/v9fs.c           | 2 +-
>  fs/9p/vfs_inode.c      | 4 ++--
>  fs/9p/vfs_inode_dotl.c | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> index 79df61fe0e59..c2b8d7fc9e53 100644
> --- a/fs/9p/fid.c
> +++ b/fs/9p/fid.c
> @@ -53,7 +53,7 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode
> *inode, kuid_t uid) p9_debug(P9_DEBUG_VFS, " inode: %p\n", inode);
> 
>  	spin_lock(&inode->i_lock);
> -	h = (struct hlist_head *)&inode->i_private;
> +	h = &inode->i_private;
>  	hlist_for_each_entry(fid, h, ilist) {
>  		if (uid_eq(fid->uid, uid)) {
>  			refcount_inc(&fid->count);
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index e28ddf763b3b..51ddc58a7029 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -622,7 +622,7 @@ static void v9fs_sysfs_cleanup(void)
> 
>  static void v9fs_inode_init_once(void *foo)
>  {
> -	struct v9fs_inode *v9inode = (struct v9fs_inode *)foo;
> +	struct v9fs_inode *v9inode = foo;
> 
>  	memset(&v9inode->qid, 0, sizeof(v9inode->qid));
>  	inode_init_once(&v9inode->vfs_inode);
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 55367ecb9442..f415fd7a1eaf 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -409,7 +409,7 @@ static int v9fs_test_inode(struct inode *inode, void
> *data) int umode;
>  	dev_t rdev;
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> -	struct p9_wstat *st = (struct p9_wstat *)data;
> +	struct p9_wstat *st = data;
>  	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
> 
>  	umode = p9mode2unixmode(v9ses, st, &rdev);
> @@ -438,7 +438,7 @@ static int v9fs_test_new_inode(struct inode *inode, void
> *data) static int v9fs_set_inode(struct inode *inode,  void *data)
>  {
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> -	struct p9_wstat *st = (struct p9_wstat *)data;
> +	struct p9_wstat *st = data;
> 
>  	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
>  	return 0;
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index d17502a738a9..b910fee62e25 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -57,7 +57,7 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode
> *dir_inode) static int v9fs_test_inode_dotl(struct inode *inode, void
> *data)
>  {
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> -	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
> +	struct p9_stat_dotl *st = data;
> 
>  	/* don't match inode of different type */
>  	if (inode_wrong_type(inode, st->st_mode))
> @@ -88,7 +88,7 @@ static int v9fs_test_new_inode_dotl(struct inode *inode,
> void *data) static int v9fs_set_inode_dotl(struct inode *inode,  void
> *data)
>  {
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> -	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
> +	struct p9_stat_dotl *st = data;
> 
>  	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
>  	inode->i_generation = st->st_gen;


