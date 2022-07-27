Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42C0582979
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiG0PUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiG0PUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:20:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23D35FE5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:20:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 70so16434154pfx.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fXbgfCs20nIBny0AEuL0qP1z9HJ+xwrZ9rBuN61bmCU=;
        b=bv2pw1RfQwJv+QWkvayMp2r1aUYszimpAsG3MqiCg9btM5a/Ljzqk0nIjB6fVr5RSN
         PUGQA76/xqL8mVeHfqAFT4xT8/Y/FRzJGN9GhttnIYxIOXTyX/VZZbAPsk1srL453ENH
         KCLrLv3eT/19ujxfYmYqcvflLnofaqhTs3jgzcHLtXsNmt9F6AHUyVGy4dUVLAxB3NYB
         ZyjobcaPHySw56zQONxOomI1ivMFJZFqTpBh6I6kfwlo4+HF3aT0QxOg15/tJT+Tt8GO
         soJRM18qgmzqgSQfR5X5L4AP9X7embjX3fD7N5uovvJknKYsnTREohjLIolTVEg3ryV2
         fIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fXbgfCs20nIBny0AEuL0qP1z9HJ+xwrZ9rBuN61bmCU=;
        b=eoWQaB0C33v+slSyqoeOTxLj8q/hLqKiKjP/4+CJh3/ne86Y1ZOBo5Yf0VFt3eX92m
         BWjIwkzElkkQSzMWokmZ1NmZV3RWXGCf+4nN+fDkHCG260Y1cxD4RSgM6HjAoH23b0jM
         mKmvYccDx/GeiXQcL3y7FN8rfc3bpAEfb0Udwd0a8rgTZj1PCeZ+6LSzcynsn6nFAeeA
         9i8XH3LAapo9traOqE24CbUroIB2sIeI37HV58ac2GHjvMkvLXh+g+y+4F195/4BddT1
         4G9toH8ShiXDExyDmoxS7E4JjqKZZJtAUIC36PZiIC8KZYyoXunctZuvFeuubfT6gZ6F
         w2IQ==
X-Gm-Message-State: AJIora+Thp3q9SgdcmSJTOVTRFFlV5Kduo1dv6uIJocUt3V/ElLdqr56
        Ep90eF1gvLvWlwSjxC3Zkn0=
X-Google-Smtp-Source: AGRyM1tOb0zSYA8vofxRyhdaTOQ2wNMqGb2pXBZtTHP+KXfbnhTXbMW1Y86I7bWL4zUVEVkJ8dkbDA==
X-Received: by 2002:a65:498b:0:b0:412:8e4:2842 with SMTP id r11-20020a65498b000000b0041208e42842mr19255819pgs.71.1658935247776;
        Wed, 27 Jul 2022 08:20:47 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:18:efed::a31c])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a19d300b001f069352d73sm1850368pjj.25.2022.07.27.08.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 08:20:47 -0700 (PDT)
Message-ID: <09574173-6a93-765e-a9e6-de12c8de2f32@gmail.com>
Date:   Wed, 27 Jul 2022 23:20:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [EXTERNAL] [PATCH] Revert "x86/sev: Expose sev_es_ghcb_hv_call()
 for use by HyperV"
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <YuFQJ9ynRk4QwFjn@zn.tnic>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YuFQJ9ynRk4QwFjn@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2022 10:48 PM, Borislav Petkov wrote:
> This reverts commit 007faec014cb5d26983c1f86fd08c6539b41392e.
> 
> Now that hyperv does its own protocol negotiation:
> 
>    49d6a3c062a1 ("x86/Hyper-V: Add SEV negotiate protocol support in Isolation VM")
> 
> revert this exposure of the sev_es_ghcb_hv_call() helper.
> 
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20220614014553.1915929-1-ltykernel%40gmail.com&amp;data=05%7C01%7CTianyu.Lan%40microsoft.com%7Ca4ab2172b0c147eab3d608da6fdf0b7d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637945301113063277%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=1ITuubB%2FfGQ7PzGmKbEnJUt7zV8S3ZH4%2FKxq4e9%2FC88%3D&amp;reserved=0
> ---
> 
> My plan is to queue this now and send it to Linus as an urgent fix so
> that 5.19 gets released clean, without that export.
> 
> So if you folks see an issue, holler now pls.
> 
> Thx.

Reviewed-by：Tianyu Lan <tiala@microsoft.com>


