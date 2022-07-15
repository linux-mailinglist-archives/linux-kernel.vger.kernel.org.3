Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4D575C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiGOHT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiGOHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:19:54 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFACA747A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:19:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJODXgh_1657869587;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJODXgh_1657869587)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 15:19:48 +0800
Date:   Fri, 15 Jul 2022 15:19:46 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 05/16] erofs: drop the old pagevec approach
Message-ID: <YtEVEtTOD2peFXum@B-P7TQMD6M-0146.local>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
 <20220714132051.46012-6-hsiangkao@linux.alibaba.com>
 <20220715150737.00006764.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220715150737.00006764.zbestahu@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 03:07:37PM +0800, Yue Hu wrote:
> On Thu, 14 Jul 2022 21:20:40 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Remove the old pagevec approach but keep z_erofs_page_type for now.
> > It will be reworked in the following commits as well.
> > 
> > Also rename Z_EROFS_NR_INLINE_PAGEVECS as Z_EROFS_INLINE_BVECS with
> > the new value 2 since it's actually enough to bootstrap.
> 
> I notice there are 2 comments as below which still use pagevec, should we
> update it as well?
> 
> [1] 
> * pagevec) since it can be directly decoded without I/O submission.
> [2]
> * for inplace I/O or pagevec (should be processed in strict order.)

Yeah, thanks for reminder... I will update it in this patch in the next
version.

> 
> BTW, utils.c includes needles <pagevec.h>, we can remove it along with the patchset
> or remove it later.

That is a completely different stuff, would you mind submitting a patch
to remove it if needed?

Thanks,
Gao Xiang
