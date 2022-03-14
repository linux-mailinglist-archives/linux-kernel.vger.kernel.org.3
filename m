Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB844D7E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiCNJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiCNJDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:03:21 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E5242496
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:02:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u61so29302114ybi.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Byqz2GoD0sDlfuOO9lpy5lpnIgz5skrfhYEx26GgvRw=;
        b=MByXomfy+YrzBOpuB1tqPl/0Rc7biiSzSvF0GgX/aBdSQ3ysGKPfQc3hMdmK5ZA/Er
         PwyZo6szruMKUwJNm+wq90gUDejGwOTwccXAARch1vAN8yS9tN7C+Vcia4i0hLjXMRXW
         H/rpKBNQP1MjXTky1MiFbJ2YdKOHcTAmQAQP2wqsV0ViCJYYC//AQa00P0YG8g8keWZL
         5/aEseu8E4JWTu72CgLYhb8v0djwUCg847TwY/e7ireaeGpsYZUs/G4QHAuHe3QBAPyY
         4Yo3nucDMeYBjVq3OxfFIxipGKi7bTyeeAJgO810YZRtsg3wjl+odb7HFhK0U540mWXT
         EnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Byqz2GoD0sDlfuOO9lpy5lpnIgz5skrfhYEx26GgvRw=;
        b=lQk6bWqXAfiJ+bnV5i00BDnRbqJ+QxcWcBGss8/lPHpWNqPvX8d3JgqygJzzyjZJkr
         78QBDl6OfTRv8SNLUXAV0E/VFhsbB4c3TYoRaRF32ebyzUWslDrl8yJG/Tl+mZGgRjJE
         1I5myoKTUL1byGbNePbNT2DP6Of+0y2bnHTG65FQiT+5vCXWJog45uSX3QnYA1X6sLkI
         ULZJOkd6wzPAzKKRPj6KSxhiqNNwFJ+TPFPXFRWhN1lp1ND6GQNhIBvvysMEMBOJKdtF
         yFHbtDqMKPfG0sYx4rH50WTs7hr9/F7APrL4+S06GuQG2YsokZKfpAc1U58iiP/e9tSa
         u3Sw==
X-Gm-Message-State: AOAM532mbeyIDEBxtwVx36vbQh/HUyvumWU2DE0x3iPTBOWL75KfZf4P
        WZf7/fbpTKo75QGRGDguwE2nOswf/KDdQR5B3uj8sg==
X-Google-Smtp-Source: ABdhPJyQvfsiPK2itmFY+vfJgdvNLVKBJNh17H1B8vR87w+ogUdtktDGCySh+IMTi2iremEjtFbQkCoJFI65eI8YCRM=
X-Received: by 2002:a25:5090:0:b0:628:b76b:b9d3 with SMTP id
 e138-20020a255090000000b00628b76bb9d3mr16939803ybb.128.1647248531337; Mon, 14
 Mar 2022 02:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXE02HH7vRUjF3iKAL+1idKTy-oOYyGnBd3g90m6eObBxg@mail.gmail.com>
 <YikByJteDEtKi4Xv@shell.armlinux.org.uk> <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
 <Yinwq3Z9l0selLLS@shell.armlinux.org.uk> <Yin2jQqW+pUWJZ7E@shell.armlinux.org.uk>
 <CAMj1kXGkUJ=-4oA4GvBZNK94A1MrZ7UwKDN_tJRgwq8KF06VmA@mail.gmail.com>
 <CA+G9fYvEANOMekjvtu7agdVYQ_b8OMtxQdyAV2JT_vMdBU3VRA@mail.gmail.com>
 <CAMj1kXEVVZTKX_86bbTfLpFuDriV0-uwCMgSKDP+dzcD1L4XCw@mail.gmail.com>
 <CA+G9fYuO-sy+sZnhSz=A7Xm0LdSp2AT+7jCKLB33tZzK4izj3g@mail.gmail.com>
 <CAMj1kXGb_0FNU7capJEDWTZF2OegmZyBphhH8GuNqL7+YYLjZQ@mail.gmail.com> <Yip3GJDbJIYNeg44@shell.armlinux.org.uk>
In-Reply-To: <Yip3GJDbJIYNeg44@shell.armlinux.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 14 Mar 2022 14:31:59 +0530
Message-ID: <CA+G9fYsjK7z3VUgaOcs+cCCQWNsXW58pbDqruev6ANLdcswF1g@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Ard and Russell,

Your three patches applied and tested on x15 tested by Daniel and reported
kernel crash did not find it after multiple iterations.

ARM: unwind: set frame.pc correctly for current-thread unwinding
ARM: entry: fix unwinder problems caused by IRQ stacks
ARM: Revert "unwind: dump exception stack from calling frame"

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build url:
https://builds.tuxbuild.com/26DZbOeAxshMvtU2FhS3Fytr7NS/

vmlinux: https://builds.tuxbuild.com/26DZbOeAxshMvtU2FhS3Fytr7NS/vmlinux.xz
zImage: https://builds.tuxbuild.com/26DZbOeAxshMvtU2FhS3Fytr7NS/zImage
System.map: https://builds.tuxbuild.com/26DZbOeAxshMvtU2FhS3Fytr7NS/System.map

LAVA test jobs ran on x15 device:
https://lkft.validation.linaro.org/scheduler/job/4702341
https://lkft.validation.linaro.org/scheduler/job/4702344
https://lkft.validation.linaro.org/scheduler/job/4702348
https://lkft.validation.linaro.org/scheduler/job/4702350
https://lkft.validation.linaro.org/scheduler/job/4702352
https://lkft.validation.linaro.org/scheduler/job/4702354

- Naresh
