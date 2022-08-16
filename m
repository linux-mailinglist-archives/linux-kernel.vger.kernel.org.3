Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DFC59596F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiHPLII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiHPLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:07:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6D58DD9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:13:30 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M6RjD3CVYz1M914;
        Tue, 16 Aug 2022 18:10:08 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 18:13:25 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 18:13:24 +0800
Message-ID: <d8d5481b-efd3-9b54-3fa6-3f6272472e6d@huawei.com>
Date:   Tue, 16 Aug 2022 18:13:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] mm: memory-failure: cleanup try_to_split_thp_page()
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220809111813.139690-1-wangkefeng.wang@huawei.com>
 <20220816054716.GA496220@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220816054716.GA496220@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/16 13:47, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Aug 09, 2022 at 07:18:13PM +0800, Kefeng Wang wrote:
>> Since commit 5d1fd5dc877b ("mm,hwpoison: introduce MF_MSG_UNSPLIT_THP"),
>> the action_result(,MF_MSG_UNSPLIT_THP,) called to show memory error event
>> in memory_failure(), so the pr_info() in try_to_split_thp_page() is only
>> needed in soft_offline_in_use_page().
>>
>> Meanwhile this could also fix the unexpected prefix for "thp split failed"
>> due to commit 96f96763de26 ("mm: memory-failure: convert to pr_fmt()").
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> # Sorry for my late reply, I'm back from summer holiday...
>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Thanks Noaya.
