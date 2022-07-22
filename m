Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC157DA86
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiGVG60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiGVG6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:58:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F3058C8E5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:58:20 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxE9CEStpiRlkuAA--.3006S3;
        Fri, 22 Jul 2022 14:58:13 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: Remove LOONGARCH_CPUCFG48 and some CSR
 definitions
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1658305979-2073-1-git-send-email-yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fc5a891d-e5a9-c02d-08e0-318213cde8f4@loongson.cn>
Date:   Fri, 22 Jul 2022 14:58:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1658305979-2073-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxE9CEStpiRlkuAA--.3006S3
X-Coremail-Antispam: 1UD129KBjvAXoWfGw4xJr4kAr47CFyrXr4xWFg_yoW8JFWkKo
        W8J3yfZ3yrG3yfCws09w4jqr9rArykAF1DX3y0qrWkKwnIq39rKF4Ut34vgr13W3yUWr13
        Grn0kFWDtayayr4Dn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYT7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
        W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfU8ksgUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/20/2022 04:32 PM, Tiezhu Yang wrote:
> According to the configuration information accessible by the CPUCFG
> instruction [1] and the Overview of Control and Status Registers [2],
> we can not see the descriptions about LOONGARCH_CPUCFG48 (0x30),
> LOONGARCH_CSR_PRID (0xc0), LOONGARCH_CSR_MCSR* (0xc0 ~ 0xff) and
> LOONGARCH_CSR_UCAWIN* (0x100 ~ 0x109), they are not used in the
> current kernel code.
>
> LOONGARCH_CPUCFG48 may be used only in the firmware layer, it should
> not be used in the future for kernel developers, remove the related
> LOONGARCH_CPUCFG48 definitions.
>
> LOONGARCH_CSR_MCSR* is shadow of LOONGARCH_CPUCFG*, no need to access
> LOONGARCH_CSR_MCSR* and LOONGARCH_CSR_PRID through CSR instruction,
> use CPUCFG instruction to access LOONGARCH_CPUCFG* is enough, so also
> remove LOONGARCH_CSR_MCSR* and LOONGARCH_CSR_PRID definitions.
>
> LOONGARCH_CSR_UCAWIN* may be not implemented in hardware, use CSR
> instruction to access them is meaningless, so also remove the related
> LOONGARCH_CSR_UCAWIN* definitions.
>
> The intention of this patch is to keep consistent between the code and
> the manual.
>
> [1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#the-configuration-information-accessible-by-the-cpucfg-instruction
> [2] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#table-overview-of-control-and-status-registers
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v2:
>   -- Remove LOONGARCH_CSR_PRID and LOONGARCH_CSR_UCAWIN*
>   -- Modify the patch subject and update the commit message
>
>  arch/loongarch/include/asm/loongarch.h | 229 ---------------------------------
>  1 file changed, 229 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
> index 3ba4f7e..43755f9 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -218,12 +218,6 @@ static inline u32 read_cpucfg(u32 reg)
>  #define  CPUCFG20_L3_SETS		16
>  #define  CPUCFG20_L3_SIZE		24
>
> -#define LOONGARCH_CPUCFG48		0x30
> -#define  CPUCFG48_MCSR_LCK		BIT(0)
> -#define  CPUCFG48_NAP_EN		BIT(1)
> -#define  CPUCFG48_VFPU_CG		BIT(2)
> -#define  CPUCFG48_RAM_CG		BIT(3)
> -
>  #ifndef __ASSEMBLY__
>
>  /* CSR */
> @@ -728,229 +722,6 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
>
>  #define LOONGARCH_CSR_CTAG		0x98	/* TagLo + TagHi */
>
> -#define LOONGARCH_CSR_PRID		0xc0
> -
> -/* Shadow MCSR : 0xc0 ~ 0xff */
> -#define LOONGARCH_CSR_MCSR0		0xc0	/* CPUCFG0 and CPUCFG1 */
> -#define  MCSR0_INT_IMPL_SHIFT		58
> -#define  MCSR0_INT_IMPL			0
> -#define  MCSR0_IOCSR_BRD_SHIFT		57
> -#define  MCSR0_IOCSR_BRD		(_ULCAST_(1) << MCSR0_IOCSR_BRD_SHIFT)
> -#define  MCSR0_HUGEPG_SHIFT		56
> -#define  MCSR0_HUGEPG			(_ULCAST_(1) << MCSR0_HUGEPG_SHIFT)
> -#define  MCSR0_RPLMTLB_SHIFT		55
> -#define  MCSR0_RPLMTLB			(_ULCAST_(1) << MCSR0_RPLMTLB_SHIFT)
> -#define  MCSR0_EP_SHIFT			54
> -#define  MCSR0_EP			(_ULCAST_(1) << MCSR0_EP_SHIFT)
> -#define  MCSR0_RI_SHIFT			53
> -#define  MCSR0_RI			(_ULCAST_(1) << MCSR0_RI_SHIFT)
> -#define  MCSR0_UAL_SHIFT		52
> -#define  MCSR0_UAL			(_ULCAST_(1) << MCSR0_UAL_SHIFT)
> -#define  MCSR0_VABIT_SHIFT		44
> -#define  MCSR0_VABIT_WIDTH		8
> -#define  MCSR0_VABIT			(_ULCAST_(0xff) << MCSR0_VABIT_SHIFT)
> -#define  VABIT_DEFAULT			0x2f
> -#define  MCSR0_PABIT_SHIFT		36
> -#define  MCSR0_PABIT_WIDTH		8
> -#define  MCSR0_PABIT			(_ULCAST_(0xff) << MCSR0_PABIT_SHIFT)
> -#define  PABIT_DEFAULT			0x2f
> -#define  MCSR0_IOCSR_SHIFT		35
> -#define  MCSR0_IOCSR			(_ULCAST_(1) << MCSR0_IOCSR_SHIFT)
> -#define  MCSR0_PAGING_SHIFT		34
> -#define  MCSR0_PAGING			(_ULCAST_(1) << MCSR0_PAGING_SHIFT)
> -#define  MCSR0_GR64_SHIFT		33
> -#define  MCSR0_GR64			(_ULCAST_(1) << MCSR0_GR64_SHIFT)
> -#define  GR64_DEFAULT			1
> -#define  MCSR0_GR32_SHIFT		32
> -#define  MCSR0_GR32			(_ULCAST_(1) << MCSR0_GR32_SHIFT)
> -#define  GR32_DEFAULT			0
> -#define  MCSR0_PRID_WIDTH		32
> -#define  MCSR0_PRID			0x14C010
> -
> -#define LOONGARCH_CSR_MCSR1		0xc1	/* CPUCFG2 and CPUCFG3 */
> -#define  MCSR1_HPFOLD_SHIFT		43
> -#define  MCSR1_HPFOLD			(_ULCAST_(1) << MCSR1_HPFOLD_SHIFT)
> -#define  MCSR1_SPW_LVL_SHIFT		40
> -#define  MCSR1_SPW_LVL_WIDTH		3
> -#define  MCSR1_SPW_LVL			(_ULCAST_(7) << MCSR1_SPW_LVL_SHIFT)
> -#define  MCSR1_ICACHET_SHIFT		39
> -#define  MCSR1_ICACHET			(_ULCAST_(1) << MCSR1_ICACHET_SHIFT)
> -#define  MCSR1_ITLBT_SHIFT		38
> -#define  MCSR1_ITLBT			(_ULCAST_(1) << MCSR1_ITLBT_SHIFT)
> -#define  MCSR1_LLDBAR_SHIFT		37
> -#define  MCSR1_LLDBAR			(_ULCAST_(1) << MCSR1_LLDBAR_SHIFT)
> -#define  MCSR1_SCDLY_SHIFT		36
> -#define  MCSR1_SCDLY			(_ULCAST_(1) << MCSR1_SCDLY_SHIFT)
> -#define  MCSR1_LLEXC_SHIFT		35
> -#define  MCSR1_LLEXC			(_ULCAST_(1) << MCSR1_LLEXC_SHIFT)
> -#define  MCSR1_UCACC_SHIFT		34
> -#define  MCSR1_UCACC			(_ULCAST_(1) << MCSR1_UCACC_SHIFT)
> -#define  MCSR1_SFB_SHIFT		33
> -#define  MCSR1_SFB			(_ULCAST_(1) << MCSR1_SFB_SHIFT)
> -#define  MCSR1_CCDMA_SHIFT		32
> -#define  MCSR1_CCDMA			(_ULCAST_(1) << MCSR1_CCDMA_SHIFT)
> -#define  MCSR1_LAMO_SHIFT		22
> -#define  MCSR1_LAMO			(_ULCAST_(1) << MCSR1_LAMO_SHIFT)
> -#define  MCSR1_LSPW_SHIFT		21
> -#define  MCSR1_LSPW			(_ULCAST_(1) << MCSR1_LSPW_SHIFT)
> -#define  MCSR1_MIPSBT_SHIFT		20
> -#define  MCSR1_MIPSBT			(_ULCAST_(1) << MCSR1_MIPSBT_SHIFT)
> -#define  MCSR1_ARMBT_SHIFT		19
> -#define  MCSR1_ARMBT			(_ULCAST_(1) << MCSR1_ARMBT_SHIFT)
> -#define  MCSR1_X86BT_SHIFT		18
> -#define  MCSR1_X86BT			(_ULCAST_(1) << MCSR1_X86BT_SHIFT)
> -#define  MCSR1_LLFTPVERS_SHIFT		15
> -#define  MCSR1_LLFTPVERS_WIDTH		3
> -#define  MCSR1_LLFTPVERS		(_ULCAST_(7) << MCSR1_LLFTPVERS_SHIFT)
> -#define  MCSR1_LLFTP_SHIFT		14
> -#define  MCSR1_LLFTP			(_ULCAST_(1) << MCSR1_LLFTP_SHIFT)
> -#define  MCSR1_VZVERS_SHIFT		11
> -#define  MCSR1_VZVERS_WIDTH		3
> -#define  MCSR1_VZVERS			(_ULCAST_(7) << MCSR1_VZVERS_SHIFT)
> -#define  MCSR1_VZ_SHIFT			10
> -#define  MCSR1_VZ			(_ULCAST_(1) << MCSR1_VZ_SHIFT)
> -#define  MCSR1_CRYPTO_SHIFT		9
> -#define  MCSR1_CRYPTO			(_ULCAST_(1) << MCSR1_CRYPTO_SHIFT)
> -#define  MCSR1_COMPLEX_SHIFT		8
> -#define  MCSR1_COMPLEX			(_ULCAST_(1) << MCSR1_COMPLEX_SHIFT)
> -#define  MCSR1_LASX_SHIFT		7
> -#define  MCSR1_LASX			(_ULCAST_(1) << MCSR1_LASX_SHIFT)
> -#define  MCSR1_LSX_SHIFT		6
> -#define  MCSR1_LSX			(_ULCAST_(1) << MCSR1_LSX_SHIFT)
> -#define  MCSR1_FPVERS_SHIFT		3
> -#define  MCSR1_FPVERS_WIDTH		3
> -#define  MCSR1_FPVERS			(_ULCAST_(7) << MCSR1_FPVERS_SHIFT)
> -#define  MCSR1_FPDP_SHIFT		2
> -#define  MCSR1_FPDP			(_ULCAST_(1) << MCSR1_FPDP_SHIFT)
> -#define  MCSR1_FPSP_SHIFT		1
> -#define  MCSR1_FPSP			(_ULCAST_(1) << MCSR1_FPSP_SHIFT)
> -#define  MCSR1_FP_SHIFT			0
> -#define  MCSR1_FP			(_ULCAST_(1) << MCSR1_FP_SHIFT)
> -
> -#define LOONGARCH_CSR_MCSR2		0xc2	/* CPUCFG4 and CPUCFG5 */
> -#define  MCSR2_CCDIV_SHIFT		48
> -#define  MCSR2_CCDIV_WIDTH		16
> -#define  MCSR2_CCDIV			(_ULCAST_(0xffff) << MCSR2_CCDIV_SHIFT)
> -#define  MCSR2_CCMUL_SHIFT		32
> -#define  MCSR2_CCMUL_WIDTH		16
> -#define  MCSR2_CCMUL			(_ULCAST_(0xffff) << MCSR2_CCMUL_SHIFT)
> -#define  MCSR2_CCFREQ_WIDTH		32
> -#define  MCSR2_CCFREQ			(_ULCAST_(0xffffffff))
> -#define  CCFREQ_DEFAULT			0x5f5e100	/* 100MHz */
> -
> -#define LOONGARCH_CSR_MCSR3		0xc3	/* CPUCFG6 */
> -#define  MCSR3_UPM_SHIFT		14
> -#define  MCSR3_UPM			(_ULCAST_(1) << MCSR3_UPM_SHIFT)
> -#define  MCSR3_PMBITS_SHIFT		8
> -#define  MCSR3_PMBITS_WIDTH		6
> -#define  MCSR3_PMBITS			(_ULCAST_(0x3f) << MCSR3_PMBITS_SHIFT)
> -#define  PMBITS_DEFAULT			0x40
> -#define  MCSR3_PMNUM_SHIFT		4
> -#define  MCSR3_PMNUM_WIDTH		4
> -#define  MCSR3_PMNUM			(_ULCAST_(0xf) << MCSR3_PMNUM_SHIFT)
> -#define  MCSR3_PAMVER_SHIFT		1
> -#define  MCSR3_PAMVER_WIDTH		3
> -#define  MCSR3_PAMVER			(_ULCAST_(0x7) << MCSR3_PAMVER_SHIFT)
> -#define  MCSR3_PMP_SHIFT		0
> -#define  MCSR3_PMP			(_ULCAST_(1) << MCSR3_PMP_SHIFT)
> -
> -#define LOONGARCH_CSR_MCSR8		0xc8	/* CPUCFG16 and CPUCFG17 */
> -#define  MCSR8_L1I_SIZE_SHIFT		56
> -#define  MCSR8_L1I_SIZE_WIDTH		7
> -#define  MCSR8_L1I_SIZE			(_ULCAST_(0x7f) << MCSR8_L1I_SIZE_SHIFT)
> -#define  MCSR8_L1I_IDX_SHIFT		48
> -#define  MCSR8_L1I_IDX_WIDTH		8
> -#define  MCSR8_L1I_IDX			(_ULCAST_(0xff) << MCSR8_L1I_IDX_SHIFT)
> -#define  MCSR8_L1I_WAY_SHIFT		32
> -#define  MCSR8_L1I_WAY_WIDTH		16
> -#define  MCSR8_L1I_WAY			(_ULCAST_(0xffff) << MCSR8_L1I_WAY_SHIFT)
> -#define  MCSR8_L3DINCL_SHIFT		16
> -#define  MCSR8_L3DINCL			(_ULCAST_(1) << MCSR8_L3DINCL_SHIFT)
> -#define  MCSR8_L3DPRIV_SHIFT		15
> -#define  MCSR8_L3DPRIV			(_ULCAST_(1) << MCSR8_L3DPRIV_SHIFT)
> -#define  MCSR8_L3DPRE_SHIFT		14
> -#define  MCSR8_L3DPRE			(_ULCAST_(1) << MCSR8_L3DPRE_SHIFT)
> -#define  MCSR8_L3IUINCL_SHIFT		13
> -#define  MCSR8_L3IUINCL			(_ULCAST_(1) << MCSR8_L3IUINCL_SHIFT)
> -#define  MCSR8_L3IUPRIV_SHIFT		12
> -#define  MCSR8_L3IUPRIV			(_ULCAST_(1) << MCSR8_L3IUPRIV_SHIFT)
> -#define  MCSR8_L3IUUNIFY_SHIFT		11
> -#define  MCSR8_L3IUUNIFY		(_ULCAST_(1) << MCSR8_L3IUUNIFY_SHIFT)
> -#define  MCSR8_L3IUPRE_SHIFT		10
> -#define  MCSR8_L3IUPRE			(_ULCAST_(1) << MCSR8_L3IUPRE_SHIFT)
> -#define  MCSR8_L2DINCL_SHIFT		9
> -#define  MCSR8_L2DINCL			(_ULCAST_(1) << MCSR8_L2DINCL_SHIFT)
> -#define  MCSR8_L2DPRIV_SHIFT		8
> -#define  MCSR8_L2DPRIV			(_ULCAST_(1) << MCSR8_L2DPRIV_SHIFT)
> -#define  MCSR8_L2DPRE_SHIFT		7
> -#define  MCSR8_L2DPRE			(_ULCAST_(1) << MCSR8_L2DPRE_SHIFT)
> -#define  MCSR8_L2IUINCL_SHIFT		6
> -#define  MCSR8_L2IUINCL			(_ULCAST_(1) << MCSR8_L2IUINCL_SHIFT)
> -#define  MCSR8_L2IUPRIV_SHIFT		5
> -#define  MCSR8_L2IUPRIV			(_ULCAST_(1) << MCSR8_L2IUPRIV_SHIFT)
> -#define  MCSR8_L2IUUNIFY_SHIFT		4
> -#define  MCSR8_L2IUUNIFY		(_ULCAST_(1) << MCSR8_L2IUUNIFY_SHIFT)
> -#define  MCSR8_L2IUPRE_SHIFT		3
> -#define  MCSR8_L2IUPRE			(_ULCAST_(1) << MCSR8_L2IUPRE_SHIFT)
> -#define  MCSR8_L1DPRE_SHIFT		2
> -#define  MCSR8_L1DPRE			(_ULCAST_(1) << MCSR8_L1DPRE_SHIFT)
> -#define  MCSR8_L1IUUNIFY_SHIFT		1
> -#define  MCSR8_L1IUUNIFY		(_ULCAST_(1) << MCSR8_L1IUUNIFY_SHIFT)
> -#define  MCSR8_L1IUPRE_SHIFT		0
> -#define  MCSR8_L1IUPRE			(_ULCAST_(1) << MCSR8_L1IUPRE_SHIFT)
> -
> -#define LOONGARCH_CSR_MCSR9		0xc9	/* CPUCFG18 and CPUCFG19 */
> -#define  MCSR9_L2U_SIZE_SHIFT		56
> -#define  MCSR9_L2U_SIZE_WIDTH		7
> -#define  MCSR9_L2U_SIZE			(_ULCAST_(0x7f) << MCSR9_L2U_SIZE_SHIFT)
> -#define  MCSR9_L2U_IDX_SHIFT		48
> -#define  MCSR9_L2U_IDX_WIDTH		8
> -#define  MCSR9_L2U_IDX			(_ULCAST_(0xff) << MCSR9_IDX_LOG_SHIFT)
> -#define  MCSR9_L2U_WAY_SHIFT		32
> -#define  MCSR9_L2U_WAY_WIDTH		16
> -#define  MCSR9_L2U_WAY			(_ULCAST_(0xffff) << MCSR9_L2U_WAY_SHIFT)
> -#define  MCSR9_L1D_SIZE_SHIFT		24
> -#define  MCSR9_L1D_SIZE_WIDTH		7
> -#define  MCSR9_L1D_SIZE			(_ULCAST_(0x7f) << MCSR9_L1D_SIZE_SHIFT)
> -#define  MCSR9_L1D_IDX_SHIFT		16
> -#define  MCSR9_L1D_IDX_WIDTH		8
> -#define  MCSR9_L1D_IDX			(_ULCAST_(0xff) << MCSR9_L1D_IDX_SHIFT)
> -#define  MCSR9_L1D_WAY_SHIFT		0
> -#define  MCSR9_L1D_WAY_WIDTH		16
> -#define  MCSR9_L1D_WAY			(_ULCAST_(0xffff) << MCSR9_L1D_WAY_SHIFT)
> -
> -#define LOONGARCH_CSR_MCSR10		0xca	/* CPUCFG20 */
> -#define  MCSR10_L3U_SIZE_SHIFT		24
> -#define  MCSR10_L3U_SIZE_WIDTH		7
> -#define  MCSR10_L3U_SIZE		(_ULCAST_(0x7f) << MCSR10_L3U_SIZE_SHIFT)
> -#define  MCSR10_L3U_IDX_SHIFT		16
> -#define  MCSR10_L3U_IDX_WIDTH		8
> -#define  MCSR10_L3U_IDX			(_ULCAST_(0xff) << MCSR10_L3U_IDX_SHIFT)
> -#define  MCSR10_L3U_WAY_SHIFT		0
> -#define  MCSR10_L3U_WAY_WIDTH		16
> -#define  MCSR10_L3U_WAY			(_ULCAST_(0xffff) << MCSR10_L3U_WAY_SHIFT)
> -
> -#define LOONGARCH_CSR_MCSR24		0xf0	/* cpucfg48 */
> -#define  MCSR24_RAMCG_SHIFT		3
> -#define  MCSR24_RAMCG			(_ULCAST_(1) << MCSR24_RAMCG_SHIFT)
> -#define  MCSR24_VFPUCG_SHIFT		2
> -#define  MCSR24_VFPUCG			(_ULCAST_(1) << MCSR24_VFPUCG_SHIFT)
> -#define  MCSR24_NAPEN_SHIFT		1
> -#define  MCSR24_NAPEN			(_ULCAST_(1) << MCSR24_NAPEN_SHIFT)
> -#define  MCSR24_MCSRLOCK_SHIFT		0
> -#define  MCSR24_MCSRLOCK		(_ULCAST_(1) << MCSR24_MCSRLOCK_SHIFT)
> -
> -/* Uncached accelerate windows registers */
> -#define LOONGARCH_CSR_UCAWIN		0x100
> -#define LOONGARCH_CSR_UCAWIN0_LO	0x102
> -#define LOONGARCH_CSR_UCAWIN0_HI	0x103
> -#define LOONGARCH_CSR_UCAWIN1_LO	0x104
> -#define LOONGARCH_CSR_UCAWIN1_HI	0x105
> -#define LOONGARCH_CSR_UCAWIN2_LO	0x106
> -#define LOONGARCH_CSR_UCAWIN2_HI	0x107
> -#define LOONGARCH_CSR_UCAWIN3_LO	0x108
> -#define LOONGARCH_CSR_UCAWIN3_HI	0x109
> -
>  /* Direct Map windows registers */
>  #define LOONGARCH_CSR_DMWIN0		0x180	/* 64 direct map win0: MEM & IF */
>  #define LOONGARCH_CSR_DMWIN1		0x181	/* 64 direct map win1: MEM & IF */
>

Hi all,

Are you OK with this change? Any comments will be much appreciated.

Thanks,
Tiezhu

