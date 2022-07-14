Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE95757CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbiGNWpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNWpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:45:18 -0400
Received: from sonic309-21.consmr.mail.gq1.yahoo.com (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086866AF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657838717; bh=82dHPxHVfQ14eG1W2sdvtK1J1D0zijc4Oov2w7XaO/I=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=h92Ne8t1w+CKrsgxM/GEldeMguYF4gOCATEwiq4hhPUWK1IIU02YW5EgSVHQWKJdAwxi/aYWqmY5Plo3MpYgsylVqdOmfy5fgLcvCg1dXiCVOkh7P5IqJGrfxqjnsDD+MyeQQocvIsDnvPXNSoSnsAh0a4x+JpygGwH9uAf4XBbkgGIu7CnE56iX9fRCTF4Sob+DVUbqRjONw1RCp4LFDRVwkj2RrhTWANClwYP0kUJOfKW16flygeLUFou9woXqX6ZkovL5JhoEHHyXaXYUwreY0s32FptY2eTtBq6VC8qVoLy69zH+RDTwFSKQZqV7i6a9tlQus/jONykPhSrVPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657838717; bh=TmBkStm0hBJ24ECMc/C3uaRtfT+qmAuIvDZZGQOe1ZS=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=XgMLdzxJKNCqLNlErV2aAgQ7rSWVE+G+1OPT2qpcPEcVCG0YihTh7K5mALean9d1KHKv5Z7BTyWyGoTQ1bSMDulCvEzmdlyjN5s1EdSD4APl0Zv8dR4KvTxyGggdveLxbHdSo4nDMy0pULu353+oFxE4ZCSqiStlj3Lga/vh3r45wwhZpQRschn30UjxQAS1/CJQd9bhG7rEk3gZOuwOsONV8V4aTUiF+5qTKdCwmifmnBUyjIhBNv8/Zdj58Ius0RXmxtgIeJD3N1VaPP9J+CSRVdl8/waT+WvnSKPiiBGQSNyZK3KT/zA+CLEirGXSwEKwSz3Gozjx9ln4iYKsLA==
X-YMail-OSG: Pzotum8VM1leh.sKkXQqcF1UiNJUYee6HDwjc0lyFFlu1O73oiWf1Nv..QzGrDj
 8AgRtCbiOcgoR3ypZEpyjkoVRmyu.D0aqA4FxIptgcip82L2wX9R7SWIKhOw2VQMCK8q1lpg.Utk
 mup3IRC9.IWYmAm.SV6TvOL_635OkocO.czf174XV8i8bxFtPj2DqICEk2Za4iFcKlaI2Jgcnspq
 sRddyMNsrRf2zt_5vVk8hZnMs2n2c_.EiR9D8cFiAEZf8cBYnKuMxmuDyInzPYJx8ux6_YU7vq9q
 0UIxoJlkbOgUpOZJvB.03eYWgKWkMiyZwTfelUqANBX7H5JYmkenDGE8SiQNbsHWVbBCbiy7omfd
 1SdqkAgEjJ5tWMNURCCFOl7peZSBLpXe67.WEkM0NefsUYX72yw_R5oXv67eqGOvt45H50n5NiT9
 6o6CxwDH3NVkGeGZa6ztsD5MHaDO_HmZMbsoaZKi0lzU3u691DBlceSD__rC11MoEQKf7ttK3F6y
 SBJaZg4mzaoLSHp9FJDmPJXufkWrFWYZOmdZZGpKylGF.zkSFF6xWbpyNu9Hek7.ZTU8yTBUUaP9
 i9d.UsQxSC7SIFCuOys.8CdXvahJ4p2xu2F1k07tjDqewjqPgzvfKoBtS_F1TDcRfALTDiYBdA.M
 fvFEgAGsz.FSst1t98T4clG6RaJSnn.df3ft82MVIYNVY8zeSxZkuPeHpfsEXttJhuALVpguxGqP
 f3E.Fue8sQZlhpH8uXL8jGTjEYWN5DV4AhC504wGRddvo9OqCPjcvA7ZYAOt5kicjq4mINbPpK7U
 yu62ltUDPXZIWVMTIPMROY4wMiPDnTSgi37lPAaa4Vv3iaq3T24gvoi6EyplaEFQB13Mh7rzg9Op
 h_qefxvmm1a_TybxTfTi1i6dcLgerzjUBObUSojtSBpXO90fBuawGSuZNKoUiZsEPuKdrbrurBz6
 wkhSvnyL27Jg.enLc_7mxI7mbm0JG_Qc4wNpStfdobc.Ftn9R7aOcmQi38MCx9jTEnfHLrAxFVTH
 sJ8F99TUAcfcui2gdHfAJqzCwsynr4Q_72zM8A6i_kzwngS3Gi6YCMb7l3rmTi2XSCznynL44g9D
 01RoKO6CnyeCOrPwONV.uIbuc7c7O_bdjF3WPKm_Pf_w6fcAehQi3fecVjmvUkEDF7OB3RT3yqGR
 N5yNc8e9mUdrXXrZKSnokaaLl0Llas5isSfUrtr4AGAry10G1bv2.NOFSjFhBHcWalaN8OiBC_JN
 A_DlERt0on2T06FXNEM0TR34.b46VzP.oy3e0rJvY07ZJ9leaaSrSd22AbP7JHGwnNKDyphsRCIF
 Tk61tHlOsuYMBrbxD2UWFzELnjcSCf4167n5zvN2HsPTTjveeaX.cwwCh0aiMIAkxZ6TNGLAgjWn
 CzNnoVqGFzqFzIg6qGhzq8Z4C6tS_h6e39hFovDsl1osqz7GpjQNbPn3bqHs31uXYFQeUPmSEnr4
 .SLCpfWjHPCMd9ryDT1iOpHzxAZG9_.yiSTf0h4d5Aj5QOGsoFGZbL9SN67FkBd85RW_i7is_BEj
 5cZaH7xPNIqb5BTDnJzD_AjA30Lvoc.f84zO8TXQDGP4nUZJzuYxT9Qxj0ZtV2ReM.D3Dvl8soT4
 WYk.xgG8xzGg5rbPzDg2u9aPg2TvIRU2KgON3IoHoIAka8rGbhEOBbHzI6kod7emcFrFf78bdKkP
 kvyHu7bhhrlN7PhKQStnDnxD8AXPQsM1IUfzm1a4vRH4yd0ZfkfovrB1LaTVcSO0t_kZGgRPO1m8
 2IqvvhL2Z64L4Xs737Rt46hngIek_dYKu1j73j_FavfjLUtLL_EIC66aukpUz2YcNkrJ_pX5gJkP
 FG26j1PDGqApGWiLvW9MsPgwEZe0bi9DidQadC4xl7LgoWjVh9TaRmUXReChwTBmaCW9FleL558O
 81mZa2ynfnStlgpR66sDUl1oMBsljgwXqkfkrjZDRWPfzXWU.rws-
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 14 Jul 2022 22:45:17 +0000
Received: by hermes--production-ne1-7864dcfd54-s2f4b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c27b74b8dd2814fc3bb62f87e7a5d5a;
          Thu, 14 Jul 2022 22:45:13 +0000 (UTC)
Message-ID: <a13b8cdd-8e9f-a917-9e61-1ce6eee8da1c@netscape.net>
Date:   Thu, 14 Jul 2022 18:45:11 -0400
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
In-Reply-To: <1a486b6d-037e-ac54-4279-286b4ae9452e@netscape.net>
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

On 7/14/2022 6:33 PM, Chuck Zmudzinski wrote:
> On 7/14/2022 1:17 PM, Chuck Zmudzinski wrote:
> > On 7/5/22 6:57 AM, Thorsten Leemhuis wrote:
> > > [CCing tglx, mingo, Boris and Juergen]
> > >
> > > On 04.07.22 14:26, Jan Beulich wrote:
> > > > On 04.07.2022 13:58, Thorsten Leemhuis wrote:
> > > >> On 25.05.22 10:55, Jan Beulich wrote:
> > > >>> On 28.04.2022 16:50, Jan Beulich wrote:
> > > >>>> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
> > > >>>> with pat_enabled()") pat_enabled() returning false (because of PAT
> > > >>>> initialization being suppressed in the absence of MTRRs being announced
> > > >>>> to be available) has become a problem: The i915 driver now fails to
> > > >>>> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
> > > >>>> located the induced failure), and its error handling is flaky enough to
> > > >>>> (at least sometimes) result in a hung system.
> > > >>>>
> > > >>>> Yet even beyond that problem the keying of the use of WC mappings to
> > > >>>> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
> > > >>>> graphics frame buffer accesses would have been quite a bit less
> > > >>>> performant than possible.
> > > >>>>
> > > >>>> Arrange for the function to return true in such environments, without
> > > >>>> undermining the rest of PAT MSR management logic considering PAT to be
> > > >>>> disabled: Specifically, no writes to the PAT MSR should occur.
> > > >>>>
> > > >>>> For the new boolean to live in .init.data, init_cache_modes() also needs
> > > >>>> moving to .init.text (where it could/should have lived already before).
> > > >>>>
> > > >>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> > > >>>
> > > >>> The Linux kernel regression tracker is pestering me because things are
> > > >>> taking so long (effectively quoting him), and alternative proposals
> > > >>> made so far look to have more severe downsides.
> > > >>
> > > >> Has any progress been made with this patch? It afaics is meant to fix
> > > >> this regression, which ideally should have been fixed weeks ago (btw:
> > > >> adding a "Link:" tag pointing to it would be good):
> > > >> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
> > > >>
> > > >> According to Juergen it's still needed:
> > > >> https://lore.kernel.org/lkml/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
> > > >>
> > > >> Or was a different solution found to fix that regression?
> > > > 
> > > > No progress and no alternatives I'm aware of.
> > >
> > > Getting closer to the point where I need to bring this to Linus
> > > attention. I hope this mail can help avoiding this.
> > >
> > > Jan, I didn't follow this closely, but do you have any idea why Dave,
> > > Luto, and Peter are ignoring this? Is reverting bdd8b6c98239 a option to
> > > get the regression fixed? Would a repost maybe help getting this rolling
> > > again?
> >
> > Hi, Thorsten,
> >
> > Here is a link to the hardware probe of my system which exhibits
> > a system hang before fully booting with bdd8b6c98239. Without
> > bdd8b6c98239, the problem is gone:
> >
> > https://linux-hardware.org/?probe=32e615b538
> >
> > Keep in mind this problem is not seen with bdd8b6c98239
> > on the bare metal, but only when running as a traditional Dom0
> > PV type guest on Xen. I don't know see the problem on Xen HVM
> > DomU, and I have not tested it on Xen PVH DomU, Xen PV DomU,
> > or the experimental Xen PVH Dom0.
>
> Update: On affected hardware, you do not need to run in a
> Xen PV Dom0 to see the regression caused by bdd8b6c98239.
>
> All you need to do is run, on the bare metal, on the affected
> hardware, with the Linux kernel nopat boot option.
>
> Jan mentions in his commit message the function in the i915
> driver that was touched by bdd8b6c98239 and that causes this
> regression. That is, any Intel IGD that needs to execute the
> function that Jan mentions in the commit message of his
> proposed patch when the i915 driver is setting up the graphics
> engine will most likely be hardware that is affected. My Intel
> IGD was marketed as HD Graphics 4600, I think.
>
> So find an a system with these hardware characteristics, and
> try running, with the nopat option, the Linux kernel, with
> and without bdd8b6c98239. You will see the regression I
> am experiencing, I predict.

