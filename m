Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC5572C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiGMEbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiGMEbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:31:36 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DDBB26FD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:31:34 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf+OiSs5iS8caAA--.58209S2;
        Wed, 13 Jul 2022 12:31:31 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Remove LOONGARCH_CPUCFG48 and LOONGARCH_CSR_MCSR* definitions
Date:   Wed, 13 Jul 2022 12:31:30 +0800
Message-Id: <1657686690-19979-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxf+OiSs5iS8caAA--.58209S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGw43XrykXF45WF4fJw18Zrb_yoWkZFWUpF
        4UKFyagrW8XFWxKwn3KF1rX3W7Xw43Aw1Yqrs8Wws8tas0g3Z7Ar1DXws5AFyFqr1rJFy8
        G397C3Wq9asxW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r45MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07b2nQUUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the configuration information accessible by the CPUCFG
instruction [1] and the Overview of Control and Status Registers [2],
we can not see the descriptions about LOONGARCH_CPUCFG48 (0x30) and
LOONGARCH_CSR_MCSR* (0xc0 ~ 0xff), they are not used in the current
kernel code.

LOONGARCH_CPUCFG48 may be used only in the firmware layer, it should
not be used in the future for kernel developers, remove the related
LOONGARCH_CPUCFG48 definitions.

LOONGARCH_CSR_MCSR* is shadow of CPUCFG, LOONGARCH_CSR_MCSR24 is
corresponding to LOONGARCH_CPUCFG48, no need to operate the other
LOONGARCH_CSR_MCSR* through CSR instruction, use CPUCFG instruction
to operate LOONGARCH_CPUCFG* is enough, so also remove the related
LOONGARCH_CSR_MCSR* definitions.

The intention of this patch is to keep consistent between the code
and the manual.

