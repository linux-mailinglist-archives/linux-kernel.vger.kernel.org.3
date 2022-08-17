Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413A8596788
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiHQCtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbiHQCsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:48:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD44506F;
        Tue, 16 Aug 2022 19:48:51 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6snh2s7qzkWQG;
        Wed, 17 Aug 2022 10:45:28 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:48:49 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:48:48 +0800
Subject: Re: [PATCH] erofs: fix error return code in
 erofs_fscache_meta_read_folio and erofs_fscache_read_folio
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
CC:     <xiang@kernel.org>, <chao@kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <yinxin.x@bytedance.com>
References: <20220815034829.3940803-1-sunke32@huawei.com>
 <YvsoIFzRlGpqNZKg@B-P7TQMD6M-0146.local>
 <d40a1e7e-d78c-1a99-0889-6fc4d2102e9d@huawei.com>
 <YvxVWP0njcgghe+r@B-P7TQMD6M-0146.local>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <e1369566-6459-2eae-35f4-818865a7df20@huawei.com>
Date:   Wed, 17 Aug 2022 10:48:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YvxVWP0njcgghe+r@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/8/17 10:41, Gao Xiang 写道:
> Hi Ke,
> 
> On Wed, Aug 17, 2022 at 09:44:46AM +0800, Sun Ke wrote:
>>
>>
>> 在 2022/8/16 13:16, Gao Xiang 写道:
>>> On Mon, Aug 15, 2022 at 11:48:29AM +0800, Sun Ke wrote:
>>>> If erofs_fscache_alloc_request fail and then goto out, it will return 0.
>>>> it should return a negative error code instead of 0.
>>>>
>>>> Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
>>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>>
>>> Minor, I tried to apply this patch by updating the patch title into
>>> "erofs: fix error return code in erofs_fscache_{meta_,}read_folio"
>>>
>>> since the original patch title is too long.
>>
>> Should I send a v2 patch to update the title?
> 
> I've already updated this by hand if you have no concern ;)
> will push out to -next today...
;)

Thanks,
Sun Ke
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Sun Ke
>>>
>>> Thanks,
>>> Gao Xiang
>>> .
>>>
> .
> 
