Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A6A4977BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 04:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbiAXDqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 22:46:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35857 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiAXDqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 22:46:33 -0500
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jhwqp548zzccNt;
        Mon, 24 Jan 2022 11:45:42 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:46:30 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:46:30 +0800
Subject: Re: [PATCH RESEND 0/3] blk-mq: allow hardware queue to get more tag
 while sharing a tag set
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220117085455.2269760-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <daa6b7d6-5b4f-19f8-d89d-56f18c398d56@huawei.com>
Date:   Mon, 24 Jan 2022 11:46:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220117085455.2269760-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/01/17 16:54, Yu Kuai Ð´µÀ:
> Previous patch: https://lkml.org/lkml/2021/7/11/343
> 
> If there are multiple active queues while sharing a tag set, the available
> tags is limit to fair share for each active queue. This patchset take
> off such restriction if no one ever failed to get driver tag.
> 
> Yu Kuai (3):
>    blk-mq: add new interfaces to track if hctx failed to get driver tag
>    blk-mq: record how many hctx failed to get driver tag while sharing a
>      tag set
>    blk-mq: allow hardware queue to get more tag while sharing a tag set
> 
>   block/blk-mq-debugfs.c |  2 ++
>   block/blk-mq-tag.c     | 45 +++++++++++++++++++++++++++++++++++++++++-
>   block/blk-mq-tag.h     | 22 +++++++++++++++++++--
>   block/blk-mq.c         | 13 +++++++++---
>   block/blk-mq.h         |  4 ++++
>   include/linux/blk-mq.h | 12 +++++++++++
>   include/linux/blkdev.h |  2 ++
>   7 files changed, 94 insertions(+), 6 deletions(-)
> 

Friendly ping ...
