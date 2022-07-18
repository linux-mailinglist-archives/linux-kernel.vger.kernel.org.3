Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245B157812C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiGRLpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiGRLpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:45:41 -0400
Received: from sonic307-54.consmr.mail.gq1.yahoo.com (sonic307-54.consmr.mail.gq1.yahoo.com [98.137.64.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D50121253
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1658144740; bh=NWRgcEKrNw577wp1orU79uRjM2h9UzwL3V9kfvs9pNE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EhGzrRlE2Yw6LdFc3Y+vidj+yJ2vCwGFx1ZHOm3AbbCcDlkuoG734dvW1txtuPbXv4DulsxiPGVoRfbEPzlQFQa5IfjOK0zn+BI1twC+Mx0EVro8HSj8WXDTV3f8bUGQgwC8khps3HWF//mpmpvAXkOd6AyG5+1HMmytla63CB6gEAXiV2Hnh86h7Q9xyq/PzEdbsRotwprDkkpl/FSSRFUq0jCwNl5Dmdecxpt2U3V1VjZtE6Pqw8J89lWJxugs5SAx3P8NR2nH/cFLiYlNaS1pYq2aAzcBD3lJ1Wkxw55o431cXiDg09+fkGH80QlcMLhM8khoyrmp69+DhTevjw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1658144740; bh=iZRE/1npaL44ct0XXAVcZyB1CdaMX8boH9OgF3My7os=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RDIECIGAhEUsPY/cK49+TNUvAV1csZfs8R8DrpMWt/LL2N4ZZB4HQsU4yz530FfB1T/eH84Y3ms8RYdbn9nQJETKrScSo3NWriYgy44k1K2ubRQv2ZztmH7kRLhObSC9Y95FYz/tT+G4QFwJ2ewhfn4nPcpYDvQQgO+xErpP2GQb3scz1JlPxi7cItppew6BmLZgobneD4lm4mgwy8RO9abVnuw2nFRKzghW6UiZ+ysZu/PUVqJ+znfNKBAVElgP8KC41tBhfsYf1g+pHdRROV2L2WdSwedAPrdn/f5OnHcLLxCwuO71DUeu59oUgs0XbaG24uQekYOOXi3OSym/lw==
X-YMail-OSG: M_JV9I8VM1mdZtbNGADi0RpaKMu5RY7DA_NHBnxKEFfMovnu_mRoNGuS8STeFaw
 Jy2rTJ42K_wtX1yAJ8OxMukHqdOba6hImm4eWMnDxp5ru0kEVBSe.GhdXMyE4t9BdSeFcGr1jcxc
 p_ry8qjrs_mHOsyZnnQZ7OxdUUP9pI_0PouzR0id81hBDfye_ZjX_hLjL3tRcO7V8zkA2hFVnIQk
 O0QN_NN0uV7sYU3wDmFK7QkTJM4xZt0bzDoUNpaV94tsLy.ZdiCcSpHLQR0tXAqPr9rdSFEfUMWg
 fG32JxLDLl4Ks.ltp9nVohpfVCGn6CSVTLbpHk8Cgx_K6kfloNjq_FIGel5om8b3upsDxLHdgDqx
 tPXxkMqeADDNKq3saqThomvDG8lMaZ8I2KENUCzqrfdRPvuudrHuav5vPcu57BnhpNv3pbOwH9Ys
 xWt79lMfAD9jqVCcJDc.KGvXyYHiyliPXor2lE2kVvwNo_KRew1VyHBzA08ZI0N59N74wwr1eqtZ
 J9FUDCpLf_G_yS3ZNazEyOAOW2JFImy_oCnATvMroYnQDvl0qmPkJD.zdGHWiu8FAUyzqi2qzx0J
 .UQPlWn.h0X5k_q.2Z4bZO.FoQswOsX9_SG.FhIMz4ytUty08gBmp0tulQeQ8BOpFstTE7CFrffo
 7YwxEHcAYBxO7ZS5ZBScI86fwd1N7zGnVMPBo04WDCbiHqSIOGfmXygoebgGO1tDRV9SPMHo5kfb
 EOw5WqV4gMBMei2vf93IaPPC_HlWlMMpe.aYY681sNaud0QyoG.3C0E_HwY0222fQVe5R3o62Gv4
 uPl1fQIUIEZlGMcYVP5kAE2WwOql1J.t3Hh.ZWzdnTv.yPjuspRvl7zuytdIbByDb6RWhMBJPTEX
 Ob9pCP7Tnd8Fd1Zyg4g0p3vbRy_4CsmJM0w5IywH2lAmMAVToiehagvk_LBi4B52zlwuEDhRf59n
 mY5TjIh2IgA4IzqZ.1WXq4ZZMEEp.XgzHxBD5zv.962APq9dKTDp9Kn5j_2YrMH6FJZHK5xDJu6D
 nVk0rGIsltXN.cTmJLJ2ldf9QoOh4EP7bhXS8WEJ_jzigkR8ZqxY9rb.kcNA5V0j3YCjSHyzyxmH
 gQ1VgUo__c2JLxy8c.PdTItoNlLGA3pGYmWLhq7KF.emml9fy2Nu5kMNgjsVNRfdb5ZfPtZw.lDw
 F7z1asyobNznyUOWwh.6YRt3jpehxy0WrIzckACJcxK.nwR985Tt9dfOTiCOwK6NYNiHqzxo_Bu6
 4p_oKW9WsC9rbQAMz6OjqJfOZTPAToi_PDJz8QiBnih.SHbT9K23za4w1VjMkmS.CK7_nJWz29Fc
 RhJexfBJq0H8BcrygbgexMpN64nTh0OWrunDfrg09xuRSffCbvvX_UNKz8_7O4GEBFkb7gth72qb
 bm5jaK4OyVIYOBQ46TqjBI6PuI_CByrvaPaWGDsZZuuSHmL2z1dBDozA0upHG1AbQxhimZP.31c3
 C9QaJHaTuBy3lgL1NJvwuZVsmWPlcvYEcRZrL156Y4S3hDqox.mIybU7Tb.wm5mmogS9RVgTZYx1
 urNYyROdEta388f6930xTps_nugnxuWPXVZL7Yt4kF61LZxFgm1JlWRn0yGb5cs5rGCnZqtMcblQ
 88BexPWYMLhbJWnUoNEajttm1ZmsCh9v_teksFQetuf4KWVl4IAgiIMXDv4ZxYmg.rTbF78E1vaP
 oXbmqfLiT0gHkBJOJ6T7npodjTWRNnK2Q8HLqRvPBry37ok_bTvAui_T1PVImE5LlQ7BhnUWDlcN
 9EKgV0qJ.WajFuxiH7DTP5LRHbcJJBo9F7FZhN4QZzntSpSlB8l3EuL1HB8RzJVaXDjTRqL4nffU
 7x.KINTVelGOQH6OIr5.zFNWoj7XrcQMIDa2PiMi._lE5gjvHpWDbXzOAKaTTqs7BScVmWRllLf4
 zyj3Z9Xabk0o3bosUQtu9s7v6DSqCHW0.gM7GmvOKD_hD_wrfJuRPvziQo9V4AxQOw6uSKiARGZJ
 MyeCNiQ9nPDsA6L395nJvwfau.oMddRhYb2Sie_R5RKII9BvObQA.75Dh19uT7h_JG96N4cPHDH.
 mgBJSpzH8Q_Zx0nrvVmacbDLbFfgofNBFIeHeQ3I2I0HSRyQcafM_J51cMG7989_ksBTKyP1jVBw
 KKXp1E7Ishe_DgS9mrpdncxTJjHk3UvcIQHsTI40q.PJtFXm_76M0fJYTVDaPDyxEkxA2epkko3G
 JoI.ae6inUsx4MLEDZYkThqqG8epqy4GZKPqN.HN4L2H.5S8YXU1zvWGxHvrRS1l4vwNAXbBm
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Mon, 18 Jul 2022 11:45:40 +0000
Received: by hermes--production-ne1-7864dcfd54-hwfdm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 383384c8c23b00dfb91d48a20405cd82;
          Mon, 18 Jul 2022 11:45:37 +0000 (UTC)
Message-ID: <f19b737d-f296-26d0-91de-14fb013b29a5@netscape.net>
Date:   Mon, 18 Jul 2022 07:45:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] Subject: x86/PAT: Report PAT on CPUs that support PAT
 without MTRR
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <9d5070ae4f3e956a95d3f50e24f1a93488b9ff52.1657671676.git.brchuckz.ref@aol.com>
 <9d5070ae4f3e956a95d3f50e24f1a93488b9ff52.1657671676.git.brchuckz@aol.com>
 <5ea45b0d-32b5-1a13-de86-9988144c0dbe@leemhuis.info>
 <56a6ab5f-06fb-fa11-5966-cb23cb276fa6@netscape.net>
 <d3555a74-d0cb-ca73-eb2e-082f882b5c81@suse.com>
 <1309c3f5-86c7-e4f8-9f35-e0d430951d49@netscape.net>
 <764ea65f-269a-6f32-c780-cbdd7cf09120@suse.com>
 <8eb62e12-17cf-cce6-666a-8ebb7915f461@netscape.net>
 <80b413d1-287a-61a3-656d-9ea680f00a90@suse.com>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <80b413d1-287a-61a3-656d-9ea680f00a90@suse.com>
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

On 7/18/2022 7:39 AM, Jan Beulich wrote:
> On 18.07.2022 13:31, Chuck Zmudzinski wrote:
> > On 7/18/2022 2:07 AM, Jan Beulich wrote:
> >> On 15.07.2022 21:53, Chuck Zmudzinski wrote:
> >>> Two things I see here in my efforts to get a patch to fix this regression:
> >>>
> >>> 1. Does Xen have plans to give Linux running in Dom0 write-access to the
> >>> PAT MSR?
> >>
> >> No, as this is not technically feasible (all physical CPUs should run
> >> with the same value in the MSR, or else other issues arise).
> >>
> >>> 2. Does Xen have plans to expose MTRRs to Linux running in Dom0?
> >>
> >> Yen does expose MTRRs to PV Dom0, but via a hypercall mechanism. I
> >> don't think there are plans on the Xen side to support the MSR
> >> interface (and hence to expose the CPUID bit), and iirc there are
> >> no plans on the Linux side to use the MTRR interface. This also
> >> wouldn't really make sense anymore now that it has become quite
> >> clear that Linux wants to have PAT working without depending on
> >> MTRR.
> > 
> > I am not so sure about that, given what Borislav Petkov
> > said when commenting on your patch here:
> > 
> > https://lore.kernel.org/lkml/YsRjX%2FU1XN8rq+8u@zn.tnic/
> > 
> > Specifically, Borislav Petkov wrote on Tue, 5 Jul 2022 18:14:23 +0200:
> > 
> > Actually, the current goal is to adjust Xen dom0 because:
> > 
> > 1. it uses the PAT code
> > 
> > 2. but then it does something special and hides the MTRRs
> > 
> > which is not something real hardware does.
> > 
> > So this one-off thing should be prominent, visible and not get in the
> > way.
> > 
> > --------------end of Borislav Petkov quote-----------
>
> And then, a day later, he said
>
> "So I'm being told that it would be generally beneficial for all kinds of
>  virtualization solutions to be able to support PAT only, without MTRRs
>  so it would be interesting to see how ugly it would become to decouple
>  PAT from MTRRs in Linux..."
>
> > Jan, can you explain this comment by Borislav Petkov about
> > Xen being a "one-off thing" that hides MTRRs and needs
> > to be "adjusted" so it does "not get in the way"?
>
> I'm afraid this isn't the first time that you ask people to explain
> what somebody else said. I don't follow why you think I could better
> explain what Boris said and why than he could do himself.

That is why I also asked Boris to say something now to clarify his
opinion on these matters. Let's wait and see if Boris says something
to clarify his opinion.

Chuck

>
> Jan

