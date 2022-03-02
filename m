Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AEB4C9BAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbiCBDEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiCBDEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:04:43 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C95F4D8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:03:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V60eo0v_1646190234;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V60eo0v_1646190234)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Mar 2022 11:03:56 +0800
Date:   Wed, 2 Mar 2022 11:03:54 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix ztailpacking on > 4GiB filesystems
Message-ID: <Yh7emmP7TkMZ+Q8B@B-P7TQMD6M-0146.local>
References: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
 <4c8ce495-a27b-cba7-7a81-26adf9a4c604@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c8ce495-a27b-cba7-7a81-26adf9a4c604@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:49:47AM +0800, Chao Yu wrote:
> On 2022/2/22 11:31, Gao Xiang wrote:
> > z_idataoff here is an absolute physical offset, so it should use
> > erofs_off_t (64 bits at least). Otherwise, it'll get trimmed and
> > cause the decompresion failure.
> > 
> > Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks Chao. Yeah, I will submit it this week..

Thanks,
Gao Xiang

> 
> Thanks,
