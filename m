Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6548A7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348284AbiAKGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiAKGpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:45:46 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA98C06173F;
        Mon, 10 Jan 2022 22:45:45 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id p37so27888962uae.8;
        Mon, 10 Jan 2022 22:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RZhbLpQ3B7NqpRNzXz0bftm8pFZQNl7wIxqoKBc5Ms=;
        b=jGvLrjPRFQ5vawz8/cvPxIdYNBg8Bqz12mBj13wOQVwr/gxhXxkVvxZQpLu1Um4jDI
         TfX2xImbxJ8d4ochE+OTN8RvzJUH2EUuJlc7EMxGxFGtqwg8t8jWeZa3TuZ4Z1pBmgGv
         jxmyGkco5/Rg5MoSI803TrTBfAqEYsv9eOKUqsxfjTKujJYzom8gRDNnveZWk5LuJMiQ
         4eq0Pjs7NT/3EKKBc8M4J8uXC+YlBsSobh6cV55t9837QEhBCiRV5C9mxaVQTlncDBFc
         rNDLoUdsow3yR+y71iGkBAjkx9rRzuQVO8z8HqXad+IV5c9Fkko6H0ccdS2SBv+PFlmr
         VaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RZhbLpQ3B7NqpRNzXz0bftm8pFZQNl7wIxqoKBc5Ms=;
        b=6h6dIR9HuWZyZ9WMqyuhDbVthUqYfR6Irja1CuzzA6Y8Ioaz9Ou8/9ig1YpAx0GJUF
         NR7Xqd1h0gNhTR4XTpxhD9WTRYHYfntgLwmssUhqsd3HP/6wKg8swdwCiF4X0+HdxnkG
         2En9ySsUqktr+gPj331a3IBlFOoh+oRByRqs45EN1V7GtGQr3rkTusT9S9O99iPvPYgJ
         gNeJDq/XDLeeq1XMMD9vt5S3N5oER0qMCSdAE/UhV/9jDK/mby5aWmgk37Tp5iDbz2R0
         W7xtLTH/DuauQenDrqE9kMsaopS08vGgE3IQH9iqf1fNTZCABLoAAP1IOeAHAgPEdSTG
         f7rw==
X-Gm-Message-State: AOAM533Qj+h0gV0fxPl/zoXc8F0/lesozHwkjN2IZd+pbq9Wxe5cmb1d
        QhBJlWpUEFmI7ePFHQJSA8TTCm9WMwL74+QW/vTc0SW+
X-Google-Smtp-Source: ABdhPJyof4wOpsVz2JJfrl7so85YWVlxsw8PfDbEz5pbF4jieUYBn40j8htFjXmWqT53tPr9fwwz8ILRZARcGAX64NE=
X-Received: by 2002:a67:ead3:: with SMTP id s19mr1397093vso.57.1641883544700;
 Mon, 10 Jan 2022 22:45:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
 <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com> <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
In-Reply-To: <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
From:   Davyd McColl <davydm@gmail.com>
Date:   Tue, 11 Jan 2022 08:45:33 +0200
Message-ID: <CAJjP=BvqZUnJPq=C0OUKbXr=mbJd7a6YDSJC-sNY1j_33_e-uw@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000071e4bf05d548cdd6"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000071e4bf05d548cdd6
Content-Type: text/plain; charset="UTF-8"

Hi Steve

As requested, wireshark captures to the device in question, as well as
the fstab entry I have for the device:
- win11, browsing with explorer
- win11, net use
- unpatched linux 5.16.0 attempt to mount
- patched linux 5.16.0 successful mount
- fstab entry - note that I have to specify samba version 1.0 as the
default has changed and the mount fails otherwise. Explicitly
specifying 2.0 errors and suggests that I should select a different
version.

-d

