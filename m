Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE14EEACB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbiDAJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbiDAJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:58:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C21526C551
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:56:59 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KVFsK2fTCzgYCJ;
        Fri,  1 Apr 2022 17:55:17 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:56:57 +0800
Received: from [10.174.179.19] (10.174.179.19) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:56:56 +0800
Message-ID: <897784aa-63b9-6f91-6c9f-ca0629d5963e@huawei.com>
Date:   Fri, 1 Apr 2022 17:56:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] hugetlb: Fix hugepages_setup when deal with pernode
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        <akpm@linux-foundation.org>, <yaozhenguo1@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rdunlap@infradead.org>
References: <20220324074037.2024608-1-liupeng256@huawei.com>
 <361111c6-921b-e129-edf3-367748f6497e@oracle.com>
 <ec312492-fea9-7130-8be4-1c362c2e84a6@huawei.com>
 <e94ea60f-9da7-98b7-7d47-1183c0fd2ddc@oracle.com>
 <d992f076-5eba-929b-e284-57bd5471cd85@huawei.com>
 <c33ab0c1-6b73-2489-efab-972c8d7fa80b@oracle.com>
 <b4d3cfee-9364-3315-652e-7f8b156306eb@huawei.com>
 <74166b6c-ce29-5bec-5513-7597afdbe5d3@oracle.com>
From:   "liupeng (DM)" <liupeng256@huawei.com>
In-Reply-To: <74166b6c-ce29-5bec-5513-7597afdbe5d3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/1 5:11, Mike Kravetz wrote:
>
> I was thinking something like the attached (untested).  It is very similar to
> your original code.
Thanks, patch-v2 is sent.
