Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAE5709AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiGKSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKSC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:02:57 -0400
Received: from sonic312-24.consmr.mail.gq1.yahoo.com (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E47A53B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657562575; bh=6Z9kuwBxngD86iqFVMf/+x91pDL1RDTsT23U8EQLlTc=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=J2hIqe3m3J6Ad7OG7LUVDz6eOejTnavh407len9wLiidGjb5m5Wz4aTA9Rt8BNw/FgEVxBU7V5r7rBnFCHuVpFs8yCK5yps26Iw+PkIYyopPD/YbfzNmwLmtusnxkBARc7iGqpfZry73kAZsjArpHvCbR3wOIRCTCUx6U1FGj6gRndpoDE5bkVBm79Pwjsl60LdcMD0yiZn2lE4qd5ZlPetH41PWQEKDQMtlk2pS2vIAFY8DOkOndXs85phBTWQcQJUTAdo+gsjBCcRz3NPADOyRd8K4E8wnA3EUbxBcYCFtJyHMyGPXjKB+kgmtFo/6LtJnmXg63b7x7KwsxpoimA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657562575; bh=/Xvi9KkaDRqREJt0I+m/NDUYa9k98z3r8BvLcgZ8O0K=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=RFAzA2GK1s8kUcBepPBgvexMcNiqmdLAzbQ2sbaYsXscxtO0kVDWe/cc9JWYCadtapZEKtmb1Zzj6/07HncptDZMuGBsee+5coNynk6oPluC0wr0EAbP8ce4DTZly+CKzOjNyVjwdw19j4EDdXp0wPvyZJmrgjG0kKIGV1OaH+0OVx/6anPoPPSKxzzwlqfXNJjKQUH6jUNz/iyRRyitOu8RW7YOCJnp6ZlehkyNuU/YBrnhJfgmsndzDcIw0Y1UruNwoYIrhyDtdaORuW3iwom5oBoMaB7P5pjvFdGfIzDi969vKRqPSl8K1hfjdS7KnDs8OeL4kwOFNiZ2PDVOZQ==
X-YMail-OSG: FGXviiwVM1nf8oOLvlcrlqzdgLJFo0AxndR7o3x4KndnObuus5vChjVnx7NhCv1
 KofFLuzNf2hRJmHQQdjaIkUxdVTA5igTBKzWgMZj77Mg22nF0DIm_Y2wtaEZWyYn5Ydwl9r7l58Y
 FEUDO8tzOWBU5TpUrb_5nQQWZbRTvcarGVscxl2VS4zS.mQ4P8OPpHUcXZg9OaTzAyW74LRJFxP7
 y_AoWxGQoJ47alFrYu0Nt18JmpkY3qAtgIP7ljw1gn9Pc5z0wnD6ZenIIXIt3C8iLzfOMbdazavU
 UpaoeEQXom3GAjusJW_Fc1NMX77x22ajD_xMVgmJd_gFPt10LRQvy7xvnhfkcFr4mYw1S4DNMzJ8
 HzG5ksBxCqkNO0x3sMMCUZhV.Trav.b1cmCArbVv6cHQgDFR5DTXbcoPQ1w_56qk7aA6LlBAj5oV
 2.GPc41nmDGEIDNkddIckZ1sRl6e_GYS1bPgzNUS7csEWNKt8YcYhoEL1lmzggV7xI0RdkVR7Khb
 WA_BWEG05Y7uSel_8Hs5JIbaDEgkFNas1OG9GB_RV37lMvbEYCYH2kq6IC_ZLvnMO.Ai90dmkatc
 f.l_7LpjQI_PcyfWPF4TWImCl4GDpA4o113NLnyCqY92BIbKBTHzJRRFfSLefybGQ72XfTqXfRTS
 2CSXDEi9ljftxhU5XmEr8AbpXrp4MBcwsgbPiEJq51Vu3QYKHlKV9YBMgp7O0UoOEOytE7GKHH7X
 II07LMQzabajbTvZT68qE7cf4XL8cVLwznp1qiDUCpJmRt8nMlzD3VXkF4x0spGYtGeAEzRnw6mr
 cwTMjiUFHbS.tL3iCOW3CBA0uqQfoSDCONULh1WSvn4uotp.SIPaGqt.AFVK6nncnM8YipE7n3l7
 sI_AnnYVzYKRIZuczHlvXXYZ3NfHxdJy_SQmEMA96fGHY8sCUsvKdE5g1CsRMM64FzYa8VLPAOj.
 aoGuhR11z7xwIGpp1i2LWU9cHx5PG4Swr.ydX2VW5Ap1g1CYtvfm7BuofIakpQyjVdR8Xq5Wp239
 Aaxeio8Z8A7pQcKcVjcxyXEJt3fPXR7y2jXAOyHyz0r0dZRCZZxuu5D5lIWFk_HtxLzY_DeZh7dM
 0CJWlTka0Uyrc0SomRiHamrvlu6c2hiz8BUJjTMc17Zd8pjqEnccyx6KqnLoG2ZsnUjUI2YawOEd
 om5W60oxSljZyI8dJ1mLAcJuR4a_uUc3Em500TK61Gzg9QSWRBRLun1p995ps6ajQz2yHZ8Is3vr
 Qdwh10ziZJ__eRKXQv4cPmQMBxk0jgC2DXexUHfmsSvuNUMlPuazx1Z.2Jf.D9mVJV20wq6bb6QT
 FBDggjwvA1qYr_Wmu6spvmeLr06_n.s4KigQp3PncATVuFiy2sr5tu6SLLmvvIRx_E0x2ZuWfqmv
 L.nRzGWX30t3kl5UNkvyLMVzWjy8nQzXE_LKRdjbYtX2K3E0WhaWad7tg21Igt.ySDp3iK5.IVlE
 amG5WOGZqmAZR7QsOvVx8il1GdxBvQyUBsSPdSczmXet2tT3fOpjHfDWDtuVBHLLgyWD4WDbBUGg
 Vw8KWPNII9lHZq5J2TVqFHAaxMk7nyuTEF2wkTsoE5g.IT.csMcqRfCB3j79wE0Q9etfWOrfAMG_
 JQywfDG2kTnhCNwMVOT7uC4fpTpFRV70ss48gvr_ZB7zcttuBwOIlVXBUV95E3_RvD19VccjNjFI
 Jo88lMeKMQthdJEFzsvvYTbUfyM94pfBJ9H23PeMuBHoqWuq15LHqorgqaw9jdV16F8AwmVjPCLE
 Pg5Eia4_2UWwjcD3JZsVxxqgY5N1YxLAjIP6pdiDqBme13PMZITiSivbSWL8oYeZYrAzrWU1etgV
 .bFqzRwDZFM3V8a.VIqwtEVJnKhxf6IFaNUvrpH3OntCu6ie4PLl2CDM5prihjEviCaHcTwjW841
 P3wwMItyMHi6uZwu0IAgEOP0gWIQlu9hPzB9QOSMscE9C0ppcMDpksZ0mSzv3_7HtO0NhOofXXJ1
 KTbSfB7Ohc1S6fJqaFQoB1OpgzvUp6UJQ0fP7Vf3G_HDh_phwChGXVHWbrch2D_0grbf3ncSlhq8
 ZkBl6Gviat1K2VDOBZpM8IPMU3qhk0ZXiraql9Xcylu3JEFdVD34OISCKRoKRe.XeQG6OzvUQnOd
 rXiPW_AvB22K_jzZ4Fj1XjZ9vPtZm20lwiOKAfELSmpilANqRlpbCgogy.4Oa0kdXxCftAhpVi7h
 vooNCbR7rTkN05hjaOkF9
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Mon, 11 Jul 2022 18:02:55 +0000
Received: by hermes--production-ne1-7864dcfd54-q5j27 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c836adb02e8ba905612c5d0278c92b3a;
          Mon, 11 Jul 2022 17:41:03 +0000 (UTC)
Message-ID: <d49e87a0-417d-194d-daa1-952f707f096c@netscape.net>
Date:   Mon, 11 Jul 2022 13:41:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Chuck Zmudzinski <brchuckz@netscape.net>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
To:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
 <aa8f99dc-e622-398e-1a68-6b060497e4b3@suse.com>
Content-Language: en-US
In-Reply-To: <aa8f99dc-e622-398e-1a68-6b060497e4b3@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20381 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2022 10:31 AM, Juergen Gross wrote:
> On 11.07.22 16:18, Chuck Zmudzinski wrote:
> > On 7/5/22 12:14 PM, Borislav Petkov wrote:
> >> On Tue, Jul 05, 2022 at 05:56:36PM +0200, Jan Beulich wrote:
> >>> Re-using pat_disabled like you do in your suggestion below won't
> >>> work, because mtrr_bp_init() calls pat_disable() when MTRRs
> >>> appear to be disabled (from the kernel's view). The goal is to
> >>> honor "nopat" without honoring any other calls to pat_disable().
> >>
> >> Actually, the current goal is to adjust Xen dom0 because:
> >>
> >> 1. it uses the PAT code
> >>
> >> 2. but then it does something special and hides the MTRRs
> >>
> >> which is not something real hardware does.
> >>
> >> So this one-off thing should be prominent, visible and not get in the
> >> way.
> > 
> > Hello,
> > 
> > I have spent a fair amount of time this past weekend
> > investigating this regression and what might have caused
> > it and I also have done several tests on my Xen workstation
> > that exhibits the regression to verify my understanding
> > of the problem and also raise other problematic points.
> > 
> > I think, in addition to immediately fixing the regression by
> > fixing the now five-year-old commit that is the root cause
> > of the recently exposed regression, as discussed in my
> > earlier message which proposes a simple patch to fix that
> > five-year-old broken commit,
> > 
> > https://lore.kernel.org/lkml/63583497-152f-5880-4c8f-d47e2a81f5a6@netscape.net/
> > 
> > there needs to be a decision about how best to deal with
> > this very aptly described "one-off Xen thing" in the future.
> > 
> > One problem in x86/mm/pat/memtype.c is the fact that there
> > exist two functions, pat_init(), and init_cache_modes(), that
> > do more or less the same thing, so that when one of those
> > functions needs to be updated, the other also needs to
> > be updated. In the past, when changes to the pat_enable
> > and pat_disable functions and variables were made, all
> > too often, the change was only applied to pat_init() and not
> > to init_cache_modes() and the one-off Xen case was simply
> > not addressed and dealt with properly.
> > 
> > So I propose the following:
> > 
> > 1) Identify those things that always need to be done in
> > either pat_init() or init_cache_modes() and try to combine
> > those things into a single function so that changes will
> > be applied for both cases. We sort of have that now with
> > __init_cache_modes(), but it is not really good enough to
> > prevent the regressions we sometimes get in Xen PV
> > domains such as the current regression we have with
> > Xen Dom0 and certain particular Intel graphics devices.
> > 
> > 2) If it is not possible to do what is proposed in 1), at least
> > re-factor the code to make it very clear that whenever
> > either pat_init() needs to be adjusted or init_cache_modes()
> > needs to be adjusted, care must be taken to ensure that
> > all cases are properly dealt with, including the
> > one-off Xen case of enabling PAT with MTRR disabled,
> > Currently, AIUI, all one really needs to know is that
> > init_cached_modes() handles two special cases:
> > First, when PAT is disabled for any reason, including when
> > the "nopat" boot option is set, and second, the one-off
> > Xen case of MTRR being disabled but PAT being enabled.
> > 
> > I am trying to do number 2 with a patch series I am
> > working on. It is up to the experts to decide if it
> > is possible or even desirable to improve the code so
> > that any changes to the caching configuration are more
> > likely to be properly implemented for all supported platforms
> > by successfully combining the two functions pat_init() and
> > init_cache_modes() into a single function. The new function
> > would probably need to be renamed and include bits from
> > mtrr_bp_enabled, etc. for it to function properly.
> > 
> > If anyone wants to argue that it is not desirable to try
> > combine pat_init() and init_cache_modes() into a single
> > function, I think the burden of proof rests on that
> > person to demonstrate why it is good and clean
> > coding practice to continue to have them separate
> > and independent from each other in the code when
> > they both essentially do the same thing in the end, which
> > is call __init_cache_modes() and determine the PAT
> > state, and also probably the MTRR state.
>
> I think the proper solution would be to make PAT and MTRR independent
> from each other with some additional restructuring on the PAT side:
>
> Today PAT can't be used without MTRR being available, unless MTRR is at
> least configured via CONFIG_MTRR and the system is running as Xen PV
> guest. In this case PAT is automatically available via the hypervisor,
> but the PAT MSR can't be modified by the kernel and MTRR is disabled.
>
> As an additional complexity the availability of PAT can't be queried
> via pat_enabled() in the Xen PV case, as the lack of MTRR will set PAT
> to be disabled.

