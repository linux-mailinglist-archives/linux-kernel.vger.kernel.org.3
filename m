Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660D94F23A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiDEGxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiDEGxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:53:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246456E8E7;
        Mon,  4 Apr 2022 23:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7516615A0;
        Tue,  5 Apr 2022 06:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DACEC340F3;
        Tue,  5 Apr 2022 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141507;
        bh=Wlj/mkoqHrHMZ0K2EWCmK376xQbEKNO7SVZEOojxAV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ix1vj01RqyJ4e/S6iGddivDMxKV01MlJysD7UfCPl0IXpNEJgA6WKMbfwGxswVrdt
         Z5YKu6oXLMPWmawCLtaE3laZzPe7CJnNcyMYYgG167no+vMsIrWzR+9NyuUdHbPDNp
         yZNxGzTZ4JqTPAntEh/4Z4FFKlm0ZkOZl6+pw0ZoaRQjvDkPkivFmCmGCs8ePjca9M
         TyO71jWF/pbfD7Q0ADeJiSobJ8pe0I6lZIySUfUNkrJx6JL/FFtVhefiyLivxbTt/n
         wCupjW6BqrBUiuVWg/DdDjU/HcxWZRtZzLxE3ha/GAHLDq2Sa5LjwGPAg3F/CUloI4
         5AEddkhFtXu2w==
Date:   Tue, 5 Apr 2022 09:52:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/30] x86/sgx: Add short descriptions to ENCLS
 wrappers
Message-ID: <YkvnSTw7zwXud1G0@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <5f8eaad96d85f78b80da47c2b851d6d8af9fc878.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8eaad96d85f78b80da47c2b851d6d8af9fc878.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:09AM -0700, Reinette Chatre wrote:
> The SGX ENCLS instruction uses EAX to specify an SGX function and
> may require additional registers, depending on the SGX function.
> ENCLS invokes the specified privileged SGX function for managing
> and debugging enclaves. Macros are used to wrap the ENCLS
> functionality and several wrappers are used to wrap the macros to
> make the different SGX functions accessible in the code.
> 
> The wrappers of the supported SGX functions are cryptic. Add short
> descriptions of each as a comment.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V2
> 
> Changes since V1:
> - Fix commit message and subject to not refer to descriptions as
> "changelog descriptions" or "shortlog descriptions" (Jarkko).
> - Improve all descriptions with guidance from Jarkko.
> 
>  arch/x86/kernel/cpu/sgx/encls.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
> index fa04a73daf9c..0e22fa8f77c5 100644
> --- a/arch/x86/kernel/cpu/sgx/encls.h
> +++ b/arch/x86/kernel/cpu/sgx/encls.h
> @@ -136,57 +136,71 @@ static inline bool encls_failed(int ret)
>  	ret;						\
>  	})
>  
> +/* Initialize an EPC page into an SGX Enclave Control Structure (SECS) page. */
>  static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
>  {
>  	return __encls_2(ECREATE, pginfo, secs);
>  }
>  
> +/* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */
>  static inline int __eextend(void *secs, void *addr)
>  {
>  	return __encls_2(EEXTEND, secs, addr);
>  }
>  
> +/*
> + * Associate an EPC page to an enclave either as a REG or TCS page
> + * populated with the provided data.
> + */
>  static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)
>  {
>  	return __encls_2(EADD, pginfo, addr);
>  }
>  
> +/* Finalize enclave build, initialize enclave for user code execution. */
>  static inline int __einit(void *sigstruct, void *token, void *secs)
>  {
>  	return __encls_ret_3(EINIT, sigstruct, secs, token);
>  }
>  
> +/* Disassociate EPC page from its enclave and mark it as unused. */
>  static inline int __eremove(void *addr)
>  {
>  	return __encls_ret_1(EREMOVE, addr);
>  }
>  
> +/* Copy data to an EPC page belonging to a debug enclave. */
>  static inline int __edbgwr(void *addr, unsigned long *data)
>  {
>  	return __encls_2(EDGBWR, *data, addr);
>  }
>  
> +/* Copy data from an EPC page belonging to a debug enclave. */
>  static inline int __edbgrd(void *addr, unsigned long *data)
>  {
>  	return __encls_1_1(EDGBRD, *data, addr);
>  }
>  
> +/* Track that software has completed the required TLB address clears. */
>  static inline int __etrack(void *addr)
>  {
>  	return __encls_ret_1(ETRACK, addr);
>  }
>  
> +/* Load, verify, and unblock an EPC page. */
>  static inline int __eldu(struct sgx_pageinfo *pginfo, void *addr,
>  			 void *va)
>  {
>  	return __encls_ret_3(ELDU, pginfo, addr, va);
>  }
>  
> +/* Make EPC page inaccessible to enclave, ready to be written to memory. */
>  static inline int __eblock(void *addr)
>  {
>  	return __encls_ret_1(EBLOCK, addr);
>  }
>  
> +/* Initialize an EPC page into a Version Array (VA) page. */
>  static inline int __epa(void *addr)
>  {
>  	unsigned long rbx = SGX_PAGE_TYPE_VA;
> @@ -194,6 +208,7 @@ static inline int __epa(void *addr)
>  	return __encls_2(EPA, rbx, addr);
>  }
>  
> +/* Invalidate an EPC page and write it out to main memory. */
>  static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
>  			void *va)
>  {
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
