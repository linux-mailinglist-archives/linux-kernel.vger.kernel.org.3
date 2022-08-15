Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22100592814
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiHODYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHODYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:24:02 -0400
Received: from sonic316-55.consmr.mail.gq1.yahoo.com (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBD13EB4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660533840; bh=+0Y8TZWBkL5dpqoymOPHRQQ+QSIXXcJpMyTnWZbMEXw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=byd1REw8QJQMKvKlEszRnmGkClyZVFYagterdZZK8nmk6U6Urj9NYh7QD5zrjDr9z5V0Igm5sNDzD+XBjhUjsrsnWFVEz1BrLgH3r7DilZ8h91l0Rd3g0st4ouxhQVlIaylBoAlJyU6bn8v/poawiPunfDhppxTfAEaSg4sW0NrvUNMYJY/DWgAoROhXO+RPlPdgHiIzaqcBnretvqnQEfVfVrJXxz0W2wZ7SDfCI83cK7hmKevCKFARzzibdWUOfP1UzkoM7AaIFSL871DVuHusGhbfldQZlVvOX8VKLN6HvVoYgpLSXq1Z7/L51Zq0fBrey+9gPRKgWGQtDWhE/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660533840; bh=+5C/iZByjZ/2wOomGaedHuNgyLtTBTw9B8hQED050Ut=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=N24f7Q5MQAAKc5jok1EyqjEa92lQTh8QccnkJ+BCYxP1ngOAa45fpKO2Cv7OqSie+j+7RvHpIvgepCSC5XaOhI1cGZErIP4B0twUcH0ly4Aa2n/aCbF38103nCkUnOqVMSsAxJHUVnVs8Pss/3ikYL8XiQq7tthcYVQ2YYrSX3NNDQ4oPMjyDn5MC/xKS6XXD7By2xofoFYfc/jp1yHIDUNrgm6pDuvUspldffHQCXWEKhKRVHl/TQgG83tEp0lNUWqqebJnR9robpHR0IqoUqHDG/sheDcXfxALONTogbRzZw18GdBUEah2kdMEd+K1MNjS54LPFDyts+4tb4m/ew==
X-YMail-OSG: iT6a2IgVM1mPgHS3fy_sk.HMG6a8c5mvjAIdmeD6gGBgp9R_KECMUlYAlE1TxvX
 qCwjbM0ShpWjQzg_H9sy5VaAL4uhNJRfqWkysT4B4qdzlrP9mDi5kMHEV3Mt6SDhg190TDdZt5ka
 jXOpmkZ5wk80j0PjK9yCn.F8bdWmAB5Wdn4hZ0dwAoFmx1oNLGPuvJMdry1WhGOqOS9mkiBkpqY8
 bOuikzcXrsZKcA06YRVzfYEiKQ4jjpQBoNLbLIEeUa32lSFvjdeyv2Y.bEGhUdfqXV0z4wQF8UPs
 OVrtnLB1bYLb6GrK6yYAaAqH9jyUz89Ty8GVOwNIBwYIsbZUaSlE.rLlZDU13g_gvnfElFxjVwG1
 XHVFW5VbbGyJi8qMPf8lOSn3gG_GEpliuiGc8PZ0j43hbJNqx_vlhIVZicCF99at5oHinM3VbKU8
 Xm81oE.wiTB2UAUB0UTmOaXdrV.j9H4YRmvBlRF5CUZRER4FeHdBSpVYw56YrCq9P5UNIuOeX9I6
 t3.C2qce.Joqqrw803vzK7430uo5KT4o0dpzrtK8uGkFb5N9Ueq2yX4_F0N0SYvbrkX4iGpJs8VZ
 zljyPVMxw3USwETCTGFuTnUdswbWq5x2oA6aNdFcmlwJwz2ZzxUj7Iu0Ilzdc2jiOkvYoNP6lebp
 f7Y4oOh03HQ1FLY4jPzLViaWdtF3jcWyPNCjOTBJZLXyuIZrWk4XY_88YkkCeSuqQz0gTUVCOw4F
 tMynGzuMnLUQmwLSSdyj5UOGZTGoKXHONaYwY0MfDnKzMSf88x8Va.RNlhm6sI4aVJ7likFtQRLA
 zo4feaNCZCAL2L0Yz6JWjuPEzoIEj7gG2xv7SW1hICte1hGPQReg0ghnXIxbmn1gz8DHvNj1.sDG
 VIXhr_f4FzndPal681VGVnRHcaKz4a0UBRz.10vvPBzojzQMEKJ.TcFpshgyMrlweLdNcyAoMwXm
 mqR0nvD_LAmXDeYe3kBiEHnzaVDbc3jztRP_gzvi4i.9fymWsZbSayhqpMUV6GQspa7Bd6w77GaP
 sVwxAaDVmQU8QcbO5mouFLiPIa_zAcLp0X.FUnOQp2YlKMnGiDnjNGbOBLRppkytLVUP9yRzJxyj
 3iSC9k0lDv35aXtvSfo_5LDKiphOxT_bhnpCx.aCYgaCybpXW5vHqFB8f_qtFartBQEBZj0kyjMO
 OKs5fSd6C4LtxZ6LH146NfDCGnV0jx3E9k_B6_SoGbtOZWDaV5f6lTqx7vmaMpgDdWe5NeFbHyiH
 0B2jWGuIZNwaGYKWA3TK1FhbE2YXG5W2hAW9_CrtuaXNAEHjRq4E5GV0g.HZUVn8U6EqGasVy9zb
 1mudNVyNXi9PIYBAVx2gQCVvosydSOz1VduFxXMFkWHzlJPE.c5rm2_6IZDbTIxwqGl4dfyMKm2i
 5iZu7lcVLQ7faOOjLqDUAy80rivNxl7CP49L4Fuj6TXkvQ823V3byatbeBQksDjZ4LTo6IcqkURQ
 286Dtkiyu6vFUW_yv5D7mh_EadNnHBmsjkwN930gAnZ_.0XXUdeGdc8J0u6vKDBzQfo4eMOMRvET
 X9PBA3TmL3J0zH9aLQIXb351be3zPjGPeDVDDGoUdsz2Ue0Xfdinae2I.Xv74cIrRt3eMw1LBaKP
 s8BXCYgAJ7Woz7SWLkhOVwlEIOPnl3mgelGRDA7A9VHS55kgJbdANKUexLRpLtacKV.qs2Wup61i
 MfZt9ObeL22GYbeUlhXe0IQCsBqRtRMjuW3dtjebQtnkxEh7p93VCIYePnTww74XwKJwPfpil8cl
 x_1sCt2GApwH9hXLAtYbV5uXdTikFl0Ys7iAgWG2sKngiX4C9RHvcu8CLJUWBAKxJ8CJIUMW5ZZV
 Y2dmXkkWMceuv_ZBHFu2hJZtL8U8CShmBZZal9.40Y7uXtNzNi4.UFDdVxAYWVjk2utP3L2lqU4A
 QrgdEBOoGUoMwGvTNT0iFlpOHVkPzQ__WsS5TgOC5.UhoAR4DqMwtOyjVduR_VbeQCIkg4yJImSr
 wOOuB1cleb7M1teGcnihcazqJ9Ynq_5Umnzcv.czUJIEX5a0.ShYfvUUQnorLKyuVa.Yr.IcNnTR
 qy5PooGuwwWCxwdEOcXU7d9sBXGcbTCnNWpii7asE5fYT8fUjsC5mSoLCXHhEkFp244Bt7zauiEc
 3ne8WuY9z2Keh.UmGsa7fTk1aw6d4to0_9eX5mpBJiU1nh39kn3_dY8606hSAnDAtoBOLpQxQoWr
 b2oGRJ.LxklbKx8V7gq_fxUpFishnpvidiu7q8fNckTDRfS0IvmxYoB7xR9.hc4AzX0ZH7w--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Mon, 15 Aug 2022 03:24:00 +0000
Received: by hermes--production-ne1-6649c47445-tp7sw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d48e2d8ae8618fd24b295ec04d4556d5;
          Mon, 15 Aug 2022 03:23:54 +0000 (UTC)
Message-ID: <bd66b5bc-4d07-d968-f46c-40cf624499a7@netscape.net>
Date:   Sun, 14 Aug 2022 23:23:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Juergen Gross <jgross@suse.com>
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
        linux-pm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/14/22 4:08 AM, Juergen Gross wrote:
> > On 8/13/2022 12:56 PM, Chuck Zmudzinski wrote:
> > 
> > This is a fairly long message but I think what I need to say
> > here is important for the future success of Linux and open
> > source software, so here goes....
> > 
> > Update: I accept Boris Petkov's response to me yesterday as reasonable
> > and acceptable if within two weeks he at least explains on the public
> > mailing lists how he and Juergen have privately agreed to fix this regression
> > "soon" if he does not actually fix the regression by then with a commit,
> > patch set, or merge. The two-week time frame is from here:
> > 
> > https://www.kernel.org/doc/html/latest/process/handling-regressions.html
> > 
> > where developers and maintainers are exhorted as follows: "Try to fix
> > regressions quickly once the culprit has been identified; fixes for most
> > regressions should be merged within two weeks, but some need to be
> > resolved within two or three days."
>
> And some more citations from the same document:
>
> "Prioritize work on handling regression reports and fixing regression over all
> other Linux kernel work, unless the latter concerns acute security issues or
> bugs causing data loss or damage."
>
> First thing to note here: "over all Linux kernel work". I' not only working
> on the kernel, but I have other responsibilities e.g. in the Xen community,
> where I was sending patches for fixing a regression and where I'm quite busy
> doing security related work. Apart from that I'm of course responsible to
> handle SUSE customers' bug reports at a rather high priority. So please stop
> accusing me to ignore the responses to these patches. This is just not really
> motivating me to continue interacting with you.

You are busy, and that is always true for someone with your responsibilities.
That is an acceptable reason to delay your responses for a time.

>
> "Always consider reverting the culprit commits and reapplying them later
> together with necessary fixes, as this might be the least dangerous and quickest
> way to fix a regression."
>
> I didn't introduce the regression, nor was it introduced in my area of
> maintainership. It just happened to hit Xen. So I stepped up after Jan's patches
> were not deemed to be the way to go, and I wrote the patches in spite of me
> having other urgent work to do. In case you are feeling so strong about the fix
> of the regression, why don't you ask for the patch introducing it to be reverted
> instead? 

I have asked for this on more than one occasion, but I was either
ignored or shot down every time. The fact is, among the persons
who have the power to actually commit a fix, only you and Boris
are currently indicating any willingness to actually fix the regression.
I will say the greater responsibility for this falls on Boris because
he is an x86 maintainer, and you have every right to walk away
and say "I will not work on a fix," and I would not blame you or accuse
you of doing anything wrong if you did that. You are under no obligation
to fix this. Boris is the one who must fix it, or the Intel developers,
by reverting the commit that was originally identified as the bad
commit.

If it is any consolation to you, Juergen, I think the greatest problem
is the silence of the drm/i915 maintainers, and Thorsten also expressed
some dissatisfaction because of that, but since there is also some
consensus that the fix should be done in x86 or x86/pat instead of
in drm/i915, another problem is the lack of initiative by the x86
developers to fix it. If they do not know how to fix it and need to
rely on someone with Xen expertise, they should be giving you
more assistance and feedback than they currently are. So far, only
Boris shows any interest, and now my only critique of your behavior
is that in your message, you chose to engage in an ad hominum attack
against me instead of taking the same amount of time to at least
briefly answer the questions Boris raised about your patch set over
three weeks ago. Your decision to attack me instead of working on
the fix was, IMHO, not helpful and constructive.
> Accusing me and Boris is not acceptable at all!

OK, I understand, now we are even. I have said it is unacceptable to
not give greater priority to the regression fix or at least keep interested
persons informed if there is a reason to continue to delay a fix, which
ordinarily should only take two weeks, but now we are at more than
three months. Now, you are saying it is unacceptable for me to accuse
you and Boris. OK, so we are even. We each think the other is acting
in an unacceptable way. I still think it is unacceptable to not work on
the fix and instead engage in ad hominum attacks. Maybe I am wrong.
Maybe maintainers are supposed to attack persons who are not
maintainers when such outsiders try to help and encourage better
cooperation and end the hostile silence by the maintainers who are
responsible to fix this. But that does not make sense to me. It makes
sense to hold accountable those persons who are responsible for fixing
this (and you, Juergen, are not the one that needs to be held accountable).
AFAICT, that is not being done and instead I am being attacked for trying
to get work towards a fix rolling again.

>
> > I also think there is a private agreement between Juergen and Boris to
> > fix this regression because AFAICT there is no evidence in the public
> > mailing lists that such an agreement has been reached, yet Boris yesterday
> > told me on the public mailing lists in this thread to be "patient" and that
> > "we will fix this soon." Unless I am missing something, and I hope I am,
> > the only way that a fix could be coming "soon" would be to presume
> > that Juergen and Boris have agreed to a fix for the regression in private.
> > 
> > However, AFAICT, keeping their solution private would be a violation of
> > netiquette as described here:
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
> > 
> > where a whole section is devoted to the importance of keeping the
> > discussion of changes to the kernel in public, with private discussions
> > being a violation of the netiquette that governs the discussions that
> > take place between persons interested in the Linux kernel project and
> > other open source projects.
>
> Another uncalled for attack.

I am just asking for some transparency and an indication that
a fix is really and truly in sight. It would only take you a few
minutes to fulfill what I am asking you to do now. The fact is,
Boris commented on your patches over three weeks ago and
asked you if you accepted the approach he outlined and you
have remained silent. That does not indicate you and Boris
are close to coming to a fix even though Boris stated that a fix
is coming soon. Based on what has been said on the mailing
lists, I just don't see the fix coming soon. That's all I can say
about it now.

>
> After sending the patches I just told Boris via IRC that I wouldn't react
> to any responses soon, as I was about to start my vacation.

That is certainly a valid reason to delay work on this - you were on
vacation. I hope you enjoyed yourself and had a good time. But I
had no way of knowing this because I was not part of the IRC
communication, so I cannot be blamed for not knowing this.

> I will continue with the patches as soon as I find time to do so.

I am willing to wait patiently for you to get back to these patches,
and I hope you can agree that you should find a few minutes
to confirm or deny Boris' statement that a fix is coming "soon"
by posting a public message to this thread within the next two
weeks, given that this regression has not been fixed for over three
months. I will not be upset if you say something like: "it looks like
it might take a while for Boris and I to work out the details of a fix,
it might take until the end of the year," and briefly explain why there
will be a delay. Boris might not like that because it would contradict
his statement that a fix is coming "soon" but I would rather be told
the truth - that the fix is going to be delayed, than be told a lie - that
a fix is coming soon.

Thanks for all the work you do.

Best regards,

Chuck
