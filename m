Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399FF5A456A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiH2Isy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiH2Isw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:48:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4033058DF4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:48:51 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGPBM2qrlzYcyK;
        Mon, 29 Aug 2022 16:44:27 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 16:48:49 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 16:48:48 +0800
Message-ID: <283e6be0-748a-9487-d4eb-11e1b18d6427@huawei.com>
Date:   Mon, 29 Aug 2022 16:48:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH -next] sched/deadline: Move __dl_clear_params out of dl_bw
 lock
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220827020911.30641-1-shangxiaojing@huawei.com>
 <9498c691-2a85-b9b1-7852-8b362455b840@redhat.com>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <9498c691-2a85-b9b1-7852-8b362455b840@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/29 16:24, Daniel Bristot de Oliveira wrote:
> On 8/27/22 04:09, Shang XiaoJing wrote:
>
> Why are y'all always setting "-next" to the subject?
i heard that "-next" means prefer to merge into linux-next branch first, 
the subsequent patches from me wont set "-next".
>> As members in sched_dl_entity are independent with dl_bw, move
>> __dl_clear_params out of dl_bw lock.
>>
>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>
> -- Daniel

Thanks,

Shang XiaoJing

