Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE88542489
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384623AbiFHCqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447217AbiFHCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:41:28 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48851912FC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:21:00 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id e11so3728393vsh.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcoQknaUmHCf5NNiXv3gVYmAHiag+xrcpWJjWHvdOZg=;
        b=El5lVxwUAtp3lYdRS44FJh/m5iar83RYu20Tydqw/TogWEAsetBxn8OJEoJ4NbUDYw
         5SZ18TwrkYHP+tIY4Qi0UQ0ohj5187hpUqw5K/NApRm6tafb74zy30i3RhTxpSAyyEBA
         wekj3031y/gM+0TLAC59s856hYDsl+SwB5L67Axrvr3jh3I9KsROUiMYMY+x/wS5PRAV
         RWMZ6cEjDE9+gffEit8/6ip0ISJn8QzjSuKESMbHEI2nqlConWUAcRbFzJdvBlW5S8k2
         iT7K2XjiuBzL3Ycg6O9EjbPmXlUXDCakvQpFZeTE9MsjPTcjY38elYLNAFjYPuRnmKIV
         oUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcoQknaUmHCf5NNiXv3gVYmAHiag+xrcpWJjWHvdOZg=;
        b=GSmqy5MW6A7Uy8Lyk+OODdGAHGhFcREAq6wg6dflQFBXbqHLE1aCDEQrxzm9ejLEpA
         elF/DfqLPDx+8zqqlU5yfEGTzlcn5C+YH5F808FrovbsXrHcmJT07hPZOZ3k/wOcoKhI
         AFklnK0QslUuJRbq68/3Kep5VlfE8KghkEDBRdBQTY03OkZhNHrGyJVkP2isV8m5LzaC
         7CauFM8PIPlIQaXiVaerAjh8fuGFMK3lmNqesJ4+/qrRSUg3Q4841hQGp0ruRopThKhj
         W82WohA6FGAySJt59Ke+8YostN78kYYJfowA8Jp9dMol6+YhiiXa/hm3l/TRJt+nx4+Y
         rIkg==
X-Gm-Message-State: AOAM530zgcotkD1pL7TteIPvNtrjiH8TmEtnuVmpHB7PU0lXmypSYCuf
        qkGOty7P7eGBaKm8ZiyLbqBvWAFiKA3RAE4nKTjArw==
X-Google-Smtp-Source: ABdhPJwR83OdverZPBwh+fyBA6W0CyLaD3ErYLyAqZbzFrJhTaO/fdBcoruij3Q+OjCh5eilVSpJLRhHQB+HdqCVSuE=
X-Received: by 2002:a05:6102:1356:b0:34b:bc70:7b44 with SMTP id
 j22-20020a056102135600b0034bbc707b44mr6576079vsl.22.1654647658820; Tue, 07
 Jun 2022 17:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <YnWRVd5slCy5H0fC@creeky> <20220507015646.5377-1-hdanton@sina.com>
 <CAOUHufY=xAvDKSaV8vybgObXPBEsPqqS7R3+T_-6ix7bUvQc6w@mail.gmail.com>
 <YnweYF9E5mt2HIwV@creeky> <CAOUHufZ_kBF+f3_RE9p8itJ8YN86cbEq9oXHCt+e1qw2Q-b8Zw@mail.gmail.com>
 <YpR/cpU+V9Dovj1p@creeky>
In-Reply-To: <YpR/cpU+V9Dovj1p@creeky>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 7 Jun 2022 18:20:22 -0600
Message-ID: <CAOUHufawX4Xsq7UV9NQPwvUp2+3ZV95u8ZDLR-VKRTibS-Qn9w@mail.gmail.com>
Subject: Re: Alpha: rare random memory corruption/segfault in user space bisected
To:     Michael Cree <mcree@orcon.net.nz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 2:25 AM Michael Cree <mcree@orcon.net.nz> wrote:
>
> On Mon, May 23, 2022 at 02:56:12PM -0600, Yu Zhao wrote:
> > On Wed, May 11, 2022 at 2:37 PM Michael Cree <mcree@orcon.net.nz> wrote:
> > >
> > > On Sat, May 07, 2022 at 11:27:15AM -0700, Yu Zhao wrote:
> > > > On Fri, May 6, 2022 at 6:57 PM Hillf Danton <hdanton@sina.com> wrote:
> > > > >
> > > > > On Sat, 7 May 2022 09:21:25 +1200 Michael Cree wrote:
> > > > > > Alpha kernel has been exhibiting rare and random memory
> > > > > > corruptions/segaults in user space since the 5.9.y kernel.  First seen
> > > > > > on the Debian Ports build daemon when running 5.10.y kernel resulting
> > > > > > in the occasional (one or two a day) build failures with gcc ICEs either
> > > > > > due to self detected corrupt memory structures or segfaults.  Have been
> > > > > > running 5.8.y kernel without such problems for over six months.
> > > > > >
> > > > > > Tried bisecting last year but went off track with incorrect good/bad
> > > > > > determinations due to rare nature of bug.  After trying a 5.16.y kernel
> > > > > > early this year and seen the bug is still present retried the bisection
> > > > > > and have got to:
> > > > > >
> > > > > > aae466b0052e1888edd1d7f473d4310d64936196 is the first bad commit
> > > > > > commit aae466b0052e1888edd1d7f473d4310d64936196
> > > > > > Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > > > Date:   Tue Aug 11 18:30:50 2020 -0700
> > > > > >
> > > > > >     mm/swap: implement workingset detection for anonymous LRU
> > > >
> > > > This commit seems innocent to me. While not ruling out anything, i.e.,
> > > > this commit, compiler, qemu, userspace itself, etc., my wild guess is
> > > > the problem is memory barrier related. Two lock/unlock pairs, which
> > > > imply two full barriers, were removed. This is not a small deal on
> > > > Alpha, since it imposes no constraints on cache coherency, AFAIK.
> > > >
> > > > Can you please try the attached patch on top of this commit? Thanks!
> > >
> > > Thanks, I have that running now for a day without any problem showing
> > > up, but that's not long enough to be sure it has fixed the problem. Will
> > > get back to you after another day or two of testing.
> >
> > Any luck? Thanks!
>
> Sorry for the delay in replying.  Testing has taken longer due to an
> unexpected hitch.  The patch proved to be good but for a double check I
> retested the above commit without the patch but it now won't fail which
> calls into question whether aae466b0052e188 is truly the bad commit. I
> have gone back to the prior bad commit in the bisection (25788738eb9c)
> and it failed again confirming it is bad.  So it looks like the first
> bad commit is somewhere between aae466b0052e188 and 25788738eb9c (a
> total of five commits inclusive, four if we take aae466b0052e188 as
> good) and I am now building 471e78cc7687337abd1 and will test that.

No worries. Thanks for the update.

Were swap devices used when the ICEs happened? If so,
1) What kind of swap devices, e.g., zram, block device, etc.?
2) aae466b0052e188 might have made the kernel swap more frequently and
thus the problem easier to reproduce. Assuming this is the case, then
setting swappiness to 200 might help reproduce the problem.