This raises a disturbing question: The commit message of
bdd8b6c98239 mentions the nopat option. It does not specify what
effect the commit was supposed to have on system
with the nopat option, but the actual effect on the system,
both with the seldom used nopat option and in Xen PV Dom0,
a nasty regression on some older Intel IGD devices. My question:

Was this intentional? Or just grossly incompetent? Any other
possibilities?

I think you should definitely notify Linus about this if you can
verify the story I am telling here.

Chuck

>
> Chuck
>
> >
> > You can probably verify yourself that reverting bdd8b6c98239
> > fixes the regression if you try to reproduce the regression with
> > any Linux version that has bdd8b6c98239 or its equivalent on
> > the stable branches with a hardware profile similar to the link
> > to the profile of my machine which exhibits the problem. Mine
> > is a Haswell core-i5 4590S CPU and ASRock B85M-Pro4
> > motherboard.
> >
> > Also, other notes:
> >
> > 1. Yes, AFAICT, Marek at Qubes OS is the first to report the problem.
> > 2. Juergen Gross' work to try to fix this has been helpful, but none
> > of his posted patches has fixed the regression on my system.
> > 3. Jan's patch fixes it also, and so do the two patches I posted to lkml
> > earlier this week to the appropriate maintainers.
> > 4. On the pkg-xen-devel mailing list, which is public, this issue was
> > briefly discussed where I first reported it. Someone there said they
> > did not see the issue with Broadwell Xeons. Mine is a Haswell core i5,
> > which is one generation older than Broadwell, so you are most likely
> > to be able to reproduce the problem with a Haswell core i5 desktop
> > system like my ASRock system, which was my own private build
> > which has been working fine for eight years until Linux 5.17.y.
> >
> > Hope this helps.
> >
> > Chuck
> >
> > > BTW, for anyone new to this, Jan's patch afaics is supposed to fix the
> > > regression reported here:
> > > https://lore.kernel.org/all/YnHK1Z3o99eMXsVK@mail-itl/
> > >
> > > Side note: Juergen Gross recently posted related patches in this code
> > > area to fix some other problems (regressions?), but his efforts look
> > > stalled, too:
> > > https://lore.kernel.org/all/ddb0cc0d-cefc-4f33-23f8-3a94c7c51a49@suse.com/
> > >
> > > And he recently stated this Jan's patch is still needed, even if his
> > > changes make it in.
> > > https://lore.kernel.org/all/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
> > >
> > > This from my point all looks a bit... unsatisfying. :-/
> > >
> > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > >
> > > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > > reports and sometimes miss something important when writing mails like
> > > this. If that's the case here, don't hesitate to tell me in a public
> > > reply, it's in everyone's interest to set the public record straight.
> >
>
>

