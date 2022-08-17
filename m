Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BEA596BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiHQJIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHQJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:08:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6530556
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:08:33 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M72Bq3NtrzXdqv;
        Wed, 17 Aug 2022 17:04:19 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 17:08:30 +0800
Subject: Re: [PATCH -next 0/2] A few fixup patches for nvmem
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
References: <20220816134935.263825-1-cuigaosheng1@huawei.com>
 <c798c5fd-e877-9f70-8733-26d1d494a637@linaro.org>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <a6511232-b08d-6e44-04f7-d67f1c11b003@huawei.com>
Date:   Wed, 17 Aug 2022 17:08:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c798c5fd-e877-9f70-8733-26d1d494a637@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll take a closer look at this link, thank you very much!

Gaosheng

在 2022/8/17 16:53, Srinivas Kandagatla 写道:
>
>
> On 16/08/2022 14:49, Gaosheng Cui wrote:
>> This series contains a fixup patches to fix possible memleak,
>> and add error handling of dev_set_name to keep nvmem code
>> implementation consistent, in addition, it can also avoid
>> the possibility illegal address access. Thanks!
>>
>> Gaosheng Cui (2):
>>    nvmem: core: Fix memleak in nvmem_register()
>>    nvmem: core: add error handling for dev_set_name
>>
>
> I have applied these patches for now but remember the subject line 
> does not reflect the patch version or the cover letter does not 
> include any changes done over the versions.
>
> Please take a look at 
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
>
>
> thanks,
> Srini
>
>>   drivers/nvmem/core.c | 27 +++++++++++++++------------
>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>
> .
