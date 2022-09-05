Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF565ACB13
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbiIEGjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiIEGja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:39:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083402DF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:39:20 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLf0f71VJzlWmt;
        Mon,  5 Sep 2022 14:35:46 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 14:39:18 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 14:39:17 +0800
Message-ID: <34d9bb08-4f50-5aef-e3fb-d9c455184505@huawei.com>
Date:   Mon, 5 Sep 2022 14:39:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH -next v3 2/2] mm: sysctl: Introduce per zone
 watermark_scale_factor
To:     <willy@infradead.org>
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <npiggin@suse.de>, <ying.huang@intel.com>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>, <mcgrof@kernel.org>,
        <mgorman@suse.de>, <keescook@chromium.org>, <yzaikin@google.com>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <osalvador@suse.de>, <surenb@google.com>, <rppt@kernel.org>,
        <charante@codeaurora.org>, <jsavitz@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <lkp@intel.com>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
 <20220905032858.1462927-3-mawupeng1@huawei.com>
 <YxVwwndLt+bsUDK0@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <YxVwwndLt+bsUDK0@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/5 11:45, Matthew Wilcox wrote:
> On Mon, Sep 05, 2022 at 11:28:58AM +0800, Wupeng Ma wrote:
>> The reason to disable THP is khugepaged_min_free_kbytes_update() will
>> update min watermark.
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> Don't include this 'Reported-by'.  The kernel test robot did not
> tell you to write this patch.
> 

Oh, i see.

For this patch, I will add this information in the change log.
