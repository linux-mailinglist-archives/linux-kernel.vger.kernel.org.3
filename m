Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EBB592366
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbiHNQUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiHNQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:20:29 -0400
Received: from sonic306-20.consmr.mail.gq1.yahoo.com (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD081115F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660493010; bh=v1wxdWmS7PzJ4GTDnvJwg409BHbOVzpx0sX5IXkXEQ8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZRp8UM9Ksuoe0l5sKKVpzcYRynNIpZ0UGvW4IXPh39EnkJOFDFhGiaIHvny4s2bwMbPsodfytc6z5Z8EyJIUrFANJgz6lmt0sUD9kBTl1BSM04kKwORliniybQ+NSLD/iC1azL0GWGNkvfTUdSNUFz6Y1ZzeJ/eFyAovrLzjgj1yQOYsXbv4uRNn5FB5jqUIFK8wdRVCKNxi8vZu2UGuTMmXgkBDQGO8NqWyAbJjcvZ+8Y5gfIgKyEmTNS7/+RjqZGCGbOCD+ZIkdm6sfs/2OBcxo1SXsilOGfUWdGPNxpeQSPdQ0AwYPiWBizN8BA2Moc/goKII/5m8pwBBtSdIHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660493010; bh=jAB2lbTuQpY5S6t3qSGZ47a6BzDgaFET83mKTD4m61w=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QshC+MWNnXm/6Chg2HlJKChlzuDctlq96f8DED+2E26SzY++MGP10NKksHtDUGmxESsZc6gY4xTyEH1bhHpQAJeX+PRHYUx0Jpw2AbR52DVOSapS7eh0lBAAeLV3kyPKBauYPRnN2yKyO/eLb3bV88H45X8Z2YRT2hO3RztK+FombVtytQBhpqGe8VcSLeZ0Dxs/sb7yPM9EfKJQmksnxvy+/dhgGg11ksUwyFkomhXRMiLTMwbevmU12JtKX1DZXCY3oFDfxMZhC6LExi1qtVjGBh9z6kZSGFp66O/M1XDeCy2ctNMkvLro21yNAlNaqLmj3Le+adh6cbH3n4jApg==
X-YMail-OSG: VwYA2mAVM1ngjslb92eTdmY6IPdA2.5XNKzC_Sc4CgFhVQoaQTYh1H.kM21MlVk
 UgE.aZNMTMGOW8oeA92sc.ApZ3mLbezib.YzW6Ubt9ydiviGnk3Czdjc0Za.ll9l3yqWoRD2otDT
 6MKg9ztY94diBre83aWDqmDF8LA9AikcOU0H2_hiOfVfDup3yk0UDNWkWzhlYmTW4RV.WYt22OcL
 TicanIQEDjCgaLIdeSxo.iepKQGlTlWKy1mpMExRDyE02C7ZfWn5eAmatDMZ4tULPv_wGhWLTCV5
 y_cumtDEBbQLvZAJPMFa_OGuoklRaahCJh1P9Qi3N.KkNc.d7Qf9ALlnapI1.0kTy6e8d7IJkmTa
 wmpCjYzuxPDIu2WcVXSmbJWAcuLgq7Sdfggk91pkqfifWKFVTyWweRv7lkezJ8Yvan1ifZ8cJVn_
 tiefnzNG0Jf4jCad9Aq1HrhbTt34ChZpguF3ZvueONwE5esOrjkUBUgQ7esUzuh0874X0WAEccp9
 C7CZF7m9ZUpo6BR0TTN2f30M0B_.DrADLSHm3HvC6ilQxv3MG8nwQd2RZG91KrCe2CDWhqmFuDx5
 QmS1ZzR03pKX.janC3sTeALWTTI4IQQFCmVLozc05x.DOn64_jrWfWOUPjQQiGXXrBRp20rNdGQA
 cKI06xJbYEHvjcZ38KRFUv4crWM0Y8qOO_ZyhNnw9LPy1vCr2LXn4s8AMzUUcOp1PfCwAOdm1bsc
 7dkOPN7NIY0AWX7XJ0ZMro69GsqOWl2vuXV47dqqt0Xgj8re21dvRmRuLlJxGkixDwBuVClvhih4
 0qft2XMMKBJAsVAFOHMrMMY23NgNL.QZOVnj0Kqq.Gs_fKZaM1hkwX7uKWHIzz1_v1kB85u1Wchf
 tXVJNKqlHQjAVmxo4YUo8aXAhKR25j_xSerABFvIwRUY9cqaDVQli1CjE6LfFIAIue_0dDHJnHLn
 wdyEIN7wVPgHp_5Oor1FyHir__M_e6sTCa8pEZnOlzHchWQRBFf4BYYzHMb3Lnn8h41gEL._XMFD
 Fd9BcOZoTPFZx.b3PKN3N.KYrhTOhSCMC0MILGjMD_HNxRA.z11pyQ2I_KEae9O0umcc6FxTcSKX
 6t6OYMNFQ.0V4jvActkMzhPV8WWLje6vNpBGrhwNQAB8Ag3a4NQ_56GJJQjyCytfQnJNaycpVke7
 Db7RUYT3hSG95G4CE6w0OPqzCPk9YV5r8oYgmZK7QOIkorhm1p65UgLW2K4HxCA7yrKRYsTkUr1Q
 5idRjus0ObcX77QqYuUdeOdKcr9czVxS4eEglfExjE3KRZHtlxIi0o8.K_pUmHjujisIb7oqQu40
 KIXJGKrMHIfHbE.k4.xn7bKfbO_kSeT1Rb6vWBS.O7JsLpfrdeCc236d24VU8h.rv70j9ZohDt9K
 _cKb0qn5em1oKqLDhsphSru3tPawGDPAUX5ltYKlEZebAwZUlL_KOWuEtLy1g6fmOyCQlitcjYKa
 EtxF06Cf2zFMdFYh2dtUlhsSyrfc87HkpnK0AQ6pYkuAlg6VheW_I3l1ZzXddIODXWQ149DCdd8m
 Ez9DCH6jQlfZwgt80YX4Ahp1GQHOnlEWuorCcNCpWseIJR9DliwZR06iwxEDDrb87SXcFc7xE3ga
 .qVabavB9LZS7UMPKskKOOQ06ATtyM6I.ZRc8QLBfp11vXgFOrhm7dcM4WxMEUJIM7azMTwRtCT_
 wQs6McQp37OM7FuT27wn4DQYkF.d7nD2uZ4_Mhuev1Xds9FFpuvjVIBsyCyT1zvy_.1h_dwaHvbW
 2b8TdRIEDo.Gh3dYXd6ri_rDmYD8.ASjal3DEjzKh9An6xNhn0SF8_YmHWT.LCr5I2Tj0x3jMrhb
 MX6DBoksOe7vItmzSCdkxQK2p0DcY4TD.DPbmMvoNK1RSREm6ktPXkI8RfbbJ0k3QHMn02VBLeqQ
 3eTteMHC2NmtemU7YMl66VtMmMRexsK.e1ypqrqteNFF_PYZ49YEkjj0yU_Pqv9cnScUQmrpdYae
 KxcO8yr4Ftf84mEXB3ck6HLbjs9sYA6PxOxZMrYR1C1UvauQTSKIW._ilrGHcPViTs9HpKfRtPHa
 v1tYYSBi1CFxyj8D.mHTlk9BP.9AdYYeByFbiCFR3HlfZgcUQwfrznL0h2MzOrLe1VlQkbSSKZnx
 pYllZVODObUwMTX7v656f75DY6ysYOHD7NvAjzO30rVdMEO5cpfEX8J5cLE7Ww1gbQ85MzlAntar
 j0txjBPLhvuObaCUrvo2dWNTSbTXQRGZcWr1VdwZG429lB7q4ufH7
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Aug 2022 16:03:30 +0000
Received: by hermes--production-ne1-6649c47445-98ntq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e7d4ad079837ab09a74572bb4eff2be9;
          Sun, 14 Aug 2022 16:03:25 +0000 (UTC)
Message-ID: <a4572696-8c4b-36ee-e067-8aa8a9786ad1@netscape.net>
Date:   Sun, 14 Aug 2022 12:03:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Greg KH <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
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
        linux-pm@vger.kernel.org
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <4688ee9b-1b18-3204-cc93-c6ab2ce9222c@netscape.net>
 <YvjFY1dn2Afg/mFj@kroah.com>
 <22bb6f38-c319-35a1-cf8a-07f78904ecfb@netscape.net>
 <YvjyNdH+X0dwjj+f@kroah.com>
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <YvjyNdH+X0dwjj+f@kroah.com>
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

On 8/14/2022 9:01 AM, Greg KH wrote:
> On Sun, Aug 14, 2022 at 08:08:30AM -0400, Chuck Zmudzinski wrote:
> > On 8/14/2022 5:50 AM, Greg KH wrote:
> > > On Sun, Aug 14, 2022 at 05:19:12AM -0400, Chuck Zmudzinski wrote:
> > > > Well, that did not take long. Juergen responded with a message,
> > > > which is encrypted and not delivered to my mailbox because I do not
> > > > have the PGP keys, presumably to make it difficult for me to continue
> > > > the discussion and defend myself after I was accused of violating
> > > > the netiquette rules yesterday by Boris:
> > >
> > > The message was signed, not encrypted.  Odd that your email client could
> > > not read it, perhaps you need to use a different one?
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > It's not that my e-mail client could not read it, there is no evidence it
> > was ever sent to me.
>
> The To: line had your address in it, so it was sent to you, and again,
> it was not encrypted as you claimed, but rather just signed to verify he
> was the sender.  That's not making anything difficult for anyone, so I
> think you owe him an apology here, especially as you are asking him to
> do work for you.
>
> best of luck!
>
> greg k-h

Dear Greg,

Thanks for the advice. I appreciate it. Below follows my apology to Juergen and
and Thorsten and some additional comments for anyone willing to hear what
I am trying to say as I continue to try to participate in the discussion of this
regression...

Dear Juergen and Thorsten,

I do apologize since I agree there is not enough evidence to conclude that
Juergen purposely made it difficult for me to respond to and defend myself
against the negative things he said about me in the e-mail I never received
from him.

I am not going to try to defend myself either, since it is not necessary and is
probably an impossible task for me to succeed in defending myself here in
this forum. The e-mail you tried and failed to send to me is currently
publicly available on more than one public mailing lists and it speaks for
itself. Each person who reads it and the other relevant messages in the
thread will decide for himself or herself what that message means.

So far I am inclined to think most people who will even take the time to
read the thread will judge me to be in the wrong, and I also am inclined
to think many who are Cc'd on this thread are already ignoring me
because they consider me to be a total jerk. That's fine, but that's just
their opinion, especially if they base their opinion only on a custom
of hazing users who dare to say what they think on the Linux public
mailing lists.

But since you are the persons who create the Linux kernel, I will express
my opinion that your decision to reject my efforts to help the kernel
developers and maintainers work better together with each other and
with users like me who are brave enough to say what they think on these
public mailing lists is the wrong decision if your goal is really to make
Linux and open source software development able to continue to produce
high quality software that is actually useful to people.

I say that because I am trying to scream to you as loud as I can: "Linux
software is no longer useful to me." No one here seems willing to hear
that message. I wonder if Linus even cares about that anymore. And that is
sad, because Linux was a great project. Unfortunately, now, it is clear to
me it is going to die a slow, painful death. The Linux kernel is a big and
powerful enough project to survive for quite a while, and I probably won't
live to see its death, but unless the people who define the Linux kernel
community change, it will eventually die.

Best regards and good luck to all of you,

Chuck
