Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9A571EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiGLPQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiGLPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:16:27 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDECBE099
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657638653; bh=bOVx7YrJAuUMpkgDTYAHEYSe4MaLEA3DCPkIu6cmXSQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lwJaZA9F7lQIKd1z2jh+I1393ECUv1G6a18GunLQOybb81a1+7PZ2kFN02SpvKJd/hx1SXIUzK+N69UziEaX3HoMZqh8fbF5EjmwpWX2PtYwkLUS8tu8DyZr7G/+W2OyuhkFw3YSTIZz2CNLOVIlqc0ftvchKIdUDe13txhMYYaPukoqiSEQZCg0vUaCaeHEGgXA4VVjXkHgixuFRq8qGHuV0jDaF2kZML3QVpPhhJUYyI/NaP3Bj3+rCcLCZ+/UFcvHImPKztANDU3oive31cimoF1eo0+citUomiB50lEOdx3tibsRQPL6UXHtLfGboxGSto2VsnegXTnnykaGow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657638653; bh=FfZVB0AtytDJFrI2r2Op342mDi9hyzYHrQ+lzrBJvzI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eUulBIhmrYpxeMz6bPnOEDof4xyRuDffvsaml9R6RRPzpCZSHjKeeEuPpxicINZqsH3b36QX93cmanSC9bqCu8WeeGhoIWIsxxX3U+A3o9EvXvm7FnAwQiMhW2+r1VEMSQPjuxT/z0VZ480mcUmZo0QSPHSpQhVImb9wJhDn+/UKzmB2BN1TrfVSVYhhb2ezl1YJv0mqQah/PiWDqeu7d8JMGMLD93kRVFz6j3Sg614ww9vcfsUrfyw7UzmSPt+qVWdj1glNRBf3w4vwi+r0Y9lYscGnGeCgW7CenstfbB6/Zb3/Wqg5vR/1fu8dJBZzQuPu4WsBqD8I0zFf52xSiw==
X-YMail-OSG: hicEidYVM1nv_OxWru_4Fj6z1kYd_Rf2mLCS5854cpF9Cw5lGoVInjCa0CmdF6g
 t71Q1bnWA3wvQqTyPPKP_X2jhNUYn5xfNZ4w9EhkQqpT54GTtdkNQ4Uj75HsFomj1nsqRDtHoUfa
 0nZ6MDQF1h7Ma_9_6n71Y0ZTARx3d3ZSv26NPe0dS6IqYy4OvNhxtyK90nLYeZc02elfGHrp4MMq
 VLJB4kxWReK6nX5lcyOQ3Bls0QuLZreqWgF_Q99kMi.7eAvpCRDIuu88ilg.33rWPGeYI0gfXgK9
 deJZue19u9uWKEMCKuym1bkwtJdkCy07voDmKhHOEois.2Mi7jVb78_PmOkT73vL4eG5RYppwxDA
 _6Ng2T5iPUH6.IDi4YGhT49xaFfHhYnbp5Glp7IP_KQbVMnDJ0o1pbgf80CkyqJUSMsIXheIWV8x
 2FrTKZQnzOO3BeSPaK5lFvw9yGtS0_kn3ImKjG_8dGqRtOsGHOnn18QhI3c6nj_qz71sLEsYKQdb
 GweFZjFXwPFAE9it_xc_I23UEXE69nCaj0jkHVfHgbuTG6GAnz1oAf2hpOqYiNdPtk7ukObwzfBB
 x8d6UNlmigKIlDNzzk8y9gKyu5UCY4LMGiXfQLPOUqD_v_UUTvFG5qhYQnP6_WybenZbFyH.lfn7
 K6zQoKk6qrKAsl8VeN_bdNx8K8UNxLrNvaoq0o_6Vo5.tgJU7M_Cp9UkRQKERpsWlWpscax5iwm0
 Thv.c._SVJ8BX2qTBWwFiOg_.J5J5ZYmjSyrqAzpfBcObsql0H42h5dwKwBy0W4a2wlw60ApU4ma
 I1JFIVfVdQM9CNftmi9q0gbQYdJyATyQb2cVrKutkkho14EXHzsMkQ5YW8mxOoeBQzhE7KyeG3J_
 Vq_65w8UmzDO6iBtfkO16lUTl2P8IX6h8VOQu4Mkh7CsZ3CLYLbeLlbFWcxM4iG81z.vvvBN6cTI
 oi1TVQF5KkpLcmpsY2WMqeRqpZGYl_gKAqhb0NVg5zHKqkWAOrjehbT80v6dFkvgiM.lckIGI8f9
 gDevs27JCfQCbtia9A8uMqVKPvlM9b0UvKoivz78y9mN.6krQjqcaHCDqnGbi3OHjrTd5YamwFxo
 HQzuLI2nMizzf_aeelaXbsGrjsQbgPKhjigF1lq0bEWFpE4apIoDv3UPKp8ZLRKNqdQylPi5bv6k
 5NSmj.3wtK41RfkG4y7ValKUdJKni5HOWkmYBQWO7X4QHn6grmUVoLSUsiOOM4Au9FZan0arrQ4f
 Ga2VL1eYTU9o8KoRP7cxnXksYBKtskOKh6MIn825.LvOGiDJAu8REgdR3Q_rXq5WqxCI5.3o.DB8
 y3wQP8m9MoqGDfkYZNUTMDQ4WJA.J.vp6qPQlOBbjrlVPGphQC6V_06sK9tL2cv.MvecaDN3I1KU
 .bGsr0KONhCfh._2xUjcp8WXoBUendH0wF6l0KzNwtLwnzscr1AP0FaPbqq1HLY1igFUNlT_h807
 VUdeln.DsYmMTCxVKqGOOEG9RRT9YYmEWb7zs1TUHSoymnJ4T3iv6X5tzvImJZ1Kvj5_5qfamAXU
 qMRsR3cDKpzbT2aclkUqrgKPY5fLGDE81lVBSEzOEIBBYvhBAcuWqiT085Nlyfntxq4D8Xn9wN1E
 OkXxTUI879yWyVqRLomYQl3SBfXDWGGb.W1q5g9f2MjNKAarYuyV.WuARcyXC81SY9y.G.D2jHvB
 Gi3KNrgCIje_EUAcFRgIY_dAQhf5mXQC5do.qA4tudRowk7zMB5JGlLKJI4o3idmQGLKPbXcjGCJ
 7tErUBo44gy2WyrJhoxId0uk6ogYI2kAO9sfrOEB0zbI9Xr3nSXZBvgR2QJvyCUkzVJ9w2rNM_W1
 Krqz.oX3_LglZVA4pXlhV5jEZ4XA3N00W0AZJ3l1kWSNFx9kW6zR0jngucXZNcRGVkwlNkpwvaQM
 vsmXMdwLD4WM6NEjKWLjPZkxWSJ5jE.PA9PjhTi7J.vE-
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Tue, 12 Jul 2022 15:10:53 +0000
Received: by hermes--production-bf1-58957fb66f-p6kcj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e0593cb1e20b98e2a34ab7885caed5d9;
          Tue, 12 Jul 2022 15:10:46 +0000 (UTC)
