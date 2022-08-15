Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327925933A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiHOQ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHOQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:56:45 -0400
Received: from sonic310-21.consmr.mail.gq1.yahoo.com (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9425C71
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660582603; bh=L2j/Wrapxc1K8yoaBhb7/4dpXISfbxNp2WwOsFC/si4=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=PWGjftKNUYWbEJJfVawXREjLFUxrDAuobgtZ1kDooWOMzv/UdlPGj5PX2z5CUAcw5aKjCbqtnKylaF7sno3mN6JcNljYLqjrjctN0Nt/0sdLo1p2zfZeJNECg18tiMAP2hOTe9KbU/0JmPKVWHwZnP9AF+VFpoLwsXdwC1cLe7MqDTMn+fyVvuHs2Ya0b82C6jDWsdznJepFUBXEMje4mO3xnQfRrvn/fErBiTAc8VGhOMpvAlu3O/NIkZM1LcxvtvroRy5JtJDfIvoR7RMDkzq7ARMfLkLZAM0nSbgKpa6y/iRjB92VDuAzbNqrNDLNsQhnv0pRdr1DMFUhcOlwJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660582603; bh=nSTObpz+pZfd/qa31LgRRNmx0RWZCOVSLgy/d/dhRS3=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=TBn0x4DpAgmyqj0OxAAEaegnKPgP7LexD2dmSK1MRFMM4ABxmCXyeFnx+f50J3OAR0jYN1maIY+4Uoygza8aCpJ/8FGr0Uk7WhWoLkoXksCPL7kKXkjN3tff7snxNo08hIMo/tQd/N9CBKzpIljC1TP2qcLl+vJ2AMjHt2I1tJYCTHFC/L7FNz7UbKz+/Z/r4prfdWquQJRt8wwsZIQGH/rtjqxWV/wPgdxkf8PCjP34Led+owAfYiaVDe/ae7zd7oYAChX8WfffFC/jzpxnT5PW/u/+/vZlCHG2xB1+N7e9o+EH/iNo+83iI8V/wr9zB8I6CRTJwfkNbUuNJX+2OQ==
X-YMail-OSG: 7GoODjwVM1lDXqG5_D.5jxXz2RvLDa.eih.Fwds5DVny5S92dJ8m2vyztLLm6dT
 oNr_UQTYtECFr2dgaB3Uz0AN_WpImeGz8oTnfhEmqD980KBsq7CWlvTQOcOgm8Y_f080QD6ruwwK
 A9h6B_4O_HFH0HC5kRtKK4xZ3w6qjWkLLn8.wfXTyR9WBIk2c_wW4WjtP7pKQ85VqGZQNhMT285H
 2uPZtuJ1VugiGR8aI4c0lrdKaAYhkQr2TiyMNSWBr0xUYeQqyYyz2cEjrnpASYdtvKcOeo9SgPOb
 ShW08WFEVG1ITcueOG.DUuOXPETwDX5Cr1MgZvSIPjH6fao6CBt7nm1nDQuMCBH9dNtj0ETiTC2k
 dyVJqBah67kpyLX6vnQgFJmLfIv_UAixxdVXt4pJ_GHSeAnWhFqH_BMVl5Loj8B58yvL8KXpNg2X
 8HSxMb14mreHFJfHxuksktn6ao7m1TUw8mruD_VCKJ1NmBLoXk4KNZr.QFrAXktO.b4_4R8xOuKs
 4tDYp.eK5amuTKeChI3kS.MtO9IO25B0wZ1a06vCYOSOJDnW_varR_5zQTeKYqjMM50IRYzG0iL4
 7ax93iwfXvde_gAv8UerW2h7gcYCBUAYhBYVYMvPmwJwpOtXzElsiaNfA8HPblsHjPGG0v6GyKSh
 aimzUwegazAyrFaJaXeYAmu5henLTwiTiRTDXe1KiFHahF2KGx5zYjBBKkI.WVAwuIt1stFIP40t
 VzbRRlHlcWkA8JXOXMGpVD0syaqoM0_Wwq9ZVjXwuRm_uLyp3okFDf4VuvGU9hAkQZNNlyN4bb0A
 jVUFQhsov2ikwkzlXul2Rdkld8D.KNRt_ubwDOtcdbp7oi1rBbqF0VQSTqRWmSKcMnAdyclEWQ4I
 uzQeMG5RF6s3j.Rq9SJXfdtIzSIPzcmdGNPEpUU1AUkzLhXRgxaGkPGbm6WQEsn5C8QPstXRenTb
 Bm87_xVsu4eG6IreDQyctd9Tyvtgy1NZnEPfN0a9CBXK2.ilOvcERausWVbEkojuLiwom8Tjg33O
 XUL9npxD5YerUl9R5kjOcWJXxjx33gguiuq6nXrAgFr1fLaDLrbTrYjocmfVxCcIeS9zNW0mwdZT
 k_PqVH2ErkihD7Rn0Tc8GU74tqVuhLeheM1R0Q7zL0tMwWraql2c9i16D6tLvx63oMzC5WMWBoqB
 UfBKlh9r2GzgoL8EILir8WIl1xL0Yojfg4S5AQ240c8C.gQfRS2JcVh9y5hYlb2iaPw4IUImc7GA
 BR1s.AK4OsrAw.hV83o9TELp76E.3u3OyMX6h_Sk_.VM.FEd4HM3hvNl2J7.9sAv4usqQbJt0DzR
 QUjXfN484nE6XAgUr62PAfiPlTUnFqvbFkQjqkUjNz8vbSrbwW01hpkeDV.RAgxkcTG3ia8Jc4Sl
 rqxRgJY1pnImg_DSALPXZGDucmPyAdQ.llTFQbKPwPlhvUdOnY8A35Tu3NTl6WjP.PW1MneyfpSt
 4hpq9Wp.L2Wlwpgwgv4GWidhic0UCngkaax1F5ZobRkoMDFuGswDYutfmZAhU045N6z9uZsn8877
 JrX7mkKuRM4BrdZ1RTwir0ABvaA1._713sLxs5pWitxRe3w3s55rhDKuWEvjG.5T_z_N.OegKmqs
 hAg9DlqvQ54wBn1dA5gsV4r0NdKxnokUSSPJQ7yOqW.IN.MtqxT2.RYGOhSk7ri8Af1mMAWNyM9n
 IZpnW1IaKYjdoI_9kyDXPOJ2FbxBvrwY8tRjigmUYnEj_cqobZEuaTijjkLa6oCfQUAQePTbz6vT
 TZqttFKEdTnuOrJjGQjcfUGEX7IdJHtRJZZhoiO1G8qgM4WEO_Yfb6b8ZEAZdmeXodQc9AcvjV7l
 fkzjSqQ6s8VIuoIfVq80q3IqV7rfhq15MXTWPOIqwDyeHdWxpcTNoUlXk5OiJFOTVmyAUQalo.fK
 _yIYVgrIQGKNve0FolcbUhmVIUsgz4wz.A8vjodig9C4PFKpWfI38Z_Lh3z2rtIGlLOr1eHUCiBx
 5wSflNhxNTxAtCTNL2RtmVKuwjM9DVwX2gB9q_dxLRxM9ifNitF4k1V0hXYPgsgo6OCZGk.jgeV9
 Um7szS5XmALzaBYFUgYRozEWgMj5sCOBBOL5WE4JdXJY2V_Yc336Nssw0ANCXi48uo.mXGoLixS8
 5Yim7ZsGRAprnQU6xyzSYiuj7b85KyEHND4CU0m1Vqz5IIdJMVLgYYozEcieIdSrOJ3CxjKyWJBt
 29dRD50lQH8aa4zdD3Q--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 15 Aug 2022 16:56:43 +0000
Received: by hermes--production-bf1-7586675c46-klczj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ddec505c2e7e4fc318c5de42ccd131af;
          Mon, 15 Aug 2022 16:56:40 +0000 (UTC)
Message-ID: <a29a66e0-2075-8084-84ad-8bd3e8a9fd4a@netscape.net>
Date:   Mon, 15 Aug 2022 12:56:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
Content-Language: en-US
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
        regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
 <bd66b5bc-4d07-d968-f46c-40cf624499a7@netscape.net>
In-Reply-To: <bd66b5bc-4d07-d968-f46c-40cf624499a7@netscape.net>
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

Hi Thorsten,

I am forwarding this to you to help you cut through the noise. Unfortunately
the discussion of fixes for this regression has degenerated into ad hominum
attacks. I admit that I started complaining about the response of the
maintainers to this regression and now they are attacking me. I do apologize,
but I do not want to over-apologize. I do not apologize for trying to get
the fix for this regression rolling again. After all, it has been over three months
since the regression was first reported. I don't think I should be accused of
doing anything wrong just for asking for some transparency, honesty, and
a realistic estimate for how long it will take before a fix is committed from the
maintainers responsible for and working on a fix for this regression. I do want
you to provide some feedback here on the public mailing lists.

I present the following message which cuts out the noise and I think describes
fairly completely the problems that are preventing a fix for this regression from
getting merged into the mainline kernel. Can you weigh in with your opinion
about what should be done now?

Best regards,

Chuck

On 8/14/2022 11:23 PM, Chuck Zmudzinski wrote:
> On 8/14/22 4:08 AM, Juergen Gross wrote:
> > > On 8/13/2022 12:56 PM, Chuck Zmudzinski wrote:
> > > 
> > > This is a fairly long message but I think what I need to say
> > > here is important for the future success of Linux and open
> > > source software, so here goes....
> > > 
> > > Update: I accept Boris Petkov's response to me yesterday as reasonable
> > > and acceptable if within two weeks he at least explains on the public
> > > mailing lists how he and Juergen have privately agreed to fix this regression
> > > "soon" if he does not actually fix the regression by then with a commit,
> > > patch set, or merge. The two-week time frame is from here:
> > > 
> > > https://www.kernel.org/doc/html/latest/process/handling-regressions.html
> > > 
> > > where developers and maintainers are exhorted as follows: "Try to fix
> > > regressions quickly once the culprit has been identified; fixes for most
> > > regressions should be merged within two weeks, but some need to be
> > > resolved within two or three days."
> >
> > And some more citations from the same document:
> >
> > "Prioritize work on handling regression reports and fixing regression over all
> > other Linux kernel work, unless the latter concerns acute security issues or
> > bugs causing data loss or damage."
> >
> > First thing to note here: "over all Linux kernel work". I' not only working
> > on the kernel, but I have other responsibilities e.g. in the Xen community,
> > where I was sending patches for fixing a regression and where I'm quite busy
> > doing security related work. Apart from that I'm of course responsible to
> > handle SUSE customers' bug reports at a rather high priority. So please stop
> > accusing me to ignore the responses to these patches. This is just not really
> > motivating me to continue interacting with you.
>
> You are busy, and that is always true for someone with your responsibilities.
> That is an acceptable reason to delay your responses for a time.
>
> >
> > "Always consider reverting the culprit commits and reapplying them later
> > together with necessary fixes, as this might be the least dangerous and quickest
> > way to fix a regression."
> >
> > I didn't introduce the regression, nor was it introduced in my area of
> > maintainership. It just happened to hit Xen. So I stepped up after Jan's patches
> > were not deemed to be the way to go, and I wrote the patches in spite of me
> > having other urgent work to do. In case you are feeling so strong about the fix
> > of the regression, why don't you ask for the patch introducing it to be reverted
> > instead? 
>
> I have asked for this on more than one occasion, but I was either
> ignored or shot down every time. The fact is, among the persons
> who have the power to actually commit a fix, only you and Boris
> are currently indicating any willingness to actually fix the regression.
> I will say the greater responsibility for this falls on Boris because
> he is an x86 maintainer, and you have every right to walk away
> and say "I will not work on a fix," and I would not blame you or accuse
> you of doing anything wrong if you did that. You are under no obligation
> to fix this. Boris is the one who must fix it, or the Intel developers,
> by reverting the commit that was originally identified as the bad
> commit.
>
> If it is any consolation to you, Juergen, I think the greatest problem
> is the silence of the drm/i915 maintainers, and Thorsten also expressed
> some dissatisfaction because of that, but since there is also some
> consensus that the fix should be done in x86 or x86/pat instead of
> in drm/i915, another problem is the lack of initiative by the x86
> developers to fix it. If they do not know how to fix it and need to
> rely on someone with Xen expertise, they should be giving you
> more assistance and feedback than they currently are. So far, only
> Boris shows any interest, and now my only critique of your behavior
> is that in your message, you chose to engage in an ad hominum attack
> against me instead of taking the same amount of time to at least
> briefly answer the questions Boris raised about your patch set over
> three weeks ago. Your decision to attack me instead of working on
> the fix was, IMHO, not helpful and constructive.
> > Accusing me and Boris is not acceptable at all!
>
> OK, I understand, now we are even. I have said it is unacceptable to
> not give greater priority to the regression fix or at least keep interested
> persons informed if there is a reason to continue to delay a fix, which
> ordinarily should only take two weeks, but now we are at more than
> three months. Now, you are saying it is unacceptable for me to accuse
> you and Boris. OK, so we are even. We each think the other is acting
> in an unacceptable way. I still think it is unacceptable to not work on
> the fix and instead engage in ad hominum attacks. Maybe I am wrong.
> Maybe maintainers are supposed to attack persons who are not
> maintainers when such outsiders try to help and encourage better
> cooperation and end the hostile silence by the maintainers who are
> responsible to fix this. But that does not make sense to me. It makes
> sense to hold accountable those persons who are responsible for fixing
> this (and you, Juergen, are not the one that needs to be held accountable).
> AFAICT, that is not being done and instead I am being attacked for trying
> to get work towards a fix rolling again.
>
> >
> > > I also think there is a private agreement between Juergen and Boris to
> > > fix this regression because AFAICT there is no evidence in the public
> > > mailing lists that such an agreement has been reached, yet Boris yesterday
> > > told me on the public mailing lists in this thread to be "patient" and that
> > > "we will fix this soon." Unless I am missing something, and I hope I am,
> > > the only way that a fix could be coming "soon" would be to presume
> > > that Juergen and Boris have agreed to a fix for the regression in private.
> > > 
> > > However, AFAICT, keeping their solution private would be a violation of
> > > netiquette as described here:
> > > 
> > > https://people.kernel.org/tglx/notes-about-netiquette
> > > 
> > > where a whole section is devoted to the importance of keeping the
> > > discussion of changes to the kernel in public, with private discussions
> > > being a violation of the netiquette that governs the discussions that
> > > take place between persons interested in the Linux kernel project and
> > > other open source projects.
> >
> > Another uncalled for attack.
>
> I am just asking for some transparency and an indication that
> a fix is really and truly in sight. It would only take you a few
> minutes to fulfill what I am asking you to do now. The fact is,
> Boris commented on your patches over three weeks ago and
> asked you if you accepted the approach he outlined and you
> have remained silent. That does not indicate you and Boris
> are close to coming to a fix even though Boris stated that a fix
> is coming soon. Based on what has been said on the mailing
> lists, I just don't see the fix coming soon. That's all I can say
> about it now.
>
> >
> > After sending the patches I just told Boris via IRC that I wouldn't react
> > to any responses soon, as I was about to start my vacation.
>
> That is certainly a valid reason to delay work on this - you were on
> vacation. I hope you enjoyed yourself and had a good time. But I
> had no way of knowing this because I was not part of the IRC
> communication, so I cannot be blamed for not knowing this.
>
> > I will continue with the patches as soon as I find time to do so.
>
> I am willing to wait patiently for you to get back to these patches,
> and I hope you can agree that you should find a few minutes
> to confirm or deny Boris' statement that a fix is coming "soon"
> by posting a public message to this thread within the next two
> weeks, given that this regression has not been fixed for over three
> months. I will not be upset if you say something like: "it looks like
> it might take a while for Boris and I to work out the details of a fix,
> it might take until the end of the year," and briefly explain why there
> will be a delay. Boris might not like that because it would contradict
> his statement that a fix is coming "soon" but I would rather be told
> the truth - that the fix is going to be delayed, than be told a lie - that
> a fix is coming soon.
>
> Thanks for all the work you do.
>
> Best regards,
>
> Chuck

