Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ED152FD04
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbiEUN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240370AbiEUN5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:57:07 -0400
Received: from sonic313-19.consmr.mail.gq1.yahoo.com (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEF3EAB4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1653141423; bh=uor+SXxCnw0boc1/6/JwSKTrqtsPIa2jA3Q1RkHef18=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RggvGHgiQ+1WxGrXWSAL0pV6znv8gHOgwcej5KAnoLQNsbpxnjji15mO7S75FIJf2YPyomi0T53RZ1IF0XiXcoeRaOCfmP1lTckLCZGeIBDYspnhlKKgMiKLPGCNHUlGcl0l5XwijgGzdK6kdx4826JRGUeOneV1nGfwffqGDtqOIjtGJPtimZyrXQz51e3FbUJ7ZHG6QoBETSzsKROWWCwzDyY9xepdia0k2EUrrrr02s5HCrEL3fho6QPWMOU6VmSXP/fE6GQePQpVBZN58aUStadD8hcTq2ehXY/rn/t+3K33V0LY3+kwZ/t51AD2Lz8YLGpg59LhUf8caEcn0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653141423; bh=tUONEN5pSlByfiW2yc8zwSvY0IUJoln0Ufpvj052B0D=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=q7tyCRkmEVC82fpHDn2ynSYBEnAiaWGoTNSxDRbcXAYJPiPw87f15oJx5oztw/S0BVkW+4VxghVWH0/NT13xJ4ps4bmZyo4yb5MbGs8KwL7UNq6jqCmWWf47he18jrkJNa6FGygRHG8DIzZaDe4j0sMucdQiKXi0xxWHsgqEMaLxSPrYICuw0YoHiuwUGD/e100poiAFtxIL7rEpEjFNq3LblvkIYCM05Il4OhOObcyKaj+URFMgvVaTF3QHbdsJxvtTQTpW7lJuuQDTbNYofZc1EHVdioviZSf+er1nyqFCv7GOXn1qoUeeHfeWPzqMf1zcDMLakNN5Q2+xE92YiA==
X-YMail-OSG: pLmcIpMVM1mF8pf3QufOf5xoOKcd_WkSzBZrsLHvR09a512QVRT5dzyw34B3bEk
 OfwOlxtRXj0PgKBI_dmWJJbRAUeZ37ReJIg73HJKxVsGkqqus324X_9nVVw1jh_i.sGTQwrFOvLe
 HXxupDWOGOvqitUfdXIY360MtTR2W4XcqTpQTU6TPuOLPqlk0EDVqxhtWOOd4v25Q2dV4QyMsDYQ
 B4QQM3_NYWmjATI0i.Mkmc12FkOUbNm6AxiZaYjexMS7j1A_6YbE_0NaukHby5KSJHHgkrX46aWN
 yMAi2yEoVD_L.ljv0molIjAZz8dHFMaWymcc658PUr3sHfqcihp4PVwbJwIFUGC5BOP2IYQZbjwG
 gzxzG2M096fGzKxF2y7PyUngexF8Tr5R73WW1nHKc0AFKjKBjau5PeqOp_0d8NvzKu9DDuPJa_b8
 VmBfGXRnmvAA1LNdcEApJPfuOgtnrqeBgxS88E1JWnNWXoHG0Ne_nUwX.PiGOahRNer.n8nZgNec
 rCJ3v5Kp9l1i0C8FXlx5e8PsD61xOrhWtxt0_ypQDG6TUzRw3ZajORuZvZVYbB9fcNdeOcxtt0hu
 6zgdjr8lpGJHR4biSZYZgGwysM5JRbVQv.bIwj5GC1fLBQevd5lAYgoWbgZG5qHcZWamjMzLx53P
 IHCkoq2bdTlS1aiGVwl1Uk.IiN0PYTjOLQagRywHX9U.5UyhbsO5uiIUspYCPiPsNT9p8zA06F.g
 rzDFrvwpwDkWnVTFV7CxrwjYXttZU6O5zEXgrlD0wIG6yVW40ZaPPCIG5B5IjC22w.Q4fTIbJLqo
 VuLebzt5b43gvqikzyxd_WRmsLC59lCMuK9R97pGzqTaNofDW0ocIzhNEEBP4Faj6FdJEdYwAYEd
 jnkylLbizc0A9MjaHc8a5hj0vWKuBVv2PZZFEyuTLc3THv4OTilUCuXoFo64p9SpU1LhRJTMDNqT
 kdKYxLLeGrS9zovgCVzYcb_7RCB5ZpVTMF.Gm8NLsnKKSQer8TSFEcgH370GVwi2mZrfEcE_rcYT
 LlT1tEyFfpYJrBr2vZhEy0YBdKHsTCoH0wPpkcieMA4mdMAksM_.RqgfwxzQNLJyzgnXwQSkz8Z0
 3qqYEkdd3uGoOdgxdWARGkF18LI52E.m1AcWmWmFR982GEC9BG5oh1tV.DZf31bQP9MTj7wBHWEo
 lOkCYLcHaDCUGNIC4690m360S2ZQeHsjNM.y6YNPtT9xf76RElaRWD2ybObRoVHk3HqyGE7pXhvF
 NDfeuB2BW0d6BdKvRMrCRvuJnAAY7hGbeYH8d4DIEbhiU2Sy5Bk9CjDIlBWpxzdQcuI8gKxtuu9Y
 fxubsoCgz6T5b2BBXFUzcGlqdMQGt8VzFVjzDGtsalsK6q5g80Am31hGyHmc8mZxh_Z5YfGC4MFA
 GaJLOZQCOveHnOD0skO3.kAu1UKssNt5ZY_mZE22vjz7h7K5jdRqwCabDgCpT6KfdaqD76IQK5kt
 8K24esLa2nCGCbhCoGfMo5Pt_4pAIzo6dZD5JXSj6B4IkWEOR6bq8saNljg8SC5keREXhMv5Kld6
 vIaubQIOOGcqCd2UVVpkrV0vrIrzqs9CcsuyJdNFoR6HQzEX0_7WMAhdnwRG_61QlouYi4gO110S
 e.2UHVWFJ2tib9IBWZCqh3omU.pucdjR5qieHWWeYSbFY1SiEB2y0q_lr4DFt5.newJn2UTUZndm
 kLAHqcB1Fxe9TIL.4KRGIUVB6FWlTBKPfIrP5zZfWn3VJGcuYX.XnCWPtODmioaR8gjjj6KcBa3b
 aSXqN8czo5te4g5GPnDbawyH6j0pIogqH9M4iy.NV7gAwl8B4CgNChPDBab0GEjUOKXi9fs8fWm1
 .MhghSVlhqh.KwuHgb87s9C4uFSIQje.H3jT0ynBW_8uFohInDjqxLc9Qk3Vychf55O_aG8QGMfR
 LHpFiT6yR_Y63rs2YS4FZeMOD.ykRSpQkSSNySVgs3eBTDCdyeyNLGgxcXpFVC4oOrkjwaEBv1wG
 MPTxjWHuwuAR9oKPqsEtgCMLH.LTOqoII7DvQQSRXPy8yl7DxKfAG.p6ueLUE1iROmOTdrBOIKVW
 s8D0eihcQM9pHtsNPuoivvd5lcD4sfhKavvxZPtLArnCviaA9Fy4miWN3.6Zj7bDsOUh6L43VDRL
 oUp48BOCSI8oPKfakNjzGAe.SVm9e4rhbVeFFDy8_N8Vao6eqWFT14p79GTs7Nf7vbMGrA.106fV
 TjdXMDSZzjHrgdFWM8vMTIz_9u5m55Gfr.Q--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 21 May 2022 13:57:03 +0000
Received: by hermes--canary-production-bf1-5d4b57496-wjd85 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0613f202b0117a0c0dc022c343ea5959;
          Sat, 21 May 2022 13:56:59 +0000 (UTC)
Message-ID: <bd9ed2c2-1337-27bb-c9da-dfc7b31d492c@netscape.net>
Date:   Sat, 21 May 2022 09:56:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 10:50 AM, Jan Beulich wrote:
> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
> with pat_enabled()") pat_enabled() returning false (because of PAT
> initialization being suppressed in the absence of MTRRs being announced
> to be available) has become a problem: The i915 driver now fails to
> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
> located the induced failure), and its error handling is flaky enough to
> (at least sometimes) result in a hung system.
>
> Yet even beyond that problem the keying of the use of WC mappings to
> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
> graphics frame buffer accesses would have been quite a bit less
> performant than possible.
>
> Arrange for the function to return true in such environments, without
> undermining the rest of PAT MSR management logic considering PAT to be
> disabled: Specifically, no writes to the PAT MSR should occur.
>
> For the new boolean to live in .init.data, init_cache_modes() also needs
> moving to .init.text (where it could/should have lived already before).
>
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
> On the system where I observed the issue, a knock-on effect of driver
> initialization failing was that the SATA-controller also started to
> report failures.
>
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -62,6 +62,7 @@
>   
>   static bool __read_mostly pat_bp_initialized;
>   static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
> +static bool __initdata pat_force_disabled = !IS_ENABLED(CONFIG_X86_PAT);
>   static bool __read_mostly pat_bp_enabled;
>   static bool __read_mostly pat_cm_initialized;
>   
> @@ -86,6 +87,7 @@ void pat_disable(const char *msg_reason)
>   static int __init nopat(char *str)
>   {
>   	pat_disable("PAT support disabled via boot option.");
> +	pat_force_disabled = true;
>   	return 0;
>   }
>   early_param("nopat", nopat);
> @@ -272,7 +274,7 @@ static void pat_ap_init(u64 pat)
>   	wrmsrl(MSR_IA32_CR_PAT, pat);
>   }
>   
> -void init_cache_modes(void)
> +void __init init_cache_modes(void)
>   {
>   	u64 pat = 0;
>   
> @@ -313,6 +315,13 @@ void init_cache_modes(void)
>   		 */
>   		pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
>   		      PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
> +	} else if (!pat_force_disabled &&
> +	           boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +		/*
> +		 * Clearly PAT is enabled underneath. Allow pat_enabled() to
> +		 * reflect this.
> +		 */
> +		pat_bp_enabled = true;
>   	}
>   
>   	__init_cache_modes(pat);
>

Hi Jan,

I tested this patch on my system with an Intel Haswell CPU with
integrated GPU. It fixes my system which currently is unable
to boot the official Linux 5.17.y as a Dom0 on Xen.

The first suggestion I have is that the commit message should be
edited to explain how the behavior of the kernel in response to
the nopat option would be changed by this patch. My tests indicate
that this patch changes what nopat actually does, and the commit
message should clearly explain that fact.

Thank you for this patch, I hope it is committed soon and backported
to 5.17 stable. I consider that it fixes a regression caused by
bdd8b6c98239, so my second suggestion is that you add Fixes:

Fixes: bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT with pat_enabled()")

I will be using this patch on my system until it, or another fix, is
committed to Linux. Without such a fix, I cannot run 5.17.y and later
on my system as a Xen Dom0.

Best regards,

Chuck
