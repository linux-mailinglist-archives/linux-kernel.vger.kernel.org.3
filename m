Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05B58E73E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiHJGTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHJGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:19:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1D65819
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:19:09 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M2fmh3MF0zXdSd;
        Wed, 10 Aug 2022 14:15:00 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 14:19:05 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 14:19:04 +0800
Message-ID: <1b8c3ece-c7bb-f11e-1f37-c2424d4ab57c@huawei.com>
Date:   Wed, 10 Aug 2022 14:19:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] mm: add warning if __vm_enough_memory fails
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
References: <20220726145428.8030-1-wangkefeng.wang@huawei.com>
 <abe62159-c218-2fb5-e096-3c71c10c28e1@huawei.com>
 <20220809190222.7da71d851e1ca7035165e42a@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220809190222.7da71d851e1ca7035165e42a@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


On 2022/8/10 10:02, Andrew Morton wrote:
> On Tue, 9 Aug 2022 16:32:46 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Hi maintainer, any comments, thanks
> Looks great to me - I have it saved away.
>
> I prefer not to add new material during the merge window prior to MM
> being fully merged up.  In fact, I think this might be against
> Stephen's rules-for-linux-next.  Even during the merge window,
> linux-next remains the testing ground for Linus's "next" release,
> so adding next+1 material will weaken that testing.
Got it, thanks~
> .
