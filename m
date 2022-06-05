Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B453D92A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 04:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbiFECFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 22:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiFECFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:05:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2524EDEA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 19:05:38 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LG0KN0W1jzgYZG;
        Sun,  5 Jun 2022 10:03:52 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 5 Jun 2022 10:05:36 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 5 Jun 2022 10:05:36 +0800
Message-ID: <374dfbbd-415e-890e-15db-b36c34a70a8d@huawei.com>
Date:   Sun, 5 Jun 2022 10:05:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 2/4] mm/shmem: return -EINVAL for addr not PAGE_SIZE
 aligned
To:     David Hildenbrand <david@redhat.com>, <hughd@google.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220601124417.2872001-1-chenwandun@huawei.com>
 <20220601124417.2872001-3-chenwandun@huawei.com>
 <d5f4c444-032d-81f6-c7b8-6e1627aaf7f7@redhat.com>
 <e25a6d7b-c93f-c680-5044-c9dac1aa0a2f@redhat.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <e25a6d7b-c93f-c680-5044-c9dac1aa0a2f@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/1 22:14, David Hildenbrand wrote:
> On 01.06.22 15:37, David Hildenbrand wrote:
>> On 01.06.22 14:44, Chen Wandun wrote:
>>> If addr is not PAGE_SIZE aligned, return -EINVAL directly.
>> Why is this one to be treated in a special way compared to all of the
>> other related checks?
> Ah, I see you modify other places in other patches. Maybe just combine
> all these return value changes into a single patch? That makes it look
> less "special".
OK, patch 2 and patch 3 are used to return error value directly, I will 
combine these patch
to a single patch in next version.

Thanks.
>
>
>

