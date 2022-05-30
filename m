Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C165374CC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiE3G7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiE3G7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:59:10 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54A762BDB
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:59:07 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MSLAe-1oO3X72fJw-00Sg07 for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022
 08:59:05 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ef5380669cso99623887b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:59:05 -0700 (PDT)
X-Gm-Message-State: AOAM530zlgvNuE+FYA8TFQ9dH7u/uL//8cZmnzc/PLfsZylSHv9T8j1k
        wDK0evRO8fZSeXmqvLN4yiVOi05y8MppJeLb6cw=
X-Google-Smtp-Source: ABdhPJxUw44ZxZjLw4bJuR6gTaVgYPR/zf2umvBRrFctapNjZG+QSh8cQbisCMhP+USKPzZc22esKiCBCM85C4wtFyk=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr57702118ywf.347.1653893944463; Sun, 29
 May 2022 23:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <YpRiZpZU3kH2xprC@linux-8mug>
In-Reply-To: <YpRiZpZU3kH2xprC@linux-8mug>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 May 2022 08:58:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2A_KHKWN3O2Wcy66yCC+T0eBsK8pNcGuLHN-BVeQ1ymw@mail.gmail.com>
Message-ID: <CAK8P3a2A_KHKWN3O2Wcy66yCC+T0eBsK8pNcGuLHN-BVeQ1ymw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: s32g changes for v5.19
To:     Chester Lin <clin@suse.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>, s32@nxp.com,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ii+PBLLZxgDmRSxiNDXXcrStNmCI+1wXU3IEIOKXsK0dYVyHN08
 3s4g/OmODPPwvbMB0EeS/r2rUtm1GxvbKy8dyJMIQKeHr4B9J+W/Wg0LL4kZSCmSzbk8b0T
 52WNS34YOEldBABj3zwVNXsZQaFtW8/4kWinGTUe4lr9KYxhXGlF6Vzz7upGEqWyKrOryey
 vS1siTZ0+gHOT39G1YOTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XW+yMdgLNEY=:N4zqB8ZUuNIj0VEQ6mHTr2
 iD9EGdX4ACWO9IGP20E5iyogjcb5/oIKH9w5M9INQ5CE2ElFDclypJLZfBb7TO/8sybikDpZE
 ncqzDV7SMU0Ouu59fbnSnuDWVnx9gRlR89Xb/lY8za0G6hnYb1c9oLJIgXCM0kflyPqEzxPDS
 5MUFbAQ3bMITdr+7iL8C8Qrx7TD0QzSTmszjoTuTgl/ITR9KgoExX8OkL8IRQdyCJi+9tN3Vc
 cnGYGgf+MLEeqcJX7Ss3v+vRFSqJYZtQ1TUQEGiurcqA7wsrfKtPhVs0gNW24rCPpOOpWP+9d
 UbCS50RgIEGLY1aHag3ClSvY4E0BRM1O/gG3jEj7je1vPJhXSgbUbL0aypCBkxrFv49itUwNp
 YyXlcZGj9e6LBfXAePcv5OHi8BkshmcA2CPlhfIZYl7aR4RRivST3bO18Zz5PEW53VoKvwgFt
 haY3sUMlRMSPWS17+6bWwIGOuw5uAodTssEOtpgXAA8hLwgRVPgmmugMeyaPfRJAxU7eUqI9g
 zBb9+mC53d0E1Rv4d+JZjaL2XfFbOA4V2D9678ompK0Z/ecIhxYAlADJ3p3qaNyUh8/VvLuH9
 z08SGvGmuat5mj6IJY+/VWUxdTEBu0Nb/MENJQ0itHfol27pRfN2Zh8BtdOOz4Lkd1HzzceTe
 bt9YB2T5ynQs9AcwOvjcNz4Tz6ttyHFHbo7/VmCf7kHjnqAIxhQtPiG8FnUhghHD+Jds5UEjf
 k4Hqs02Ofy8Qs9anyzDdUHdIyj6ll5NmPksj9A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 8:21 AM Chester Lin <clin@suse.com> wrote:
>
> ----------------------------------------------------------------
> s32g changes for v5.19
>
> ----------------------------------------------------------------
> Chester Lin (1):
>       MAINTAINERS: add a new reviewer for S32G
>
> Fabio Estevam (1):
>       Pass unit name to soc node to fix the following W=1 build warning:

The patches look fine, but there are a few minor problems with the
submission:

- The branch is based on top of a random commit from the mainline repository,
  you should instead always base this on top of an -rc tag in order to not
  clutter up the git history or make bisection unnecessarily hard. My 'arm/late'
  branch is currently based on a random commit 16477cdfefdb ("Merge tag
  'asm-generic-5.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic")
  as well, but this is an exception and I will explain it when I send the pull
  request ;-)

- The tag description is only a single line, there should be at least some
  content in here. Please have a look at other merge commits to see what
  you can put in here. For a small number of independent patches like
  these two, you can also just forward them to soc@kernel.org as
  individual emails without a tag.

- The subject lines of the individual emails should have the right namespace
  listed in them, e.g. 'arm64: s32g: ...'.  Fabio's patch originally had
  this, but it looks like the entire subject line got lost.

- The subject for the pull request indicates that this is meant as your normal
  submission, but this is the wrong time for that, because the merge window
  is currently open. At this point, only bugfixes get merged, but I do classify
  MAINTAINERS changes as bugfixes, so this is actually ok, just change the
  subject.

Please address these and resend.

         Arnd
