Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B9D57210E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiGLQfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiGLQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:34:50 -0400
Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C6326DA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657643673; bh=9IPvrhsDCI1C7tNIqLBIkt5VSUNjrL3qx3hjUwV1AVc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mkQn2ruLTkVnkaYhPKMI8A1lymmgrtP3aERlUAE5AfykX9IB4aVdLdozjGH/jXZ60eYNMa8ubOKn8kukli/tfeoJRvZbESUxZClkAFHldkc/7+GfUHkWU0kFwWaE+Sk/sTklS5ARwMZ3q3v2Mp91aKVKnZltz9jBaW2FUd1Rf8k4B61Ye4sCnkXfe21XWK6k1ZDTdRM+SMdc+L1pwWDMtCQCd6zWcWIj8B6rU5nVsPd4WKmJ8AguhM3YFlz/NPYsICLWLUQ63GzMwx6WsfGY2kRuWP25RlIBG+8VlUayCrklhsvbpL6lJp/2X9Mjd5KeEZS+6EFiesKRmZAvp0OP4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657643673; bh=wKSWEjne/d5RFVv8EG+JgkENbFezPjdV65OY/2OPOwa=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GCJjBW+1cz0+qw690ie/dsV3VntOKOmkoSlraIq+83Tuyx3j/5nCuGLFykvuYUpH+wUpBJFfsOgNN4TcAWy41tQRFvt+Qelmf0e3cCpZgOCPb3YOvxSTiJvVqvEg4gW74AKPsUXUo9S5u7xyJs/H1vT7lNIQcmDnPv/8rvEZA6XGJeqHS8nXPdLHjZRKAQWgX0iNeRHdrX6NRoCWeoi+HT8usweFV1XbHTOOxrDPCTWr+7JlQXi5N4k5KwpHRo8mzvIRuMfDR8nXF3RzUyNIna1+nAEwV8up7GGnDLWyHiJk4n7pscqYoBiQhlGxhmUW5ojkhzPkMWAHpUgmmVVEZA==
X-YMail-OSG: 0UPu97wVM1muZrI_X_I3OFm.UHdm2L8gFk9nuSipTX6bcrrKj4JP6Eaff37VDcS
 tIkeCtA1MEboyz2x4S4q4X9T31UvZQBn2foYA7U.in3RoJofqjIL2KS0XPkMavz124tniTumj.lA
 HjWk3ck7blLCxbNSUSadsAPUbiYhGP5Gb4Itd52ePYftyMYssvkobshcjJdJqR_WVsZWogQFZQwd
 tzMMF8ka.q0gCvWtydEqnVH_t4aRA8sApHZrq3ElufWCaygI9KTA39hdAd4BHbUI35ompFFkKuHA
 098uFwpDVxDz_HihwVnhapQIgRbgdkAwWc.0dBOa7xfCuachjBndOYjTqzwm82zgr9h_hggYghv0
 DEE5NlUTTZm..RJGtcuQyO71ZLN0VA5nW2VjiyejvtibsNylIWpScu7yJOVkwqhS15UlP1mIkM.s
 XY9r7PadGcICC6MocUMYwDQGVKO8usnc.7igW4MVg_84P7wW5L7RFW2GR7o08O.wcI8rcill67qH
 8t6Vx2Q6OZXLA9RyxU0ItBR5rUpsEiZ2e2sFDtO2ukaM7ETL7TO9YgjOAe5K3MD6.txTeaDEGbK8
 hx2v_l3.REgFU7tEhquvg9rEGzFDRRyu1AwDD8BlQDIcCXwo3NbRFgUhW2pvLRSvoOS1dWRTjE1J
 w6BXuWlkfFnt_eupyimFCL_V.2MRbIMOxUQM1XZQtKHFwbiSW8YmFnmWz4PJcNPIeNrOwO44KHwm
 lGk_9mfMfIFwCvMp9OYuhlHTa2BM0_T56Vze5PN8sBzRo633rgFLuXlgCdxbgLTgxwmQs1h2UVXM
 q4ZCCvWbmg851J5MpofSLBkCUNHk7mK3HFh7qjCdqJlKS22t8ArgNjIL59iRgisc3VcvKD48ES7a
 7ICfi4ikrNgnY7fbnrHFSM44e2z5ITAvY.vMm8ntCRY40mLxuWogJhQhdukIGlp70m2JSQtag3r4
 dyMLo1X_OYW28WlFA0w1V_MCVfDUmEIl2sotInHefhSjmw5Jihwl9h9e6QELF1jw_79anVoOhfrV
 0w7hyXPhYOVbaM0CowtInk1XaRqlamepdMBaeHybCl64sdXqSv5RPcUhLxKYyjgR_NvjWrFj9yiG
 2QiYmg_5gbeDXrJHAcQW7kc4CbS8CBXtqLV8dholK0WWmR7QSiPkp5U6UVkh0SNECJ4GnJFEhab5
 s7fo1W4CqenR398nJRTSRDEI0gAzBxLB9F6ZOnLr96Elu1XAtZxRh_nVRnu8zhzkSWLAqpBveH5e
 9.GX2_zdQkBWSM6UjJ6msOYlcJuiO6DKlB_q3_MGMrQjwlpxPElOECd_h9pu1KwkiOMfNaDb8TGY
 wM5yPmUZrVvZMqo35d.1rzaNtqNnb5y3oguulw9JW.VlLaXXhxHZ4CxOYsyTopcUuFMMoWZC5Z9D
 X.7qTzRooyvR8FQqH__68jT3FvD91rhls9T0f4Vy8QWuAhCK4oCK7FTBdIZz8FXH8JDRuUEXYThA
 hHQgyB961gfVi0icoChz3YAUW2CQa.bTntGEtYhS3ShENdFzaG_k5sWpk2p6sSyFl2iE.gHWEv.K
 nU_Vpk_Avjpf1PS7Vy7aNZuE0kTeC1SCDxDPC25yMFz3VbrPG5kqYA0B6FG68_HLFnZpx_WQJSCK
 bAvVUB6Lmy_T0M.ELUUId4EA0iWlP2XbO07GBcJYdZLKhIkZF66GcoeK0WCw2PpiyMArCXU7VH2y
 4TwHmZgB.pk2zmubg2CbRCb.nrabOGYvgNvhMdirkK9m1ea_dcRUDHCrJ.9u6dRVlQSpawZec6wa
 AxLgy.B1mxRb8ZqhZlZwHfhwJKj8bxkwPcUsRiNyrZlCgOaXNZ8X65MbOtHwe8skFjghodag_k.P
 RE0nlhbOKRetMu3TDD0VVMlfv2VpAbZTWqw1waZ6tfjIySLC832YNe1o4qhtvDh5lH3_pmG321c4
 s5uZN9FHvrWA7m71jSs9bMiig7WYhI.eukhSpFn1KDIHSaorPVjRf.qPWRB4gx61f5JXEPjEVMR5
 iyHgs2dAXJRb0vMQKAE4wdIVdz4baYONpth7tonr.LaumuSFG8uM4oMNNzqVQandIgbpOjSInaZs
 vW2bt_NwDVVCxZX_Ra2L3.OMiEookM0TFc_ip6dE.YnP5cgKj9v9dRWRe5KflhB_hPiIsK8jk16s
 .U_7bV6dH_aXAaPoWLWHhY7m4J8sLTu55dtXoUo6FEQI2xEYCJ179Svj63I1.F_8rWSwUgVdcLoO
 x74jLDWAwhrZ9
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Tue, 12 Jul 2022 16:34:33 +0000
Received: by hermes--production-bf1-58957fb66f-88chf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 692ae7703da13e268bead15e283ae6fb;
          Tue, 12 Jul 2022 16:34:28 +0000 (UTC)
