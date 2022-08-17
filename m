Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA2F596926
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiHQGJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQGJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:09:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E670E5B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:09:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6yFJ2rfWzkWJh;
        Wed, 17 Aug 2022 14:06:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 14:09:33 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 14:09:32 +0800
Subject: Re: [PATCH] ubi: ubi-media.h: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>, <vigneshr@ti.com>
CC:     <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220811135730.25480-1-wangborong@cdjrlc.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6a7ce5c9-a59d-e8e2-5c70-a688d8fceeb9@huawei.com>
Date:   Wed, 17 Aug 2022 14:09:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220811135730.25480-1-wangborong@cdjrlc.com>
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

ÔÚ 2022/8/11 21:57, Jason Wang Ð´µÀ:
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/mtd/ubi/ubi-media.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
> index 386db0598e95..2c9cd3b6434f 100644
> --- a/drivers/mtd/ubi/ubi-media.h
> +++ b/drivers/mtd/ubi/ubi-media.h
> @@ -131,7 +131,7 @@ enum {
>    * is changed radically. This field is duplicated in the volume identifier
>    * header.
>    *
> - * The @vid_hdr_offset and @data_offset fields contain the offset of the the
> + * The @vid_hdr_offset and @data_offset fields contain the offset of the
>    * volume identifier header and user data, relative to the beginning of the
>    * physical eraseblock. These values have to be the same for all physical
>    * eraseblocks.
> 

