Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF74253208B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiEXCBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiEXCBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:01:31 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A8991E3D1;
        Mon, 23 May 2022 19:01:29 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axith4PIxi_sIgAA--.20109S3;
        Tue, 24 May 2022 10:01:28 +0800 (CST)
Subject: Re: [PATCH 0/3] MIPS: Modify early_parse_mem()
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1647615920-23103-1-git-send-email-yangtiezhu@loongson.cn>
 <c3e2d39f-1691-4065-c1fb-06f4059c3e0c@loongson.cn>
 <20220523132852.GA8289@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1492a31f-9cda-8e2f-165f-dd79b9abb100@loongson.cn>
Date:   Tue, 24 May 2022 10:01:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220523132852.GA8289@alpha.franken.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Axith4PIxi_sIgAA--.20109S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW8JFWrKw47Kw15AFWkWFg_yoWDXFc_Xa
        y7C39rGw1YqF97AF9rGr45ZrWDKrWUAFWrua42grsrCwn5XF1UGFsYkryrXr1kJF4xJrnr
        CrZ8Za4fXr429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUYc_-DUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/23/2022 09:28 PM, Thomas Bogendoerfer wrote:
> On Mon, May 09, 2022 at 03:30:11PM +0800, Tiezhu Yang wrote:
>>
>>
>> On 03/18/2022 11:05 PM, Tiezhu Yang wrote:
>>> Tiezhu Yang (3):
>>>   MIPS: Return -EINVAL if mem parameter is empty in early_parse_mem()
>>>   MIPS: Return -EINVAL if mem parameter is invalid in early_parse_mem()
>>>   MIPS: Use memblock_add_node() in early_parse_mem() under CONFIG_NUMA
>>>
>>>  arch/mips/kernel/setup.c | 35 +++++++++++++++++++++++++++++------
>>>  1 file changed, 29 insertions(+), 6 deletions(-)
>>>
>>
>> Hi Thomas,
>>
>> Any comments? Are you OK with these changes?
>
> first and last patch are ok with me. The second patch changes semantics
> for mem=, which I don't want to change. Iirc the latest idea to solve
> your problem was to use mem=XX@ syntax to limit detected memory, which
> is the preferred way for me, too.
>
> If you want I'll take patch 1 and 3 out of this series.
>
> Thomas.
>

OK, thank you.

Let me rebase and send v2 later.

Thanks,
Tiezhu

