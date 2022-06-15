Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD21A54BFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345644AbiFODDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbiFODDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:03:17 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB262E0A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:03:15 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 870AAC01D; Wed, 15 Jun 2022 05:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655262193; bh=7kMu/er3n8xssH8Yllmj0gmeCch7WnvyDQ8/z2G1Q2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWdCwODk2Y5gdwoUgKCqvykGg6/H48ERJUP5x05TQqlJVF5gwsqJLP8sOgH3eEwMP
         gCt1LgCGDPz1eP4maHvNv8sNSrPKevbSP5P1x0HDnHzDCB6CWb3gIvBO7U+8WtFpt2
         f/lLINpLo2f50MbIKP/3jWa0S0GxkOoG/OwLFRUZXXxLKnNqdQeVvBtao5JBd8gnB5
         OrDhtF5Sr0sMa9zOFksSD+ygHAndA+mVH49915/YO/vtVGt3kaobQGOQlP53AbP+GL
         WSTBIT27jLRSskZ6qmR1AM9vPve1GEMUmF6ejLNK20LtXgIGN7Gw5owZI/2hnpz4fY
         zom2InOdOBf2A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id CB626C009;
        Wed, 15 Jun 2022 05:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655262192; bh=7kMu/er3n8xssH8Yllmj0gmeCch7WnvyDQ8/z2G1Q2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUWQ0WmgDU4ApRpsAeCgnHYYc0gpOOnOPQARXLU+/+QYg+JveNgdIh7niWo4ODInc
         NRKDnKqKqeASbiKtO30/KdDDgl/jWCBvVrxq7cMqxLevqEnEA0W4ayBDEeyk6JZ5dX
         Xwbdzd5OWo47hUvow5Zn2vRKJ9220xYVr7nKboGvuLUp+InusnACXjrnqB8Tru0zHr
         p43bpSHgrBu/Lc+LtXf3jS94EX9NyF1R0PrElD6dayWwS1QjzX+VjyV+gWRDoPqwUq
         ifKWb9JgIN+vsd6RYDHFlEWE4pqxglpUo95LhoUGwrmMuR2MXEnJHxMAXf7VlnfC0R
         Ri5wnGBHivXUA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id da6275d0;
        Wed, 15 Jun 2022 03:03:06 +0000 (UTC)
Date:   Wed, 15 Jun 2022 12:02:51 +0900
From:   asmadeus@codewreck.org
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, linux_oss@crudebyte.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] 9p: Fix some kernel-doc comments
Message-ID: <YqlL22D6l7XErRoo@codewreck.org>
References: <20220615012039.43479-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220615012039.43479-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Li wrote on Wed, Jun 15, 2022 at 09:20:39AM +0800:
> Remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.

ugh, I was told W=1 would become the default for net,
but I guess it isn't question about that yet for fs...

Do you know how to make W=1 the default for part of the subtree?

> fs/9p/fid.c:35: warning: Function parameter or member 'pfid' not described in 'v9fs_fid_add'
> fs/9p/fid.c:35: warning: Excess function parameter 'fid' description in 'v9fs_fid_add'
> fs/9p/fid.c:80: warning: Function parameter or member 'pfid' not described in 'v9fs_open_fid_add'
> fs/9p/fid.c:80: warning: Excess function parameter 'fid' description in 'v9fs_open_fid_add'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Will apply and add a note that it is NULLed out, thanks.

> ---
>  fs/9p/fid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> index 289a85eae2ae..3a0f5963b8bd 100644
> --- a/fs/9p/fid.c
> +++ b/fs/9p/fid.c
> @@ -28,7 +28,7 @@ static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
>  /**
>   * v9fs_fid_add - add a fid to a dentry
>   * @dentry: dentry that the fid is being added to
> - * @fid: fid to add
> + * @pfid: fid to add
>   *
>   */
>  void v9fs_fid_add(struct dentry *dentry, struct p9_fid **pfid)
> @@ -72,7 +72,7 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
>  /**
>   * v9fs_open_fid_add - add an open fid to an inode
>   * @inode: inode that the fid is being added to
> - * @fid: fid to add
> + * @pfid: fid to add
>   *
>   */
>  
