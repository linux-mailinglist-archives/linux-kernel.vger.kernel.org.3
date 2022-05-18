Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CE152B03B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiERBwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiERBwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:52:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577582FFDE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:52:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2wvz3DX6zhYqH;
        Wed, 18 May 2022 09:51:59 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 09:52:34 +0800
Subject: Re: [PATCH 00/15] A few cleanup patches for swap
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220517164239.d4e81d6f637afce5c304ec05@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5b989480-43e1-4c5c-bef6-12c5ffb8ef0d@huawei.com>
Date:   Wed, 18 May 2022 09:52:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220517164239.d4e81d6f637afce5c304ec05@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/18 7:42, Andrew Morton wrote:
> On Mon, 9 May 2022 21:14:01 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> This series contains a few patches to fix the comment, remove unneeded
>> return value, use some helpers and so on. More details can be found in
>> the respective changelogs. 
> 
> After dropping [10/14] and with the four fixlets I just sent out, I
> believe this series is ready to be moved into mm-stable.  Is there

Sorry, I am focus on fixing the deadloop when swapin error occurs at swapoff recently.
Many thanks for doing this and above changes look good to me. :)

> anything outstanding?
> 

That's all. Thanks a lot!

> 
> .
> 