Message-ID: <3b228e55-53b6-beb8-7822-af03e65a078b@netscape.net>
Date:   Tue, 12 Jul 2022 11:09:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>
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
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <45fd7ade-61fe-18fa-aacc-ed80fdf3fb8d@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2022 9:32 AM, Juergen Gross wrote:
> On 12.07.22 15:22, Chuck Zmudzinski wrote:
> > On 7/12/2022 2:04 AM, Jan Beulich wrote:
> >> On 11.07.2022 19:41, Chuck Zmudzinski wrote:
> >>> Moreover... (please move to the bottom of the code snippet
> >>> for more information about my tests in the Xen PV environment...)
> >>>
> >>> void init_cache_modes(void)
> >>> {
> >>>      u64 pat = 0;
> >>>
> >>>      if (pat_cm_initialized)
> >>>          return;
> >>>
> >>>      if (boot_cpu_has(X86_FEATURE_PAT)) {
> >>>          /*
> >>>           * CPU supports PAT. Set PAT table to be consistent with
> >>>           * PAT MSR. This case supports "nopat" boot option, and
> >>>           * virtual machine environments which support PAT without
> >>>           * MTRRs. In specific, Xen has unique setup to PAT MSR.
> >>>           *
> >>>           * If PAT MSR returns 0, it is considered invalid and emulates
> >>>           * as No PAT.
> >>>           */
> >>>          rdmsrl(MSR_IA32_CR_PAT, pat);
> >>>      }
> >>>
> >>>      if (!pat) {
> >>>          /*
> >>>           * No PAT. Emulate the PAT table that corresponds to the two
> >>>           * cache bits, PWT (Write Through) and PCD (Cache Disable).
> >>>           * This setup is also the same as the BIOS default setup.
> >>>           *
> >>>           * PTE encoding:
> >>>           *
> >>>           *       PCD
> >>>           *       |PWT  PAT
> >>>           *       ||    slot
> >>>           *       00    0    WB : _PAGE_CACHE_MODE_WB
> >>>           *       01    1    WT : _PAGE_CACHE_MODE_WT
> >>>           *       10    2    UC-: _PAGE_CACHE_MODE_UC_MINUS
> >>>           *       11    3    UC : _PAGE_CACHE_MODE_UC
> >>>           *
> >>>           * NOTE: When WC or WP is used, it is redirected to UC- per
> >>>           * the default setup in __cachemode2pte_tbl[].
> >>>           */
> >>>          pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
> >>>                PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
> >>>      }
> >>>
> >>>      else if (!pat_bp_enabled) {
> >>>          /*
> >>>           * In some environments, specifically Xen PV, PAT
> >>>           * initialization is skipped because MTRRs are
> >>>           * disabled even though PAT is available. In such
> >>>           * environments, set PAT to initialized and enabled to
> >>>           * correctly indicate to callers of pat_enabled() that
> >>>           * PAT is available and prevent PAT from being disabled.
> >>>           */
> >>>          pat_bp_enabled = true;
> >>>          pr_info("x86/PAT: PAT enabled by init_cache_modes\n");
> >>>      }
> >>>
> >>>      __init_cache_modes(pat);
> >>> }
> >>>
> >>> This function, patched with the extra 'else if' block, fixes the
> >>> regression on my Xen worksatation, and the pr_info message
> >>> "x86/PAT: PAT enabled by init_cache_modes" appears in the logs
> >>> when running this patched kernel in my Xen Dom0. This means
> >>> that in the Xen PV environment on my Xen Dom0 workstation,
> >>> rdmsrl(MSR_IA32_CR_PAT, pat) successfully tested for the presence
> >>> of PAT on the virtual CPU that Xen exposed to the Linux kernel on my
> >>> Xen Dom0 workstation. At least that is what I think my tests prove.
> >>>
> >>> So why is this not a valid way to test for the existence of
> >>> PAT in the Xen PV environment? Are the existing comments
> >>> in init_cache_modes() about supporting both the case when
> >>> the "nopat" boot option is set and the specific case of Xen and
> >>> MTRR disabled wrong? My testing confirms those comments are
> >>> correct.
> >>
> >> At the very least this ignores the possible "nopat" an admin may
> >> have passed to the kernel.
> > 
> > I realize that. The patch I proposed here only fixes the regression. It
> > would be easy to also modify the patch to also observe the 'nopat"
> > setting. I think your patch had a force_pat_disable local variable that
> > is set if pat is disabled by the administrator with "nopat." With that
> > variable available, modifying the patch so in init_cache_modes we have:
> > 
> >       if (!pat || force_pat_disable) {
> >           /*
> >            * No PAT. Emulate the PAT table that corresponds to the two
> > 
> > Instead of:
> > 
> >       if (!pat) {
> >           /*
> >            * No PAT. Emulate the PAT table that corresponds to the two
> > 
> > would cause the kernel to respect the "nopat" setting by the administrator
> > in the Xen PV Dom0 environment.
>
> Chuck, could you please send out a proper patch with your initial fix
> (setting pat_bp_enabled) and the fix above?
>
> I've chatted with Boris Petkov on IRC and he is fine with that.

That's great, I will submit a formal patch later today.

>
> > I agree this needs to be fixed up, because currently the code is very
> > confusing and the current variable names and function names do not
> > always accurately describe what they actually do in the code. That is
> > why I am working on a patch to do some re-factoring, which only consists
> > of function and variable name changes and comment changes to fix
> > the places where the comments in the code are misleading or incomplete.
>
> Boris and I agreed to pursue my approach further by removing the
> dependency between PAT and MTRR and to make this whole mess more
> clear.
>
> I will start to work on this as soon as possible, which will
> probably be some time in September.

Good, I will look for your patches and try them out.

>
> > I think perhaps the most misnamed variable here is the  local
> > variable pat_disabled in memtypes.c and the most misnamed function is the
> > pat_disable function in memtypes.c. They should be named pat_init_disabled
> > and pat_init_disable, respectively, because they do not really disable
> > PAT in
> > the code but only prevent execution of the pat_init function. That
> > leaves open
> > the possibility for PAT to be enabled by init_cache_modes, which actually
> > occurs in the current code in the Xen PV Dom0 environment, but the current
> > code neglects to set pat_bp_enabled to true in that case. So we need a patch
> > to fix that in order to fix the regression.
>
> In principle I agree, but you should be aware of my refactoring plans.

I will defer to you and stop working on this re-factoring effort, but I
will prepare a formal patch to fix the regression later today.

I do think Jan's point about respecting the administrator's "nopat" setting
should also be considered. AFAICT, the "nopat" option in current code
is also not being respected on the bare metal, and the patch to
init_cache_modes with a force_no_pat variable is also needed to
ensure "nopat" is respected on the bare metal, AFAICT.

Best Regards,

Chuck