My testing indicates your presumption is not correct, or at least my
testing on my Xen workstation makes me doubt that your assertion that
PAT can't be queried vi pat_enabled() in the Xen PV case is true.

Let me begin a discussion by posing a question about the following
code in init_cache_modes(), a function implemented in
arch/x86/mm/pat/memtypes.c, and which is called from
arch/x86/kernel/setup.c but only effective if pat_cm_initialized
has not already been set by pat_init(), as is obvious from the
immediate return if pat_cm_initialized has already been set.

Now in the Xen PV case, pat_cm_initialized is not set because
pat_init(), where it is normally set, was skipped due to the fact
that MTRRs are disabled in Xen PV domains. I verified that
init_cache_modes() is activated in the Xen PV Dom0 case by my
testing. So, I ask, why cannot the code that is present here in
init_cache_modes() be used to test for PAT in the Xen PV Dom0
environment and if the test is positive, why cannot pat_bp_enabled
be set which will cause pat_enabled() to return true in the Xen
PV environment? In fact, I used the additional 'else if' block to
set pat_bp_enabled to true in the Xen PV environment for the
case when boot_cpu_has(X86_FEATURE_PAT) is true and PAT
MSR does not return 0, that, is, when pat !=0 after calling
rdmsrl(MSR_IA32_CR_PAT, pat) for the boot CPU. All the existing
comments in this function indicate this is a valid way to test
for the existence of PAT in the Xen PV Dom0 environment.

