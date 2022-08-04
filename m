Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3B589590
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 03:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiHDBEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 21:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHDBED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 21:04:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E131818E1C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 18:04:01 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lyr542xbwzjXX1;
        Thu,  4 Aug 2022 09:00:56 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 09:03:59 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 09:03:59 +0800
Message-ID: <dd492213-3e6e-a1dd-75cf-eb8500bcbf20@huawei.com>
Date:   Thu, 4 Aug 2022 09:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: memory-failure: cleanup try_to_split_thp_page()
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e699cd23-3eeb-7920-accd-b30622efa551@huawei.com>
 <20220802021256.162269-1-wangkefeng.wang@huawei.com>
 <20220804004552.GA3631345@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220804004552.GA3631345@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/4 8:45, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Aug 02, 2022 at 10:12:56AM +0800, Kefeng Wang wrote:
>> Since commit 5d1fd5dc877b ("mm,hwpoison: introduce MF_MSG_UNSPLIT_THP"),
>> the action_result() called to show memory error event in memory_failure(),
>> so the pr_info() in try_to_split_thp_page() is only needed in
>> soft_offline_in_use_page().
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Thanks, looks good to me.  Probably this patch may come before
> "mm: memory-failure: convert to pr_fmt()" to be a cleanup.
>
> And recently another patch [1] is trying to change the same function, so we
> might need to resolve the conflict with it.  I expect it's not so hard, but
> I think your series had better come after [1] because [1] is a bug fix and
> might be backported to stable-5.19.
OK， I could repost after[1] merged into mm tree,  thanks.
>
> [1] https://lore.kernel.org/linux-mm/20220803025243.155798-1-fengwei.yin@intel.com/T/#u
>
> Thanks,
> Naoya Horiguchi
