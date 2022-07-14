Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC745757B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbiGNWdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGNWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:33:34 -0400
Received: from sonic306-21.consmr.mail.gq1.yahoo.com (sonic306-21.consmr.mail.gq1.yahoo.com [98.137.68.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FC71BCC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657838011; bh=QXJxK9uRHPgeJRYwYqRfbGAEL0vbJkn+fNS92crcabw=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=SrT8orGXGXfdlnw18KfQ6xiDEMi1bWINravl/lGmRyFYTsbGoBPJSb5FLtNWlDqfID1gVSPFqe84lzpKmUtt00FK+IhmjIHXGXSi0LkKW0ZAj3+IXQf78uSQPajb80E9OBIxyB/e47VbMHx6nU3SupOwWxtsJevwoyTU8Q+gR4OE3ic97VP8WSuR7/0+Jp7q5SEG82NQHL4I8Cu4wfrE7R9/2/r0gtWCMpOf5W8segQhYm/KMpxjxo6ZWIeogSKFVOmupwHi55+Uph1cMOnhaIUS5bL47ik5htW0Wz0YCj81+ANo/J3yQup5SZ0UNr5843QvkLoT5/Z2dkEG7xKn0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657838011; bh=5EH6pEyDHX14H2TfJ4h1fCsU95bY0bgSM0NUqADtoMo=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=anMbBvXEVzp1zpYaTS+WzCGGdkS3ySaGB/nmk72ujHZywg8Abul9wnx8Nxw8APiFMEBi8HofXG3bY4Z9RqxTLkeW81CTOkJ737hidIp8DVYeYPkff+0SnLCq9r4P8ah5bqYcqm/WJKCIH3aAgcOT5AEnnUiO44NWiN+7MndwU6sJdPWjzoAIlx85fpDfvfPv2LLNxIdCP/kmax3EWwV9x5GvC4GjpmKNucePsNe2QQqbkLWNnUuHs0E4fF5etDB3MFFJwtLHfNnlGrAEBBhRh9PuJ0UpIUfRTvGVbOaE3Cb2FhBHDptbj14nsnD6fFQtuOcXHzUoRzsuxB1E4WIQeQ==
X-YMail-OSG: 7LiRrc0VM1mpINPlx9OtkbZVhtIdlEu.6jc1MF2_AlHiYGU0IvI5LM8aIsRrE4U
 dZA3WYXohky5mb.HQ6NPcyk8dnsqQRbpe_Uj2eiMJmyGznOZenH7LyFDNUpVRuNEbFPA5MiDn1JY
 NUCfYQP.isyvQk_sYaH.oN.ce1r2v5uoMGBfByQqpXFtNacsVBBzqaM3bOGXoF.YE8P_HWdjWt5O
 VnWL26UMHwP_sgTU6t1Xh56sfcBRzdlgDl7zE2.eLia5ujeqg92UK.BmBZufttMz2mnPuzOJx3PS
 5HsEIWLGOEA.GahB.pV8aB9FRPWhBJufsSxop6pUBIeeVqt7jAP94pyRVNYv58Q3CRVAs9722AT2
 VpnEjTc2FkwKecdBf04k9bg_rnps7jWMDdAoMbKjp7xmSQdKPYRYwOwneLa3XxiKHem.AC1cPQa4
 sIC4d6h.5rc6aejrnp7dOHzLBoLiYPPII9JOSRp30AMEAs89BIBJh6uYDNQ7NI1JkDp_U71cfUQ4
 c6s6wH6tMjdA7UomXWZfG7chxnvVBwUdSt95DWUp1roNJ9gT6WXVCwwWW6VCm.8p8QWZULOCsCQa
 ekqYeF.eqFbTRH8xTAaaSpeK797v7H.Sjwi8J6nsMyZIKtAWsVO7VntlP9t1G7_lQ.Nq52UeieCp
 0lb09R6k.EzeevL9amiE4itDq35YjL71VYdvwJHQzJH0lMlpqK39vNftIKkRVLeZDv53jqhZz9pB
 F4fBBRH_BZk.u79YrPUeiVpnoR3hqhtLCit6JiewR3mAwS_5.cd_bTc5K59ZgbPPTWw9mmz6YT5q
 hR77zAuvfVDYf1WkAa4zVN86MBgNN9tl2UDhlnAKfkPwxz.5eL6r4TSe.ViigS8MMKamJaCoqvDh
 hge8PrOSbtQbyDieAQV.TLUBLv0kSdUoE.DRkSW1v.sbxNMoYtIE0UGRydeDtgJCPPWGG7yZt0yZ
 Y0VRcD.i8mER_ZLyvDx8m0RAvAnIBuGMrgKDJDNFCrvkTv9Q4HX4sluYFkHgONKpE0M5b8jj7szP
 xq_CmFuEHX_4Ip3WloXAHR8mI4qmZvvKVieh0k8eDcYZhE48._Ri.u.bFwokKpLX4IntLpz2hg5_
 4Ese1tgx1CrWI4qqRWlP.b_hiR1rfjOUU0eK0YzIeNGW48nGeRzRVeUI9SD06s9WKiqyV0pKD4Ce
 E0kDss17PM8OJGFdVzxKFl0WFjK5PAEBiMXokDnytF9Dmyn5tEK7tyTtVCSQFpHgxiRUDVnWcFH1
 JyOU7vMxVQJ9rBq6omrhI62kWoIgziIFzI1L08NyT_RJ_qvbq.JTeTp7g4hbBMoUoULHz0YsRLCw
 I5XTyPmrtelZRvXAlpKQDo_UrlT7Rm6Uq7gz0ZwvdMxL1fG2fMG.wEgnKYPd.7RmF5Crun2Pzqls
 poNalRcNlM7dvoRSpwfsZke2EHZzW0T4v3IPObjeW_nzQXlpCJog8LDfJIGrQYCKX1PDEBdtgf3O
 Pr2pqHNXprkwnugK9S1BZDSQNN1j090_ExqdZvVEK8ut4tv3zJxRPC3jssR0FspbDJYlsBMolXUs
 YLcIcG7pUCM1lyF1Yq2ZG2smQykkjdVMi_dYZG0488TXPflOlvdy4g7Dn6IiN1RiIPqyhxfpMuHU
 QCvF6OzK_uisToqLAtCDsShqt4NflKLv6arQFcGkYm2QLb1N6_vlM8IYbtWVNIZnPAR4s8hiXFXg
 u3D.b9R.LEsXy65AMvv_sQ2ZkIkSbLAi_sDOwnENgUdJC6MIqrQ1oX2JGGaRm6oGtXLhsw2pMAxk
 aVCdp4eUsjEbmNGTqWCblmHWZwkwEH1pND7PdPzHWvmNtE3R4r1dAPL.lTn54SoscY5UNsUzDG4Q
 gnCqwMqHwMdPyBjYHUgjU6YtZ4oGcmRlsxgtOdU7_yg.rCjpX6BeJiiYlERcDzL0glxM0_G..BKK
 mgemFArKIq.9CD1rOBb9mpN.rklqSfJ01HbiZgr0amafF2rCI2VB3DMG.IPxQP20pL3U1bpRfh2z
 javnaR9dbAqlDUOD2YaGoCRHozthmk115.9NueZYuK9h2DeOiqJECug12FygH1UiJgWOE_0c_kpB
 76wDsk.ppOgEvDqCK85s8BJkWGeUs0J4FBPqCNjO_YW2VBVFja2bRJKdz8TiHhYNTXJV3mhDRPtZ
 tTdL_iWD3WicNXZkwKy1q_pkcGAnNOt3fg_8N9npv7yfO2c7vOmjmaPnyZujPoXHoid4Jy6oJwki
 uQSc90ySOEP6uZqnuWkPFiQ6U
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Thu, 14 Jul 2022 22:33:31 +0000
Received: by hermes--production-ne1-7864dcfd54-q5j27 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 97517d2a66b128664f6173582b24cba9;
          Thu, 14 Jul 2022 22:33:26 +0000 (UTC)
Message-ID: <1a486b6d-037e-ac54-4279-286b4ae9452e@netscape.net>
Date:   Thu, 14 Jul 2022 18:33:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Ping: [PATCH] x86/PAT: have pat_enabled() properly reflect state
 when running on e.g. Xen
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jan Beulich <jbeulich@suse.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <dff7bcd3-affc-9272-81e9-d686d9c997d5@suse.com>
 <8756355c-b586-3d1b-531c-72a04a8c047a@leemhuis.info>
 <05b5e672-0a1b-2d00-a879-b5127a94973f@suse.com>
 <4c8c9d4c-1c6b-8e9f-fa47-918a64898a28@leemhuis.info>
 <eda0381b-fe6d-144b-76cd-d943082d70e0@netscape.net>
In-Reply-To: <eda0381b-fe6d-144b-76cd-d943082d70e0@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/14/2022 1:17 PM, Chuck Zmudzinski wrote:
> On 7/5/22 6:57 AM, Thorsten Leemhuis wrote:
> > [CCing tglx, mingo, Boris and Juergen]
> >
> > On 04.07.22 14:26, Jan Beulich wrote:
> > > On 04.07.2022 13:58, Thorsten Leemhuis wrote:
> > >> On 25.05.22 10:55, Jan Beulich wrote:
> > >>> On 28.04.2022 16:50, Jan Beulich wrote:
> > >>>> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
> > >>>> with pat_enabled()") pat_enabled() returning false (because of PAT
> > >>>> initialization being suppressed in the absence of MTRRs being announced
> > >>>> to be available) has become a problem: The i915 driver now fails to
> > >>>> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
> > >>>> located the induced failure), and its error handling is flaky enough to
> > >>>> (at least sometimes) result in a hung system.
> > >>>>
> > >>>> Yet even beyond that problem the keying of the use of WC mappings to
> > >>>> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
> > >>>> graphics frame buffer accesses would have been quite a bit less
> > >>>> performant than possible.
> > >>>>
> > >>>> Arrange for the function to return true in such environments, without
> > >>>> undermining the rest of PAT MSR management logic considering PAT to be
> > >>>> disabled: Specifically, no writes to the PAT MSR should occur.
> > >>>>
> > >>>> For the new boolean to live in .init.data, init_cache_modes() also needs
> > >>>> moving to .init.text (where it could/should have lived already before).
> > >>>>
> > >>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > >>>
> > >>> The Linux kernel regression tracker is pestering me because things are
> > >>> taking so long (effectively quoting him), and alternative proposals
> > >>> made so far look to have more severe downsides.
> > >>
> > >> Has any progress been made with this patch? It afaics is meant to fix
> > >> this regression, which ideally should have been fixed weeks ago (btw:
> > >> adding a "Link:" tag pointing to it would be good):
> > >> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
> > >>
> > >> According to Juergen it's still needed:
> > >> https://lore.kernel.org/lkml/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
> > >>
> > >> Or was a different solution found to fix that regression?
> > > 
> > > No progress and no alternatives I'm aware of.
> >
> > Getting closer to the point where I need to bring this to Linus
> > attention. I hope this mail can help avoiding this.
> >
> > Jan, I didn't follow this closely, but do you have any idea why Dave,
> > Luto, and Peter are ignoring this? Is reverting bdd8b6c98239 a option to
> > get the regression fixed? Would a repost maybe help getting this rolling
> > again?
>
> Hi, Thorsten,
>
> Here is a link to the hardware probe of my system which exhibits
> a system hang before fully booting with bdd8b6c98239. Without
> bdd8b6c98239, the problem is gone:
>
> https://linux-hardware.org/?probe=32e615b538
>
> Keep in mind this problem is not seen with bdd8b6c98239
> on the bare metal, but only when running as a traditional Dom0
> PV type guest on Xen. I don't know see the problem on Xen HVM
> DomU, and I have not tested it on Xen PVH DomU, Xen PV DomU,
> or the experimental Xen PVH Dom0.

