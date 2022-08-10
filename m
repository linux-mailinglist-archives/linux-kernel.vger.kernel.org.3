Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6540358EB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiHJMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHJMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:00:31 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F02B37;
        Wed, 10 Aug 2022 05:00:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VLv5JNk_1660132822;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLv5JNk_1660132822)
          by smtp.aliyun-inc.com;
          Wed, 10 Aug 2022 20:00:23 +0800
Subject: Re: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
To:     Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
 <cf03285d-62e7-c70a-4197-8519fe9effe0@microchip.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <31231d21-7d23-9412-01d4-b2d4aa73cfc9@linux.alibaba.com>
Date:   Wed, 10 Aug 2022 20:00:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cf03285d-62e7-c70a-4197-8519fe9effe0@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/10 上午5:20, Conor.Dooley@microchip.com 写道:
> On 02/08/2022 13:18, Xianting Tian wrote:
>> riscv: crash_core: Export kernel vm layout, phys_ram_base
> Can you please just use RISC-V: for the whole series, my OCD
> hates the mix haha.

Sorry, I missed it,  you ever pointed out this poblem in the comments of 
V3, I will definitely fix the issue in V6.

>
>> These infos are needed by the kdump crash tool. Since these values change
>> from time to time, it is preferable to export them via vmcoreinfo than to
>> change the crash's code frequently.
> This commit description doesn't seem to match the patches at all.
> I don't see any exporting happening here at all - this is documenting
The real export code is in 2/6 patch, yes this is the document just 
describe the exporting contents
> the export. Maybe I am just misunderstanding, but this commit message
> just doesn't seem to match the change. Secondly, should the subject not
> be something like "docs: admin-guide: add riscv crash kernel yada yada"?
the commit log for the file 
'Documentation/admin-guide/kdump/vmcoreinfo.rst' is not unified in the 
commit history of the file. I agree with you 'docs: admin-guide: xxx' is 
better,  will fix it V6.
> Maybe the current subject lime that explains the lack of a review from
> the docs maintainer?
yes, it is possible :)
>
> Thanks,
> Conor.
For your comments for other patches, I will fix it in v6, thanks
>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> index 8419019b6a88..6b76284a503c 100644
>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> @@ -595,3 +595,34 @@ X2TLB
>>   -----
>>   
>>   Indicates whether the crashed kernel enabled SH extended mode.
>> +
>> +RISCV64
>> +=======
>> +
>> +VA_BITS
>> +-------
>> +
>> +The maximum number of bits for virtual addresses. Used to compute the
>> +virtual memory ranges.
>> +
>> +PAGE_OFFSET
>> +-----------
>> +
>> +Indicates the virtual kernel start address of direct-mapped RAM region.
>> +
>> +phys_ram_base
>> +-------------
>> +
>> +Indicates the start physical RAM address.
>> +
>> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
>> +-----------------------------------------------------------------------------
>> +KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
>> +----------------------------------------------------------------------
>> +
>> +Used to get the correct ranges:
>> +	MODULES_VADDR ~ MODULES_END : Kernel module space.
>> +	VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
>> +	VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
>> +	KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
>> +	KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
