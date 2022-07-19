Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB457A1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbiGSOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiGSOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:34:46 -0400
Received: from sonic307-55.consmr.mail.gq1.yahoo.com (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1C1CFC8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1658240803; bh=0MCR8ztNVvXBqIPyv/idSIbRg9uzDbj24OkajSfymqY=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=Z3k1/SJIzrZYrmbOX1dBbaf5GPEKHP9SIlbBvRQlqBjd8qMjN/2mF7XRPzfHAbxlmURUBwF5s5RI6+x316ZZpLkLk5e8Eu63arS8GgpUfxv3qs0+kJMCF+XL++omqVMKJXY05rIIue4WPv+uZJoi0BQjIoNZ8HVPWuF/zUjyI7Sg/4LD4pAW0Hud6OIkN5f5fBXX8Kv9+iodyZwQNK0ebnPwk1kchQpcrS0K5YPlRhbpz6Mv7x5htlA0KyUVm9cZsXJbVeoT9lijfAGPEiDRWImhzrz0LkvD844VI8FxMilexZ6roqaALnwSahB/eQ8f3muNnR6y/rO+H1Q92jwqvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1658240803; bh=prMMb/82heNYdPl8col/mQCTUTYLA2n+jBI4we748yI=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=PXDSqxBhUqlwJ479JUvc/OkXo87eA2EEDdZ0OgsoauJScchd8YyBSp/YMrYVHro8a8bBIhBTykGItbHbW7MMF5gZrSx3uBA7uTU5/taPrnANWu/LAfYW2Y31lcjoZACWbOIpeXyUhzgGaOxViSAvoNzb5K4/W1cXrUw/hktCFsyDW8lMC4TvP3pfzFfBqZlDHR6e00rAI0Buub08vGArUAkHytVsPVxwkgNOziLAs/Q/aYHHX/92rcB+2H/ezAlqcKx23fymfTPIJ1UGBbG2MW+yos2nEwNRhebgrKewXVKQA2Oowrh3azQWKSjAH8dH5PB2p23de2SREOEaSIehuw==
X-YMail-OSG: GyAknA4VM1kx2hr044yAhCFakR.BiMo_KCi1aa1GGZVgj47vNFVX2KVm5iDUEFP
 QBdv0weC5482CAyl_reJrQeG7yhskjldBgFPnX6gi5Zt0H23wjVn08.AKrv9fxduJj1vTPqIGFJC
 P6VRJ5uFKnLmRC5FbZqJbxFoVNdNBCHC2gKWKxdq3RsM5n9cyFDnQnK.Kn0.Pk9Ug.j7iEOS2f9e
 04jepfROKgV3LSQtuBFB9JiJ6_QbDXo7Z8OoGkMFEAqtNhXAxnQyyzcHD4q.Mc3ZWQZRlQx4BmwZ
 na7vGEY93Q72xg.gQGt3OjRbP9rHnHPVOunGQy82lLOPhe1.menmI.4iYiPd6sgQ62Ng95Sxdwep
 7YplzMHSl5ZkYQkdrw99l1_CdeoINsCmUH_T2X1pwCGMcIEScz4BnDVseOWHTFlMELqS_OLywuRF
 yuhKryGQjDgpEsMIv2ASWN5QgKiISbQdtSmCKOUh_BnH3UBok6pBuIR8bj6m9QS2_zevXfGHiFPd
 P7b7Gy5DTz_bBh9ELpcGVGupqSZjF5BHx9r4F_YvEL3sPgrRuurMhgT.xks5mcb0XQD.ypbUbnCK
 pPZKp..QoZPYjWwq3Zy_unTauYc092g6h7AgtX022cBlfpwNyK55.KB0sXEdHAeihT5a_aKpnTAl
 6CmaxqWzR_skPl19hHtrfVvC8xmJwPyQxr6DeZOAXDP7PST6inAkyROyytSyVQA47dvi.AzWo4F6
 HuI2zMHolHgkocRl.3UQQ7Rk6ftZ1OTCsrlCrwzKN4ZpyPrOrutBDiYx0JpZYDipMfPXXL0Sp1iR
 dxecP0SOs.DRrNqkrYBTrd13.rRiA_Nfx6OPYkGIM4NCSMEMkm6vydRQDIEG5MM6Czdq53O937CV
 tWls6IqkwMHGvFManTX5wR24_Ow9y5UzCFa6zG2EOXdovq_1TF2JBoq8GOjeZgZHvKljWxV4wYmt
 AYBf9AirQQIRlzTovcuRuG0KDb9PNAntFpYnjpZlLfnQp4Q8KpX3tSPEbb9xR9V5wspdsUf_kVJS
 Rcmqm_T4hB7FGolwjYHOxUdftLx6.h8..h9HaP3GM0WRoO.WHOCFdIzuE3viSlnpZLW_QVModxIU
 kPp2dYNsqd5fhPNiWK01KOxKtV6jH.A_XCdXW7Yz.ZcoK1Y45cpxvj3bJSW0KXj8Vpf566nn1TaY
 sDQzkqgwhW5bNXFJJZkq97FcqZaXGfsCEQr57ckaxV7EV6W6PVK_Baow1FCAcTq3Ds9En3VM_nhL
 P5DhFhvSCAD.7DrCPEkDxraKn4XA_RY53p20snBga7NMYjqX9h2EZDXqUxyoxYyrwoswumb37_Wa
 TRZE.SjiIDiuY6yTL8CRpKrZLxFAkEwmnnwmdWGmqeQvYRdRn1KzTroB3nyfh_A3TbBFllUvJ3Bu
 cMiW.Gkp8172fijKqa7OVLjmltJKgTW4js3zHm8sU_xVMrwy_zfGoCNlw3El2vLw32GeTXoqzVnu
 VXdgXvDEw4SfkIk6rBnkL47Zi95Cy4QIetKfg3ywIkYGWVs9ZI0XxIaOFzYO_HrqlBZ8XYw.JXHa
 Wp0LK3oob4utMS3pr81QkDQ0QkcjB.yNOnA9ookCXhJyeDhjnjdPjxTu5kOWgoZafzQUc66nroal
 _NUpYCDB9xGEMDj0ESfRZHyslut8FOYa865RZZ1KZZ1st86xczDzl.24gS1opmAlPN5vCuaXjLGd
 0ihIrsBWEADnSRmLuxNlsSmuIkOWzv_pDu1LtIMSaAxUy6d9TJ5gfdLHL7WXddNGBt.BbJbvTSj5
 EFACuylD3.ASK.7J29Og4x_y4gFGrRaQFwWhaKDg6I.FzLCRsHCUNugN1176q7a94Tx4ts6j9.IG
 1mPzfpNdx0AunF8y0vl9dhhdqzq564gZFshrBjSDbCfIlXEUHNDdOt2TnOuk_AN0q7nsRn5V5zcU
 aiGrNYcmt1yTRDF4fk8C7fKLFQaklfFkOIwrgwVUBPkDLws9en8hRpgdR7UI0JK6UkPAA0PWwktA
 70r6OGbOBCJppoxtEXoUQBjbTVHLFmwJIs6f_3uQAF.7NWM0GGvEE9NuWo2r7gvQluSVvRjW6Ji_
 .tUFXl8SnC34We6uYhEYB3nmDLX97eDjLsJPTuYKikdnmRX96HghKnqsXXlXxxZRgt3FuexlOAUK
 UVMvfK9fn8oQ84KcNbgYds0HCEZJIfmtPMwpEQJ1hTWVAsO5x3eilTOEfWF0.WjPuw_NLCWYZdkg
 W8ioE52OkZ.N18NN7rbedB6Q1rh3fSw--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Tue, 19 Jul 2022 14:26:43 +0000
Received: by hermes--production-ne1-7864dcfd54-xmlhn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b8ca309c635e58bb59d98f5d4af24c5c;
          Tue, 19 Jul 2022 14:26:39 +0000 (UTC)
Message-ID: <786efd9f-d8fc-7235-7c1c-e0e90d1640be@netscape.net>
Date:   Tue, 19 Jul 2022 10:26:36 -0400
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
 <1a486b6d-037e-ac54-4279-286b4ae9452e@netscape.net>
 <a13b8cdd-8e9f-a917-9e61-1ce6eee8da1c@netscape.net>
In-Reply-To: <a13b8cdd-8e9f-a917-9e61-1ce6eee8da1c@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2022 6:45 PM, Chuck Zmudzinski wrote:
> On 7/14/2022 6:33 PM, Chuck Zmudzinski wrote:
> > On 7/14/2022 1:17 PM, Chuck Zmudzinski wrote:
> > > On 7/5/22 6:57 AM, Thorsten Leemhuis wrote:
> > > > [CCing tglx, mingo, Boris and Juergen]
> > > >
> > > > On 04.07.22 14:26, Jan Beulich wrote:
> > > > > On 04.07.2022 13:58, Thorsten Leemhuis wrote:
> > > > >> On 25.05.22 10:55, Jan Beulich wrote:
> > > > >>> On 28.04.2022 16:50, Jan Beulich wrote:
> > > > >>>> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
> > > > >>>> with pat_enabled()") pat_enabled() returning false (because of PAT
> > > > >>>> initialization being suppressed in the absence of MTRRs being announced
> > > > >>>> to be available) has become a problem: The i915 driver now fails to
> > > > >>>> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
> > > > >>>> located the induced failure), and its error handling is flaky enough to
> > > > >>>> (at least sometimes) result in a hung system.
> > > > >>>>
> > > > >>>> Yet even beyond that problem the keying of the use of WC mappings to
> > > > >>>> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
> > > > >>>> graphics frame buffer accesses would have been quite a bit less
> > > > >>>> performant than possible.
> > > > >>>>
> > > > >>>> Arrange for the function to return true in such environments, without
> > > > >>>> undermining the rest of PAT MSR management logic considering PAT to be
> > > > >>>> disabled: Specifically, no writes to the PAT MSR should occur.
> > > > >>>>
> > > > >>>> For the new boolean to live in .init.data, init_cache_modes() also needs
> > > > >>>> moving to .init.text (where it could/should have lived already before).
> > > > >>>>
> > > > >>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > > > >>>
> > > > >>> The Linux kernel regression tracker is pestering me because things are
> > > > >>> taking so long (effectively quoting him), and alternative proposals
> > > > >>> made so far look to have more severe downsides.
> > > > >>
> > > > >> Has any progress been made with this patch? It afaics is meant to fix
> > > > >> this regression, which ideally should have been fixed weeks ago (btw:
> > > > >> adding a "Link:" tag pointing to it would be good):
> > > > >> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
> > > > >>
> > > > >> According to Juergen it's still needed:
> > > > >> https://lore.kernel.org/lkml/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
> > > > >>
> > > > >> Or was a different solution found to fix that regression?
> > > > > 
> > > > > No progress and no alternatives I'm aware of.
> > > >
> > > > Getting closer to the point where I need to bring this to Linus
> > > > attention. I hope this mail can help avoiding this.
> > > >
> > > > Jan, I didn't follow this closely, but do you have any idea why Dave,
> > > > Luto, and Peter are ignoring this? Is reverting bdd8b6c98239 a option to
> > > > get the regression fixed? Would a repost maybe help getting this rolling
> > > > again?
> > >
> > > Hi, Thorsten,
> > >
> > > Here is a link to the hardware probe of my system which exhibits
> > > a system hang before fully booting with bdd8b6c98239. Without
> > > bdd8b6c98239, the problem is gone:
> > >
> > > https://linux-hardware.org/?probe=32e615b538
> > >
> > > Keep in mind this problem is not seen with bdd8b6c98239
> > > on the bare metal, but only when running as a traditional Dom0
> > > PV type guest on Xen. I don't know see the problem on Xen HVM
> > > DomU, and I have not tested it on Xen PVH DomU, Xen PV DomU,
> > > or the experimental Xen PVH Dom0.
> >
> > Update: On affected hardware, you do not need to run in a
> > Xen PV Dom0 to see the regression caused by bdd8b6c98239.
> >
> > All you need to do is run, on the bare metal, on the affected
> > hardware, with the Linux kernel nopat boot option.
> >
> > Jan mentions in his commit message the function in the i915
> > driver that was touched by bdd8b6c98239 and that causes this
> > regression. That is, any Intel IGD that needs to execute the
> > function that Jan mentions in the commit message of his
> > proposed patch when the i915 driver is setting up the graphics
> > engine will most likely be hardware that is affected. My Intel
> > IGD was marketed as HD Graphics 4600, I think.
> >
> > So find an a system with these hardware characteristics, and
> > try running, with the nopat option, the Linux kernel, with
> > and without bdd8b6c98239. You will see the regression I
> > am experiencing, I predict.
>
> This raises a disturbing question: The commit message of
> bdd8b6c98239 mentions the nopat option. It does not specify what
> effect the commit was supposed to have on system
> with the nopat option, but the actual effect on the system,
> both with the seldom used nopat option and in Xen PV Dom0,
> a nasty regression on some older Intel IGD devices. My question:
>
> Was this intentional? Or just grossly incompetent? Any other
> possibilities?

