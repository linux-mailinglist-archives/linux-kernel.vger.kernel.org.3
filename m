Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782314C9AC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiCBBzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbiCBBzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:55:05 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0505F27F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:54:22 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K7cVs1G0FzbbkQ;
        Wed,  2 Mar 2022 09:49:41 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 09:54:20 +0800
Subject: Re: [PATCH 0/9] A few cleanup patches for z3fold
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
 <e7162599-0313-f34c-c708-f8c22b5973de@huawei.com>
 <20220301093613.0849d09db2061b0d53ccb66d@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3b68029f-1700-9d8e-0ef0-db534fd6688a@huawei.com>
Date:   Wed, 2 Mar 2022 09:54:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220301093613.0849d09db2061b0d53ccb66d@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/3/2 1:36, Andrew Morton wrote:
> On Tue, 1 Mar 2022 21:03:37 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2022/2/19 17:25, Miaohe Lin wrote:
>>> Hi,
>>> This series contains a few patches to simplify the code, remove unneeded
>>> return value, fix obsolete comment and so on. More details can be found
>>> in the respective changelogs. Thanks!
>>>
>>
>> Friendly ping in case this is forgotten. :)
> 
> I was expecting updates resulting from the [6/9] discussion?

I think that could be another separate patch to reduce the atomic operation overhead.
And I have some z3fold bugfix patches pending to sent. They might can be sent together
if such separate patch is prepared at that point.

Many thanks. :)

> .
> 

