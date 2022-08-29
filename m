Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4335A4F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiH2Oee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiH2Oea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:34:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C10E791084
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:34:25 -0700 (PDT)
Received: from [192.168.68.105] (unknown [111.19.45.114])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnmtnzgxjVeoLAA--.39136S3;
        Mon, 29 Aug 2022 22:34:17 +0800 (CST)
Message-ID: <4ff2a310-c8ba-ccf2-8d51-5181b83685c7@loongson.cn>
Date:   Mon, 29 Aug 2022 22:34:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] LoongArch: Fix warning: #warning syscall fstat not
 implemented
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1661766931-7277-1-git-send-email-yangtiezhu@loongson.cn>
 <d1a52fa2-380a-421b-8c46-5150a39be484@www.fastmail.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <d1a52fa2-380a-421b-8c46-5150a39be484@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxnmtnzgxjVeoLAA--.39136S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyxJrWDCw1kXF1UAF4DXFb_yoW3trb_J3
        srursru3ykAr1xA3ZIyF1DZFy8K3y5Wa4UZr4UWrW7Aw10v39YgrnI9ry8XF17Aanagrn8
        u3yYvF1UWF15ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2_HUDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/22 19:36, Arnd Bergmann wrote:
> On Mon, Aug 29, 2022, at 11:55 AM, Tiezhu Yang wrote:
> 
>>    CALL    scripts/checksyscalls.sh
>> <stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]
> 
>> @@ -1,4 +1,5 @@
>> /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +#define __ARCH_WANT_NEW_STAT
>> #define __ARCH_WANT_SYS_CLONE
>> #define __ARCH_WANT_SYS_CLONE3
> 
> The correct fix is to change scripts/checksyscalls.sh,
> making it always define __IGNORE_fstat
> 

Hi Arnd,

Thank you very much.

I read the commit message in the commit 82b355d161c9 ("y2038: Remove
newstat family from default syscall set"), I am not quite sure whether
we should check __ARCH_WANT_NEW_STAT first, like this:

   #ifndef __ARCH_WANT_NEW_STAT
   #define __IGNORE_fstat
   #endif

Thanks,
Tiezhu

