Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E888591F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiHNJTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 05:19:20 -0400
Received: from sonic312-23.consmr.mail.gq1.yahoo.com (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934EE37F95
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660468758; bh=8iIA02dH3r2aLoyEecV+4evgi7/R5+ofGdB8rtP7gHE=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=JRRO7blCoIV4kPhTsnKnu29A2WNECrGKDiMs0Zde1Ma2SasJqZWNloIO7vSVkNu9CmlOkWVsT77H7b9FeHrMiQLueCqWNfg7qoxO6lgNQZhYIpiNSCjADu9LdgkiA8WD+ZF4A17o40MMqmxHW6U4Y6XQyKbg7BGM7rdUTumg6yBNqzc3rUQgIyTpfl10sJscowyZQAaB3yLT4S70XKjDLXOl0sDE2Dpl7jhHPZ+8h88PZYrpX6WCqWraCQHk2/m2eOwug3mLowtP+6DCdIcmFHbuAv0UcxOSkdCwtbDzOiTa0PkVHHX2wuBMYbRGYKEXeKyyPDrURMRXnx2w1T8/Ng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660468758; bh=wIaCdc2m0rr0QpUnWym3/C1TvLdrbrAjWN0w5qLpQFG=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=NclwQIYDoAbIzbrgMsWrpgmDKqT9L1RqM0dHJCStmBuyxG4bXdhw5SoN4V0j2pmVKuCH2sJORcNCtvKSudrAKMLK4zIQhRAhqzTFCXy9jq1InOfqTsTMdQl1cxeQ8yaw7O8Tq2uJbkpOkHJmgqvDXSuj7hkrxH28tUe6zXP6yzml3N0+0FcxFcEne92LrtedmHyuZuXV3nLIAdOCYgo6jvgEx2BWxU3CiC1w53QDT6obioANt2ypd+rDz/8wKkzXpYIrH/8d5mUIpwmv4s0vAxd321weag+NZR3b+kmx7hc0gddShub+G+XTmV124z7zRnooEg3lIsdDs7Llp+jDMw==
X-YMail-OSG: rNlUVtYVM1kM3tGTHO68rRkykM6AVI9PYGnwI0Gxgp5H2..AzTR4taMuRnF4Qac
 WbriozOhUKPMcGZWFDOHqUnPBznhPulnduPlIg7jneGTbmQ_WSBhGLwGf_M21RAzIri0hcu78P34
 Zh6H2cpOe2Ku98vTRtQaq744BudSuSGq_Yb7dx.x0mj4bkfJ9jpjP_63qrBZrm20kfjFRePWrk_h
 jDRXWVULwIHfoRZrH7fAKwXZujglImOH4QwcI9TRqfqElx_qpbYs1hGxbtxphfCiso65HIbsw_qK
 oV4tOv7.XBgYVZy8jPhTC92GJ8TRoQZs9yIVU4bWNUTo6lpfgi8bshX4FfSYOACbWHGpoJKa4cxe
 lARHbwFCF_8Y3aMJi7J8j7mETxcgj04d74QSps6CPF8NZxyIarU1GH36nrMxrHHavxyV4sFjheCF
 LlTLdiSFd9Aj7E71rz71j4h0eMGKbY3DSRCf2uhcjQL_g4shcu4HqQ53E.z4SLgiWwE3I9BlcNK5
 NNtShrnYnkwPfSfBGnStZ.__opD3dJ0QeJy3EWFSAngEbhvmAWsZd2iE1TszsTYpnv_u647Ofi0T
 CwCYs5aKouoD7X24ncJDfHnxgxIweImgwj88aMaJmlHDZ_27308Dmqiy4e8kwUVgyrgRaQVKt.ow
 7fi_QfktliIflvgiTwBclyGHkkvb4gZMdoG7QuFWQu0i69DbBwEqR_9UYMzCtgG7G7xhjT7ExibW
 KnVd6qR1TCHQxdUBjsgg8bhh4g5MttTbQVQHKrN9DoPamZzmMo24p5b0Q5mg7ouJmhTe3AH1JlPU
 xuWn2eSK6U7GVQFfI7z.HPkNyfSLwz6mxdYSc2pdtJAK190s7ZLBQ6juH96.7haM17SbSy.MiGhr
 CSwEYWXz11piPJb_VhpQAegr_nkZWSn0_1noxu_cespzvTGIije9TDwdxNXW6GYHSxiqiuClnIqP
 HKp8Krmp_qqp7oEraA8NoF1vw28X38apn_mQHf7J5RuZNxLuG5TvPnlWvpbAopGYLxyD0FPZxvjB
 nJR9LbFbEXJPSWsFgV3Roo9.QvIjOfCCWGOTn5EJ2.DEDAjHYBtPD7yGAqJAxX8aiUrzSSdtMZfP
 BbKpCExvstCRtPlZAO.cxDf0npgErVEcIMd51lmZIKJo7xVa9Doy.tDgEgacycP5YO7vUg6.vtNE
 MHMOV5cM_Hx4I27D9boDF45qsoGjc5MOlAIpBMaZZAvmk9wQd7sXdapIpGYt6uE_0Nrszz4C5gsw
 5nFpg.uIzI6OD5p54bC69ycZUm50PcivLsYTmfRlK3.ioTaWhwTs5mso9iDcxBX8mMD2dH.IjiED
 Hk.MMzvQb8Lc02yCPwMj.26jh74Lf8LDgnfQsw9mCoRc9SZSASBWLtdGY46.H3C8IyNc7qRQCflw
 TB2ceSOJbv.Zu9RXPo5u4vSmB3SI86VqA6cgans5Zd.jTUgBKTzRps1WEt7Okfxda.jO736eQvSU
 l_Q_dkseKsDbCH1I6IIy4gf3yM41AhfR4z04NFzAtXph6cjGxGFb_ipQ.20pzB6n8h2qkjNmEUmy
 AnG4u_QCK60UAE2suFcdlpiYmrXfkRKtgXJOcspe5vJjTwhDPupbPH423lApIGprftUM_YcntJ.Z
 5T2KVOWQ_hb8jjRGlTr6ZjZhHZP.8q8TmLkHdnxRMNvPYmvixgerJn3LiDMHkSBIzPtAdfBWDxuP
 1lpZrOYJDz1b2AG9HnN6ohyflQGFxcagoa3xsq84Mdu4gEFYuKvn28FDLXKvrrYRk2ChT8G73vLB
 qgEIKZ0ErmRXQKgxYvj2mJIp9l.AOIxzmD7SCkpLbFjfR8vT6ekANR3PpKJrHWnVY9MSVQM1Si_v
 o7ZolplfVlLGSPNLLAH1D7WER0j_E9BoHu9r1MSx3T5085elcGwi28NBCWav.5jPl3oK_Etwjqjm
 2DK4nR4xxkyVP8EkvhYi4kCD39B5Bmw1gwI.XwHvWYwShNimVlyyngQcprMqchoJUONpDn8gfZ1e
 CTMRdkeFrGXi7B2nTb.Vl8ipeIDCw4nCC210IBf9G7pOGCQhhqDVncK1ORq4VdyJsU3hcU3Ua.vm
 lW1U6ta7FIpJlQFLG8ObqZOjd6C.BA.fWYW2kScIoHBBpcdhmqawOk7NuAeJ_1ZN3fFdNFgE7EjT
 kcgrW9FcJ8uJ4blgvXEd9GeTAntuSX5oDLwZ6RerPTakCugIkNWuMmZfqvyySRLrfsxE5EzyP4mi
 1Cge_0xm9.aZyhsysAm7Ymo7s5nm9lw--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Aug 2022 09:19:18 +0000
Received: by hermes--production-bf1-7586675c46-6jlzf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0eb8331defe85a8add7b909f415843bf;
          Sun, 14 Aug 2022 09:19:16 +0000 (UTC)
Message-ID: <4688ee9b-1b18-3204-cc93-c6ab2ce9222c@netscape.net>
Date:   Sun, 14 Aug 2022 05:19:12 -0400
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
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
Content-Language: en-US
In-Reply-To: <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 8/14/2022 3:42 AM, Chuck Zmudzinski wrote:
> On 8/13/2022 12:56 PM, Chuck Zmudzinski wrote:
> > On 7/17/22 3:55 AM, Thorsten Leemhuis wrote:
> > > Hi Juergen!
> > >
> > > On 15.07.22 16:25, Juergen Gross wrote: ...
> >
> > Hi Thorsten,
> >
> > This appears stalled again and we are now over three months
> > from the first report of the regression, The only excuse for
> > ignoring your comments, and other comments on the patches
> > in this patch series for this long a time is that the patch series
> > for some reason cannot be considered a true regression. If this is a
> > regression, then, IMHO, this needs to have a higher priority by the
> > maintainers, or the maintainers need to explain why this regression
> > cannot be fixed in a more timely manner. But continued silence
> > by the maintainers is unacceptable, IMHO. This is especially true
> > in this case when multiple fixes for the regression have been
> > identified and the maintainers have not yet clearly explained why
> > at least a fix, even if temporary, cannot be applied immediately
> > while we wait for a more comprehensive fix.
> >
> > At the very least, I would expect Juergen to reply here and say that
> > he is delayed but does plan to spin up an updated version and include
> > the necessary links in the new version to facilitate your tracking of
> > the regression. Why the silence from Juergen here?
>
> This is a fairly long message but I think what I need to say
> here is important for the future success of Linux and open
> source software, so here goes....
>
> Update: I accept Boris Petkov's response to me yesterday as reasonable
> and acceptable if within two weeks he at least explains on the public
> mailing lists how he and Juergen have privately agreed to fix this regression
> "soon" if he does not actually fix the regression by then with a commit,
> patch set, or merge. The two-week time frame is from here:
>
> https://www.kernel.org/doc/html/latest/process/handling-regressions.html
>
> where developers and maintainers are exhorted as follows: "Try to fix
> regressions quickly once the culprit has been identified; fixes for most
> regressions should be merged within two weeks, but some need to be
> resolved within two or three days."
>
> I also think there is a private agreement between Juergen and Boris to
> fix this regression because AFAICT there is no evidence in the public
> mailing lists that such an agreement has been reached, yet Boris yesterday
> told me on the public mailing lists in this thread to be "patient" and that
> "we will fix this soon." Unless I am missing something, and I hope I am,
> the only way that a fix could be coming "soon" would be to presume
> that Juergen and Boris have agreed to a fix for the regression in private.
>
> However, AFAICT, keeping their solution private would be a violation of
> netiquette as described here:
>
> https://people.kernel.org/tglx/notes-about-netiquette
>
> where a whole section is devoted to the importance of keeping the
> discussion of changes to the kernel in public, with private discussions
> being a violation of the netiquette that governs the discussions that
> take place between persons interested in the Linux kernel project and
> other open source projects.
>
> Yet, in one of his messages to me yesterday, Boris appended the link
> to the netiquette rules, thus implicitly accusing me of violating the
> netiquette rules when in fact he is the one who at least seems to be
> violating the rule forbidding private discussions of changes to the
> kernel once a patch set is already up for discussion on the public
> mailing lists.
>
> Of course Boris can exonerate himself completely if within two
> weeks he at least explains on the public mailing lists how he and
> Juergen have agreed to fix the regression. I sincerely hope he at
> least does that within the next two weeks, or even better, that he
> exonerates himself by actually committing the official fix for the
> regression within the next two weeks.
>
> However, I will only believe it when I see it. When it comes to the
> Linux kernel, I go by what I see  in the performance of the Linux
> kernel in my computing environments, what I see on the public
> mailing lists and in the official documentation, and by what I
> see in the source code itself. I do not go by blind faith in any
> single developer. I am not religious when it comes to the Linux
> kernel. Instead, I am scientific and practical about it.
>
> Finally, please forgive me also if I am mistaken in my assumption
> that these rules of netiquette apply no less to the developers and
> maintainers of the Linux kernel than to others who wish to offer
> their contributions to the development of the Linux kernel. If the
> rules of netiquette do not apply to the developers and maintainers,
> of the kernel, then, IMHO, the great advantage of open source
> software development is totally lost, because the advantage of the
> open source software development model depends at least as
> much on free and open access to the discussions about the
> source code conducted by the developers and maintainers as it
> does on the freedom to have access to the source code itself.
> If someone here tells me that those rules of netiquette need
> not be followed by the developers and maintainers I certainly
> hope someone else will come to the defense of those same
> wise rules that have allowed such a successful open source
> software ecosystem to flourish and thrive around this project,
> the Linux kernel.
>
> IMHO, the day someone make the decision to stop enforcing these
> wise rules is the day that the open source development model will
> begin to lose its advantage over proprietary software development
> models. And perhaps the most important rule of all for the continued
> success of Linux and open source software development is the Linus
> regression rule, with the rule that discussions about changes
> to the source code must be done in public being a close second in
> importance to the Linus regression rule.
>
> Best Regards,
>
> Chuck

Hi Thorsten,

Well, that did not take long. Juergen responded with a message,
which is encrypted and not delivered to my mailbox because I do not
have the PGP keys, presumably to make it difficult for me to continue
the discussion and defend myself after I was accused of violating
the netiquette rules yesterday by Boris:

https://lore.kernel.org/lkml/c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com/raw

Fortunately, lore.kernel.org did decrypt Juergen's message so you can read
what he wrote in response to my message there. I don't think what Juergen said
there is very constructive although I am not surprised he seeks to defend himself,
and he makes many valid points that are good for developers and Linux insiders
but not so good for users and the long-term success of the Linux kernel project,
so I am not going to reproduce what he said in this message, but I think you
need to read it to help you understand why this regression is not being fixed
in a timely manner:

https://lore.kernel.org/lkml/c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com/

Sorry for the trouble, but I am just a user trying to understand why this
regression has not been fixed for over three months.  If this is the best the
Linux kernel community can do in response to my questions about this regression,
then in the long run, I can assure, you, the open source development model is
doomed to a slow, long, and eventually painful death.

Best regards,

Chuck
