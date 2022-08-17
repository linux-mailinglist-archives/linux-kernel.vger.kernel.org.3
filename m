Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83416596929
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiHQGJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:09:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ED572EE7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:09:23 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6yFM3R7wzlWJx;
        Wed, 17 Aug 2022 14:06:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 14:09:19 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 14:09:18 +0800
Subject: Re: [PATCH] mtd/ubi/block: Remove a semicolon
To:     Li zeming <zeming@nfschina.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220817011406.3117-1-zeming@nfschina.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <1c453512-6e88-9bc0-fa3a-ac6028fc8662@huawei.com>
Date:   Wed, 17 Aug 2022 14:09:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220817011406.3117-1-zeming@nfschina.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/8/17 9:14, Li zeming Ð´µÀ:
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> Remove the repeated ';' from code.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>   drivers/mtd/ubi/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 4cf67a2a0d04..4fc7e756d885 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -409,7 +409,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
>   	ret = blk_mq_alloc_tag_set(&dev->tag_set);
>   	if (ret) {
>   		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
> -		goto out_free_dev;;
> +		goto out_free_dev;
>   	}
>   
>   
> 