> 
>   arch/x86/include/asm/sev.h   |  7 +------
>   arch/x86/kernel/sev-shared.c | 25 +++++++++----------------
>   arch/x86/kernel/sev.c        | 17 ++++++++---------
>   3 files changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 19514524f0f8..4a23e52fe0ee 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -72,7 +72,6 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
>   
>   struct real_mode_header;
>   enum stack_type;
> -struct ghcb;
>   
>   /* Early IDT entry points for #VC handler */
>   extern void vc_no_ghcb(void);
> @@ -156,11 +155,7 @@ static __always_inline void sev_es_nmi_complete(void)
>   		__sev_es_nmi_complete();
>   }
>   extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
> -extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
> -					  bool set_ghcb_msr,
> -					  struct es_em_ctxt *ctxt,
> -					  u64 exit_code, u64 exit_info_1,
> -					  u64 exit_info_2);
> +
>   static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
>   {
>   	int rc;
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index b478edf43bec..3a5b0c9c4fcc 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -219,9 +219,10 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
>   	return ES_VMM_ERROR;
>   }
>   
> -enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
> -				   struct es_em_ctxt *ctxt, u64 exit_code,
> -				   u64 exit_info_1, u64 exit_info_2)
> +static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
> +					  struct es_em_ctxt *ctxt,
> +					  u64 exit_code, u64 exit_info_1,
> +					  u64 exit_info_2)
>   {
>   	/* Fill in protocol and format specifiers */
>   	ghcb->protocol_version = ghcb_version;
> @@ -231,14 +232,7 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
>   	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
>   	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
>   
> -	/*
> -	 * Hyper-V unenlightened guests use a paravisor for communicating and
> -	 * GHCB pages are being allocated and set up by that paravisor. Linux
> -	 * should not change the GHCB page's physical address.
> -	 */
> -	if (set_ghcb_msr)
> -		sev_es_wr_ghcb_msr(__pa(ghcb));
> -
> +	sev_es_wr_ghcb_msr(__pa(ghcb));
>   	VMGEXIT();
>   
>   	return verify_exception_info(ghcb, ctxt);
> @@ -795,7 +789,7 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>   		 */
>   		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
>   		ghcb_set_sw_scratch(ghcb, sw_scratch);
> -		ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_IOIO,
> +		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
>   					  exit_info_1, exit_info_2);
>   		if (ret != ES_OK)
>   			return ret;
> @@ -837,8 +831,7 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>   
>   		ghcb_set_rax(ghcb, rax);
>   
> -		ret = sev_es_ghcb_hv_call(ghcb, true, ctxt,
> -					  SVM_EXIT_IOIO, exit_info_1, 0);
> +		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
>   		if (ret != ES_OK)
>   			return ret;
>   
> @@ -894,7 +887,7 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
>   		/* xgetbv will cause #GP - use reset value for xcr0 */
>   		ghcb_set_xcr0(ghcb, 1);
>   
> -	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_CPUID, 0, 0);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
>   	if (ret != ES_OK)
>   		return ret;
>   
> @@ -919,7 +912,7 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
>   	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
>   	enum es_result ret;
>   
> -	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, 0, 0);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
>   	if (ret != ES_OK)
>   		return ret;
>   
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c05f0124c410..63dc626627a0 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -786,7 +786,7 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
>   		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
>   
>   		/* This will advance the shared buffer data points to. */
> -		ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
> +		ret = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
>   
>   		/*
>   		 * Page State Change VMGEXIT can pass error code through
> @@ -1212,8 +1212,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>   		ghcb_set_rdx(ghcb, regs->dx);
>   	}
>   
> -	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_MSR,
> -				  exit_info_1, 0);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
>   
>   	if ((ret == ES_OK) && (!exit_info_1)) {
>   		regs->ax = ghcb->save.rax;
> @@ -1452,7 +1451,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>   
>   	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
>   
> -	return sev_es_ghcb_hv_call(ghcb, true, ctxt, exit_code, exit_info_1, exit_info_2);
> +	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
>   }
>   
>   /*
> @@ -1628,7 +1627,7 @@ static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
>   
>   	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
>   	ghcb_set_rax(ghcb, val);
> -	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
>   	if (ret != ES_OK)
>   		return ret;
>   
> @@ -1658,7 +1657,7 @@ static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
>   static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
>   				       struct es_em_ctxt *ctxt)
>   {
> -	return sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_WBINVD, 0, 0);
> +	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
>   }
>   
>   static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
> @@ -1667,7 +1666,7 @@ static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt
>   
>   	ghcb_set_rcx(ghcb, ctxt->regs->cx);
>   
> -	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_RDPMC, 0, 0);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDPMC, 0, 0);
>   	if (ret != ES_OK)
>   		return ret;
>   
> @@ -1708,7 +1707,7 @@ static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
>   	if (x86_platform.hyper.sev_es_hcall_prepare)
>   		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
>   
> -	ret = sev_es_ghcb_hv_call(ghcb, true, ctxt, SVM_EXIT_VMMCALL, 0, 0);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
>   	if (ret != ES_OK)
>   		return ret;
>   
> @@ -2197,7 +2196,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
>   		ghcb_set_rbx(ghcb, input->data_npages);
>   	}
>   
> -	ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
> +	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
>   	if (ret)
>   		goto e_put;
>   
