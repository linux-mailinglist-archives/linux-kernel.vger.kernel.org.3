Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54355470C73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhLJVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbhLJVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:25:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9380C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:21:36 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A03011EC036C;
        Fri, 10 Dec 2021 22:21:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639171290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DTBeuhnvmwzIHGDmzUdDmJUVR448dpo5zwNE9d94t8Q=;
        b=OUASN5mkUO40iDLhnVk7Z9iFvStxFyGRQftVDsV8w/P3i+YrUx+lfCppMe163A13KODt+3
        KfKSqx89QNPX40yjjhjRQHZU4NAJqW59yu9irBQgcaP3zZXfcyzdlFqF5BbIrt3XGCLwz0
        vwfcrKSM2lvxdL/0Qe412zvJxm09cpo=
Date:   Fri, 10 Dec 2021 22:21:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v4 02/14] x86/cpufeatures: add AMD Fam19h Branch Sampling
 feature
Message-ID: <YbPE3PDQ6Ro9oVEH@zn.tnic>
References: <20211210210229.2991238-1-eranian@google.com>
 <20211210210229.2991238-3-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210210229.2991238-3-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 01:02:17PM -0800, Stephane Eranian wrote:
> This patch adds a cpu feature for AMD Fam19h Branch Sampling feature as bit
> 31 of EBX on CPUID leaf function 0x80000008.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d5b5f2ab87a0..e71443f93f04 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -315,6 +315,7 @@
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_AMD_BRS		(13*32+31) /* Branch Sampling available */
>  
>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
> -- 

It seems you missed my note from the last time:

https://lore.kernel.org/r/YY0OUNqv1w/ihmHX@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
