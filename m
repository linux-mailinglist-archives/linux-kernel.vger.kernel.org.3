Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D963659677F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiHQCli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiHQClf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:41:35 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FFA94EC1;
        Tue, 16 Aug 2022 19:41:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VMTZlVN_1660704088;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VMTZlVN_1660704088)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 10:41:30 +0800
Date:   Wed, 17 Aug 2022 10:41:28 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [PATCH] erofs: fix error return code in
 erofs_fscache_meta_read_folio and erofs_fscache_read_folio
Message-ID: <YvxVWP0njcgghe+r@B-P7TQMD6M-0146.local>
References: <20220815034829.3940803-1-sunke32@huawei.com>
 <YvsoIFzRlGpqNZKg@B-P7TQMD6M-0146.local>
 <d40a1e7e-d78c-1a99-0889-6fc4d2102e9d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d40a1e7e-d78c-1a99-0889-6fc4d2102e9d@huawei.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ke,

On Wed, Aug 17, 2022 at 09:44:46AM +0800, Sun Ke wrote:
> 
> 
> 在 2022/8/16 13:16, Gao Xiang 写道:
> > On Mon, Aug 15, 2022 at 11:48:29AM +0800, Sun Ke wrote:
> > > If erofs_fscache_alloc_request fail and then goto out, it will return 0.
> > > it should return a negative error code instead of 0.
> > > 
> > > Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
> > > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > 
> > Minor, I tried to apply this patch by updating the patch title into
> > "erofs: fix error return code in erofs_fscache_{meta_,}read_folio"
> > 
> > since the original patch title is too long.
> 
> Should I send a v2 patch to update the title?

I've already updated this by hand if you have no concern ;)
will push out to -next today...

Thanks,
Gao Xiang

> 
> Thanks,
> Sun Ke
> > 
> > Thanks,
> > Gao Xiang
> > .
> > 
