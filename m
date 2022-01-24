Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453AF497A69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiAXIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:34:07 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58706 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242127AbiAXIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:34:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V2gQ.wI_1643013242;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V2gQ.wI_1643013242)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Jan 2022 16:34:04 +0800
Date:   Mon, 24 Jan 2022 16:34:02 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix fsdax partition offset handling
Message-ID: <Ye5kehup+iQ3g+q/@B-P7TQMD6M-0146.local>
References: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
 <d424369b-c559-bf63-bbb3-71886f1799c9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d424369b-c559-bf63-bbb3-71886f1799c9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:11:35PM +0800, Chao Yu wrote:
> On 2022/1/13 13:18, Gao Xiang wrote:
> > After seeking time on testing today upstream fsdax, I found it
> > actually doesn't work well as below:
> > 
> > [  186.492983] ------------[ cut here ]------------
> > [  186.493629] WARNING: CPU: 1 PID: 205 at fs/iomap/iter.c:33 iomap_iter+0x2f6/0x310
> > 
> > The problem is that m_dax_part_off should be applied to physical
> > addresses and very sorry about that I didn't catch this eariler.
> > 
> > Anyway, let's fix it up now. Also, I need to find a way to set up
> > a standalone testcase to look after this later.
> > 
> > Fixes: de2051147771 ("fsdax: shift partition offset handling into the file systems")
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks for the review! I will send this together with other misc
fixes this or next week..

Thanks,
Gao Xiang

> 
> Thanks,