On Tue, 11 Jan 2022 at 00:13, Steve French <smfrench@gmail.com> wrote:
>
> I would be surprised if Windows 11 still negotiates (with default
> registry settings) SMB1 much less NTLMv1 in SMB1, but I have not tried
> Windows 11 with an NTLMv1 only server (they are hard to find - I may
> have an original NT4 and an NT3.5 CD somewhere - might be possible to
> install a VM with NT3.5 but that is really really old and not sure I
> can find those CDs).
>
> Is it possible to send me the wireshark trace (or other network trace)
> of the failing mount from Linux and also the one with the succeeding
> NET USE from Windows 11 to the same server?
>
> Hopefully it is something unrelated to NTLMv1, there has been a LOT of
> pushback across the world, across products in making sure no one uses
> SMB1 anymore.  See e.g.
> https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858
> and https://twitter.com/nerdpyle/status/776900804712148993
>
> On Mon, Jan 10, 2022 at 2:30 PM Davyd McColl <davydm@gmail.com> wrote:
> >
> > I don't understand. I tracked down the exact commit where the issue
> > occurs with a 2 hour git bisect. This was after first confirming that
> > my older 5.14 kernel did not display the symptoms. I can still connect
> > to the share via windows 11 explorer. I don't know what else I need to
> > do here to show where the issue was introduced?
> >
> > Apologies for bouncing mails - literally no email client I have seems
> > to be capable of plaintext emails, so every time I forget, I have to
> > find a browser with the gmail web interface to reply.
> >
> > -d
> >
> > On Mon, 10 Jan 2022 at 19:31, Steve French <smfrench@gmail.com> wrote:
> > >
> > > I want to make sure that we don't have an unrelated regression
> > > involved here since NTLMv2 replaced NTLMv1 over 20 years ago (googling
> > > this e.g. I see "NTLMv2, introduced in Windows NT 4.0 SP4 and natively
> > > supported in Windows 2000")  and should be the default for Windows
> > > NT4, Windows 2000 etc. as well as any version of Samba from the last
> > > 15 years+.  I have significant concerns with adding mechanisms that
> > > were asked to be disabled ~19 years ago e.g. see
> > > https://support.microsoft.com/en-us/topic/security-guidance-for-ntlmv1-and-lm-network-authentication-da2168b6-4a31-0088-fb03-f081acde6e73
> > > due to security concerns.
> > >
> > > Can we double check that there are not other issues involved in your example?
> > >
> > > The concerns about NTLMv1 security concerns (and why it should never
> > > be used) are very persuasive e.g. many articles like
> > > https://miriamxyra.com/2017/11/08/stop-using-lan-manager-and-ntlmv1/
> > >
> > > On Mon, Jan 10, 2022 at 7:48 AM Davyd McColl <davydm@gmail.com> wrote:
> > > >
> > > > Good day
> > > >
> > > > I'm following advice from the thread at
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
> > > > this, so please bear with me and redirect me as necessary.
> > > >
> > > > Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
> > > > mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> > > > runs some older linux). Apparently I'm not the only one, according to
> > > > that thread, though the other affected party there is windows-based.
> > > >
> > > > I first logged this in the Gentoo bugtracker
> > > > (https://bugs.gentoo.org/821895) and a reversion patch is available
> > > > there for the time being.
> > > >
> > > > I understand that some of the encryption methods upon which the
> > > > original feature relied are to be removed and, as such, the ability to
> > > > mount these older shares was removed. This is sure to affect anyone
> > > > running older Windows virtual machines (or older, internally-visible
> > > > windows hosts) in addition to anyone attempting to connect to shares
> > > > from esoteric devices like mine.
> > > >
> > > > Whilst I understand the desire to clean up code and remove dead
> > > > branches, I'd really appreciate it if this particular feature remains
> > > > available either by kernel configuration (which suits me fine, but is
> > > > likely to be a hassle for anyone running a binary distribution) or via
> > > > boot parameters. In the mean-time, I'm updating my own sync software
> > > > to support this older device because if I can't sync media to the
> > > > player, the device is not very useful to me.
> > > >
> > > > Thanks
> > > > -d
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> >
> >
> >
> > --
> > -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> > If you say that getting the money is the most important thing
> > You will spend your life completely wasting your time
> > You will be doing things you don't like doing
> > In order to go on living
> > That is, to go on doing things you don't like doing
> >
> > Which is stupid.
> >
> > - Alan Watts
> > https://www.youtube.com/watch?v=-gXTZM_uPMY
> >
> > Quidquid latine dictum sit, altum sonatur.
>
>
>
> --
> Thanks,
>
> Steve



-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
If you say that getting the money is the most important thing
You will spend your life completely wasting your time
You will be doing things you don't like doing
In order to go on living
That is, to go on doing things you don't like doing

Which is stupid.

- Alan Watts
https://www.youtube.com/watch?v=-gXTZM_uPMY

Quidquid latine dictum sit, altum sonatur.

--00000000000071e4bf05d548cdd6
Content-Type: application/x-zip-compressed; 
	name="cifs-wireshark-captures.zip"
Content-Disposition: attachment; filename="cifs-wireshark-captures.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_ky9r252i0>
X-Attachment-Id: f_ky9r252i0

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
dXgtNS4xNi4wL2ZzdGFiLWVudHJ5U0QEAKAAAABVVAUAB70m3WFQSwECHgAUAAIACABDRStUsWh3
2uYKAACQIwAARAARAAAAAAAAACAAAADlCwAAY2lmcy13aXJlc2hhcmstY2FwdHVyZXMvbGludXgt
NS4xNi4wL3N1Y2Nlc3NmdWwtbW91bnQtcGF0Y2hlZC5wY2FwbmdTRAQAoAAAAFVUBQAHvSbdYVBL
AQIeAAoAAAAAAE1FK1QAAAAAAAAAAAAAAAAiABEAAAAAAAAAEAAAAKgXAABjaWZzLXdpcmVzaGFy
ay1jYXB0dXJlcy93aW5kb3dzMTEvU0QEALQAAABVVAUAB9Im3WFQSwECHgAUAAIACAC0QitUtxlW
8woVAAAsXgAAPwARAAAAAAAAACAAAABsGAAAY2lmcy13aXJlc2hhcmstY2FwdHVyZXMvd2luZG93
czExL2Jyb3dzaW5nLXdpdGgtZXhwbG9yZXIucGNhcG5nU0QEAKAAAABVVAUAB/Mh3WFQSwECHgAU
AAIACADuQitU0uJ4R4MPAAB4VgAAMAARAAAAAAAAACAAAABOLgAAY2lmcy13aXJlc2hhcmstY2Fw
dHVyZXMvd2luZG93czExL25ldC11c2UucGNhcG5nU0QEAKAAAABVVAUAB2Ai3WFQSwUGAAAAAAgA
CAB9AwAAmj4AAAAA
--00000000000071e4bf05d548cdd6--