Update: On affected hardware, you do not need to run in a
Xen PV Dom0 to see the regression caused by bdd8b6c98239.

All you need to do is run, on the bare metal, on the affected
hardware, with the Linux kernel nopat boot option.

Jan mentions in his commit message the function in the i915
driver that was touched by bdd8b6c98239 and that causes this
regression. That is, any Intel IGD that needs to execute the
function that Jan mentions in the commit message of his
proposed patch when the i915 driver is setting up the graphics
engine will most likely be hardware that is affected. My Intel
IGD was marketed as HD Graphics 4600, I think.

So find an a system with these hardware characteristics, and
try running, with the nopat option, the Linux kernel, with
and without bdd8b6c98239. You will see the regression I
am experiencing, I predict.

Chuck

>
> You can probably verify yourself that reverting bdd8b6c98239
> fixes the regression if you try to reproduce the regression with
> any Linux version that has bdd8b6c98239 or its equivalent on
> the stable branches with a hardware profile similar to the link
> to the profile of my machine which exhibits the problem. Mine
> is a Haswell core-i5 4590S CPU and ASRock B85M-Pro4
> motherboard.
>
> Also, other notes:
>
> 1. Yes, AFAICT, Marek at Qubes OS is the first to report the problem.
> 2. Juergen Gross' work to try to fix this has been helpful, but none
> of his posted patches has fixed the regression on my system.
> 3. Jan's patch fixes it also, and so do the two patches I posted to lkml
> earlier this week to the appropriate maintainers.
> 4. On the pkg-xen-devel mailing list, which is public, this issue was
> briefly discussed where I first reported it. Someone there said they
> did not see the issue with Broadwell Xeons. Mine is a Haswell core i5,
> which is one generation older than Broadwell, so you are most likely
> to be able to reproduce the problem with a Haswell core i5 desktop
> system like my ASRock system, which was my own private build
> which has been working fine for eight years until Linux 5.17.y.
>
> Hope this helps.
>
> Chuck
>
> > BTW, for anyone new to this, Jan's patch afaics is supposed to fix the
> > regression reported here:
> > https://lore.kernel.org/all/YnHK1Z3o99eMXsVK@mail-itl/
> >
> > Side note: Juergen Gross recently posted related patches in this code
> > area to fix some other problems (regressions?), but his efforts look
> > stalled, too:
> > https://lore.kernel.org/all/ddb0cc0d-cefc-4f33-23f8-3a94c7c51a49@suse.com/
> >
> > And he recently stated this Jan's patch is still needed, even if his
> > changes make it in.
> > https://lore.kernel.org/all/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
> >
> > This from my point all looks a bit... unsatisfying. :-/
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >
> > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > reports and sometimes miss something important when writing mails like
> > this. If that's the case here, don't hesitate to tell me in a public
> > reply, it's in everyone's interest to set the public record straight.
>


