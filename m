Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E35547D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiFMBtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiFMBsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:48:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C3F1A045
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:48:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LLvbT2MstzDqsL;
        Mon, 13 Jun 2022 09:48:05 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 09:48:28 +0800
Subject: Re: [PATCH 1/7] mm/khugepaged: remove unneeded shmem_huge_enabled()
 check
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <aarcange@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <neilb@suse.de>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-2-linmiaohe@huawei.com>
 <20220611133336.b582edd4c2c2df15f5561d2b@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ac9e17d1-18f8-aa63-6c52-1822c752b63f@huawei.com>
Date:   Mon, 13 Jun 2022 09:48:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220611133336.b582edd4c2c2df15f5561d2b@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/12 4:33, Andrew Morton wrote:
> On Sat, 11 Jun 2022 16:47:25 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> If we reach here, hugepage_vma_check() has already made sure that hugepage
>> is enabled for shmem. Remove this duplicated check.
> 
> I updated this to
> 
> If we reach here, hugepage_vma_check() has already made sure that hugepage
> is enabled for shmem, via its call to hugepage_vma_check().  Remove this
> duplicated check.

Do you mean "khugepaged_scan_mm_slot() has already made sure that hugepage is
enabled for shmem, via its call to hugepage_vma_check()"?

Thanks!

> 
> .
> 

