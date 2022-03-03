Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF62D4CB45E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiCCB2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCCB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:28:09 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FB6337;
        Wed,  2 Mar 2022 17:27:24 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j15so416674lfg.1;
        Wed, 02 Mar 2022 17:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJ2B08gabJYFOVfBFYdoJ25PiQBivMoWx7JQUDugqj8=;
        b=XK9g8de1WlKR4Ep1aunBAzRbzL518T38TZYa+51FTG7FvSU8eLsi/nPu656mKCH3tV
         JH4GFqGnnFtf2my/pCAoyx47iWRGwifeiqCC/OsIPznUnTM480n+pYXRyVT1Jr4LcZE8
         osGTSqU24WTVrl81+DZWGMqkEbT7dv4j0f8NPM48OMpy9n5HTOl7X7M6MLLk8ySG6qbE
         7HyxRjPwSLMvCIi+2Ltqij3/T/09vIWT4r8KR53HvfWG4TeSGu2Pi9/mWCuB+2UympSV
         7sH0wXU9YBz8I3fn6OtNut9/J79iOUxbLowji/gOK4aMzilo1tkX7lJaqiH6QF6+LQFk
         V+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJ2B08gabJYFOVfBFYdoJ25PiQBivMoWx7JQUDugqj8=;
        b=RgcQahWITDUySjS7TK8cXeH8It24rMR2gDruja3o+9nDzLoufu014QUAhOxhFm9KLX
         U94/RnX5eiOB6NkIQELRxXawGzPp5qdEH4mlwAnNDZcqPdVX55KeHuTGR704IR4ft2fy
         VypDQ9Cm41DQDXOsyZoN400t0LoMZwJ0gV0A1dv13BRGd82L5SdhnjtPYScEr0+68yxn
         Sl6uWulROIChRW7iUwt2f1okEtG6EEGMT7X/oGRZJFU+ggyy1mVZsx2jrCUt5DMuTA14
         za1agTFBlbmYMRRR4QLlwFje7E5LBD9F9/eL3Qb9Fi6GZ5YG9/5a7+hLsmdiY9jO9uNC
         WamQ==
X-Gm-Message-State: AOAM53332AeEKGnllXXx/PsV1Z6xCQuXwJxpDI6PQvMeeAgudO3uZd+B
        jlLRdGaLBgHZlfS0CMPlXdwrDi8X1cTScqIQDhk=
X-Google-Smtp-Source: ABdhPJybVffnhsMu3mAEUolbs46+nnRBt8avMFeRcwJ2+g9t25FCJJ53mhJ8wrGGNqA36LrGqEDGOHuh7DCGTPUkUik=
X-Received: by 2002:ac2:5c11:0:b0:445:b993:bfff with SMTP id
 r17-20020ac25c11000000b00445b993bfffmr3943357lfp.595.1646270842893; Wed, 02
 Mar 2022 17:27:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
 <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
 <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
 <CAJjP=BvqZUnJPq=C0OUKbXr=mbJd7a6YDSJC-sNY1j_33_e-uw@mail.gmail.com>
 <CAN05THSGwCKckQoeB6D91iBv0Sed+ethK7tde7GSc1UzS-0OYg@mail.gmail.com>
 <CAJjP=BvcWrF-k_sFxak1mgHAHVVS7_JZow+h_47XB1VzG2+Drw@mail.gmail.com>
 <ebf8c487-0377-834e-fbb7-725cceae1fbb@leemhuis.info> <CAN05THRJJj48ueb34t18Yj=JYuhiwZ8hTvOssX4D6XhNpjx-bg@mail.gmail.com>
 <f7eb4a3e-9799-3fe4-d464-d84dd9e64510@leemhuis.info> <CAJjP=Bus1_ce4vbHXpiou1WrSe8a61U1NzGm4XvN5fYCPGNikA@mail.gmail.com>
 <fe156bb6-c6d2-57da-7f62-57d2972bf1ae@leemhuis.info> <CAHk-=wjSBvRk-ksUBOiQzJd=e19UZKvOSZs1UHahK5U0QVh6RQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjSBvRk-ksUBOiQzJd=e19UZKvOSZs1UHahK5U0QVh6RQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 2 Mar 2022 19:27:11 -0600
Message-ID: <CAH2r5mvQnQTDQaci-NbLBjRb=gCPtMewrKhLBOLGrN2_Zpc3Bg@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Davyd McColl <davydm@gmail.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been looking to see if we could setup some VMs for something
that old, and we are willing to test against it if it could
realistically be setup, but it has been harder than expected.  Ronnie
had some ideas and we are willing to experiment more but realistically
it is very hard to deal with 'legacy museum style' unless we have some
VMs available for old systems.

Feel free to contact Ronnie and me or Shyam etc (offline if easier) if
you have ideas on how to setup something like this.   We don't want to
be encouraging SMB1, but certainly not NTLMv1 auth with SMB1 given its
security weaknesses (especially given the particular uses hackers have
made of 25+ year old NTLMv1 weaknesses).

On Wed, Mar 2, 2022 at 6:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 1, 2022 at 10:58 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > Thx for the update. I pointed Linus towards this thread two times now,
> > but he didn't comment on it afaics. CCing him now, maybe that will to
> > the trick.
>
> So I have to admit that I think it's a 20+ year old legacy and
> insecure protocol that nobody should be using.
>
> When the maintainer can't really even test it, and it really has been
> deprecated that long, I get the feeling that somebody who wants it to
> be maintained will need to do that job himself.
>
> This seems to be a _very_ niche thing, possibly legacy museum style
> equipment, and maybe using an older kernel ends up being the answer if
> nobody steps up and maintains it as an external patch.
>
>              Linus



-- 
Thanks,

Steve