Moreover... (please move to the bottom of the code snippet
for more information about my tests in the Xen PV environment...)

void init_cache_modes(void)
{
    u64 pat = 0;

    if (pat_cm_initialized)
        return;

    if (boot_cpu_has(X86_FEATURE_PAT)) {
        /*
         * CPU supports PAT. Set PAT table to be consistent with
         * PAT MSR. This case supports "nopat" boot option, and
         * virtual machine environments which support PAT without
         * MTRRs. In specific, Xen has unique setup to PAT MSR.
         *
         * If PAT MSR returns 0, it is considered invalid and emulates
         * as No PAT.
         */
        rdmsrl(MSR_IA32_CR_PAT, pat);
    }

    if (!pat) {
        /*
         * No PAT. Emulate the PAT table that corresponds to the two
         * cache bits, PWT (Write Through) and PCD (Cache Disable).
         * This setup is also the same as the BIOS default setup.
         *
         * PTE encoding:
         *
         *       PCD
         *       |PWT  PAT
         *       ||    slot
         *       00    0    WB : _PAGE_CACHE_MODE_WB
         *       01    1    WT : _PAGE_CACHE_MODE_WT
         *       10    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
         *       11    3    UC : _PAGE_CACHE_MODE_UC
         *
         * NOTE: When WC or WP is used, it is redirected to UC- per
         * the default setup in __cachemode2pte_tbl[].
         */
        pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
              PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
    }

    else if (!pat_bp_enabled) {
        /*
         * In some environments, specifically Xen PV, PAT
         * initialization is skipped because MTRRs are
         * disabled even though PAT is available. In such
         * environments, set PAT to initialized and enabled to
         * correctly indicate to callers of pat_enabled() that
         * PAT is available and prevent PAT from being disabled.
         */
        pat_bp_enabled = true;
        pr_info("x86/PAT: PAT enabled by init_cache_modes\n");
    }

    __init_cache_modes(pat);
}

