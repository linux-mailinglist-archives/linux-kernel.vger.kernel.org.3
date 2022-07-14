Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080BB5753D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiGNRSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGNRSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:18:05 -0400
Received: from sonic310-21.consmr.mail.gq1.yahoo.com (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36548CB6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1657819082; bh=K6joDuzaz6ReyBN1azQqrz7eoLesddIL/DW3l7lThp0=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=M9awDOAzPh3Fw17O4JgpEjPn9mjHJ7usy0wGo+t1B7h5gSKRHlXk09+YYJNOmCQev4heN9bp1zRakNptwTWQ2UkwWQnTul777CPYQdrqZSh6uRifbNoUO02fg2kg5UknGqw0wcaYPxUns6Bd+glWpl0iYwiRb8kWaRSKT767APrn04VY9HtROnGES40Uqc/Iz3wN1XB+G24k9ZWGilZ0QEY6gDntHRXL3ON6ikCUpJPh2sz4QJYyUFEAyMBpeMRjth9WM9SSkDaZq9bSvW6xSQOzrZ2kAEvU/wYQGKp79kb4hMsv9dw1pjM9pxH1VSLNQI7lO4HQ3gSDO5tvX2Z8Qg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657819082; bh=xIGE8RBQDUpUkF4cyoBG8GZz5Q2LafG9TdX2VJtrVS4=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=knCxCA00GJeVPCjt3+nTqNd4TO7ZzSXoX849CBPd6pAYvOEFPHeSibRa1eouvP9tn5Gu6fZwoOS20jkWiuYBBNX5wsAbKsNb30cXlxYK2mq8zYmGLw04M5k2L5N3WpmONTVbl2XgX0oqYk8auMwwIjD1MYWM37CPy1z5lKQdiTNCOn5Hu2TSelh2klvuCp+hK/8pOqh1HcJKg8njPK0DfwtwAT+TF2SXRk0+e1T8jom5Ut2r9S5X9HKQfv3Gdf+24NVxNzZ2DASEzITsFpAHaYOY9Gp8gF/wxvsn13M44igaQ4Za6e6MYwaDGSjBdcZnQFlqruZV77fimkCDcBcY9Q==
X-YMail-OSG: _G3Z_fUVM1mmgdigp1QpLXL0sKHIi8.3W1ckI4YZkbMlI7ljSvNIqCVUpe7tT8v
 GIu_y4vEnuYkUh_CcSsHGTJidjxFYuXfB66rZspz56_qx84XD0bhk9l_br2Jjfbyn8QsaU2grcBq
 9f8JV6apWuACoFy4V9Nrq8bdV6jJZX9uFeoWm0C0tTg0sAkhMefP4qCMqAsca2ZALq2X4zoRyzqL
 E1ld_DFdxjERy9edhOpN8CJAAopAZO4QQZhFqyq44C4u4jFH.YxWAMUXByLE2iky3_q4vCrqBebh
 I3U2v4EuOSpt7U6.QG88zH8L5hXrjKBmoIp3jBOfCHQ758dUybjOL7uCJ3yubSeTb4q_ovqEleWk
 I124SYO.SdneY3XgIjYxEQ2kCi3Kxx5yN5KS7L3wYlUkeCxYEI_M3Apo1PSsth_EzCwnO2qoiY1G
 LYZQN4sqzVuwbKmcLDad0oGWR.DOLAacx5J2anrtS42WdpqJL.tmMQ7ja_1QniXkWoGaovhp4YiM
 8Oksu9rrvYM5zJoVq6pmObXQdF5pcRZLzr_vhjVcKZGHBwW1BUoJxjo0pQG3Mw7XZOCR1hEEjN8K
 RyMwIpnfTIs9bp_oZW9SWFW5iVQO.ThbbJoaKL34wC6ppUDnRaysfHq7sT3YSE4YbL0iUl_rSZO0
 x4_JCD9B_1OTKBlRo45RKNzrOjgEFXw8p716FtthW4n4cK3MLrji2o_rlncsiDs9Uj9wiDctVMlf
 4bWgD7u2zGmJdF0BHKSHVpFgNQdF6viE_OE7QU2_eCpGykC811NkmlVpI9RYD6G9sQe77fG6Bqp3
 zrxM38o6rvKuhxyQcCTwKYCyvFFNcxDVdUO2tarFhhjKLp2AFmaT.otRFpMNZ9zZxNlB2DE_s4IC
 mF0I66peWeKkG5Qqg4A8KdA7NGI_oJI4V3K4j04oxIY9YC6YNxyjdfBDj7RYfXUNvnIylI8h7DUG
 DBAJ3BdLBSzeEx3g4r13Dl6msk7aGSv51NHXqoYR2sFLPYiV92tVAVLpGSZEPxjN4zudbfjHNFok
 it2V.HXHZnw5ztr5n_tBW5LVOk9GftbeSLGMEw502Jr51Hk62cLTcWdr0hks.IWOZJaqB1ffoN1r
 pPIRTgKWFWLyvPNyQpKy9LEjOcCLmYESX_armBrxLZGXRtQFm704WAY8n5BSes8lrvrIJ52lY.HR
 gEaomrCMaiMvVUNxgaFM92srpoB93tfTSf5Whn6zTcGAribQp1zO0BrP6tWD3OGFlIEMui7JQQFs
 GDCta4unrrOegQh1DyttghwxZdA0IHpw40qm5NkDZxdIMc_gy1FcRQBCSZTHLDUpVcCarpr3LfnS
 an64El6lVaiRQab08E6EzarOAjaUicBj5aed8TzMzY.LMJkriBa7K7tx8Y8JpdFiXIbYbu6JXa_o
 mbf6S2hofpCMT5_FjD_S2wkGV8W8t3yWl7ze49Nq4R4LK7sHUeWNjR0j0gAPkoOZ2Siv4SP859OT
 253vAIbvHVZ5c3HUx9wWABJvjQ76KILFbYW63yn6FtjOiuOPP_M05NCGcR21943DRX6UbJ4bWNMB
 wW67eJ38MrpthNtdkcm400ftIXOGHePta4KOrij6NCTlANmh4DmgyUorIpRgjXQByINO3uYLgoek
 v8kzlRrQ_l6fOngV8JIJg413TrC1eSP74d2X.lXwx23LECZgllruKvskMcaBQclkaIO6LLjTxlPg
 DtCqVW_hGlWX0LiWrHvotDFSCzJgaVvSqs_VseD9aEA27vAohe1KRDmUB_q7e3FRBvWugJRXwVam
 _Q6otUZOtc0Yc_SWK8mAToqxCrYcbpISPjlmOSM1beFaX8ImRKAic3TuW05GTGde9pGH4uXPyuWN
 Zuq4.lSEyEjc9_w8hJte9Fq8.hWfm9XZE3r3wS0.w9TaSa3K5xzDir_42qBa7F7qpO9bT05rxPO.
 3t0KFBuypyampyroB3D2Qfmpb45vvvyLdzFpTB_oX.dxo2uMPt6ubF9gmYswWjaBTqimRPlkJT3Z
 AgWr0aunWDyVCiOdzHuZU3nWshCkdeIldhEjtXny49tIyyXtrsb35_FPzgGM.FM3fMOI.wBz7kKn
 saB8OkA_CcD7dqlKuykEZJi1FOirLbYg.1KoWjlMTLiCHVgjFIONSZEqGPYNcV4mpBbdbtFRB5iC
 rOHMq0xlLgY7Of1SF3Nf.XbdpNbnnPUuY7HOIWZRwD01w9Oc2lB2ZRA6zYDerd1_dIdb5jUCzdce
 PvXPWEcaPXdPtOkcYx9Uhr5VSvT.ow.bVphpSVoxTLmd2QYyy2.uC8iFSeHMY5h0VrouMQwTl_Wn
 jjYcN55VtVsr1wqqHOK_Ns5zOElFJOEpB
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 14 Jul 2022 17:18:02 +0000
Received: by hermes--production-ne1-7864dcfd54-dxcrc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 78c9938f79c6bfaa1dd44261bd92c198;
          Thu, 14 Jul 2022 17:17:56 +0000 (UTC)
Message-ID: <eda0381b-fe6d-144b-76cd-d943082d70e0@netscape.net>
Date:   Thu, 14 Jul 2022 13:17:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Chuck Zmudzinski <brchuckz@netscape.net>
Subject: Re: Ping: [PATCH] x86/PAT: have pat_enabled() properly reflect state
 when running on e.g. Xen
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
Content-Language: en-US
In-Reply-To: <4c8c9d4c-1c6b-8e9f-fa47-918a64898a28@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20432 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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

On 7/5/22 6:57 AM, Thorsten Leemhuis wrote:
> [CCing tglx, mingo, Boris and Juergen]
>
> On 04.07.22 14:26, Jan Beulich wrote:
> > On 04.07.2022 13:58, Thorsten Leemhuis wrote:
> >> On 25.05.22 10:55, Jan Beulich wrote:
> >>> On 28.04.2022 16:50, Jan Beulich wrote:
> >>>> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
> >>>> with pat_enabled()") pat_enabled() returning false (because of PAT
> >>>> initialization being suppressed in the absence of MTRRs being announced
> >>>> to be available) has become a problem: The i915 driver now fails to
> >>>> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
> >>>> located the induced failure), and its error handling is flaky enough to
> >>>> (at least sometimes) result in a hung system.
> >>>>
> >>>> Yet even beyond that problem the keying of the use of WC mappings to
> >>>> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
> >>>> graphics frame buffer accesses would have been quite a bit less
> >>>> performant than possible.
> >>>>
> >>>> Arrange for the function to return true in such environments, without
> >>>> undermining the rest of PAT MSR management logic considering PAT to be
> >>>> disabled: Specifically, no writes to the PAT MSR should occur.
> >>>>
> >>>> For the new boolean to live in .init.data, init_cache_modes() also needs
> >>>> moving to .init.text (where it could/should have lived already before).
> >>>>
> >>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >>>
> >>> The Linux kernel regression tracker is pestering me because things are
> >>> taking so long (effectively quoting him), and alternative proposals
> >>> made so far look to have more severe downsides.
> >>
> >> Has any progress been made with this patch? It afaics is meant to fix
> >> this regression, which ideally should have been fixed weeks ago (btw:
> >> adding a "Link:" tag pointing to it would be good):
> >> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
> >>
> >> According to Juergen it's still needed:
> >> https://lore.kernel.org/lkml/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
> >>
> >> Or was a different solution found to fix that regression?
> > 
> > No progress and no alternatives I'm aware of.
>
> Getting closer to the point where I need to bring this to Linus
> attention. I hope this mail can help avoiding this.
>
> Jan, I didn't follow this closely, but do you have any idea why Dave,
> Luto, and Peter are ignoring this? Is reverting bdd8b6c98239 a option to
> get the regression fixed? Would a repost maybe help getting this rolling
> again?

