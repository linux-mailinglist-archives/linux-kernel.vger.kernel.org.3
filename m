Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEDC583F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiG1Mlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiG1Mle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:41:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50A26DE86
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:41:32 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb+P5g+JiCys_AA--.25558S3;
        Thu, 28 Jul 2022 20:41:29 +0800 (CST)
Subject: Re: [PATCH v2 4/4] LoongArch: Support modules with new relocation
 types
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
 <93087353ec0d23c56345d4c05e3d9719b284942c.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <1c1b5d2f-84f0-534c-ace2-2da48b5a7419@loongson.cn>
Date:   Thu, 28 Jul 2022 20:41:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <93087353ec0d23c56345d4c05e3d9719b284942c.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxb+P5g+JiCys_AA--.25558S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4DKFW5Zw47uw15Ar1UJrb_yoW3Jr45pF
        yDZr9rtF48GFn7Wa40y3W5ZF1xWw1kKrW2ga43W3yxAFnrtFyIk3WxKr98GayUWrsYkryr
        XrnYgw1xZa9rA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU5dpnJUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/28/2022 08:04 PM, Xi Ruoyao wrote:
> If GAS 2.40 and/or GCC 13 is used to build the kernel, the modules will
> contain R_LARCH_B26, R_LARCH_PCALA_HI20, R_LARCH_PCALA_LO12,
> R_LARCH_GOT_PC_HI20, and R_LARCH_GOT_PC_LO12 relocations.  Support them
> in the module loader to allow a kernel built with latest toolchain
> capable to load the modules.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/include/asm/elf.h        | 37 +++++++++++
>  arch/loongarch/kernel/module-sections.c | 12 +++-
>  arch/loongarch/kernel/module.c          | 83 +++++++++++++++++++++++++
>  3 files changed, 130 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
> index 5f3ff4781fda..7af0cebf28d7 100644
> --- a/arch/loongarch/include/asm/elf.h
> +++ b/arch/loongarch/include/asm/elf.h
> @@ -74,6 +74,43 @@
>  #define R_LARCH_SUB64				56
>  #define R_LARCH_GNU_VTINHERIT			57
>  #define R_LARCH_GNU_VTENTRY			58
> +#define R_LARCH_B16				64
> +#define R_LARCH_B21				65
> +#define R_LARCH_B26				66
> +#define R_LARCH_ABS_HI20			67
> +#define R_LARCH_ABS_LO12			68
> +#define R_LARCH_ABS64_LO20			69
> +#define R_LARCH_ABS64_HI12			70
> +#define R_LARCH_PCALA_HI20			71
> +#define R_LARCH_PCALA_LO12			72
> +#define R_LARCH_PCALA64_LO20			73
> +#define R_LARCH_PCALA64_HI12			74
> +#define R_LARCH_GOT_PC_HI20			75
> +#define R_LARCH_GOT_PC_LO12			76
> +#define R_LARCH_GOT64_PC_LO20			77
> +#define R_LARCH_GOT64_PC_HI12			78
> +#define R_LARCH_GOT_HI20			79
> +#define R_LARCH_GOT_LO12			80
> +#define R_LARCH_GOT64_LO20			81
> +#define R_LARCH_GOT64_HI12			82
> +#define R_LARCH_TLS_LE_HI20			83
> +#define R_LARCH_TLS_LE_LO12			84
> +#define R_LARCH_TLS_LE64_LO20			85
> +#define R_LARCH_TLS_LE64_HI12			86
> +#define R_LARCH_TLS_IE_PC_HI20			87
> +#define R_LARCH_TLS_IE_PC_LO12			88
> +#define R_LARCH_TLS_IE64_PC_LO20		89
> +#define R_LARCH_TLS_IE64_PC_HI12		90
> +#define R_LARCH_TLS_IE_HI20			91
> +#define R_LARCH_TLS_IE_LO12			92
> +#define R_LARCH_TLS_IE64_LO20			93
> +#define R_LARCH_TLS_IE64_HI12			94
> +#define R_LARCH_TLS_LD_PC_HI20			95
> +#define R_LARCH_TLS_LD_HI20			96
> +#define R_LARCH_TLS_GD_PC_HI20			97
> +#define R_LARCH_TLS_GD_HI20			98
> +#define R_LARCH_32_PCREL			99
> +#define R_LARCH_RELAX				100
>
>  #ifndef ELF_ARCH
>
> diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
> index 36a77771d18c..8c0e4ad048cc 100644
> --- a/arch/loongarch/kernel/module-sections.c
> +++ b/arch/loongarch/kernel/module-sections.c
> @@ -76,12 +76,20 @@ static void count_max_entries(Elf_Rela *relas, int num,
>
>  	for (i = 0; i < num; i++) {
>  		type = ELF_R_TYPE(relas[i].r_info);
> -		if (type == R_LARCH_SOP_PUSH_PLT_PCREL) {
> +		switch (type) {
> +		case R_LARCH_SOP_PUSH_PLT_PCREL:
> +		case R_LARCH_B26:
>  			if (!duplicate_rela(relas, i))
>  				(*plts)++;
> -		} else if (type == R_LARCH_SOP_PUSH_GPREL)
> +			break;
> +		case R_LARCH_SOP_PUSH_GPREL:
> +		case R_LARCH_GOT_PC_HI20:
>  			if (!duplicate_rela(relas, i))
>  				(*gots)++;
> +			break;
> +		default:
> +			/* Do nothing. */
> +		}
>  	}
>  }
>
> diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> index 3ac4fbb5f109..8954ac24d4ab 100644
> --- a/arch/loongarch/kernel/module.c
> +++ b/arch/loongarch/kernel/module.c
> @@ -291,6 +291,84 @@ static int apply_r_larch_add_sub(struct module *mod, u32 *location, Elf_Addr v,
>  	}
>  }
>
> +static int apply_r_larch_b26(struct module *mod, u32 *location, Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	ptrdiff_t offset = (void *)v - (void *)location;
> +
> +	if (offset >= SZ_128M)
> +		v = module_emit_plt_entry(mod, v);
> +
> +	if (offset < -SZ_128M)
> +		v = module_emit_plt_entry(mod, v);
> +
> +	offset = (void *)v - (void *)location;
> +
> +	if (!signed_imm_check(offset, 28)) {
> +		pr_err("module %s: jump offset = 0x%llx overflow! dangerous R_LARCH_B26 (%u) relocation\n",
> +				mod->name, (long long)offset, type);
> +		return -ENOEXEC;
> +	}
> +
> +	if (offset & 3) {
> +		pr_err("module %s: jump offset = 0x%llx unaligned! dangerous R_LARCH_B26 (%u) relocation\n",
> +				mod->name, (long long)offset, type);
> +		return -ENOEXEC;
> +	}
Unaligned is handled more efficiently before overflow checking, while
being consistent with apply_r_larch_sop_imm_field.

> +
> +	*location &= ~(u32)0x3ffffff;
> +	*location |= (offset >> 18) & 0x3ff;
> +	*location |= ((offset >> 2) & 0xffff) << 10;

It may be better to use the loongarch_instruction format to modify the
immediate field of the instruction, similar to the following:

union loongarch_instruction *insn = (union loongarch_instruction *)location;

offset >>= 2;
insn->reg0i26_format.immediate_l = offset & 0xffff;
insn->reg0i26_format.immediate_h = (offset >> 16) & 0x3ff;

> +	return 0;
> +}
> +
> +static int apply_r_larch_pcala_hi20(struct module *mod, u32 *location,
> +		Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
> +		unsigned int type)
> +{
> +	ptrdiff_t offset = (void *)((v + 0x800) & ~0xfff) -
> +		(void *)((Elf_Addr)location & ~0xfff);
> +
> +	if (!signed_imm_check(offset, 32)) {
> +		pr_err("module %s: PCALA offset = 0x%llx does not fit in 32-bit signed and is unsupported by kernel! dangerous %s (%u) relocation\n",
> +				mod->name, (long long)offset, __func__, type);
> +		return -ENOEXEC;
> +	}
> +
> +	*location &= ~((u32)0xfffff << 5);
> +	*location |= ((offset >> 12) & 0xfffff) << 5;

Ditto.

> +	return 0;
> +}
> +
> +static int apply_r_larch_got_pc_hi20(struct module *mod, u32 *location,
> +		Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
> +		unsigned int type)
> +{
> +	Elf_Addr got = module_emit_got_entry(mod, v);
> +
> +	return apply_r_larch_pcala_hi20(mod, location, got, rela_stack,
> +			rela_stack_top, type);
> +}
> +
> +static int apply_r_larch_pcala_lo12(struct module *mod, u32 *location,
> +		Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
> +		unsigned int type)
> +{
> +	*location &= ~((u32)0xfff << 10);
> +	*location |= ((u32)v & 0xfff) << 10;

Ditto.

Thanks,
Youling
> +	return 0;
> +}
> +
> +static int apply_r_larch_got_pc_lo12(struct module *mod, u32 *location,
> +		Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
> +		unsigned int type)
> +{
> +	Elf_Addr got = module_emit_got_entry(mod, v);
> +
> +	return apply_r_larch_pcala_lo12(mod, location, got, rela_stack,
> +			rela_stack_top, type);
> +}
> +
>  /*
>   * reloc_handlers_rela() - Apply a particular relocation to a module
>   * @mod: the module to apply the reloc to
> @@ -321,6 +399,11 @@ static reloc_rela_handler reloc_rela_handlers[] = {
>  	[R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE] 	     = apply_r_larch_sop,
>  	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
>  	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     = apply_r_larch_add_sub,
> +	[R_LARCH_B26]					     = apply_r_larch_b26,
> +	[R_LARCH_PCALA_HI20]				     = apply_r_larch_pcala_hi20,
> +	[R_LARCH_PCALA_LO12]				     = apply_r_larch_pcala_lo12,
> +	[R_LARCH_GOT_PC_HI20]				     = apply_r_larch_got_pc_hi20,
> +	[R_LARCH_GOT_PC_LO12]				     = apply_r_larch_got_pc_lo12,
>  };
>
>  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>

