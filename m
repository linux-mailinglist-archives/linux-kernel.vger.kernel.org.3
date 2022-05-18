Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0264552C607
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiERWOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiERWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:14:02 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B162013B7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:14:00 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60424)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrRva-003Y9P-Hy; Wed, 18 May 2022 16:13:58 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38702 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrRvZ-002wWx-3I; Wed, 18 May 2022 16:13:58 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
Date:   Wed, 18 May 2022 16:59:37 -0500
In-Reply-To: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com> (Naveen
        N. Rao's message of "Wed, 18 May 2022 23:48:28 +0530")
Message-ID: <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrRvZ-002wWx-3I;;;mid=<87ee0q7b92.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19j5afT7cfR1QMALWtaSChY2lnR9xJRogY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 740 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 14 (1.9%), b_tie_ro: 12 (1.6%), parse: 1.88
        (0.3%), extract_message_metadata: 21 (2.9%), get_uri_detail_list: 4.8
        (0.7%), tests_pri_-1000: 17 (2.3%), tests_pri_-950: 1.68 (0.2%),
        tests_pri_-900: 1.37 (0.2%), tests_pri_-90: 245 (33.1%), check_bayes:
        243 (32.8%), b_tokenize: 13 (1.8%), b_tok_get_all: 10 (1.4%),
        b_comp_prob: 3.4 (0.5%), b_tok_touch_all: 211 (28.5%), b_finish: 1.19
        (0.2%), tests_pri_0: 414 (55.9%), check_dkim_signature: 1.00 (0.1%),
        check_dkim_adsp: 3.7 (0.5%), poll_dns_idle: 1.01 (0.1%), tests_pri_10:
        4.5 (0.6%), tests_pri_500: 13 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [1], binutils (v2.36+) started dropping section symbols that
> it thought were unused.  This isn't an issue in general, but with
> kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
> separate .text.unlikely section and the section symbol ".text.unlikely"
> is being dropped. Due to this, recordmcount is unable to find a non-weak
> symbol in .text.unlikely to generate a relocation record against.
>
> Address this by dropping the weak attribute from these functions:
> - arch_kexec_apply_relocations() is not overridden by any architecture
>   today, so just drop the weak attribute.
> - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>   Retain the function prototype for those and move the weak
>   implementation into the header as a static inline for other
>   architectures.
>
> [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1

Any chance you can also get machine_kexec_post_load,
crash_free_reserved_phys_range, arch_kexec_protect_protect_crashkres,
arch_kexec_unprotect_crashkres, arch_kexec_kernel_image_probe,
arch_kexec_kernel_image_probe, arch_kimage_file_post_load_cleanup,
arch_kexec_kernel_verify_sig, and arch_kexec_locate_mem_hole as well.

That is everything in kexec that uses a __weak symbol.  If we can't
count on them working we might as well just get rid of the rest
preemptively.

Could you also address Andrews concerns by using a Kconfig symbol that
the architectures that implement the symbol can select.

I don't want to ask too much of a volunteer but if you are willing
addressing both of those would be a great help.

Eric

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  include/linux/kexec.h | 28 ++++++++++++++++++++++++----
>  kernel/kexec_file.c   | 19 +------------------
>  2 files changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 58d1b58a971e34..e656f981f43a73 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -193,10 +193,6 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
>  int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  				  unsigned long buf_len);
>  void *arch_kexec_kernel_image_load(struct kimage *image);
> -int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> -				     Elf_Shdr *section,
> -				     const Elf_Shdr *relsec,
> -				     const Elf_Shdr *symtab);
>  int arch_kexec_apply_relocations(struct purgatory_info *pi,
>  				 Elf_Shdr *section,
>  				 const Elf_Shdr *relsec,
> @@ -229,6 +225,30 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mend);
>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>  				       void **addr, unsigned long *sz);
> +
> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +#else
> +/*
> + * arch_kexec_apply_relocations_add - apply relocations of type RELA
> + * @pi:		Purgatory to be relocated.
> + * @section:	Section relocations applying to.
> + * @relsec:	Section containing RELAs.
> + * @symtab:	Corresponding symtab.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +static inline int
> +arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
> +				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
> +{
> +	pr_err("RELA relocation unsupported.\n");
> +	return -ENOEXEC;
> +}
> +#endif /* CONFIG_X86_64 || CONFIG_S390 */
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  #ifdef CONFIG_KEXEC_ELF
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b96..6bae253b4d315e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -108,23 +108,6 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  }
>  #endif
>  
> -/*
> - * arch_kexec_apply_relocations_add - apply relocations of type RELA
> - * @pi:		Purgatory to be relocated.
> - * @section:	Section relocations applying to.
> - * @relsec:	Section containing RELAs.
> - * @symtab:	Corresponding symtab.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int __weak
> -arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
> -				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
> -{
> -	pr_err("RELA relocation unsupported.\n");
> -	return -ENOEXEC;
> -}
> -
>  /*
>   * arch_kexec_apply_relocations - apply relocations of type REL
>   * @pi:		Purgatory to be relocated.
> @@ -134,7 +117,7 @@ arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
>   *
>   * Return: 0 on success, negative errno on error.
>   */
> -int __weak
> +int
>  arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
>  			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
>  {
>
> base-commit: ef1302160bfb19f804451d0e919266703501c875
