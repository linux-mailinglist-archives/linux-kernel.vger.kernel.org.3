Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC10353DFBB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349141AbiFFCg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFFCgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:36:25 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA64A30542
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:36:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VFQ-rv7_1654482979;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VFQ-rv7_1654482979)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Jun 2022 10:36:21 +0800
Date:   Mon, 6 Jun 2022 10:36:19 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Message-ID: <Yp1oIye4FM+uU0a+@B-P7TQMD6M-0146.local>
References: <20220606021103.89211-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220606021103.89211-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:11:03AM +0800, Jeffle Xu wrote:
> Glad to contribute the fscache mode to erofs. Sincerely I recommend
> myself as the reviewer to maintain these codes.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Thanks for taking time on EROFS and looking after this.
Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1309e1496c23..6cd8b3631cc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7388,6 +7388,7 @@ EROFS FILE SYSTEM
>  M:	Gao Xiang <xiang@kernel.org>
>  M:	Chao Yu <chao@kernel.org>
>  R:	Yue Hu <huyue2@coolpad.com>
> +R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> -- 
> 2.27.0