After reading more of the discussions on lkml, I suppose Intel
decided a regression affecting older Intel IGDs running on Xen
would not affect enough users to cause a serious problem.
I just happen to be one of the few users affected by it. I
understand I cannot expect Intel to support its older devices
forever, even if Linus' regression rule would seem to suggest
that on Linux older devices need to continue to be supported
for as long as is reasonably possible. In any case, I can see that
efforts are still underway to fix this regression, not from Intel,
but from maintainers of x86 and Xen kernel code, and that is
what is necessary if the Linus regression rule applies even when
just a few users are affected by a regression. While waiting for a
fix in the mainline kernel, affected users can revert bdd8b6c98239
on top of the released kernel versions as the most simple
workaround for this regression.

Chuck

>
> I think you should definitely notify Linus about this if you can
> verify the story I am telling here.
>
> Chuck
>
> >
> > Chuck
> >
> > >
> > > You can probably verify yourself that reverting bdd8b6c98239
> > > fixes the regression if you try to reproduce the regression with
> > > any Linux version that has bdd8b6c98239 or its equivalent on
> > > the stable branches with a hardware profile similar to the link
> > > to the profile of my machine which exhibits the problem. Mine
> > > is a Haswell core-i5 4590S CPU and ASRock B85M-Pro4
> > > motherboard.
> > >
> > > Also, other notes:
> > >
> > > 1. Yes, AFAICT, Marek at Qubes OS is the first to report the problem.
> > > 2. Juergen Gross' work to try to fix this has been helpful, but none
> > > of his posted patches has fixed the regression on my system.
> > > 3. Jan's patch fixes it also, and so do the two patches I posted to lkml
> > > earlier this week to the appropriate maintainers.
> > > 4. On the pkg-xen-devel mailing list, which is public, this issue was
> > > briefly discussed where I first reported it. Someone there said they
> > > did not see the issue with Broadwell Xeons. Mine is a Haswell core i5,
> > > which is one generation older than Broadwell, so you are most likely
> > > to be able to reproduce the problem with a Haswell core i5 desktop
> > > system like my ASRock system, which was my own private build
> > > which has been working fine for eight years until Linux 5.17.y.
> > >
> > > Hope this helps.
> > >
> > > Chuck
> > >
> > > > BTW, for anyone new to this, Jan's patch afaics is supposed to fix the
> > > > regression reported here:
> > > > https://lore.kernel.org/all/YnHK1Z3o99eMXsVK@mail-itl/
> > > >
> > > > Side note: Juergen Gross recently posted related patches in this code
> > > > area to fix some other problems (regressions?), but his efforts look
> > > > stalled, too:
> > > > https://lore.kernel.org/all/ddb0cc0d-cefc-4f33-23f8-3a94c7c51a49@suse.com/
> > > >
> > > > And he recently stated this Jan's patch is still needed, even if his
> > > > changes make it in.
> > > > https://lore.kernel.org/all/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
> > > >
> > > > This from my point all looks a bit... unsatisfying. :-/
> > > >
> > > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > > >
> > > > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > > > reports and sometimes miss something important when writing mails like
> > > > this. If that's the case here, don't hesitate to tell me in a public
> > > > reply, it's in everyone's interest to set the public record straight.
> > >
> >
> >
>

