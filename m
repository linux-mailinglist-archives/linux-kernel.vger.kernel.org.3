Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A9959692A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiHQGJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiHQGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:09:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417F75FC8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:09:51 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M6yFd0stqz1M8wN;
        Wed, 17 Aug 2022 14:06:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 14:09:49 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 14:09:48 +0800
Subject: Re: [PATCH] mtd: rawnand: gpmi: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>, <miquel.raynal@bootlin.com>
CC:     <han.xu@nxp.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220811135854.27036-1-wangborong@cdjrlc.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <28935439-276f-50a9-2526-13da5ffcc9db@huawei.com>
Date:   Wed, 17 Aug 2022 14:09:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220811135854.27036-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

ÔÚ 2022/8/11 21:58, Jason Wang Ð´µÀ:
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 93da23682d86..01ccbde748f3 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -1361,7 +1361,7 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
>   /*
>    * Handles block mark swapping.
>    * It can be called in swapping the block mark, or swapping it back,
> - * because the the operations are the same.
> + * because the operations are the same.
>    */
>   static void block_mark_swapping(struct gpmi_nand_data *this,
>   				void *payload, void *auxiliary)
> 

