Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C254692EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbhLFJw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:52:29 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:21880 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241479AbhLFJwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:52:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UzauTOV_1638784114;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UzauTOV_1638784114)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 17:48:35 +0800
Date:   Mon, 6 Dec 2021 17:48:33 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Huang Jianan <jnhuang95@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-kernel@vger.kernel.org, guoweichao@oppo.com,
        guanyuwei@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v7 2/3] erofs: add sysfs interface
Message-ID: <Ya3cceIRz5HHlc/6@B-P7TQMD6M-0146.local>
References: <CAJfKizqxkt4BYa26cmOgCD9OFOck_J0NZ8hxCQbVoyv0j4SMJg@mail.gmail.com>
 <20211201145436.4357-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201145436.4357-1-huangjianan@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:54:36PM +0800, Huang Jianan wrote:
> Add sysfs interface to configure erofs related parameters later.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Reviewed-by: Chao Yu <chao@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
