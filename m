Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E78537C72
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiE3NcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiE3NaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:30:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80E58BD29
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:27:18 -0700 (PDT)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MyK9U-1naaIi2FFE-00yhLN for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022
 15:27:16 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ef5380669cso109805747b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:27:16 -0700 (PDT)
X-Gm-Message-State: AOAM532o2BqlmayrBWevv5ebubrc/INTyBNge2Y1jc8ECYBj+FRG+tdT
        ljeX6yfFZEkBQ4aImRjy1F0h58oLIfHWqJ8AKoE=
X-Google-Smtp-Source: ABdhPJzhFSGg2w/8ZGCTnRd3eo/K+0TESAOoljCU1poY/jQ3ltF9m1UCs/H2BhLsNUV4//0jprJWNAAdam+fS4ulT30=
X-Received: by 2002:a81:488c:0:b0:302:549f:ffbc with SMTP id
 v134-20020a81488c000000b00302549fffbcmr22682224ywa.495.1653917235399; Mon, 30
 May 2022 06:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <YpRiZpZU3kH2xprC@linux-8mug> <CAK8P3a2A_KHKWN3O2Wcy66yCC+T0eBsK8pNcGuLHN-BVeQ1ymw@mail.gmail.com>
 <YpS/jhQf6zLXZSvy@linux-8mug>
In-Reply-To: <YpS/jhQf6zLXZSvy@linux-8mug>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 May 2022 15:26:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3CuFOAPkk89i+tPgGa3xzPhB=bftQw6QW=hMaqK3-2AQ@mail.gmail.com>
Message-ID: <CAK8P3a3CuFOAPkk89i+tPgGa3xzPhB=bftQw6QW=hMaqK3-2AQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: s32g changes for v5.19
To:     Chester Lin <clin@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>, s32@nxp.com,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:D7ZTkbN1Ba8GZsXWHfm1tMDEI6IGYrrbz40Iv8MLkIs0rdoQ4h9
 Z9fQwZciD/w6DOdTSFmtWn+IMKtXaHtlQROdOl+KNt141HXhjVUMnt1HoMBrm2aRYXCGuoZ
 CE0vRsMJdHG/a44ab9sCDmurWKYKAh5h2KNeTSEjfAamO3ONxsejV9DtB/IPZuLokksOt0R
 mqzLK8D0WhMBuGaT3lCmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qqi0UzDKH/0=:u4cEDF8+U+FtV70rxli2hj
 /XBa1ikGM+zgZPHVlE46zWjvXl4j8vG/OS+eS7nDZ6BY4FmocOPN6/ElQlW2g19ZOLjvi1NU7
 XL/TpIXTX/I2QDKreryW2RaQGLi5tkjZOUagmPr2O0tCn0eWh06t7Ul+MBpPyqgeRm1hDMPDj
 JAwGNjtbG9EE9aIYXMQmb+IBc78FoEAF3xB1hdtFI51KimaZNmLkybVHZH4aptM2Ul5SnaITq
 ch3U08n6WvfKKXJSUtFFK62MpRsTmi/tCvg7a61MZiy8Cc+fVFWe8HrZRzza1uNbC63riQUC0
 ItX6V4hUBLukFm+DGQtBN4uwy1ILaQmlotsLaGtOHZ2IaHMvQqUC7eknWGiVNhTsfYYJTsaOP
 3l/7i6MaRLNP9a3URXxT6pQ4bDcWTm3GqNEQHTEuPMe32EmeesPkL4L1YAXzIENSuI/ozx79x
 QhqBuUhuPH3wJrOWuW5/RdnMLdtuAv0sraKLApnOixkiwCE6In9gawI1PRqSL4woqOUwtzX2O
 KQsn+05ftc5OjvFd4pgZGi0WL5qawoOjBbL/p3NH1R485xaUQyZWSXCHxqL7eucPBLV/UpdjR
 /hL/xqKNgjJhkGx0lKWdEQQLuCDm7EZYcQQzND3UGZ79rT9KG91um7ecrCja9f7TF25LNhfta
 55ygkViKlyKaPIv9kIUUY1dBlac5G+hwWewNVu8Yfbi7mOv36F1MS+8bclFWhG6s5NciPM9sL
 7Rro/iUmkuYgyZxuDIVKbwUxJJjBJDgpRXIVJZYbb/3gXK4YiXuwl49nkSUbEsnlUsjEtqqrQ
 WNOtN+bEWYH9UnSWH4CsO7IqKxUYwRtEnw+UlmBDGtUqhngRAi+1GKYtr/wa8dflQwFqIY+M0
 FtUEBrDRPDzhcuci0fQw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 2:58 PM Chester Lin <clin@suse.com> wrote:
>  On Mon, May 30, 2022 at 08:58:47AM +0200, Arnd Bergmann wrote:
> > - The branch is based on top of a random commit from the mainline repository,
> >   you should instead always base this on top of an -rc tag in order to not
> >   clutter up the git history or make bisection unnecessarily hard. My 'arm/late'
> >   branch is currently based on a random commit 16477cdfefdb ("Merge tag
> >   'asm-generic-5.19' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic")
> >   as well, but this is an exception and I will explain it when I send the pull
> >   request ;-)
> >
>
> Thanks for your guidance and sorry for any inconvenience this causes. I will
> wait for the next cycle.

Just to clarify: both of the patches you sent are good, and I want to apply
them for 5.19, so please send them as a bugfix pull request.

      Arnd