This function, patched with the extra 'else if' block, fixes the
regression on my Xen worksatation, and the pr_info message
"x86/PAT: PAT enabled by init_cache_modes" appears in the logs
when running this patched kernel in my Xen Dom0. This means
that in the Xen PV environment on my Xen Dom0 workstation,
rdmsrl(MSR_IA32_CR_PAT, pat) successfully tested for the presence
of PAT on the virtual CPU that Xen exposed to the Linux kernel on my
Xen Dom0 workstation. At least that is what I think my tests prove.

So why is this not a valid way to test for the existence of
PAT in the Xen PV environment? Are the existing comments
in init_cache_modes() about supporting both the case when
the "nopat" boot option is set and the specific case of Xen and
MTRR disabled wrong? My testing confirms those comments are
correct.

> This leads to some drivers believing that not all cache
> modes are available, resulting in failures or degraded functionality
> (the current regression).

I also did some tests to try to verify that fast WC caching mode
was used as requested by the i915 Intel graphics driver on my
Xen Dom0 workstation and so far I cannot prove that the WC caching
mode was not used, and I have some custom logs from the
Linux kernel i915 driver that indicates my Linux Xen Dom0 is able to
use the fast WC caching mode, so long as the bug that causes
pat_enabled() to return a false negative is fixed.

