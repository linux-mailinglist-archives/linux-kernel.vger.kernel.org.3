Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884C748F339
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiANXtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:49:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55764 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiANXtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:49:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F806208C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 23:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AF9C36AED;
        Fri, 14 Jan 2022 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642204140;
        bh=VGzZ1qktjWK63n+TD+u6C6vymHdhmpsegEuCfaqnW5A=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=bY8KYlFKe6qELH8Yew4liDpGOgphdLcWnXINN6rCo265iZr2ZUv8C39F9gM7FHa3t
         k36XyF4MSqppJgoT/fsps+/FwriT4NZokNu0s5M9EBB/Dji1B382l/aScjJNoAz/M3
         ZZDmLpd82GbxdsF35CwYT52r2gfvWgzB32bHnc9VmSwkUWpNwbstZkIw0NfeGtoXxv
         HFQ2PMJWyfPVutPLYhWb0PlRKSvrwTjyouyZExIpgzVUZwlyw+fhPWXkhTwUz+Eidq
         D0MQ6nH5I7nGgI1m3PeXIEmp3FM9nfitJ4OMMhs6EreOW+IvBqhgl+GbLWEK1uv3g0
         a32jmheQLhoNw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id DC49C27C005A;
        Fri, 14 Jan 2022 18:48:58 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Fri, 14 Jan 2022 18:48:58 -0500
X-ME-Sender: <xms:6gviYcJ509WqYhUGwgPf5bGZtjM9ooxNSTufb_-Vhmow9OuZccB1eA>
    <xme:6gviYcI_Pc1gFLkwex1-l9zIMrbQJ_mhHC4QHUfjXL8CJf-a56k8xm-dUx_nedmQx
    6Yr5ATvnStn9A6rIMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhephfelhfdugeetvdfhfeeuveevtdegueekhfffheetffdtleevtdehtdei
    vdeuvedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluhhtoh
    eppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:6gviYcvJlGSO_ZzFgqYXgkjryt2wurwTfAVcmFZSRdcx5wOuCdIOWg>
    <xmx:6gviYZa5rdZruiwAjYgDDodAYKSKcGxuWa-8mkPnYWovXrP2Iz95mw>
    <xmx:6gviYTaNQONzbew0nDcGO4cdZJG6BkuoyBPCL5NBJyvaNUhx1QkgCg>
    <xmx:6gviYYPT-ohoK-Gs9jBdaah-p1hXQrtvtqQVowKrkRIVTFzItGbzFw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4A15821E0073; Fri, 14 Jan 2022 18:48:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <760ea801-8394-4e0c-9ec3-23e36e436551@www.fastmail.com>
In-Reply-To: <YeFdeZsTWDt9WU8f@zn.tnic>
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
 <Yd4u2rVVSdpEpwwM@google.com>
 <Yd6zrbFBzSn3ducx@hirez.programming.kicks-ass.net> <Yd724f1Uv1GTZ+46@zn.tnic>
 <73020277-d49f-7aae-22db-945e040a31a2@kernel.org>
 <YeCDudla868Ipf++@hirez.programming.kicks-ass.net> <YeFdeZsTWDt9WU8f@zn.tnic>
Date:   Fri, 14 Jan 2022 15:48:31 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Sean Christopherson" <seanjc@google.com>,
        "kernel test robot" <oliver.sang@intel.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH] x86/entry_32: Fix segment exceptions
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Jan 14, 2022, at 3:24 AM, Borislav Petkov wrote:
> On Thu, Jan 13, 2022 at 08:55:37PM +0100, Peter Zijlstra wrote:
>> On IRC Andrew also noted that these EX_REG_* things should be __i386__
>> only. Previosly when they lived as open-coded EX_DATA_REG() usage in
>> entry_32.S that was implied, but now ...
>
> I guess that then below.
>
> amluto, I'd love it if we (and by that I mean you :-)) could document
> the rules for GS on 32-bit so that it is clear what's going on there...
>
> entry_32.S is only hinting at what's going on, we have comments here and
> there but not all concentrated into a single location.

Acked-by: Andy Lutomirski <luto@kernel.org>

>
> Thx.
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Fri, 14 Jan 2022 12:15:21 +0100
> Subject: [PATCH] x86/entry_32: Remove GS from the pt_regs offsets and fixup
>  regs
>
> GS is special on 32-bit and segment exceptions fixup through it won't
> work. Leave breadcrumbs for others not to walk into the same nasty.
>
> Fixes: 9cdbeec40968 ("x86/entry_32: Fix segment exceptions")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/extable_fixup_types.h | 5 +++--
>  arch/x86/lib/insn-eval.c                   | 5 ++++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/extable_fixup_types.h 
> b/arch/x86/include/asm/extable_fixup_types.h
> index 503622627400..0aa5f4d3234f 100644
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -20,11 +20,12 @@
>  #define EX_DATA_FLAG(flag)		((flag) << EX_DATA_FLAG_SHIFT)
>  #define EX_DATA_IMM(imm)		((imm) << EX_DATA_IMM_SHIFT)
> 
> -/* segment regs */
> +#ifdef CONFIG_X86_32
> +/* segment regs, valid only for 32-bit code, see pt_regoff */
>  #define EX_REG_DS			EX_DATA_REG(8)
>  #define EX_REG_ES			EX_DATA_REG(9)
>  #define EX_REG_FS			EX_DATA_REG(10)
> -#define EX_REG_GS			EX_DATA_REG(11)
> +#endif
> 
>  /* flags */
>  #define EX_FLAG_CLEAR_AX		EX_DATA_FLAG(1)
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index b781d324211b..34001eee7482 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -432,7 +432,10 @@ static const int pt_regoff[] = {
>  	offsetof(struct pt_regs, ds),
>  	offsetof(struct pt_regs, es),
>  	offsetof(struct pt_regs, fs),
> -	offsetof(struct pt_regs, gs),
> +	/*
> +	 * Can't use that one - it is special - see entry_32.S
> +	 * offsetof(struct pt_regs, gs),
> +	 */
>  #endif
>  };
> 
> -- 
> 2.29.2
>
>
> -- 
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
