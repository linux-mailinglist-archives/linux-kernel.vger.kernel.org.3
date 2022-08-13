Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5957591C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbiHMQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiHMQ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:56:51 -0400
Received: from sonic313-19.consmr.mail.gq1.yahoo.com (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A82C67B
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660409809; bh=QRQBPbaJj2JGJe+PhZxZ66B9bo7GJ0cjESR5eyJpCvU=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=hytzFYTpa9PgpMH6rZ9sGrwc/r7N0xW6ezurFyh5z9CrY3cimzqLcKCLaKjQyHy6G8Y3uiNkC+jJMEKq6Pq7YOaPy5Uo7dSXqIbvbFAel17Udl3HxZg7M0o1bbP6Soz65qeGl2PTp2WNF0e47KpkddlI1Srmh6lwF1sODjDdAwj++xA+yIFC+f13uSJJLbXErjpSUdGGz59RBXnWMdqJYsnfMvGFVrYVzTh7sSqHE/yViYcsNtbg7tYDykb2oTnKyXOWZmikKtqcrderry3CZP7Nlkc99STBcHlaa7gkMYItWfZpB350t1oQNHmRhQUss2dPW6c1eJsSEyD2di3fIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660409809; bh=yQZ3P0IsqeiiA0dZkrTD1G4Z78sLpvW9+sAwKLNlpvB=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=a5qeST9hBIrEJHEpCcI5wrk6ei/TujAmWFR98I8nTh14/LvpB4fLfCOVnv2H4rgiIUQxR5sXNjDaDT80+M8SpCuTimq8s5opyEQZmZWYeDC6wZLFQxUZ7jxQadr7K35YldC2GtOlqdl+6T5QbCQs+eUmYc/GbPb7TS1G4p2suMAtNl812eG988wICOKWH9VBlD+lLa6/D9xk2NAtJUSPkiVutsQPA7p1D/F+sUc8CmwaDThIyMNem8lBN52SOgCENgf29DT+D/zBcKwtoEZ31IoJiCDhxtahQnLaZUPkhTaOu/B1B2zls4TbmwCpvu+aNQO2Uj/AFAlpyMJgx+KkUQ==
X-YMail-OSG: OQbhtbUVM1nOQ6jnLdzPWPN_bd55lZ6LHInmMNByAOaV9HSItHoQ4qvwJwUcttV
 e4nvHeMobRWrL6nfaT4j9cGFc3_RMhHDalf7gYxESiRItX8_OrhCoWBbU6_ymUvXd5p7__URF5ng
 yFs6KLjWCd80YYOhC_86sEqobjQx1BGnNj3YoR6sgQSgEQqDazeRyB1zzaUAl2Gvhtm3Cn6Z8Eu.
 nM80Z9mA.id7WyziYqSwJZv2KwBQURjqUb1G2T3KooAz8SaCpHv_lSXxyPcWNZLwg16IfxvImTLp
 pNJJVsJMGEsBKolSZXO1nHLMCIJf7f27y.THOmF9pp0C0WsDFvurksxhjwG59OC1qlnWV_BQBNqp
 JTEzoPLbwSAZRdxGzUYf0wwh_je8FJZ7bDtgVXM_vzSX33AuBqwkBp.ynCimUY7w4XLxo4PQ.jQq
 499348bto4OXTUCVBSAS04ONUhRT.cnjJC2TtC0BdUgXbGKzfSs0w.sT.u9.k145TBWLFr3BRvHy
 W5j3Vv07Y.pjn9U6p7nSWXx2jPeDqf5qfKIJbOZqtaNFX5FNi7k8NO1EBQFZcERbsLdFaHol5VpI
 rHElfW_LNljI08YXxvLBxGOo_A_.5LYCYeBUTr_C3v9OoKM6bXKtl0PK5EfNEFTbVDyoinZH.bU8
 bEzgC4IOHSx.CWhYFTaCP6d6ubFm2WdW42iT97zkV_QFwQHWNE7zhJe7KfxHPE17S.3t_hMvcKRz
 dA2RFP5DvXTbzID8wuonj7mHyf1zkCAgihEu_G8VyubEqzxUueB18F17y8vBhLfyk6hywdgiIS_N
 wyaW2zXbt5cmfbt_BK1CJS7_k5FR21KMQSqKrrQcPArlGX5ksjOyLjXtZbtUbfEZ5i.AxQnTuFGe
 DPZWpM0yc9wUy9ox62kzxk0i32Fuix5jLlgCQ2nQDKV60Tgp0nUPYtHAM3db6xb.M.5zBDZkTh9S
 HpqUgqNeEIrkHIufi8637tUFf_71sM0pdRSZgH0IpcmpDkeGt8VVm04nWSsyunc5DDCoNQvyeruT
 wO0BFroXfxjHxMKJDG3jGjBt6KJ6uFIBQdnz_tVGzmYGlA0l8VQCB0wmA8RujoBr.usio41fCVG7
 .WZicdRm9KNCzl0xKZxwm_7eM8WrV7a7_YxcgIMjv.B.P_kV65xvhdc2__aitiMuyA5XRD0Y63m3
 fV7Cpi_UJRnAg8VohVoL651fIB7T6SsKIVcIRxBfuGljyEWw_U2t6BalpfAYAizKZhAT4z2nTtan
 uAneSEyPKnU8rGqdLTsnVSU_Bdjwwhhtwjr5ldOaTsKGMYs7DdtTfgmV7dBo3TzGQc8dO8D8hbmM
 NQidk.u8wN0qKnV_eu7AoA9Hn1ErYqWCkB_u.0hnqJIIQLU.xN.s185Utg92ydmz3y6i2ljAFB.L
 UTTN6xAnsuhNJmh2JEIxmLIlPDaygMSAa0oCFxARvpwc88gKpKIPSQCHMJ_F0W7ZFHePQIv8UQgj
 w_NJU.9YsCGpYuNDbBgb3RHOUnXgGKpiA94xWxJOKpFzIhlLa1RLAozyme.0fjmel9YW_ISVfiVy
 dMBb.GyEv3nnnYDj.D7g1fx.2xRfr7Mln33gS.l0c.0Ch79fRCfH.6MpvzK0Mr3a3GJlMpLVQO6q
 xPs.v6_A4l4vebg.Q8gtS8ARaxBY79VpRVl2H8x7yBZ17.aKRYYxdPl3RC0KsSvfG79O5xwovIlT
 5MQJszRy_XfoEfi6FqukEbEM0cteDTMroAfyi7O8yN4YlM22U7wlQk0JtQe94DxeeH_aYQI71uQj
 ydAWwOOget9fH8Ki5x0j_14mPGSmpecmG6Cog3XLuN_rVWtwPoCSpVeHJ2tGVyxatlmq9Kbrr999
 phWg.9aqXeRK815s4_8zPtNRwZms8RmBeFUDhQaSQusMXbFg9v0wZwnW4jMVa0RuqutpI0jmmbkh
 gapL48O.v7LtPPBVByeJXIt.IQNBAqDHyiz2qG0NGEt0pSkx0hHT5QFMAc.iquwfBTvi9mZnoap9
 4LFP6YBlJ8x3FyDCrC_x3eDmoGov.JVfemXWRc60zxAvSj7vrazhUXcIg2aZz0d_Ug59JLbNJQGr
 a0jPVt9sIILfX7MlwcqhxVnuSRqPy8Pw22lpRcu44oLRlfuJ83X0Gqv7uu.Ti4Bx3da5NASYuW5A
 Lcs_Fk3.Vc5sMk6urzZn0PgThmydksH7f2WLpi1G4Ks0Ui6YE6954K3BOkpiV.UJvA4zsNhdIIxK
 BdBLb7UygVYN1O7h16PCUlwOmWC76Z9Lxvy8lMiXYbNhCwK1zOcQF9OLjW1OR9HcuATM8JJpSEF.
 6._m8e4umqWdXYoBRCv3GesC5y7Rv1FTkjic-
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Aug 2022 16:56:49 +0000
Received: by hermes--production-ne1-6649c47445-tz6bb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 66f3ba59478f3bc107a9b6db1aef8ef8;
          Sat, 13 Aug 2022 16:56:46 +0000 (UTC)
Message-ID: <d838264a-bcd0-29e2-3b23-5427ee0ee041@netscape.net>
Date:   Sat, 13 Aug 2022 12:56:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Chuck Zmudzinski <brchuckz@netscape.net>
Subject: Re: PING [PATCH 3/3] x86: decouple pat and mtrr handling
To:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev
References: <20220715142549.25223-1-jgross@suse.com>
 <20220715142549.25223-4-jgross@suse.com> <YtbKf51S4lTaziKm@zn.tnic>
Content-Language: en-US
In-Reply-To: <YtbKf51S4lTaziKm@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
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

On 7/19/22 11:15 AM, Borislav Petkov wrote:
> On Fri, Jul 15, 2022 at 04:25:49PM +0200, Juergen Gross wrote:
> > Today PAT is usable only with MTRR being active, with some nasty tweaks
> > to make PAT usable when running as Xen PV guest, which doesn't support
> > MTRR.
> > 
> > The reason for this coupling is, that both, PAT MSR changes and MTRR
> > changes, require a similar sequence and so full PAT support was added
> > using the already available MTRR handling.
> > 
> > Xen PV PAT handling can work without MTRR, as it just needs to consume
> > the PAT MSR setting done by the hypervisor without the ability and need
> > to change it. This in turn has resulted in a convoluted initialization
> > sequence and wrong decisions regarding cache mode availability due to
> > misguiding PAT availability flags.
> > 
> > Fix all of that by allowing to use PAT without MTRR and by adding an
> > environment dependent PAT init function.
>
> Aha, there's the explanation I was looking for.
>
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 0a1bd14f7966..3edfb779dab5 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -2408,8 +2408,8 @@ void __init cache_bp_init(void)
> >  {
> >  	if (IS_ENABLED(CONFIG_MTRR))
> >  		mtrr_bp_init();
> > -	else
> > -		pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
> > +
> > +	pat_cpu_init();
> >  }
> >  
> >  void cache_ap_init(void)
> > @@ -2417,7 +2417,8 @@ void cache_ap_init(void)
> >  	if (cache_aps_delayed_init)
> >  		return;
> >  
> > -	mtrr_ap_init();
> > +	if (!mtrr_ap_init())
> > +		pat_ap_init_nomtrr();
> >  }
>
> So I'm reading this as: if it couldn't init AP's MTRRs, init its PAT.
>
> But currently, the code sets the MTRRs for the delayed case or when the
> CPU is not online by doing ->set_all and in there it sets first MTRRs
> and then PAT.
>
> I think the code above should simply try the two things, one after the
> other, independently from one another.
>
> And I see you've added another stomp machine call for PAT only.
>
> Now, what I think the design of all this should be, is:
>
> you have a bunch of things you need to do at each point:
>
> * cache_ap_init
>
> * cache_aps_init
>
> * ...
>
> Now, in each those, you look at whether PAT or MTRR is supported and you
> do only those which are supported.
>
> Also, the rendezvous handler should do:
>
> 	if MTRR:
> 		do MTRR specific stuff
>
> 	if PAT:
> 		do PAT specific stuff
>
> This way you have clean definitions of what needs to happen when and you
> also do *only* the things that the platform supports, by keeping the
> proper order of operations - I believe MTRRs first and then PAT.
>
> This way we'll get rid of that crazy maze of who calls what and when.
>
> But first we need to define those points where stuff needs to happen and
> then for each point define what stuff needs to happen.
>
> How does that sound?
>
> Thx.
>

