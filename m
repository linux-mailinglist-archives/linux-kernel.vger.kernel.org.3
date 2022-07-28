Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58676583B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiG1Jqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiG1Jqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:46:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C789140BFD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:46:41 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9L_WuJi7dU+AA--.24856S3;
        Thu, 28 Jul 2022 17:46:40 +0800 (CST)
Subject: Re: [PATCH 4/5] LoongArch: Stop using undocumented assembler options
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
 <4f09c81c22d0a16883a6914a8f7209957386c07c.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <4f4ced23-2046-586c-2590-542923025149@loongson.cn>
Date:   Thu, 28 Jul 2022 17:46:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <4f09c81c22d0a16883a6914a8f7209957386c07c.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxr9L_WuJi7dU+AA--.24856S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKFW5AFW5XF1fKF1fXrWUurg_yoW8Jr13pF
        Z2kr4DJa1fGFy8tr12v343Xr1q9a1DtF12vFZI9ry8CF4UZr1fXrWaya4DWFyDX3s7AFy0
        qr9agFy2qF45twUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IUYjXd5UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/28/2022 12:29 AM, Xi Ruoyao wrote:
> Now we can handle GOT and GOT-based relocations properly, remove the
> undocumented `-Wa,-mla-{global,local}-with-{pcrel,abs}` assembler hacks.
>
> Adjust assembly code to explicitly use "la.pcrel" where necessary.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Makefile      |  5 +----
>  arch/loongarch/kernel/head.S | 10 +++++-----
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 039dcc4fe1f3..9552c7880d34 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -40,10 +40,7 @@ endif
>
>  cflags-y			+= -G0 -pipe -msoft-float
>  LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
> -KBUILD_AFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
> -KBUILD_CFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
> -KBUILD_AFLAGS_MODULE		+= -Wa,-mla-global-with-abs
> -KBUILD_CFLAGS_MODULE		+= -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
> +KBUILD_CFLAGS_MODULE		+= -fplt

The -fplt flag may be removed, the compiler defaults to -fplt if not
specified (riscv is also not manually specified as -fplt).

Thanks,
Youling

