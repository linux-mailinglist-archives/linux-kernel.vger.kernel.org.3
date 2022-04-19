Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAF506292
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbiDSD0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiDSD0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:26:52 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1523BE0;
        Mon, 18 Apr 2022 20:24:09 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 19 Apr
 2022 11:24:11 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 19 Apr
 2022 11:24:07 +0800
Message-ID: <291672f3-99ca-a894-1423-8985d1f2dbdf@meizu.com>
Date:   Tue, 19 Apr 2022 11:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V5] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
To:     yanteng si <siyanteng01@gmail.com>
CC:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Shi <seakeel@gmail.com>,
        Yanteng Si <siyanteng@loongson.cn>
References: <CAEensMz1BWx2arYAqo_g5_0w1z+m-X3nRYATmSMvZ44rb05w4Q@mail.gmail.com>
 <1650334070-7233-1-git-send-email-baihaowen@meizu.com>
 <CAEensMza-D5LhMHAmAih-s6ZkjtV+ztUXLqFqEZyjCPpJCutJw@mail.gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <CAEensMza-D5LhMHAmAih-s6ZkjtV+ztUXLqFqEZyjCPpJCutJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/19/22 10:33 AM, yanteng si 写道:
> Haowen Bai <baihaowen@meizu.com> 于2022年4月19日周二 10:07写道：
>> As the tools/vm/page_owner_sort added some feature and original text
>> updated, sync the translation of zh_CN.
>>
>> fix tags:
>> 8bd16bc0a081 ("tools/vm/page_owner_sort.c: support sorting blocks by multiple keys")
>> 78a0b94f3829 ("tools/vm/page_owner_sort.c: support for multi-value selection in single argument")
>> c89b3ad2dea2 ("doc/vm/page_owner.rst: remove content related to -c option")
>> 9c8a0a8e599f ("tools/vm/page_owner_sort.c: support for user-defined culling rules")
>> 8ea8613a616a ("tools/vm/page_owner_sort.c: support for selecting by PID, TGID or task command name")
>> 194d52d771b8 ("tools/vm/page_owner_sort: support for sorting by task command name")
> I may not have described it clearly, you can refer to
> Documentation/translations/zh_CN/process/submitting-patches.rst
>
> ===========================================================================================
> 如果您想要引用一个特定的提交，不要只引用提交的 SHA-1 ID。还请包括提交的一行
> 摘要，以便于审阅者了解它是关于什么的。例如::
>
>         Commit e21d2170f36602ae2708 ("video: remove unnecessary
>         platform_set_drvdata()") removed the unnecessary
>         platform_set_drvdata(), but left the variable "dev" unused,
>         delete it.
>
> 您还应该确保至少使用前12位 SHA-1 ID. 内核存储库包含*许多*对象，使与较短的ID
> 发生冲突的可能性很大。记住，即使现在不会与您的六个字符ID发生冲突，这种情况
> 可能五年后改变。
>
> 如果修补程序修复了特定提交中的错误，例如，使用 ``git bisct`` ，请使用带有前
> 12个字符SHA-1 ID 的"Fixes:"标记和单行摘要。为了简化不要将标记拆分为多个，
> 行、标记不受分析脚本“75列换行”规则的限制。例如::
>
>         Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return
> the number of pages it actually freed")
> ==========================================================================================
>
> BTW，you need to update the original document first, because the
> translation document is dependent on the original document, which
> means you need to update Documentation/process/submitting-patches.rst
> first.
> So, let's submit another separate patch to update
> Documentation/process/submitting-patches.rst.
Yes, I have just applied another patch to original doc:
https://lore.kernel.org/all/1650338276-13687-1-git-send-email-baihaowen@meizu.com/

> Thanks,
> Yanteng
>> Signed-off-by: Haowen Bai <baihaowen@meizu.co
>> ---
>> V1->V2: fix whitespace warning.
>> V2->V3: fix some tab Alignment issue.
>> V3->V4: fix sphinx warning
>> V4->V5: fix whitespace warning; add fix tags.
>>
>>  Documentation/translations/zh_CN/vm/page_owner.rst | 61 +++++++++++++++++++++-
>>  1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/translations/zh_CN/vm/page_owner.rst b/Documentation/translations/zh_CN/vm/page_owner.rst
>> index 9e951fabba9d..4d719547ce4f 100644
>> --- a/Documentation/translations/zh_CN/vm/page_owner.rst
>> +++ b/Documentation/translations/zh_CN/vm/page_owner.rst
>> @@ -103,14 +103,73 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
>>                 -m              按总内存排序
>>                 -p              按pid排序。
>>                 -P              按tgid排序。
>> +               -n              按任务名称排序。
>>                 -r              按内存释放时间排序。
>>                 -s              按堆栈跟踪排序。
>>                 -t              按时间排序（默认）。
>> +               --sort <order>  指定排序顺序。排序语法是 [+|-]key[,[+|-]key[,...]]. 从
>> +                                               **标准格式说明符** 部分选择一个键。"+" 是可选的，因为默认方向是增加数字或字典顺序。
>> +                                               允许混合使用缩写键和全称键。
>> +
>> +               Examples:
>> +                               ./page_owner_sort <input> <output> --sort=n,+pid,-tgid
>> +                               ./page_owner_sort <input> <output> --sort=at
>>
>>     其它函数:
>>
>>         Cull:
>> -               -c              通过比较堆栈跟踪而不是总块来进行剔除。
>> +               --cull <rules>
>> +                               指定筛选规则。筛选语法是 key[,key[,...]]。在**标准格式说明符**部分选择一个多字母键
>> +
>> +               <rules> 是逗号分隔列表形式的单个参数，它提供了一种指定单个筛选规则的方法。下面的**标准格式说明
>> +                               符**部分描述了可识别的关键字。<rules> 可以由键 k1,k2, ... 顺序指定，如下面的
>> +                               STANDARD SORT KEYS 部分所述。允许混合使用缩写形式和完整形式的键。
>>
>> +               Examples:
>> +                               ./page_owner_sort <input> <output> --cull=stacktrace
>> +                               ./page_owner_sort <input> <output> --cull=st,pid,name
>> +                               ./page_owner_sort <input> <output> --cull=n,f
>>         Filter:
>>                 -f              过滤掉内存已被释放的块的信息。
>> +
>> +       Select:
>> +               --pid <pidlist>         通过 pid 进行选择。这将选择进程 ID 号出现在 <pidlist> 中的块。
>> +               --tgid <tgidlist>       通过 tgid 进行选择。这将选择线程组 ID 号出现在 <tgidlist> 中的块。
>> +               --name <cmdlist>        按任务名称选择。这将选择任务名称出现在 <cmdlist> 中的块。
>> +
>> +               <pidlist>、<tgidlist>、<cmdlist>是逗号分隔列表形式的单参数，它提供了一种指定单个选择规则的方法。
>> +
>> +
>> +               Examples:
>> +                               ./page_owner_sort <input> <output> --pid=1
>> +                               ./page_owner_sort <input> <output> --tgid=1,2,3
>> +                               ./page_owner_sort <input> <output> --name name1,name2
>> +
>> +标准格式说明符
>> +==============
>> +
>> +--sort 选项:
>> +
>> +        ======          ==========      ===================
>> +        缩写键          全称键          描述
>> +        ======          ==========      ===================
>> +        p               pid             进程 ID
>> +        tg              tgid            线程组 ID
>> +        n               name            任务名称
>> +        st              stacktrace      页面分配的调用栈
>> +        T               txt             块的全文
>> +        ft              free_ts         页面被释放的时间戳
>> +        at              alloc_ts        页面分配的时间戳
>> +        ======          ==========      ===================
>> +
>> +--curl 选项:
>> +
>> +        ======          ==========      ==================
>> +        缩写键          全称键          描述
>> +        ======          ==========      ==================
>> +        p               pid             进程 ID
>> +        tg              tgid            线程组 ID
>> +        n               name            任务名称
>> +        f               free            该页面是否已被释放
>> +        st              stacktrace      页面分配的调用栈
>> +        ======          ==========      ==================
>> --
>> 2.7.4
>>

-- 
Haowen Bai

