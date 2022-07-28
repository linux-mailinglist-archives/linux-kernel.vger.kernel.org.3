Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E563583B07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiG1JPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiG1JPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:15:00 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0497F6566E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:14:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx39CPU+Jij70+AA--.203S3;
        Thu, 28 Jul 2022 17:14:57 +0800 (CST)
Subject: Re: [PATCH 3/5] LoongArch: Support relocation against
 _GLOBAL_OFFSET_TABLE_
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
 <99733532831377ab6585d43ee40bf314a2d4c5a3.camel@xry111.site>
 <10c1e0f9-8409-a0f4-9b18-a5f56dfb14e1@loongson.cn>
 <9a79a424a11339ae025539c38fe121104ff00804.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <caf8ec4b-f74d-e6ef-17f2-9e899d41b3a9@loongson.cn>
Date:   Thu, 28 Jul 2022 17:14:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <9a79a424a11339ae025539c38fe121104ff00804.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx39CPU+Jij70+AA--.203S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xWFyUAF47WFWDAFyftFb_yoW8CFWkpr
        ZFkr4kKanrGrn5Gw17tw18ur1jka97ur4fKFZ8X3y8ArnYqryDur48tr90vF47X34kKw40
        qa4v9348Wa98ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgg_TUUUUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/2022 02:41 PM, Xi Ruoyao wrote:

> On Thu, 2022-07-28 at 09:02 +0800, Jinyang He wrote:
>
>> Hi, Ruoyao,
>>
>> It is possible to create a symbol when linking, which means
>> maybe we can add _GLOBAL_OFFSET_TABLE_ in 'module.lds.h'.
>> What do you think about it?
> Hi Jinyang,
>
> I think you are right, this patch can be replaced with the following,
> which is much simpler.
>
> -- >8 --
>
> With the stack-based relocations, the assembler emits three relocations
> to push the PC-relative offset of a GOT entry:
>
>      R_LARCH_SOP_PUSH_PCREL _GLOBAL_OFFSET_TABLE_
>      R_LARCH_SOP_PUSH_GPREL foo
>      R_LARCH_SOP_ADD
>
> In normal relocatable ELF object files, "_GLOBAL_OFFSET_TABLE_" is
> undefined in the symtab and the BFD linker generates it on final link.
> Define it for kernel modules so we will be able to really use
> R_LARCH_SOP_PUSH_GPREL relocation.
>
> Note that we need to use "HIDDEN" to make it a local symbol because each
> kernel module has its own GOT and the reference to it should not be
> resolved to the GOT in the main kernel image.
>
> Suggested-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>   arch/loongarch/include/asm/module.lds.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/include/asm/module.lds.h
> index 57bbd0cedd26..42b7cca0b947 100644
> --- a/arch/loongarch/include/asm/module.lds.h
> +++ b/arch/loongarch/include/asm/module.lds.h
> @@ -4,5 +4,5 @@ SECTIONS {
>   	. = ALIGN(4);
>   	.plt : { BYTE(0) }
>   	.plt.idx : { BYTE(0) }
> -	.got : { BYTE(0) }
> +	.got : { HIDDEN(_GLOBAL_OFFSET_TABLE_ = .); BYTE(0) }
Not sure but maybe re-align is needed here.
Since '{BYTE(0)}' actually use 1byte. _GLOABL_OFFSET_TABLE_ may have
difference with really GOT table entry. Have no machine and without 
test... :-(

Thanks,
Jinyang
>   }

