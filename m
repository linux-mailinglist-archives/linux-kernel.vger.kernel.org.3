Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684BA54C19A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiFOGG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiFOGGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:06:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50826DEF0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:06:21 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LNFBF3SXlzgZMG;
        Wed, 15 Jun 2022 14:04:21 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 14:06:19 +0800
Received: from [10.174.177.130] (10.174.177.130) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 14:06:18 +0800
Subject: Re: Re: [PATCH] mm/swapfile: release swap info when swap device is
 unpluged
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        linmiaohe <linmiaohe@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <20220528084941.28391-1-liubo254@huawei.com>
 <80d54ab2864e4011a9f5e5b198ccfe8e@huawei.com>
 <20220613144651.8f54b3da0c2e013d9db89f02@linux-foundation.org>
From:   "liubo (AW)" <liubo254@huawei.com>
Message-ID: <fd9e40a8-4782-a8ff-09d7-3c8f96c4bfb0@huawei.com>
Date:   Wed, 15 Jun 2022 14:06:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220613144651.8f54b3da0c2e013d9db89f02@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.130]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 5:46, Andrew Morton wrote:
> On Mon, 30 May 2022 13:00:24 +0000 "liubo (AW)" <liubo254@huawei.com> wrote:
>
>> friendly ping.
> I was hoping that someone might weigh in and review this, but no joy.
>
> The patch does quite a large amount of code movement, which makes it
> quite hard to review - to see what functionally changed.  Is it possible to turn
> this into a two patch series?  The first does the code movement with no
> functional changes and the second is the actual fix?

Thanks a lot for your comments, We'll do it in the next version.