Message-ID: <08691a7e-8af6-00d8-4bd3-41b8c44536e1@netscape.net>
Date:   Tue, 12 Jul 2022 12:34:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Borislav Petkov <bp@alien8.de>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
 <aa8f99dc-e622-398e-1a68-6b060497e4b3@suse.com>
 <d49e87a0-417d-194d-daa1-952f707f096c@netscape.net>
 <6afa42fd-469d-5b08-1688-5af8a3c9d8fa@suse.com>
 <8011dff1-6551-898f-7e37-38ede106e2f4@netscape.net>
 <45fd7ade-61fe-18fa-aacc-ed80fdf3fb8d@suse.com>
 <3b228e55-53b6-beb8-7822-af03e65a078b@netscape.net>
 <7ff738f2-716f-f42a-2f92-3a7d94722d33@suse.com>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <7ff738f2-716f-f42a-2f92-3a7d94722d33@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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



On 7/12/22 11:30 AM, Juergen Gross wrote:
> On 12.07.22 17:09, Chuck Zmudzinski wrote:
> > On 7/12/2022 9:32 AM, Juergen Gross wrote:
> >> On 12.07.22 15:22, Chuck Zmudzinski wrote:
> >>> On 7/12/2022 2:04 AM, Jan Beulich wrote:
> >>>> On 11.07.2022 19:41, Chuck Zmudzinski wrote:
> >>>>> Moreover... (please move to the bottom of the code snippet
> >>>>> for more information about my tests in the Xen PV environment...)
> >>>>>
> >>>>> void init_cache_modes(void)
> >>>>> {
> >>>>>       u64 pat = 0;
> >>>>>
> >>>>>       if (pat_cm_initialized)
> >>>>>           return;
> >>>>>
> >>>>>       if (boot_cpu_has(X86_FEATURE_PAT)) {
> >>>>>           /*
> >>>>>            * CPU supports PAT. Set PAT table to be consistent with
> >>>>>            * PAT MSR. This case supports "nopat" boot option, and
> >>>>>            * virtual machine environments which support PAT without
> >>>>>            * MTRRs. In specific, Xen has unique setup to PAT MSR.
> >>>>>            *
> >>>>>            * If PAT MSR returns 0, it is considered invalid and emulates
> >>>>>            * as No PAT.
> >>>>>            */
> >>>>>           rdmsrl(MSR_IA32_CR_PAT, pat);
> >>>>>       }
> >>>>>
> >>>>>       if (!pat) {
> >>>>>           /*
> >>>>>            * No PAT. Emulate the PAT table that corresponds to the two
> >>>>>            * cache bits, PWT (Write Through) and PCD (Cache Disable).
> >>>>>            * This setup is also the same as the BIOS default setup.
> >>>>>            *
> >>>>>            * PTE encoding:
> >>>>>            *
> >>>>>            *       PCD
> >>>>>            *       |PWT  PAT
> >>>>>            *       ||    slot
> >>>>>            *       00    0    WB : _PAGE_CACHE_MODE_WB
> >>>>>            *       01    1    WT : _PAGE_CACHE_MODE_WT
> >>>>>            *       10    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
> >>>>>            *       11    3    UC : _PAGE_CACHE_MODE_UC
> >>>>>            *
> >>>>>            * NOTE: When WC or WP is used, it is redirected to UC- per
> >>>>>            * the default setup in __cachemode2pte_tbl[].
> >>>>>            */
> >>>>>           pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
> >>>>>                 PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
> >>>>>       }
> >>>>>
> >>>>>       else if (!pat_bp_enabled) {
> >>>>>           /*
> >>>>>            * In some environments, specifically Xen PV, PAT
> >>>>>            * initialization is skipped because MTRRs are
> >>>>>            * disabled even though PAT is available. In such
> >>>>>            * environments, set PAT to initialized and enabled to
> >>>>>            * correctly indicate to callers of pat_enabled() that
> >>>>>            * PAT is available and prevent PAT from being disabled.
> >>>>>            */
> >>>>>           pat_bp_enabled = true;
> >>>>>           pr_info("x86/PAT: PAT enabled by init_cache_modes\n");
> >>>>>       }
> >>>>>
> >>>>>       __init_cache_modes(pat);
> >>>>> }
> >>>>>
> >>>>> This function, patched with the extra 'else if' block, fixes the
> >>>>> regression on my Xen worksatation, and the pr_info message
> >>>>> "x86/PAT: PAT enabled by init_cache_modes" appears in the logs
> >>>>> when running this patched kernel in my Xen Dom0. This means
> >>>>> that in the Xen PV environment on my Xen Dom0 workstation,
> >>>>> rdmsrl(MSR_IA32_CR_PAT, pat) successfully tested for the presence
> >>>>> of PAT on the virtual CPU that Xen exposed to the Linux kernel on my
> >>>>> Xen Dom0 workstation. At least that is what I think my tests prove.
> >>>>>
> >>>>> So why is this not a valid way to test for the existence of
> >>>>> PAT in the Xen PV environment? Are the existing comments
> >>>>> in init_cache_modes() about supporting both the case when
> >>>>> the "nopat" boot option is set and the specific case of Xen and
> >>>>> MTRR disabled wrong? My testing confirms those comments are
> >>>>> correct.
> >>>>
> >>>> At the very least this ignores the possible "nopat" an admin may
> >>>> have passed to the kernel.
> >>>
> >>> I realize that. The patch I proposed here only fixes the regression. It
> >>> would be easy to also modify the patch to also observe the 'nopat"
> >>> setting. I think your patch had a force_pat_disable local variable that
> >>> is set if pat is disabled by the administrator with "nopat." With that
> >>> variable available, modifying the patch so in init_cache_modes we have:
> >>>
> >>>        if (!pat || force_pat_disable) {
> >>>            /*
> >>>             * No PAT. Emulate the PAT table that corresponds to the two
> >>>
> >>> Instead of:
> >>>
> >>>        if (!pat) {
> >>>            /*
> >>>             * No PAT. Emulate the PAT table that corresponds to the two
> >>>
> >>> would cause the kernel to respect the "nopat" setting by the administrator
> >>> in the Xen PV Dom0 environment.
> >>
> >> Chuck, could you please send out a proper patch with your initial fix
> >> (setting pat_bp_enabled) and the fix above?
> >>
> >> I've chatted with Boris Petkov on IRC and he is fine with that.
> > 
> > That's great, I will submit a formal patch later today.
> > 
> >>
> >>> I agree this needs to be fixed up, because currently the code is very
> >>> confusing and the current variable names and function names do not
> >>> always accurately describe what they actually do in the code. That is
> >>> why I am working on a patch to do some re-factoring, which only consists
> >>> of function and variable name changes and comment changes to fix
> >>> the places where the comments in the code are misleading or incomplete.
> >>
> >> Boris and I agreed to pursue my approach further by removing the
> >> dependency between PAT and MTRR and to make this whole mess more
> >> clear.
> >>
> >> I will start to work on this as soon as possible, which will
> >> probably be some time in September.
> > 
> > Good, I will look for your patches and try them out.
> > 
> >>
> >>> I think perhaps the most misnamed variable here is the  local
> >>> variable pat_disabled in memtypes.c and the most misnamed function is the
> >>> pat_disable function in memtypes.c. They should be named pat_init_disabled
> >>> and pat_init_disable, respectively, because they do not really disable
> >>> PAT in
> >>> the code but only prevent execution of the pat_init function. That
> >>> leaves open
> >>> the possibility for PAT to be enabled by init_cache_modes, which actually
> >>> occurs in the current code in the Xen PV Dom0 environment, but the current
> >>> code neglects to set pat_bp_enabled to true in that case. So we need a patch
> >>> to fix that in order to fix the regression.
> >>
> >> In principle I agree, but you should be aware of my refactoring plans.
> > 
> > I will defer to you and stop working on this re-factoring effort, but I
> > will prepare a formal patch to fix the regression later today.
> > 
> > I do think Jan's point about respecting the administrator's "nopat" setting
> > should also be considered. AFAICT, the "nopat" option in current code
>
> Yes, please add that, too. This was what I meant with "the fix above".
>
> > is also not being respected on the bare metal, and the patch to
> > init_cache_modes with a force_no_pat variable is also needed to
> > ensure "nopat" is respected on the bare metal, AFAICT.
>
> Hmm, I don't see how the PAT MSR will be written on bare metal when "nopat"
> has been specified.
>
> I just tried it with a 5.19 kernel and it booted with the correct PAT
> settings:
>
> [    0.000000] x86/PAT: PAT support disabled via boot option.
> [    0.000986] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
>
>
> Juergen

OK, I understand. In init_cache_modes, if on Xen we read the PAT MSR
to pick up the configuration Xen did, so on bare metal we will just read the
configuration with PAT disabled. So "nopat" does work on bare metal.

I do think Jan is correct that "nopat" does not work on Xen, though.

Chuck
