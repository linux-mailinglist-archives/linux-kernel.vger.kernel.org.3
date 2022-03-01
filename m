Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874944C8C39
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiCANEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCANEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:04:21 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE788791
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:03:40 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K7HPc001Lz1GByl;
        Tue,  1 Mar 2022 20:58:59 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 21:03:38 +0800
Subject: Re: [PATCH 0/9] A few cleanup patches for z3fold
To:     <akpm@linux-foundation.org>
CC:     <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e7162599-0313-f34c-c708-f8c22b5973de@huawei.com>
Date:   Tue, 1 Mar 2022 21:03:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220219092533.12596-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/19 17:25, Miaohe Lin wrote:
> Hi,
> This series contains a few patches to simplify the code, remove unneeded
> return value, fix obsolete comment and so on. More details can be found
> in the respective changelogs. Thanks!
> 

Friendly ping in case this is forgotten. :)

> Miaohe Lin (9):
>   mm/z3fold: declare z3fold_mount with __init
>   mm/z3fold: remove obsolete comment in z3fold_alloc
>   mm/z3fold: minor clean up for z3fold_free
>   mm/z3fold: remove unneeded page_mapcount_reset and ClearPagePrivate
>   mm/z3fold: remove confusing local variable l reassignment
>   mm/z3fold: move decrement of pool->pages_nr into
>     __release_z3fold_page()
>   mm/z3fold: remove redundant list_del_init of zhdr->buddy in
>     z3fold_free
>   mm/z3fold: remove unneeded PAGE_HEADLESS check in free_handle()
>   mm/z3fold: remove unneeded return value of z3fold_compact_page()
> 
>  mm/z3fold.c | 78 +++++++++++++++--------------------------------------
>  1 file changed, 22 insertions(+), 56 deletions(-)
> 

