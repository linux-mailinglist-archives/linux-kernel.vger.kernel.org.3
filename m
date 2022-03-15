Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C564D9B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348429AbiCOMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiCOMqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:46:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5605A46164
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:45:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KHtMN0Gnzz9sp2;
        Tue, 15 Mar 2022 20:41:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 20:45:39 +0800
Subject: Re: [PATCH] mm/mlock: Use vma_lookup() instead of find_vma()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220314151728.20800-1-linmiaohe@huawei.com>
 <Yi9qdrJ9AXOJszmu@casper.infradead.org>
 <b2dc4e8a-be8f-88e4-040a-91a6d033ab6d@huawei.com>
 <YjCJG2m84NSFrsHr@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a1709d16-6404-fca3-27ed-28e40ee7daed@huawei.com>
Date:   Tue, 15 Mar 2022 20:45:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YjCJG2m84NSFrsHr@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
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

On 2022/3/15 20:39, Matthew Wilcox wrote:
> On Tue, Mar 15, 2022 at 08:24:04PM +0800, Miaohe Lin wrote:
>> On 2022/3/15 0:16, Matthew Wilcox wrote:
>>> On Mon, Mar 14, 2022 at 11:17:28PM +0800, Miaohe Lin wrote:
>>>> Using vma_lookup() verifies the start is contained in the found vma. This
>>>> results in easier to read the code.
>>>
>>> This conflicts with the maple tree.
>>
>> IIUC, maple tree is the implementation detail of the vma and this patch
>> should not be conflict with it. But there might be some trival conflict.
>> Am I supposed to delay this patch until the maple tree's work is done?
> 
> This function is rewritten as part of the maple tree patchset.
> There's no point in merging it now, or later.
> 

I see. Thanks for explanation.

> .
> 

