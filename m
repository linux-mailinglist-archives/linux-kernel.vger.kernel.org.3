Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8821C476108
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbhLOSs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:48:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239248AbhLOSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:48:58 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFGfel8014460;
        Wed, 15 Dec 2021 18:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=XaoY6Yj1xf6THqmZS3tvySRdWBCn8hXHU9UNO45+vG4=;
 b=VrUUH8blOtWr+hKjbLvpQvIvYIkcTFv0/gr+77trOyzrCJVVaxBzWXZ5LnJCAhr1907n
 /4eZs7e+e5ox9yl3wt7rwNcGyikjVR9t2biVAagyivwX6aC1i/4nEpbiNJLPVj2Iq2Hl
 yyb/DwmB1Sc6SrJqEpEDidmPKjDPwRrvxau45Wu5vc3HjSRqHvEKW8cfUtANJG3PUpmQ
 wQzwxewrwgcAgAL+c9DsghetcgLPPlMvfutiXtVwFqiGY/8BbUEAGO1uYIK2cYq1nGk+
 mJgw6O27D0iLoYgDudAk/7gPZ8jSyH3qiAJPAwGlxn+S64CO8hsbu4CXW3CyVAyMR2OP EA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyfdp2d03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 18:48:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIhRQB004736;
        Wed, 15 Dec 2021 18:48:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3cy7qw08x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 18:48:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFImpER42140158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:48:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 312E75204F;
        Wed, 15 Dec 2021 18:48:51 +0000 (GMT)
Received: from osiris (unknown [9.145.87.178])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E262752059;
        Wed, 15 Dec 2021 18:48:50 +0000 (GMT)
Date:   Wed, 15 Dec 2021 19:48:49 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.16-rc6
Message-ID: <Ybo4kWEmz2yVEhoE@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WSDRtLqJC1ui_BrtHgd8rGn2hEl58e3g
X-Proofpoint-ORIG-GUID: WSDRtLqJC1ui_BrtHgd8rGn2hEl58e3g
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_11,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=324 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of s390 fixes for 5.16-rc6.

Thanks,
Heiko

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-5

for you to fetch changes up to 85bf17b28f97ca2749968d8786dc423db320d9c2:

  recordmcount.pl: look for jgnop instruction as well as bcrl on s390 (2021-12-12 18:52:26 +0100)

----------------------------------------------------------------
s390 updates for 5.16-rc6

- Add missing handling of R_390_PLT32DBL relocation type in
  arch_kexec_apply_relocations_add(). Clang and the upcoming gcc 11.3
  generate such relocation entries, which our relocation code silently
  ignores, and which finally will result in an endless loop within the
  purgatory code in case of kexec.

- Add proper handling of errors and print error messages when applying
  relocations

- Fix duplicate tracking of irq nesting level in entry code

- Let recordmcount.pl also look for jgnop mnemonic. Starting with binutils
  2.37 objdump emits a jgnop mnemonic instead of brcl, which breaks mcount
  location detection. This is only a problem if used with compilers older
  than gcc 9, since with gcc 9 and newer compilers recordmcount.pl is not
  used anymore.

- Remove preempt_disable()/preempt_enable() pair in kprobe_ftrace_handler()
  which was done for all architectures except for s390.

- Update defconfig

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/kexec: handle R_390_PLT32DBL rela in arch_kexec_apply_relocations_add()

Jerome Marchand (2):
      s390/ftrace: remove preempt_disable()/preempt_enable() pair
      recordmcount.pl: look for jgnop instruction as well as bcrl on s390

Niklas Schnelle (1):
      s390: enable switchdev support in defconfig

Philipp Rudo (2):
      s390/kexec_file: print some more error messages
      s390/kexec_file: fix error handling when applying relocations

Sven Schnelle (1):
      s390/entry: fix duplicate tracking of irq nesting level

 arch/s390/configs/debug_defconfig     |  2 ++
 arch/s390/configs/defconfig           |  2 ++
 arch/s390/kernel/ftrace.c             |  2 --
 arch/s390/kernel/irq.c                |  9 +++++----
 arch/s390/kernel/machine_kexec_file.c | 38 +++++++++++++++++++++++++++++++----
 scripts/recordmcount.pl               |  2 +-
 6 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index b626bc6e0eaf..e45cc27716de 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -117,6 +117,7 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
+CONFIG_NET_SWITCHDEV=y
 CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
@@ -511,6 +512,7 @@ CONFIG_NLMON=m
 CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
+CONFIG_MLX5_ESWITCH=y
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 0056cab27372..1c750bfca2d8 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -109,6 +109,7 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
+CONFIG_NET_SWITCHDEV=y
 CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
