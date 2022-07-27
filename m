Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301035823C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiG0KE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiG0KEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:04:52 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD31CFE2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:04:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VKadIyQ_1658916285;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VKadIyQ_1658916285)
          by smtp.aliyun-inc.com;
          Wed, 27 Jul 2022 18:04:48 +0800
Date:   Wed, 27 Jul 2022 18:04:44 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] erofs: update ctx->pos for every emitted dirent
Message-ID: <YuENvEMh7us0vhKr@B-P7TQMD6M-0146.local>
References: <20220722082732.30935-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220722082732.30935-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 04:27:32PM +0800, Jeffle Xu wrote:
> From: Hongnan Li <hongnan.li@linux.alibaba.com>
> 
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Also fix the update of ctx->pos when the initial file position has
> exceeded nameoff.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
