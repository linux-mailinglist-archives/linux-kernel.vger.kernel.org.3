Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6C591EEF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiHNHmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbiHNHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:42:32 -0400
Received: from sonic316-8.consmr.mail.gq1.yahoo.com (sonic316-8.consmr.mail.gq1.yahoo.com [98.137.69.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A61FCDB
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660462950; bh=8KLSx83P40LmS693s/Onl3yKyZEW86eCxHNLSUmvq+Q=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=F4LxfdGGvqqhb2tyqcdgsZO95KDy0YEYJRplu1+36jx7Gczr7q9eHTXPD33gBL3s6v83awy5sp2NeSjHusDNNV3dri183vH8Pwnsm//I4mcb+Pmp9dYGAyHR2hEHvR72iaa2+7a3hZ370wdEhKrpU87yf5rfpqsvoWK/J0B6UmzzaBuAF/pdelYgFMmq9d3w818JVLf1FnrN73B+fsKCCWiRXWMd/VY3TcnGUiq71noLUt1vxvi7RLPreuZywdVTb+TW+rUJI7dNVco+Hw063AIvPvFK5e27EODz6hPzY40c25BXSSff4TZfSYXM+q1Rt248abUJZBUlo5rutnaKPg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660462950; bh=Y9kpONcRYDFhgrlS+qagnlOXvpi15V7X/Y/y5emlzac=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=R9RhDD4tVvXB6mM/UxSTKqyGFwtVTpMIY9RI7npSMS4lZRU/O+9JPyZYupQ4ZnbcgR5HlW5pzkaX9RVuI/qwu1sFhaLssiPm3cIAhkrsAha/Pd3VvjHXc1l/b1uSz4Dx5jsQTvtPEIbMfiFzawxA9KykSSGbjDyUa3vRYtdPG316OXNsbob1+l1D/Y1LwiZWUar3UiUb6kQuOcvlLHOLhmIEJpPni8R+a9leJ2m9afK7VjuU6ufZsrziGRjAE7R84LL+xiRSe5YteDMcfY3RlcaHlYY59BNLS+wR/8LnG+a4FkHekvMpWWGOJ+1HpjiifYP+MNHZujecOaI6KwGR9A==
X-YMail-OSG: cQUlzkYVM1nRx0T1KwK9GJBuhFcn1E1zkgLQjlveO2mpKXSEENomTcpm5FZ8pt5
 fD9VeYLJDWybc4zq2QQeMqUg51OlJez_U4TCos4xJPAsn0pqL.em5sgZh_Vcj7K2SP9pYbAvoy3z
 GsHMQCNHk0iHEheYqsTqZj4OcqbYuDIF2IDMR2va7CTtMicLhgNd.bFEl9aPXPlNuNJU.2qAMTs2
 n76SMG_U6Z3P2arh2WunSZFMXoJMYm2BScjOG_P2Fa_D3U3513awHdmgnyvU66gjE2vbHaQ0UgCy
 VFQaL7w8BqDKtCKDi8Y6lMUtJksCWHUi.H1v79JoQ7B_Di3MWLEFzWH51xq0_va7e16pJ.w1Jshb
 CjzoLm8.GWaO7zI0j8EPuEc06OFtgNng5mK4WVAcJ6YKQ8EBBHt56DVjsnukgNnLqu0ZRZlAbRA9
 bmDzg4R1EpN.fSsZyeeVF7ybitBWZ9c5L8FkC2k8nMAYZjWdcCJ6zFbPYUuZVKOLHtG6ud4GpG0X
 gogGjYZSll.fHaU_8s_rE5LpkxH1o95mK_LLM_dPyuRN.4cuxabEKlILz83_jBQj_j1p9i.KXQ8k
 H2sGXlC4f5sRJY21eiNyIOgbcgzCRAhTwP2phd2udkPmgSdilPtUDTrHUvL9oertnCjHocZE_PPM
 eKh.hM0pWYrghSp2cV1sEBLlpJpENGdksmMCOwV0wQ7wik3YHGbZV8bGYhBvosQdNUzGkob7tIfJ
 Hu3Ool7KLBYiK3NQAbQE2M_uBSQ4pQXRbo3lQ.itR5OMt1VUyQgaBHjmu0ktgHLdFoSNH9Ivlcbs
 2Yla68ske2JQpErV1G8dAaQgKCFeGthm1UtsSQ8hOIO7XF_vputVN7woTp2Jh8m3Afbc_B0QqIha
 xMCmpC1BaxG6Zi9tHxMMTpTK3z39HwqhjBisEInsIXzdm21KzkImNFvHhKCQ3OYvvstrlZ3OsZdV
 UBARtaTlIfA4XbMj7jxv038r1GreAa9Lr93rQBGaTLJSVdPMp9XN6DgPDaVqRodDSpWI3C_tyZlQ
 tFdBODVH98q7MuUNEXsRuoAV.qh77Jik60NM34UebRAHCBxm6CZAr.qd82k9FKZC7hf48zuy2y5g
 ELjrDEPU8z2Y2SSKgIPSQnFMrVqEhkhGCFR5A0NQzqqFEOfcyD6FMfzmG8VDVuA5gHfTyMKP50K.
 .g18BOQYbvCYsaR_rs1RaVaIurqnYohMUiA9IBNx61m7dONnhu8UTK538OttIM77v4o6lXJ_gY4Y
 zzLWaWNh3Bui78YPsuQFb314.XiKC8r5RxDIQjzIQPnmYBrTX92cdlJowulSa9HEc1MW6BFWqOm5
 pCwjcBZlZjbfO.iJTbcJtMKuMSK.eDQvuePGnxP_pJcpEdsf7aMxhjYzxe26wq5oMunHZ3W3PU6Q
 ZtyRG4iD8Jv761bkCfIm4ErNxDKT2y5hSBmOk0P5Y2vaxpH1QKpiLNUA0OpTM9gqOHxeSQsuAMct
 9ZGFL6BOYMBG8d3De98juBHwpGYoOQTzUvopRVBxl7dzweHzQrhNzQ5nc00ZukEWaeYcJ.5O95Yy
 n1BREUmelVEAJyZBdWAsyLaaB_F5ID.0uP2wzJHU3lLzbtzfHmwKyoOxrhJXVHpXCkgrv_fQRkJc
 C27ubKSU0tpL1ZuiOQRsgilwAZUkuCZ7YClTxfJzfT.oXSFXWS29ID.ZWchzvvyDxI66SzvXwKm0
 HHkO7SGKJr9pfnH2oVVja7Zf5HWhwDPOtDpsCiEnFuaJZv3MfColVaJC5.WT4kbYIZz5UQ1pJ8NG
 ul5SbYL9xups732zCuKxNZGYrBarGQS_HLuyKQ2KBh_vraBv4B7eD2t3B0uIWh7RZX1rSO0kapOD
 n_m5pnQ82p7SoBjxbWI5vU1JGCe4Mx00FfwhOtmWMg3s7ygyG.6Jrooe6jQRIxcZkYEHkfmMPra2
 qluIlqrzN9IFrWmZDENcAH5R2v6Zw9qurHO2eK4UfPnHKsw8lNvqwQOYpENMLwhbTkSrFmENwj8f
 bdwfpuDiMDI5SHAu7U8vk.4280IPmZwKhCrfbNxoR3dtKM3csdCW7vcujyGuDC7RnUqcNggNf3.z
 nNIvZDShfioK87v.dt.skuV0xwbeTzTccUVRKB_wh_T1APLBc1vYgrr3i0lfX_k1GuDrO8ylSQ2N
 yUo4AMivomcwnUjoOwF_rdyQabIDj7k6Lb.rN9ZwlhNxu4fR2PPqIcy3VdjSsVYPOLaxxKdu1Muq
 UCMp6ZgrJWu0bW4eFECw5PgO53zRTD3O3RZ5YtwOqqf_d_BMPq6eNm4aiUF47btO8
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Aug 2022 07:42:30 +0000
Received: by hermes--production-ne1-6649c47445-tp7sw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d22bc789d6c8fbcdb1065c6baabbfe20;
          Sun, 14 Aug 2022 07:42:24 +0000 (UTC)
Message-ID: <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
Date:   Sun, 14 Aug 2022 03:42:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
From:   Chuck Zmudzinski <brchuckz@netscape.net>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
Content-Language: en-US
In-Reply-To: <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/2022 12:56 PM, Chuck Zmudzinski wrote:
> On 7/17/22 3:55 AM, Thorsten Leemhuis wrote:
> > Hi Juergen!
> >
> > On 15.07.22 16:25, Juergen Gross wrote: ...
>
> Hi Thorsten,
>
> This appears stalled again and we are now over three months
> from the first report of the regression, The only excuse for
> ignoring your comments, and other comments on the patches
> in this patch series for this long a time is that the patch series
> for some reason cannot be considered a true regression. If this is a
> regression, then, IMHO, this needs to have a higher priority by the
> maintainers, or the maintainers need to explain why this regression
> cannot be fixed in a more timely manner. But continued silence
> by the maintainers is unacceptable, IMHO. This is especially true
> in this case when multiple fixes for the regression have been
> identified and the maintainers have not yet clearly explained why
> at least a fix, even if temporary, cannot be applied immediately
> while we wait for a more comprehensive fix.
>
> At the very least, I would expect Juergen to reply here and say that
> he is delayed but does plan to spin up an updated version and include
> the necessary links in the new version to facilitate your tracking of
> the regression. Why the silence from Juergen here?

This is a fairly long message but I think what I need to say
here is important for the future success of Linux and open
source software, so here goes....

Update: I accept Boris Petkov's response to me yesterday as reasonable
and acceptable if within two weeks he at least explains on the public
mailing lists how he and Juergen have privately agreed to fix this regression
"soon" if he does not actually fix the regression by then with a commit,
patch set, or merge. The two-week time frame is from here:

https://www.kernel.org/doc/html/latest/process/handling-regressions.html

where developers and maintainers are exhorted as follows: "Try to fix
regressions quickly once the culprit has been identified; fixes for most
regressions should be merged within two weeks, but some need to be
resolved within two or three days."

I also think there is a private agreement between Juergen and Boris to
fix this regression because AFAICT there is no evidence in the public
mailing lists that such an agreement has been reached, yet Boris yesterday
told me on the public mailing lists in this thread to be "patient" and that
"we will fix this soon." Unless I am missing something, and I hope I am,
the only way that a fix could be coming "soon" would be to presume
that Juergen and Boris have agreed to a fix for the regression in private.

However, AFAICT, keeping their solution private would be a violation of
netiquette as described here:

https://people.kernel.org/tglx/notes-about-netiquette

where a whole section is devoted to the importance of keeping the
discussion of changes to the kernel in public, with private discussions
being a violation of the netiquette that governs the discussions that
take place between persons interested in the Linux kernel project and
other open source projects.

Yet, in one of his messages to me yesterday, Boris appended the link
to the netiquette rules, thus implicitly accusing me of violating the
netiquette rules when in fact he is the one who at least seems to be
violating the rule forbidding private discussions of changes to the
kernel once a patch set is already up for discussion on the public
mailing lists.

Of course Boris can exonerate himself completely if within two
weeks he at least explains on the public mailing lists how he and
Juergen have agreed to fix the regression. I sincerely hope he at
least does that within the next two weeks, or even better, that he
exonerates himself by actually committing the official fix for the
regression within the next two weeks.

However, I will only believe it when I see it. When it comes to the
Linux kernel, I go by what I see  in the performance of the Linux
kernel in my computing environments, what I see on the public
mailing lists and in the official documentation, and by what I
see in the source code itself. I do not go by blind faith in any
single developer. I am not religious when it comes to the Linux
kernel. Instead, I am scientific and practical about it.

Finally, please forgive me also if I am mistaken in my assumption
that these rules of netiquette apply no less to the developers and
maintainers of the Linux kernel than to others who wish to offer
their contributions to the development of the Linux kernel. If the
rules of netiquette do not apply to the developers and maintainers,
of the kernel, then, IMHO, the great advantage of open source
software development is totally lost, because the advantage of the
open source software development model depends at least as
much on free and open access to the discussions about the
source code conducted by the developers and maintainers as it
does on the freedom to have access to the source code itself.
If someone here tells me that those rules of netiquette need
not be followed by the developers and maintainers I certainly
hope someone else will come to the defense of those same
wise rules that have allowed such a successful open source
software ecosystem to flourish and thrive around this project,
the Linux kernel.

IMHO, the day someone make the decision to stop enforcing these
wise rules is the day that the open source development model will
begin to lose its advantage over proprietary software development
models. And perhaps the most important rule of all for the continued
success of Linux and open source software development is the Linus
regression rule, with the rule that discussions about changes
to the source code must be done in public being a close second in
importance to the Linus regression rule.

Best Regards,

Chuck