So my testing seems to contradict rather than confirm your claim
that "the availability of PAT can't be queried via pat_enabled() in
the Xen PV case." I think my patch successfully does what you
claim cannot be done, and I also think the existing comments in
init_cache_modes() indicates that my patch is successfully testing
for PAT in the Xen PV case.

>
> The same applies to a kernel built with no MTRR support: it won't
> allow to use the PAT MSR, even if there is no technical reason for
> that, other than setting up PAT on all cpus the same way (which is a
> requirement of the processor's cache management) is relying on some
> MTRR specific code.

After reading the code extensively, I am curious about testing
and even successfully compiling a kernel with options like
CONFIG_MTRR and CONFIG_PAT disabled. But my testing indicates
such problems could be debugged and fixed if they manifest
using the current code which, AFAICT, appears to be mostly
designed and tested for the case when both PAT and MTRR
are enabled on modern x86 hardware. I would expect many
bugs for configurations that deviate too far from that paradigm
on Linux. This is the problem with Xen's unique configuration
that enables PAT but disables MTRR. I think the problem can
be solved, it is just that there is not enough care taken to
ensure that these outlier cases will work as well as the common
configuration that Linux supports well, which is with both
MTRR and PAT enabled on x86.

>
> All of that should be fixable by:
>
> - moving the function needed by PAT from MTRR specific code one level
>    up
> - adding a PAT indirection layer supporting the 3 cases "no or disabled
>    PAT", "PAT under kernel control", and "PAT under Xen control"

I am not sure the right way to divide the cases is "PAT under
kernel control" and "PAT under Xen control." I also looked at
the code in the Xen hypervisor and it does allow for Dom0
to use a Xen hypercall provided by the xenctrl library to enable
PAT WC caching mode, and I ran some tests for evidence that
my Xen Dom0 was making such hypercalls to support the WC
caching mode, but I have not yet been able to verify that the
WC caching mode is enabled by a hypercall from Dom0 to Xen,
although by reading the code in the hypervisor and xenctrl it
seems to be possible. I just don't think the i915 Linux kernel
driver uses such hypercalls, and I am not sure that my Xen
Dom0 could be using the fast WC caching mode because
"PAT is under Xen control" instead of "under kernel control"
unless the kernel is relying on Xen to provide PAT via Xen
hypercalls. The successful call of my Xen Dom0 to rdmsrl
which obtained a valid configuration of PAT for the virtual
boot CPU exposed by Xen to the kernel indicates at least that
the kernel can detect, if not control, what the supported PAT
caching modes are. Of course you are absolutely correct that
the kernel cannot directly control the PAT caching modes in the
Xen PV environment, at least not without possibly resorting to
some Xen hypercalls that are most likely not currently in use
by the kernel.


I would have to do much more testing to really determine
what is happening and how my Xen Dom0 is really
configuring the PAT caching modes and specifically, if
it is actually using the fast WC caching mode as requested
by the i915 Intel graphics driver.

> - removing the dependency of PAT on MTRR
>
> I'd be up for trying this, but right now I haven't got the time to do
> it. I might be able to start working on that in September.

Please let me know if/when you start on it, I would be interested
to try out what you come up with on my Xen Dom0.

>
> Meanwhile I think either Jan's patch or the simple one of Chuck
> should be applied.

I agree.

Best Regards,

Chuck
