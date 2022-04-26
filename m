Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCD450F8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbiDZJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348050AbiDZJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:15:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C171900B3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:52:58 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KnbDr2r5kzGpRl;
        Tue, 26 Apr 2022 16:50:20 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 16:52:56 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 16:52:55 +0800
Subject: Re: [PATCH 1/2] riscv: ftrace: Fix the comments about the number of
 ftrace instruction
To:     Guo Ren <guoren@kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        "Anil S Keshavamurthy" <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>, <jszhang@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <liaochang1@huawei.com>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Pekka Enberg <penberg@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20220426015751.88582-1-lihuafei1@huawei.com>
 <CAJF2gTR6hL1DfaGpPqfVwtmCHaVYK1nz_-W-h_mye34UjeeAcg@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <3bf77687-61c1-6d05-eea8-afe11a268421@huawei.com>
Date:   Tue, 26 Apr 2022 16:52:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTR6hL1DfaGpPqfVwtmCHaVYK1nz_-W-h_mye34UjeeAcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/26 14:22, Guo Ren wrote:
> On Tue, Apr 26, 2022 at 9:59 AM Li Huafei <lihuafei1@huawei.com> wrote:
>> When DYNAMIC_FTRACE is enabled, we put four instructions in front of the
>> function for ftrace use, not five.
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>   arch/riscv/kernel/ftrace.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>> index 4716f4cdc038..63f457650fa4 100644
>> --- a/arch/riscv/kernel/ftrace.c
>> +++ b/arch/riscv/kernel/ftrace.c
>> @@ -73,7 +73,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>>   }
>>
>>   /*
>> - * Put 5 instructions with 16 bytes at the front of function within
>> + * Put 4 instructions with 16 bytes at the front of function within
> Yeah, 5 instructions are for mcount, -fpatchable-function-entry=8
> cause 8 16bit instructions.
I misunderstood, thanks for the clarification.
>
> Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
There is no functional fix here, do we need to add the fix tag?
>
> I recommend just delete "4 instructions with"
> - * Put 5 instructions with 16 bytes at the front of function within
> - * patchable function entry nops' area.
> + * Put 16 bytes at the front of the function within the patchable
> + * function entry nops' area.

I agree and will use this modification for the next version, thanks!


Huafei
>
>>    * patchable function entry nops' area.
>>    *
>>    * 0: REG_S  ra, -SZREG(sp)
>> --
>> 2.17.1
>>
>