Hi, Thorsten,

Here is a link to the hardware probe of my system which exhibits
a system hang before fully booting with bdd8b6c98239. Without
bdd8b6c98239, the problem is gone:

https://linux-hardware.org/?probe=32e615b538

Keep in mind this problem is not seen with bdd8b6c98239
on the bare metal, but only when running as a traditional Dom0
PV type guest on Xen. I don't know see the problem on Xen HVM
DomU, and I have not tested it on Xen PVH DomU, Xen PV DomU,
or the experimental Xen PVH Dom0.

You can probably verify yourself that reverting bdd8b6c98239
fixes the regression if you try to reproduce the regression with
any Linux version that has bdd8b6c98239 or its equivalent on
the stable branches with a hardware profile similar to the link
to the profile of my machine which exhibits the problem. Mine
is a Haswell core-i5 4590S CPU and ASRock B85M-Pro4
motherboard.

Also, other notes:

1. Yes, AFAICT, Marek at Qubes OS is the first to report the problem.
2. Juergen Gross' work to try to fix this has been helpful, but none
of his posted patches has fixed the regression on my system.
3. Jan's patch fixes it also, and so do the two patches I posted to lkml
earlier this week to the appropriate maintainers.
4. On the pkg-xen-devel mailing list, which is public, this issue was
briefly discussed where I first reported it. Someone there said they
did not see the issue with Broadwell Xeons. Mine is a Haswell core i5,
which is one generation older than Broadwell, so you are most likely
to be able to reproduce the problem with a Haswell core i5 desktop
system like my ASRock system, which was my own private build
which has been working fine for eight years until Linux 5.17.y.

Hope this helps.

Chuck

> BTW, for anyone new to this, Jan's patch afaics is supposed to fix the
> regression reported here:
> https://lore.kernel.org/all/YnHK1Z3o99eMXsVK@mail-itl/
>
> Side note: Juergen Gross recently posted related patches in this code
> area to fix some other problems (regressions?), but his efforts look
> stalled, too:
> https://lore.kernel.org/all/ddb0cc0d-cefc-4f33-23f8-3a94c7c51a49@suse.com/
>
> And he recently stated this Jan's patch is still needed, even if his
> changes make it in.
> https://lore.kernel.org/all/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
>
> This from my point all looks a bit... unsatisfying. :-/
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.