[1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#the-configuration-information-accessible-by-the-cpucfg-instruction
[2] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#table-overview-of-control-and-status-registers

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h | 216 ---------------------------------
 1 file changed, 216 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 3ba4f7e..9d40fa4 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -218,12 +218,6 @@ static inline u32 read_cpucfg(u32 reg)
 #define  CPUCFG20_L3_SETS		16
 #define  CPUCFG20_L3_SIZE		24
 
-#define LOONGARCH_CPUCFG48		0x30
-#define  CPUCFG48_MCSR_LCK		BIT(0)
-#define  CPUCFG48_NAP_EN		BIT(1)
-#define  CPUCFG48_VFPU_CG		BIT(2)
-#define  CPUCFG48_RAM_CG		BIT(3)
-
 #ifndef __ASSEMBLY__
 
 /* CSR */
@@ -730,216 +724,6 @@ static __always_inline void iocsr_write64(u64 val, u32 reg)
 
 #define LOONGARCH_CSR_PRID		0xc0
 
-/* Shadow MCSR : 0xc0 ~ 0xff */
-#define LOONGARCH_CSR_MCSR0		0xc0	/* CPUCFG0 and CPUCFG1 */
-#define  MCSR0_INT_IMPL_SHIFT		58
-#define  MCSR0_INT_IMPL			0
-#define  MCSR0_IOCSR_BRD_SHIFT		57
-#define  MCSR0_IOCSR_BRD		(_ULCAST_(1) << MCSR0_IOCSR_BRD_SHIFT)
-#define  MCSR0_HUGEPG_SHIFT		56
-#define  MCSR0_HUGEPG			(_ULCAST_(1) << MCSR0_HUGEPG_SHIFT)
-#define  MCSR0_RPLMTLB_SHIFT		55
-#define  MCSR0_RPLMTLB			(_ULCAST_(1) << MCSR0_RPLMTLB_SHIFT)
-#define  MCSR0_EP_SHIFT			54
-#define  MCSR0_EP			(_ULCAST_(1) << MCSR0_EP_SHIFT)
-#define  MCSR0_RI_SHIFT			53
-#define  MCSR0_RI			(_ULCAST_(1) << MCSR0_RI_SHIFT)
-#define  MCSR0_UAL_SHIFT		52
-#define  MCSR0_UAL			(_ULCAST_(1) << MCSR0_UAL_SHIFT)
-#define  MCSR0_VABIT_SHIFT		44
-#define  MCSR0_VABIT_WIDTH		8
-#define  MCSR0_VABIT			(_ULCAST_(0xff) << MCSR0_VABIT_SHIFT)
-#define  VABIT_DEFAULT			0x2f
-#define  MCSR0_PABIT_SHIFT		36
-#define  MCSR0_PABIT_WIDTH		8
-#define  MCSR0_PABIT			(_ULCAST_(0xff) << MCSR0_PABIT_SHIFT)
-#define  PABIT_DEFAULT			0x2f
-#define  MCSR0_IOCSR_SHIFT		35
-#define  MCSR0_IOCSR			(_ULCAST_(1) << MCSR0_IOCSR_SHIFT)
-#define  MCSR0_PAGING_SHIFT		34
-#define  MCSR0_PAGING			(_ULCAST_(1) << MCSR0_PAGING_SHIFT)
-#define  MCSR0_GR64_SHIFT		33
-#define  MCSR0_GR64			(_ULCAST_(1) << MCSR0_GR64_SHIFT)
-#define  GR64_DEFAULT			1
-#define  MCSR0_GR32_SHIFT		32
-#define  MCSR0_GR32			(_ULCAST_(1) << MCSR0_GR32_SHIFT)
-#define  GR32_DEFAULT			0
-#define  MCSR0_PRID_WIDTH		32
-#define  MCSR0_PRID			0x14C010
-
-#define LOONGARCH_CSR_MCSR1		0xc1	/* CPUCFG2 and CPUCFG3 */
-#define  MCSR1_HPFOLD_SHIFT		43
-#define  MCSR1_HPFOLD			(_ULCAST_(1) << MCSR1_HPFOLD_SHIFT)
-#define  MCSR1_SPW_LVL_SHIFT		40
-#define  MCSR1_SPW_LVL_WIDTH		3
-#define  MCSR1_SPW_LVL			(_ULCAST_(7) << MCSR1_SPW_LVL_SHIFT)
-#define  MCSR1_ICACHET_SHIFT		39
-#define  MCSR1_ICACHET			(_ULCAST_(1) << MCSR1_ICACHET_SHIFT)
-#define  MCSR1_ITLBT_SHIFT		38
-#define  MCSR1_ITLBT			(_ULCAST_(1) << MCSR1_ITLBT_SHIFT)
-#define  MCSR1_LLDBAR_SHIFT		37
-#define  MCSR1_LLDBAR			(_ULCAST_(1) << MCSR1_LLDBAR_SHIFT)
-#define  MCSR1_SCDLY_SHIFT		36
-#define  MCSR1_SCDLY			(_ULCAST_(1) << MCSR1_SCDLY_SHIFT)
-#define  MCSR1_LLEXC_SHIFT		35
-#define  MCSR1_LLEXC			(_ULCAST_(1) << MCSR1_LLEXC_SHIFT)
-#define  MCSR1_UCACC_SHIFT		34
-#define  MCSR1_UCACC			(_ULCAST_(1) << MCSR1_UCACC_SHIFT)
-#define  MCSR1_SFB_SHIFT		33
-#define  MCSR1_SFB			(_ULCAST_(1) << MCSR1_SFB_SHIFT)
-#define  MCSR1_CCDMA_SHIFT		32
-#define  MCSR1_CCDMA			(_ULCAST_(1) << MCSR1_CCDMA_SHIFT)
-#define  MCSR1_LAMO_SHIFT		22
-#define  MCSR1_LAMO			(_ULCAST_(1) << MCSR1_LAMO_SHIFT)
-#define  MCSR1_LSPW_SHIFT		21
-#define  MCSR1_LSPW			(_ULCAST_(1) << MCSR1_LSPW_SHIFT)
-#define  MCSR1_MIPSBT_SHIFT		20
-#define  MCSR1_MIPSBT			(_ULCAST_(1) << MCSR1_MIPSBT_SHIFT)
-#define  MCSR1_ARMBT_SHIFT		19
-#define  MCSR1_ARMBT			(_ULCAST_(1) << MCSR1_ARMBT_SHIFT)
-#define  MCSR1_X86BT_SHIFT		18
-#define  MCSR1_X86BT			(_ULCAST_(1) << MCSR1_X86BT_SHIFT)
-#define  MCSR1_LLFTPVERS_SHIFT		15
-#define  MCSR1_LLFTPVERS_WIDTH		3
-#define  MCSR1_LLFTPVERS		(_ULCAST_(7) << MCSR1_LLFTPVERS_SHIFT)
-#define  MCSR1_LLFTP_SHIFT		14
-#define  MCSR1_LLFTP			(_ULCAST_(1) << MCSR1_LLFTP_SHIFT)
-#define  MCSR1_VZVERS_SHIFT		11
-#define  MCSR1_VZVERS_WIDTH		3
-#define  MCSR1_VZVERS			(_ULCAST_(7) << MCSR1_VZVERS_SHIFT)
-#define  MCSR1_VZ_SHIFT			10
-#define  MCSR1_VZ			(_ULCAST_(1) << MCSR1_VZ_SHIFT)
-#define  MCSR1_CRYPTO_SHIFT		9
-#define  MCSR1_CRYPTO			(_ULCAST_(1) << MCSR1_CRYPTO_SHIFT)
-#define  MCSR1_COMPLEX_SHIFT		8
-#define  MCSR1_COMPLEX			(_ULCAST_(1) << MCSR1_COMPLEX_SHIFT)
-#define  MCSR1_LASX_SHIFT		7
-#define  MCSR1_LASX			(_ULCAST_(1) << MCSR1_LASX_SHIFT)
-#define  MCSR1_LSX_SHIFT		6
-#define  MCSR1_LSX			(_ULCAST_(1) << MCSR1_LSX_SHIFT)
-#define  MCSR1_FPVERS_SHIFT		3
-#define  MCSR1_FPVERS_WIDTH		3
-#define  MCSR1_FPVERS			(_ULCAST_(7) << MCSR1_FPVERS_SHIFT)
-#define  MCSR1_FPDP_SHIFT		2
-#define  MCSR1_FPDP			(_ULCAST_(1) << MCSR1_FPDP_SHIFT)
-#define  MCSR1_FPSP_SHIFT		1
-#define  MCSR1_FPSP			(_ULCAST_(1) << MCSR1_FPSP_SHIFT)
-#define  MCSR1_FP_SHIFT			0
-#define  MCSR1_FP			(_ULCAST_(1) << MCSR1_FP_SHIFT)
-
-#define LOONGARCH_CSR_MCSR2		0xc2	/* CPUCFG4 and CPUCFG5 */
-#define  MCSR2_CCDIV_SHIFT		48
-#define  MCSR2_CCDIV_WIDTH		16
-#define  MCSR2_CCDIV			(_ULCAST_(0xffff) << MCSR2_CCDIV_SHIFT)
-#define  MCSR2_CCMUL_SHIFT		32
-#define  MCSR2_CCMUL_WIDTH		16
-#define  MCSR2_CCMUL			(_ULCAST_(0xffff) << MCSR2_CCMUL_SHIFT)
-#define  MCSR2_CCFREQ_WIDTH		32
-#define  MCSR2_CCFREQ			(_ULCAST_(0xffffffff))
-#define  CCFREQ_DEFAULT			0x5f5e100	/* 100MHz */
-
-#define LOONGARCH_CSR_MCSR3		0xc3	/* CPUCFG6 */
-#define  MCSR3_UPM_SHIFT		14
-#define  MCSR3_UPM			(_ULCAST_(1) << MCSR3_UPM_SHIFT)
-#define  MCSR3_PMBITS_SHIFT		8
-#define  MCSR3_PMBITS_WIDTH		6
-#define  MCSR3_PMBITS			(_ULCAST_(0x3f) << MCSR3_PMBITS_SHIFT)
-#define  PMBITS_DEFAULT			0x40
-#define  MCSR3_PMNUM_SHIFT		4
-#define  MCSR3_PMNUM_WIDTH		4
-#define  MCSR3_PMNUM			(_ULCAST_(0xf) << MCSR3_PMNUM_SHIFT)
-#define  MCSR3_PAMVER_SHIFT		1
-#define  MCSR3_PAMVER_WIDTH		3
-#define  MCSR3_PAMVER			(_ULCAST_(0x7) << MCSR3_PAMVER_SHIFT)
-#define  MCSR3_PMP_SHIFT		0
-#define  MCSR3_PMP			(_ULCAST_(1) << MCSR3_PMP_SHIFT)
-
-#define LOONGARCH_CSR_MCSR8		0xc8	/* CPUCFG16 and CPUCFG17 */
-#define  MCSR8_L1I_SIZE_SHIFT		56
-#define  MCSR8_L1I_SIZE_WIDTH		7
-#define  MCSR8_L1I_SIZE			(_ULCAST_(0x7f) << MCSR8_L1I_SIZE_SHIFT)
-#define  MCSR8_L1I_IDX_SHIFT		48
-#define  MCSR8_L1I_IDX_WIDTH		8
-#define  MCSR8_L1I_IDX			(_ULCAST_(0xff) << MCSR8_L1I_IDX_SHIFT)
-#define  MCSR8_L1I_WAY_SHIFT		32
-#define  MCSR8_L1I_WAY_WIDTH		16
-#define  MCSR8_L1I_WAY			(_ULCAST_(0xffff) << MCSR8_L1I_WAY_SHIFT)
-#define  MCSR8_L3DINCL_SHIFT		16
-#define  MCSR8_L3DINCL			(_ULCAST_(1) << MCSR8_L3DINCL_SHIFT)
-#define  MCSR8_L3DPRIV_SHIFT		15
-#define  MCSR8_L3DPRIV			(_ULCAST_(1) << MCSR8_L3DPRIV_SHIFT)
-#define  MCSR8_L3DPRE_SHIFT		14
-#define  MCSR8_L3DPRE			(_ULCAST_(1) << MCSR8_L3DPRE_SHIFT)
-#define  MCSR8_L3IUINCL_SHIFT		13
-#define  MCSR8_L3IUINCL			(_ULCAST_(1) << MCSR8_L3IUINCL_SHIFT)
-#define  MCSR8_L3IUPRIV_SHIFT		12
-#define  MCSR8_L3IUPRIV			(_ULCAST_(1) << MCSR8_L3IUPRIV_SHIFT)
-#define  MCSR8_L3IUUNIFY_SHIFT		11
-#define  MCSR8_L3IUUNIFY		(_ULCAST_(1) << MCSR8_L3IUUNIFY_SHIFT)
-#define  MCSR8_L3IUPRE_SHIFT		10
-#define  MCSR8_L3IUPRE			(_ULCAST_(1) << MCSR8_L3IUPRE_SHIFT)
-#define  MCSR8_L2DINCL_SHIFT		9
-#define  MCSR8_L2DINCL			(_ULCAST_(1) << MCSR8_L2DINCL_SHIFT)
-#define  MCSR8_L2DPRIV_SHIFT		8
-#define  MCSR8_L2DPRIV			(_ULCAST_(1) << MCSR8_L2DPRIV_SHIFT)
-#define  MCSR8_L2DPRE_SHIFT		7
-#define  MCSR8_L2DPRE			(_ULCAST_(1) << MCSR8_L2DPRE_SHIFT)
-#define  MCSR8_L2IUINCL_SHIFT		6
-#define  MCSR8_L2IUINCL			(_ULCAST_(1) << MCSR8_L2IUINCL_SHIFT)
-#define  MCSR8_L2IUPRIV_SHIFT		5
-#define  MCSR8_L2IUPRIV			(_ULCAST_(1) << MCSR8_L2IUPRIV_SHIFT)
-#define  MCSR8_L2IUUNIFY_SHIFT		4
-#define  MCSR8_L2IUUNIFY		(_ULCAST_(1) << MCSR8_L2IUUNIFY_SHIFT)
-#define  MCSR8_L2IUPRE_SHIFT		3
-#define  MCSR8_L2IUPRE			(_ULCAST_(1) << MCSR8_L2IUPRE_SHIFT)
-#define  MCSR8_L1DPRE_SHIFT		2
-#define  MCSR8_L1DPRE			(_ULCAST_(1) << MCSR8_L1DPRE_SHIFT)
-#define  MCSR8_L1IUUNIFY_SHIFT		1
-#define  MCSR8_L1IUUNIFY		(_ULCAST_(1) << MCSR8_L1IUUNIFY_SHIFT)
-#define  MCSR8_L1IUPRE_SHIFT		0
-#define  MCSR8_L1IUPRE			(_ULCAST_(1) << MCSR8_L1IUPRE_SHIFT)
-
-#define LOONGARCH_CSR_MCSR9		0xc9	/* CPUCFG18 and CPUCFG19 */
-#define  MCSR9_L2U_SIZE_SHIFT		56
-#define  MCSR9_L2U_SIZE_WIDTH		7
-#define  MCSR9_L2U_SIZE			(_ULCAST_(0x7f) << MCSR9_L2U_SIZE_SHIFT)
-#define  MCSR9_L2U_IDX_SHIFT		48
-#define  MCSR9_L2U_IDX_WIDTH		8
-#define  MCSR9_L2U_IDX			(_ULCAST_(0xff) << MCSR9_IDX_LOG_SHIFT)
-#define  MCSR9_L2U_WAY_SHIFT		32
-#define  MCSR9_L2U_WAY_WIDTH		16
-#define  MCSR9_L2U_WAY			(_ULCAST_(0xffff) << MCSR9_L2U_WAY_SHIFT)
-#define  MCSR9_L1D_SIZE_SHIFT		24
-#define  MCSR9_L1D_SIZE_WIDTH		7
-#define  MCSR9_L1D_SIZE			(_ULCAST_(0x7f) << MCSR9_L1D_SIZE_SHIFT)
-#define  MCSR9_L1D_IDX_SHIFT		16
-#define  MCSR9_L1D_IDX_WIDTH		8
-#define  MCSR9_L1D_IDX			(_ULCAST_(0xff) << MCSR9_L1D_IDX_SHIFT)
-#define  MCSR9_L1D_WAY_SHIFT		0
-#define  MCSR9_L1D_WAY_WIDTH		16
-#define  MCSR9_L1D_WAY			(_ULCAST_(0xffff) << MCSR9_L1D_WAY_SHIFT)
-
-#define LOONGARCH_CSR_MCSR10		0xca	/* CPUCFG20 */
-#define  MCSR10_L3U_SIZE_SHIFT		24
-#define  MCSR10_L3U_SIZE_WIDTH		7
-#define  MCSR10_L3U_SIZE		(_ULCAST_(0x7f) << MCSR10_L3U_SIZE_SHIFT)
-#define  MCSR10_L3U_IDX_SHIFT		16
-#define  MCSR10_L3U_IDX_WIDTH		8
-#define  MCSR10_L3U_IDX			(_ULCAST_(0xff) << MCSR10_L3U_IDX_SHIFT)
-#define  MCSR10_L3U_WAY_SHIFT		0
-#define  MCSR10_L3U_WAY_WIDTH		16
-#define  MCSR10_L3U_WAY			(_ULCAST_(0xffff) << MCSR10_L3U_WAY_SHIFT)
-
-#define LOONGARCH_CSR_MCSR24		0xf0	/* cpucfg48 */
-#define  MCSR24_RAMCG_SHIFT		3
-#define  MCSR24_RAMCG			(_ULCAST_(1) << MCSR24_RAMCG_SHIFT)
-#define  MCSR24_VFPUCG_SHIFT		2
-#define  MCSR24_VFPUCG			(_ULCAST_(1) << MCSR24_VFPUCG_SHIFT)
-#define  MCSR24_NAPEN_SHIFT		1
-#define  MCSR24_NAPEN			(_ULCAST_(1) << MCSR24_NAPEN_SHIFT)
-#define  MCSR24_MCSRLOCK_SHIFT		0
-#define  MCSR24_MCSRLOCK		(_ULCAST_(1) << MCSR24_MCSRLOCK_SHIFT)
-
 /* Uncached accelerate windows registers */
 #define LOONGARCH_CSR_UCAWIN		0x100
 #define LOONGARCH_CSR_UCAWIN0_LO	0x102
-- 
2.1.0

