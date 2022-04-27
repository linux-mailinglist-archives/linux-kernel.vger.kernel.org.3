Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F402511142
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358180AbiD0GkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358167AbiD0Gjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:39:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE97F1CFD8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:36:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kp8C56QRkzfbHl;
        Wed, 27 Apr 2022 14:35:45 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 14:36:39 +0800
Subject: Re: [PATCH v3 3/6] mm/vmscan: activate swap-backed executable folios
 after first usage
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Joonsoo Kim <js1304@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Hellwig <hch@lst.de>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220425111232.23182-1-linmiaohe@huawei.com>
 <20220425111232.23182-4-linmiaohe@huawei.com>
 <20220425140711.0c1898862fc817135bbbc56e@linux-foundation.org>
 <6b74e6f3799032d4f12bae0d97a453dc85d03028.camel@intel.com>
 <5a108252-4eb8-e353-da3d-a96b8799fadf@huawei.com>
 <CAAmzW4NV9_LiGsN3Qn3uv19ZLFn9zZ3hdLFy1HOgbec5Or0Ccw@mail.gmail.com>
 <75adcfe33483d5e30855226b6efcd8dcd2f52925.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b41d51c2-5ff9-024e-34ff-0c9652f30a1c@huawei.com>
Date:   Wed, 27 Apr 2022 14:36:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <75adcfe33483d5e30855226b6efcd8dcd2f52925.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/27 14:10, ying.huang@intel.com wrote:
> On Wed, 2022-04-27 at 13:08 +0900, Joonsoo Kim wrote:
>> Hello,
>>
>> 2022년 4월 26일 (화) 오후 3:58, Miaohe Lin <linmiaohe@huawei.com>님이 작성:
>>>
>>> On 2022/4/26 10:02, ying.huang@intel.com wrote:
>>>> On Mon, 2022-04-25 at 14:07 -0700, Andrew Morton wrote:
>>>>> On Mon, 25 Apr 2022 19:12:29 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>
>>>>>> We should activate swap-backed executable folios (e.g. tmpfs) after first
>>>>>> usage so that executable code gets yet better chance to stay in memory.
>>
>> Missing activation for swap-backed executable page is the intended operation.
>> So, I disagree with this patch until some numbers are provided.
>> See following discussion.
>>
>> https://lore.kernel.org/all/20200316161208.GB67986@cmpxchg.org/T/#u
> 
> Thanks for your pointer.  Now I understood more about this.  I agree to
> keep the original behavior unless we can prove the change with numbers.
> 

Many thanks both! I will keep the original behavior. :)

> Best Regards,
> Huang, Ying
> 
> 
> .
> 

