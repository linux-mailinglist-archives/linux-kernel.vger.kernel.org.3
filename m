Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0247EBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 06:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351372AbhLXF0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 00:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbhLXF0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 00:26:49 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E0C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:26:48 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id w1so5822545ilh.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kidXoHFYkT/EcDpKPw9KOkyRrXXqBBDOQdea3bdYgM4=;
        b=ek+FCr7sjm1ubPRSRFQijMKrgo3c06JT/gDeRkG5APtXUP6TxQMeXnaPlXLF8q5MBz
         K60fI1CTzAtQp54JQ8+wZNuTPVp03XVUM5pJIzDJ6pjO3/uv9p8l/h889cq3u9lThDII
         aXnVyjS3iSLOBKJynZr+xRKLqpoc2iHcs4u2To5dSXvIZ9HJeYS7wD2yL8oO8sy7s6me
         m197kYSCpUNY4T1cwn9xoo7o0ulkjPUF7cJVYWl9PxPIolixQBKBiTl2E6SgXEcbpD2M
         rYt/wM3+Sb85q6wP4ZPLy83EXGa4aV/AKFO9lgAZt87gjcsMbahIln/tUXYdxwhbp+6I
         gMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kidXoHFYkT/EcDpKPw9KOkyRrXXqBBDOQdea3bdYgM4=;
        b=US1mJjvsNfqdMy9teFXOMvV+nRjzT3rLupSqIU46SEnuD0kKric1EsHuzp8iSJY9hN
         CqFZwpxiKNucA2pxysbZ5LY2TKFIS4s0apWnGcsN3ybVWzzIdCKv4wKQC+HfbO8GvEkb
         DkAPAFaLkgGNU7we2F6YHx8L6NyhtlvQFQEReYsm/BALTbXLWsucAE50kHX7+BGbbUSO
         4+25DegvAy9zZZt2NcllxFn5T+CeJHmIL98nUM83lVTzjMpCOAKnVminWmi/tOpEreZ2
         aercQFQTEKJqdSxi4ocf7aiF9KpAM4A7awKucN+NHbR2miKc8M/Mgt/dCDdZ4VHfLhsm
         WO8A==
X-Gm-Message-State: AOAM533INo5QtYF089XlyeiH9MnwLmpvBKSKwGAXbQD41aZUNZHyKk2w
        w/nzb/iB9LJpx+zYzYjy+099rpfvTX/wen0i4/BH+Q==
X-Google-Smtp-Source: ABdhPJxvcgZCTKdh52s1CyfM1zqXYElZ058SO/hYaLMbTsqmJWpqhBmtzBbU2Iz72WBPbUuTmj5BEKYWW/Xy+vdEeAI=
X-Received: by 2002:a05:6e02:973:: with SMTP id q19mr2265756ilt.206.1640323608180;
 Thu, 23 Dec 2021 21:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20210419212525.12894-1-ljp@linux.ibm.com> <161887560929.13803.2397044457894925895.git-patchwork-notify@kernel.org>
 <CAOhMmr7MSQvHkFucvF-5fvNsm7PCJt_UVEjhuTvSnjHOypvh1g@mail.gmail.com>
In-Reply-To: <CAOhMmr7MSQvHkFucvF-5fvNsm7PCJt_UVEjhuTvSnjHOypvh1g@mail.gmail.com>
From:   Slade Watkins <slade@sladewatkins.com>
Date:   Fri, 24 Dec 2021 00:26:37 -0500
Message-ID: <CA+pv=HMqeEUnCs3waDKitgmRn=xXX-_AFAOY2ve1zVqQtX0sag@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: update
To:     Lijun Pan <lijunp213@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 12:19 AM Lijun Pan <lijunp213@gmail.com> wrote:
>
> On Mon, Apr 19, 2021 at 6:40 PM <patchwork-bot+netdevbpf@kernel.org> wrot=
e:
> >
> > Hello:
> >
> > This patch was applied to netdev/net.git (refs/heads/master):
> >
> > On Mon, 19 Apr 2021 16:25:25 -0500 you wrote:
> > > I am making this change again since I received the following instruct=
ion.
> > >
> > > "As an IBM employee, you are not allowed to use your gmail account to=
 work
> > > in any way on VNIC. You are not allowed to use your personal email ac=
count
> > > as a "hobby". You are an IBM employee 100% of the time.
> > > Please remove yourself completely from the maintainers file.
> > > I grant you a 1 time exception on contributions to VNIC to make this
> > > change."
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [net] MAINTAINERS: update
> >     https://git.kernel.org/netdev/net/c/4acd47644ef1
>
>
> In the past 8 months I have received many emails from you, asking me
> about my current status. I am sorry that I did not have a chance to
> answer all of them.
>
> The most questions being asked were =E2=80=9CAre you still with IBM? Did =
they
> restore you to the previous job?=E2=80=9D. I think I can answer these
> questions now. I am not with IBM anymore. I was terminated this month.
> I wasn=E2=80=99t able to work on ibmvnic since June, even as a hobby, whi=
ch
> you can figure out from the mailing list traffic. The last 8 months
> was tough for me. But I am very thankful to all of you for your
> kindness and support.

hi Lijun,
just wanted to pop in for a sec.

I am so sorry to hear about this and I sincerely hope that you are
doing better now.

>
> I will be celebrating the holiday with my family for the rest of the
> year. I would be happy to find something worth my time (vs. arguing
> about the open source way of doing things with an entity). I would
> rather just have a break and relax myself than do something completely
> mundane for another company. Thank you in advance for any connections,
> advice or opportunities that you can offer.

please do! relax and don't burn yourself out. everything will be okay with =
time!

Merry Christmas and happy holidays to you, and your family! :)

best,
slade
