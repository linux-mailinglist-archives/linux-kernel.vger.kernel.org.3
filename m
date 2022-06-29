Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BE455F372
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiF2Cee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF2Ced (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:34:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF4183AF;
        Tue, 28 Jun 2022 19:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC508B82040;
        Wed, 29 Jun 2022 02:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531C8C341C8;
        Wed, 29 Jun 2022 02:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656470069;
        bh=juL1y1N9G1MajC5lcjvHICIzZE9cBhf0A0KZ54WUcmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMz2Ne532W+E8mDvGlVkMMin9+0J5modUQ121kVBHKaWV5FvhKwuKrO/5Fo/d8IH6
         HM3Vvd854on4IwQ4KFrmPFljy1izUbxlSmDKhrq70hDppGE39a2pLPDrwy7J5GTnsf
         6gUmxhqEKmjXsSHUT1q8HVzw6nt8GTxqmMfHOzSKpt2Iw8ph6VudXW/YMXH4DttbK3
         YxJtJkUZIQlxa9aXNanFcDxqUt1XMXEqMrK1OZ7OFGMstGdAgTl93YddQO2sxv3vzy
         aOTmQ1JTzK9zbrl3S7coCxmhStBq3hDWy2aDS2pmo1VPoSSkHJewbCKSuR9G7xyKCw
         xV+WHRyMo/9yw==
Date:   Wed, 29 Jun 2022 05:34:26 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 04/22] x86/sgx: fix kernel-doc markups
Message-ID: <Yru6Muchc93ovhNa@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
 <49f0900ca467867917182a4428b731e55608ca67.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f0900ca467867917182a4428b731e55608ca67.1656409369.git.mchehab@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:46:08AM +0100, Mauro Carvalho Chehab wrote:
> There are a couple typos there, violating kernel-doc syntax.
> 
> Also, on a function typedef, the register snapshots aren't
> documented.
> 
> This should fix those warnings:
> 
> 	arch/x86/include/uapi/asm/sgx.h:19: warning: Enum value 'SGX_PAGE_MEASURE' not described in enum 'sgx_page_flags'
> 	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'rdi' not described in 'sgx_enclave_user_handler_t'
> 	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'rsi' not described in 'sgx_enclave_user_handler_t'
> 	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'rdx' not described in 'sgx_enclave_user_handler_t'
> 	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'rsp' not described in 'sgx_enclave_user_handler_t'
> 	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'r8' not described in 'sgx_enclave_user_handler_t'
> 	arch/x86/include/uapi/asm/sgx.h:97: warning: Function parameter or member 'r9' not described in 'sgx_enclave_user_handler_t'
> 	arch/x86/include/uapi/asm/sgx.h:124: warning: Function parameter or member 'reserved' not described in 'sgx_enclave_run'
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/
> 
>  arch/x86/include/uapi/asm/sgx.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
> index f4b81587e90b..e0e6a3ebc941 100644
> --- a/arch/x86/include/uapi/asm/sgx.h
> +++ b/arch/x86/include/uapi/asm/sgx.h
> @@ -10,7 +10,7 @@
>  
>  /**
>   * enum sgx_page_flags - page control flags
> - * %SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
> + * @SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
>   *			ENCLS[EEXTEND] operations.
>   */
>  enum sgx_page_flags {
> @@ -81,6 +81,12 @@ struct sgx_enclave_run;
>  /**
>   * typedef sgx_enclave_user_handler_t - Exit handler function accepted by
>   *					__vdso_sgx_enter_enclave()
> + * @rdi:	snapshot of DI register at enclave exit
> + * @rsi:	snapshot of SI register at enclave exit
> + * @rdx:	snapshot of DX register at enclave exit
> + * @rsp:	snapshot of SP register at enclave exit
> + * @r8:		snapshot of R8 register at enclave exit
> + * @r9:		snapshot of R9 register at enclave exit
>   * @run:	The run instance given by the caller
>   *
>   * The register parameters contain the snapshot of their values at enclave
> @@ -104,7 +110,7 @@ typedef int (*sgx_enclave_user_handler_t)(long rdi, long rsi, long rdx,
>   * @exception_addr:		The address that triggered the exception
>   * @user_handler:		User provided callback run on exception
>   * @user_data:			Data passed to the user handler
> - * @reserved			Reserved for future extensions
> + * @reserved:			Reserved for future extensions
>   *
>   * If @user_handler is provided, the handler will be invoked on all return paths
>   * of the normal flow.  The user handler may transfer control, e.g. via a
> -- 
> 2.36.1
> 

I guess this also needs:

Fixes: 3fa97bf00126 ("Documentation/x86: Document SGX kernel architecture")

Other than that,

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
