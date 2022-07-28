Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE7583B21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiG1JVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiG1JVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:21:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41D4F48CA1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:21:07 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX9MBVeJivcQ+AA--.797S3;
        Thu, 28 Jul 2022 17:21:05 +0800 (CST)
Subject: Re: [PATCH 1/5] LoongArch: Add section of GOT for kernel module
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
 <3f43d51d530344f73a0a7087407799ff9dff3ba8.camel@xry111.site>
 <849f514e-f78a-72a2-b94e-6974074b75eb@loongson.cn>
 <00914cf65b64e06f370213fdc079111aa2a27145.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <fac4319d-26ee-1702-518c-2d6fbb1a0d57@loongson.cn>
Date:   Thu, 28 Jul 2022 17:21:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <00914cf65b64e06f370213fdc079111aa2a27145.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxX9MBVeJivcQ+AA--.797S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4xtFy5KFyxKw48CFykKrg_yoWfZrgEvr
        nruw1kGayxuryrAwsxtrW5GrnxtanIvrykZrsrXF9xCr95tF92kF4vgw1fu3W5KrWfJrs8
        urnaqaykZayaqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIAYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUxT5dDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/28/2022 05:02 PM, Xi Ruoyao wrote:
> On Thu, 2022-07-28 at 16:29 +0800, Youling Tang wrote:
>> On 07/28/2022 12:26 AM, Xi Ruoyao wrote:
>>> +	mod->arch.got.shdr->sh_type = SHT_NOBITS;
>>> +	mod->arch.got.shdr->sh_flags = SHF_ALLOC;
>>> +	mod->arch.got.shdr->sh_addralign = L1_CACHE_BYTES;
>>> +	mod->arch.got.shdr->sh_size = (num_plts + 1) *
>>> sizeof(struct plt_entry);
>>> +	mod->arch.got.num_entries = 0;
>>> +	mod->arch.got.max_entries = num_plts;
>>  Hi, Ruoyao
>>
>>   We should use num_gots instead of num_plts when creating .got
>> section.
>
> Yes, it's a stupid error and I'll fix it in V2.
>
> But why didn't this cause a malfunction on my system? :(.

Maybe num_plts is greater than num_gots, and the size of plt_entry is 
equivalent to the size of four got_entry, so that when the module is 
loaded, it just allocates a larger space without causing the module to 
fail to load.

Thanks,
Youling
>

