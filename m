Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF314E7E60
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiCZBNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCZBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:13:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03FC170D97;
        Fri, 25 Mar 2022 18:11:39 -0700 (PDT)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KQLTN49pKzCrC1;
        Sat, 26 Mar 2022 09:09:28 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 26 Mar 2022 09:11:37 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 09:11:37 +0800
Subject: Re: [PATCH 2/3] block: factor out common code for part_stat_show()
 and diskstats_show()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <mpatocka@redhat.com>, <snitzer@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220317112653.1019490-1-yukuai3@huawei.com>
 <20220317112653.1019490-3-yukuai3@huawei.com>
 <Yj2BTUIEooYX/IaA@infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c6a80995-7af9-3daa-9d5b-ba73f75788be@huawei.com>
Date:   Sat, 26 Mar 2022 09:11:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yj2BTUIEooYX/IaA@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
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

ÔÚ 2022/03/25 16:46, Christoph Hellwig Ð´µÀ:
> On Thu, Mar 17, 2022 at 07:26:52PM +0800, Yu Kuai wrote:
>> part_stat_show() and diskstats_show() are very similar, just factor out
>> common code.
> 
> Well, it doesn't really "factor" much, but creates a big and pretty
> unmaintainble macro.  I don't really see the benefit here.

Hi,

Thanks for your advice, I'll remove this patch.

BTW, do you have any suggestion about patch 3 ?

Thanks,
Kuai
> .
> 
