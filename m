Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674B3543048
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiFHM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiFHM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:27:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C123E835
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:27:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJ60C3hlFzjYcL;
        Wed,  8 Jun 2022 20:26:19 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 20:27:39 +0800
Subject: Re: [PATCH] MAINTAINERS: add myself as a memory-failure reviewer
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220607145135.38670-1-linmiaohe@huawei.com>
 <20220607224210.GA1400450@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <07a5fb28-a9b2-3c77-79fd-c1dc7dbe755e@huawei.com>
Date:   Wed, 8 Jun 2022 20:27:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220607224210.GA1400450@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/6/8 6:42, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Jun 07, 2022 at 10:51:35PM +0800, Miaohe Lin wrote:
>> I have been focusing on mm for the past two years. e.g. fixing bugs,
>> cleaning up the code and reviewing. I would like to help maintainers
>> and people working on memory-failure by reviewing their work.
>>
>> Let me be Cc'd on patches related to memory-failure.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thank you for raising a hand, this is really nice.

That's my pleasure. I will try my best to be qualified for this position. ;)

> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks!

> 
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6e4ad450bf3c..6430aebfe296 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9136,6 +9136,7 @@ F:	drivers/media/platform/st/sti/hva
>>  
>>  HWPOISON MEMORY FAILURE HANDLING
>>  M:	Naoya Horiguchi <naoya.horiguchi@nec.com>
>> +R:	Miaohe Lin <linmiaohe@huawei.com>
>>  L:	linux-mm@kvack.org
>>  S:	Maintained
>>  F:	mm/hwpoison-inject.c
>> -- 
>> 2.23.0

