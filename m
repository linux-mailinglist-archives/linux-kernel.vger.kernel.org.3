Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FC504E61
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiDRJb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiDRJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:31:53 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C553715FF1;
        Mon, 18 Apr 2022 02:29:13 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 18 Apr
 2022 17:29:06 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 18 Apr
 2022 17:29:05 +0800
Message-ID: <8b7485c9-eb17-e508-2d3e-a630fcaa998d@meizu.com>
Date:   Mon, 18 Apr 2022 17:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
To:     yanteng si <siyanteng01@gmail.com>,
        =?UTF-8?B?5Y+45bu26IW+?= <siyanteng@loongson.cn>
CC:     "alexs@kernel.org" <alexs@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <81254c7.3c4d.1802ad7fa26.Coremail.siyanteng@loongson.cn>
 <CAEensMyRDFzcz11Zui8+U6bjZmUM1vKdya7rwDLDgYQi4Fv7pA@mail.gmail.com>
 <CAEensMx3qvL7qmT=PhxYoJ4v5P8USn1qyAGBcB1WR5R4FQ24og@mail.gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <CAEensMx3qvL7qmT=PhxYoJ4v5P8USn1qyAGBcB1WR5R4FQ24og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/18/22 9:58 AM, yanteng si 写道:
> yanteng si <siyanteng01@gmail.com> 于2022年4月15日周五 10:09写道：
>> 司延腾 <siyanteng@loongson.cn> 于2022年4月15日周五 09:31写道：
>>> Dear siyanteng
>>>
>>> Could you help to review my translation？
>>>
>>> Certainly!
>>>
>>> --CC siyanteng01@gmail.com
>>>
>>> Thanks,
>>> Yanteng
>>>
>>>
>>>
>>>
>>>
>>> -------- 原始邮件 --------
>>> 发件人：白浩文 <baihaowen@meizu.com>
>>> 时间：2022年4月12日 17:29
>>> 收件人：alexs@kernel.org,corbet@lwn.net
>>> 抄送：siyanteng@loongson.cn,白浩文 <baihaowen@meizu.com>,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org
>>> 主题：[PATCH V3] docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
>>>
>>> As the tools/vm/page_owner_sort added some feature and original text
>>> updated, sync the translation of zh_CN.
>>>
>>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>>> ---
>>> V1-&gt;V2: fix whitespace warning.
>>> V2-&gt;V3: fix some tab Alignment issue.
>>>
>>> Documentation/translations/zh_CN/vm/page_owner.rst | 54 +++++++++++++++++++++-
>>> 1 file changed, 53 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/translations/zh_CN/vm/page_owner.rst b/Documentation/translations/zh_CN/vm/page_owner.rst
>>> index 9e951fabba9d..0d4f94034db6 100644
>>> --- a/Documentation/translations/zh_CN/vm/page_owner.rst
>>> +++ b/Documentation/translations/zh_CN/vm/page_owner.rst
>>> @@ -103,14 +103,66 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
>>> -m              按总内存排序
>>> -p              按pid排序。
>>> -P              按tgid排序。
>>> +               -n              按任务名称排序。
>>> -r              按内存释放时间排序。
>>> -s              按堆栈跟踪排序。
>>> -t              按时间排序（默认）。
>>> +               --sort <order>  指定排序顺序。排序语法是 [+|-]key[,[+|-]key[,...]]. 从
>>> +                                               **标准格式说明符**部分选择一个键。"+" 是可选的，因为默认方向是增加数字或字典顺序。
>>> +                                               允许混合使用缩写键和全称键。
>>> +
>>> +               Examples:
>>> +                               ./page_owner_sort <input> <output> --sort=n,+pid,-tgid
>>> +                               ./page_owner_sort <input> <output> --sort=at
>>>
>>> 其它函数:
>>>
>>> Cull:
>>> -               -c              通过比较堆栈跟踪而不是总块来进行剔除。
>>> +               --cull <rules>
>>> +                               指定筛选规则。筛选语法是 key[,key[,...]]。在**标准格式说明符**部分选择一个多字母键
>>> +
>>> +               <rules> 是逗号分隔列表形式的单个参数，它提供了一种指定单个筛选规则的方法。下面的**标准格式说明
>>> +                               符**部分描述了可识别的关键字。<rules> 可以由键 k1,k2, ... 顺序指定，如下面的
>>> +                               STANDARD SORT KEYS 部分所述。允许混合使用缩写形式和完整形式的键。
>>>
>>> +               Examples:
>>> +                               ./page_owner_sort <input> <output> --cull=stacktrace
>>> +                               ./page_owner_sort <input> <output> --cull=st,pid,name
>>> +                               ./page_owner_sort <input> <output> --cull=n,f
>>> Filter:
>>> -f              过滤掉内存已被释放的块的信息。
>>> +
>>> +       Select:
>>> +               --pid <pidlist>         通过 pid 进行选择。这将选择进程 ID 号出现在 <pidlist> 中的块。
>>> +               --tgid <tgidlist>       通过 tgid 进行选择。这将选择线程组 ID 号出现在 <tgidlist> 中的块。
>>> +               --name <cmdlist>        按任务名称选择。这将选择任务名称出现在 <cmdlist> 中的块。
>>> +
>>> +               <pidlist>、<tgidlist>、<cmdlist>是逗号分隔列表形式的单参数，它提供了一种指定单个选择规则的方法。
>>> +
>>> +
>>> +               Examples:
>>> +                               ./page_owner_sort <input> <output> --pid=1
>>> +                               ./page_owner_sort <input> <output> --tgid=1,2,3
>>> +                               ./page_owner_sort <input> <output> --name name1,name2
>>> +
>>> +       标准格式说明符
>>> +==========================
>> I ran a build test before reviewing and found the following ERROR：
>>
>> Sphinx parallel build error:
>> docutils.utils.SystemMessage: .../vm/page_owner.rst:149: (SEVERE/4)
>> Missing matching underline for section title overline.
>>
>> As for how to fix it, see：
>> <https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#bullet-lists>
>>
>> ref:: Documentation/translations/zh_CN/index.rst
>> 顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
>> 的字符标点占用两个英文字符宽度， 所以，当英文要求不要超过每行100个字符时，
>> 中文就不要超过50个字符。另外，也要注意'-'，'=' 等符号与相关标题的对齐。在将
>> 补丁提交到社区之前，一定要进行必要的checkpatch.pl检查和编译测试。
>>> _<
> Oops! I forgot to write Haowen's email address last week.
>
> So, --to baihaowen@meizu.com
>
> 标准格式说明符
> ==============
>
> In this way，It should fix this error. Then you need to pass the build
> test yourself. The general steps are as follows:
>
> $ cd xxxx/linux-next
> $ ./scripts/sphinx-pre-install
> $ . sphinx_2.4.4/bin/activate
> $ make cleandocs
> $ make htmldocs
>
> If  there is no error and warning about zh_CN/vm/page_owner.rst，
> Congratulations, passed!
> else
> Please try to fix them
>
> Thanks,
> Yanteng
>
>
>> Thanks,
>> Yanteng
>>
>>> +--sort 选项:
>>> +
>>> +       缩写键             全称键             描述
>>> +       p               pid             进程 ID
>>> +       tg              tgid            线程组 ID
>>> +       n               name            任务名称
>>> +       st              stacktrace      页面分配的调用栈
>>> +       T               txt             块的全文
>>> +       ft              free_ts         页面被释放的时间戳
>>> +       at              alloc_ts        页面分配的时间戳
>>> +
>>> +--curl 选项:
>>> +
>>> +       缩写键             全称键             描述
>>> +       p               pid             进程 ID
>>> +       tg              tgid            线程组 ID
>>> +       n               name            任务名称
>>> +       f               free            该页面是否已被释放
>>> +       st              stacktrace      页面分配的调用栈
>>> --
>>> 2.7.4
>>>
>>>
>>> </output></output></output></cmdlist></tgidlist></pidlist></cmdlist></cmdlist></tgidlist></tgidlist></pidlist></pidlist></output></output></output></rules></rules></rules></output></output></order></baihaowen@meizu.com></baihaowen@meizu.com></baihaowen@meizu.com>
>>>
>>> 本邮件及其附件含有龙芯中科的商业秘密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制或散发）本邮件及其附件中的信息。如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
>>> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it.
hi, yanteng
Thank you for your help and review.

-- 
Haowen Bai