@@ -502,6 +503,7 @@ CONFIG_NLMON=m
 CONFIG_MLX4_EN=m
 CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
+CONFIG_MLX5_ESWITCH=y
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 5510c7d10ddc..21d62d8b6b9a 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -290,7 +290,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	regs = ftrace_get_regs(fregs);
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -318,7 +317,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	}
 	__this_cpu_write(current_kprobe, NULL);
 out:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 0df83ecaa2e0..cb7099682340 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -138,7 +138,7 @@ void noinstr do_io_irq(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	int from_idle;
 
-	irq_enter();
+	irq_enter_rcu();
 
 	if (user_mode(regs)) {
 		update_timer_sys();
@@ -158,7 +158,8 @@ void noinstr do_io_irq(struct pt_regs *regs)
 			do_irq_async(regs, IO_INTERRUPT);
 	} while (MACHINE_IS_LPAR && irq_pending(regs));
 
-	irq_exit();
+	irq_exit_rcu();
+
 	set_irq_regs(old_regs);
 	irqentry_exit(regs, state);
 
@@ -172,7 +173,7 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	int from_idle;
 
-	irq_enter();
+	irq_enter_rcu();
 
 	if (user_mode(regs)) {
 		update_timer_sys();
@@ -190,7 +191,7 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 
 	do_irq_async(regs, EXT_INTERRUPT);
 
-	irq_exit();
+	irq_exit_rcu();
 	set_irq_regs(old_regs);
 	irqentry_exit(regs, state);
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 9975ad200d74..8f43575a4dd3 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -7,6 +7,8 @@
  * Author(s): Philipp Rudo <prudo@linux.vnet.ibm.com>
  */
 
+#define pr_fmt(fmt)	"kexec: " fmt
+
 #include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/kexec.h>
@@ -290,8 +292,16 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     const Elf_Shdr *relsec,
 				     const Elf_Shdr *symtab)
 {
+	const char *strtab, *name, *shstrtab;
+	const Elf_Shdr *sechdrs;
 	Elf_Rela *relas;
 	int i, r_type;
+	int ret;
+
+	/* String & section header string table */
+	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
+	strtab = (char *)pi->ehdr + sechdrs[symtab->sh_link].sh_offset;
+	shstrtab = (char *)pi->ehdr + sechdrs[pi->ehdr->e_shstrndx].sh_offset;
 
 	relas = (void *)pi->ehdr + relsec->sh_offset;
 
@@ -304,15 +314,27 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		sym = (void *)pi->ehdr + symtab->sh_offset;
 		sym += ELF64_R_SYM(relas[i].r_info);
 
-		if (sym->st_shndx == SHN_UNDEF)
+		if (sym->st_name)
+			name = strtab + sym->st_name;
+		else
+			name = shstrtab + sechdrs[sym->st_shndx].sh_name;
+
+		if (sym->st_shndx == SHN_UNDEF) {
+			pr_err("Undefined symbol: %s\n", name);
 			return -ENOEXEC;
+		}
 
-		if (sym->st_shndx == SHN_COMMON)
+		if (sym->st_shndx == SHN_COMMON) {
+			pr_err("symbol '%s' in common section\n", name);
 			return -ENOEXEC;
+		}
 
 		if (sym->st_shndx >= pi->ehdr->e_shnum &&
-		    sym->st_shndx != SHN_ABS)
+		    sym->st_shndx != SHN_ABS) {
+			pr_err("Invalid section %d for symbol %s\n",
+			       sym->st_shndx, name);
 			return -ENOEXEC;
+		}
 
 		loc = pi->purgatory_buf;
 		loc += section->sh_offset;
@@ -326,7 +348,15 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		addr = section->sh_addr + relas[i].r_offset;
 
 		r_type = ELF64_R_TYPE(relas[i].r_info);
-		arch_kexec_do_relocs(r_type, loc, val, addr);
+
+		if (r_type == R_390_PLT32DBL)
+			r_type = R_390_PC32DBL;
+
+		ret = arch_kexec_do_relocs(r_type, loc, val, addr);
+		if (ret) {
+			pr_err("Unknown rela relocation: %d\n", r_type);
+			return -ENOEXEC;
+		}
 	}
 	return 0;
 }
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 7d631aaa0ae1..52a000b057a5 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "s390" && $bits == 64) {
     if ($cc =~ /-DCC_USING_HOTPATCH/) {
-	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*brcl\\s*0,[0-9a-f]+ <([^\+]*)>\$";
+	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
 	$mcount_adjust = 0;
     }
     $alignment = 8;
