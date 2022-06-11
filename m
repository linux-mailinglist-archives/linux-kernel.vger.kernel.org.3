Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1FB547261
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiFKGcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFKGci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:32:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2BA1AE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:32:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LKp094mYTzDqnh;
        Sat, 11 Jun 2022 14:32:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 14:32:30 +0800
Subject: Re: [PATCH] mm/shmem.c: use helper transhuge_vma_enabled()
To:     Hugh Dickins <hughd@google.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220611022314.21593-1-linmiaohe@huawei.com>
 <8b34a515-e5fd-731a-4164-9080c275d4e9@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bc1fba72-ccfb-d53f-8101-e7d20eaf5eb9@huawei.com>
Date:   Sat, 11 Jun 2022 14:32:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8b34a515-e5fd-731a-4164-9080c275d4e9@google.com>
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

On 2022/6/11 11:14, Hugh Dickins wrote:
> On Sat, 11 Jun 2022, Miaohe Lin wrote:
> 
>> Use helper transhuge_vma_enabled() to check whether transhuge is enable
>> on vma. Minor readability improvement.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> No thanks, that's a readability regression, forcing reader
> to go and look up what transhuge_vma_enabled() actually means.
> 
> What you call a helper, I call an obfuscator - as I implied in
> b9e2faaf6fa0 ("huge tmpfs: revert shmem's use of transhuge_vma_enabled()")

Oh, that commit also cc to me. But I forgot it... Sorry.

> 
> Hugh
>
