Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC575932B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiHOQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiHOQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:04:36 -0400
Received: from sonic303-24.consmr.mail.gq1.yahoo.com (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FEC1C92F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660579475; bh=sYAAhX43MCCsbni+t3ras/1mu65BWwozDfG3fjXajrE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uIg3pIhy0YdYlJImLiEt17URoe2yHezG0c4Quwo1U/55CteT8PaXlscpd4MvRpYS3rd+4qmsrzvntNcu6GSbEb+6OEjxWyg/Gpt7Didi++hdGF2C0ORcmcJ+n1IP3swFnkA5I4sapMUglmtAuWA4m6rVDXQRQQLDLKVWRZ/p1OFcBb9sqbj6cHm6q5+QEENIVOjSQ4c1VHRYnLuzeKviiwkZ6kN9aWbX3BL5s9KZxs+LqtvhZzCN0n6i21OLJXvTOhJ3fKvuMXN51rVKKWlAn4+3Q2Sop6cbG9Jme3wyMpsdKN2N9MeLsVH1tXv4rifoIncoLctU/xUJWRL4QK7/4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660579475; bh=ybL5Mt+yaL5D3vUzu/vdv9kPx/lGJ4wGmcberhf3Pcz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jcqWWIhITjFqDRC6iVb346l6/0Wo3eXkRjYKJlMPm0ZPbn+iyVg9wy700o1DlE1sLpQmBUdnPZ4hUSEg/NZj1pIuYetbCc/wS+u+YWjmK4NH2ohrWLn2AMC2KNIypw1DCjsCo/tSUxzaLG4ZJ4ULf4KuIJnDbXjK6eCqozSXq0+DseQd3wl6ir4gExpqDPXHbWwg6gv7nMJ2lbRDQd0ijk6pZ2BnWvsMDRojS0uSb6sziOJ3lxtqq8bCt/YmYgGdQ/iPuKF0/LLQQRoBpX8mrdYIngmqfwRBWxI9+vQDmNrvmUsMZC3ecU9OIBKJUfIVr+iLNxQxaNm7ZA/+u3u/XQ==
X-YMail-OSG: Lw1zKVAVM1lDEiCu_ta3TH3pZkDKTW8Uh.c6sfZ.0cVbYSFp0QtW.XesvgtZlOc
 lyYzVrT.fWxCJoaRhcd6s8MiFC5XrUPFvVdefRbA2_ntdK1Kgfs3z8qvHlnTAWqm9RG9QRLVfhbz
 focPQsiWtVBGddj9qzsgBS.4kIIjZQWOT2p1v4QI3ZdS6PpVSObCHhTfgoISo6ZSSfB3jrcZ5pXK
 k4gFy.GbkrvLtwKyOJ_zXWyg9TVpryuCLjOcm1xVYP4s.7yWyQmzpg3u2y9RilLQseHxLWdlIHxR
 4aLUjcZkHt1oumxgMPBaWR1aRZk526wc2A10CyqZyf2dOuVvUf6XMUsiC9NZbdx0I62XIXiFGqev
 5In48r9mSwTqyFL1m5sRugxttH4c.HqsTe0s38WuPGdEzpwko.VxvNzlOoFtukS3MgJ5i2kdhioO
 iE4C4.2kbkdOnki2Y1A009kB_oVECiDId0weTBzhlyOaam9lidznf2gaJ0qGRkDK6WtlsVTDAJqG
 ALfd5SijJiP9gUts.mA4kBtYVmOPxcV5XH6y7PfksPqlGVOiRefUCh.omWiKDX9ljs0YvcSFtjWH
 Bf.VOxR7ryEIWgo6qldcExG8XzoHFLaPE5x3CGF0UENqNM6xH3aXXWOGBNW2dZQ.nrW5bo5rXkbs
 5IIsFrgVtxg7FVLt3frGheUZp_XgTuGfFC4gFeOytR688SqvINifKe06Jbw79AsW9trR1cK8HkAs
 4ced5VVl7tag8pXeUJObT2reYGO4ulFJ9Dvs.D8wngi5rENzAn9l9d4KoRcQulNzEHR6RaENFbiz
 AHm460wXj18ni1Bqm5XehXM_mCDrFgTASBEfqbrRiROR.NISmKz.wzwIzCCT8Fm06eyGyCOstRSG
 L6NYDGyCQTwz5dxgwsy3y0IYmdsvTUGKr1r6DbdZbm2zc3.olBD2YNq5nrguITkRWsQ6nXql5MDa
 E4YPqV4uUdfatcfywIT57xPFmZ7D6HybWsANaUxFfiPtb_RyXlPZdi4gL0I2onWOtP3b.NoYBtGb
 54qnFVCo8McoSSmS6leV9JEAF4z_BmtqV68ByCDjqvXzEQDkdEzz3xjDvq7lChVpjP0aeIUr0TS7
 pqyPSiogtgxMm_.C.X7_VeS1FsB1e4LsME2BjTVTbjcLTfTHMUxM6JHX7MxsxiSOAja1va5bgp7q
 N.osY841hGeXFWfSDJSAY.7q0CK8R1gSm_ruELxIUgnpgYVyRUQ3WdAQTN_3pavpK679unj7SAvX
 uOaetmW7SCAP6DIpGph7c0Hvb0MzC8_lw7WnEgYB8owurh6MiutxCKRKsVKb25b2bV8QnH3LUbFr
 vGYkX91K.lWVCB0OD3XO0fdpWev8aCEkd8eBwLs9egLDpiGL7szljDVCQImtzbeQGuHrOgl5AANw
 ytSdmsIvJvaSd5m1CuR3a_X9EfDUeUG3xoxz8eQZSOI.WPfdghQ5mq_PX_CsRgv1bMBdd99IjqXG
 qKCGzh5Zt3vsyqbsgUK0cwIIgcJD73dhII0ME_RJTciCpmGzRUfAQJHhUz_rT7nd_ze.lZ68ZJ9U
 nKOnZejm7_y1UxHlDJy4uDi2OlAu09J2pe4kH38wEmdRNxZt0UnheZmyzu9ckz15.iAE6LlucYlZ
 te9XzbVq31Y03uPqEENg02sQwtSURkWQT6_VD0mNgHqoV9vtYsigcZ_grZA0xbKhYKmpGDE4e.ev
 w.aAWMcVK7t02sIgfiO8To7oUmMZaE4n9Fan5PU20hV5_qyUw2kb0lQxVV8LeW_T2SLa1kCzWyU4
 AxIXX8E_yBiwPXG5Pjd68lZB2Hcuc5SGIROivjZzi55P2qiCQmlUCiOShQXR5m3vuizquDQ9AFcR
 qfFv6R4q_23TzDek11jaZVOkH.hlVuFgSsmcvbkDeevdP5Q.SZSZ86QSSqfl_z6MRbHc2rjK4h.2
 8MixQT2Nq.8U8ITlKTvhnO9VsR6fkN2ACevUx_7IX.wQuuJ5r7m5FlGU4xbcWPWFS3lZVunLMCP6
 eOHaTIjhrIVpFntw6rs_t3TV8lh4wi0fAyqO2bkEp7d0Zu3H1p6cCm5DP0oO.bbcVmskOx7XLHH.
 d0QmfBh8Tc0BJc116ZImQ2QoTePEsTNlUc66Rh7DAWE8VQMc1Fsa3g4PCAJJyjlM6s7mqCLMIT4M
 FLPHLzs26s0C4133qMiS6ULyWNwO5s8tjVaRCIrNUdMS0wWr96BxpsxzfrHx4mdVbb6BpW.cRPcz
 .0ThTFXHoDhmJmgB3pIQTXR05Zd6h
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Mon, 15 Aug 2022 16:04:35 +0000
Received: by hermes--production-bf1-7586675c46-klczj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bff9f0204351eaed002b73cbfd01432e;
          Mon, 15 Aug 2022 16:04:31 +0000 (UTC)
Message-ID: <907702d6-05f0-0f2e-6dba-399688972b40@netscape.net>
Date:   Mon, 15 Aug 2022 12:04:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>, jbeulich@suse.com,
        Thomas Gleixner <tglx@linutronix.de>,
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
> The To: line had your address in it, so it was sent to you,

Well, that only proves the sender, Juergen Gross, intended to send it to me.
So far, I have not found any evidence the message was delivered to my
Inbox. The evidence I have obtained so far in my filesystem and from my
e-mail provider and the messages I have received through my e-mail provider
is that the message was never delivered to my Inbox, and based on that
evidence, my current theory is that my e-mail service provider silently
dropped the message because it was signed. I will report the full findings
of my investigation here when my investigation is complete.

The only way I was able to respond to the message was by downloading
the mbox file from lore.kernel.org and importing it into my e-mail client.
So it is a fact that it was more difficult for me to respond and defend myself
against the attack that Juergen made against me because I had to go to the
trouble of finding the message on lore.kernel.org and import it into my
e-mail client instead of just using the ordinary procedure of replying to
a message I received in my Inbox.

Best regards,

Chuck