Hi Thorsten,

IMHO, silence here is unacceptable given that this is supposed to
be fixing a regression and not just adding a new feature or
re-working the code in a case where there is no regression.

The regression was first reported on May 4, 2022, now over
three months ago:

https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/

Why has Juergen not at least responded in some way to the
comments that Boris has made here? Why has Boris not
pinged Juergen by now, which is almost four weeks after his
comment and over three months from the first report of the
regression? IMHO, both Juergen and Boris are not treating
this with the priority of a regression fix. At the very least,
they should reaffirm their commitment to fix the regression
in a timely manner or explain what factors demand that the
Linus regression rule be set aside in this case.

There are valid reasons to delay a fix, but in all the discussion
of the various patches that have been proposed to fix this
regression, no maintainer has yet given a clear and reasonable
explanation for why this is not getting a higher priority from the
developers.

Some developers, (Dave, Luto, and Peter) have ignored a fix
proposed by Jan Beulich as you pointed out in an earlier message
to Jan Beulich here:

https://lore.kernel.org/lkml/4c8c9d4c-1c6b-8e9f-fa47-918a64898a28@leemhuis.info/

To his credit, Jan Beulich replied to your message in a reasonable
manner but he also could not explain why Dave, Luto, and Peter
ignored Jan's patch and remain silent in the discussion of the possible
fixes for this regression. I note also that the original report of the
regression identified a specific commit that also fixes the regression
if that bad commit is reverted, and that commit is also mentioned in
the aforementioned message to Jan about his proposed fix. It is a commit
that lives in the i915 Intel GPU/DRM driver, commit bdd8b6c98239, and
my testing confirms the regression can also be fixed by reverting
bdd8b6c98239 instead of applying Jan Beulich's patch that was the
subject of the aforementioned message from you to Jan Beulich where
you also expressed your dissatisfaction with the silence of some
developers (Dave, Lotu, and Peter) when there is a regression that needs
fixing.

Why their silence? In that same message, you pondered that it might
be necessary to bring this matter to Linus' attention. The developers'
silence makes me think this regression is a regression the developers
do not want to fix. And that would be a clear violation of the Linux
regression rule if it were true. So, Thorsten, I think it is time for you to
elevate this to Linus if the developers do not clearly explain why they
are ignoring this again.

Best regards,

Chuck
