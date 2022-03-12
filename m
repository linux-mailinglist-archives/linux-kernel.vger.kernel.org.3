Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECF4D6F90
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 15:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiCLOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 09:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCLOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 09:36:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9613B3F0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 06:35:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCBA821904;
        Sat, 12 Mar 2022 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647095705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IthrpOCooCp3FiIIF6kWTRXy/sHRLvF+Z3Xur25XAh4=;
        b=TOk8pzJbsVp1/H4Gls6ryfB/jBIP1zA5ChRVVl2zBxD9Li7iH8yYsLThVaGVBuKViCFrjs
        qb5TDsS2w7NRNn4FidOBaByStckFkplUzRC5fL4q5QZNZcXc9TqC0Mdd3SB2nUwBbXEF5m
        puVf7SPaX9AD5L/x5+vUgldS5FDbuLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647095705;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IthrpOCooCp3FiIIF6kWTRXy/sHRLvF+Z3Xur25XAh4=;
        b=5mO5YUAZ6e3anOCe7+mt4ifuNOVxVc95caQbdYbLpxEaIjSpHreBSHvAlHvxTSFajJF12b
        soQ+guXMQqV6B+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B05B213AB4;
        Sat, 12 Mar 2022 14:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sA8HK5mvLGIyCwAAMHmgww
        (envelope-from <bp@suse.de>); Sat, 12 Mar 2022 14:35:05 +0000
Date:   Sat, 12 Mar 2022 15:35:07 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tools headers cpufeatures: Sync with the kernel
 sources
Message-ID: <Yiyvm1/qdYxFoN+a@zn.tnic>
References: <YiyiHatGaJQM7l/Y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YiyiHatGaJQM7l/Y@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 10:37:33AM -0300, Arnaldo Carvalho de Melo wrote:
> FYI, I'm carrying this on the perf tools tree,
> 
> Regards,
> 
> - Arnaldo
> 
> ---
> 
> To pick the changes from:
> 
>   d45476d983240937 ("x86/speculation: Rename RETPOLINE_AMD to RETPOLINE_LFENCE")
> 
> Its just a comment fixup.
> 
> This only causes these perf files to be rebuilt:
> 
>   CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
>   CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
> 
> And addresses this perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/arch/x86/include/asm/cpufeatures.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
> index ab4e53715d8ad8ae..65d147974f8d95e6 100644
> --- a/tools/arch/x86/include/asm/cpufeatures.h
> +++ b/tools/arch/x86/include/asm/cpufeatures.h
> @@ -204,7 +204,7 @@
>  /* FREE!                                ( 7*32+10) */
>  #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
>  #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
> -#define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCEs for Spectre variant 2 */
> +#define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCE for Spectre variant 2 */
>  #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
>  #define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
>  #define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
> -- 

ACK.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
