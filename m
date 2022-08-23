Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF459D4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbiHWI1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbiHWIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:21:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52C070E59
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:13:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb36so25831022ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=M2VC3T3i8SI6ISvyTjIYNrIDwSYB0SPwFcKC30GUfDM=;
        b=YhnTBXKsX1sutRE3jqRO9H6Pjc1ZGKYwM6o16Q0HFOdstfdMOz52ZyhELuCQJXRG36
         zhmsnRPt5OkaQBKmjswJIygbaUEYQfs5ITpnbmXlta8HzIMzCM5ofAonMP0eWDOuo/dS
         +Rdh140kzsHwOpdzshLKhiTpaVIWcDxpncvtaY8fcWjxK/W+dbyvunc1qRpd+s0M3QME
         n0Bmg63HsdKktJ6CvRLGxpiXhXz4I1s/EP64HmMismIM9r2zLw7T3nR4gq22B0+JIB/I
         s9M/zgtKzwbvOY5obJkZjPkjN1v9+5tlUkl0QmaAFM0w1vSGg0xj1KyEZG4fpvS6Fda/
         wlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=M2VC3T3i8SI6ISvyTjIYNrIDwSYB0SPwFcKC30GUfDM=;
        b=X64yS/W9vVCxg79IK2tLjIiA6bumiqn5abzLnxMDZVI+IiSJQ7KSJF1cx3io7HiVXE
         4FKgS29JN5UL3KDs1fwPThPaIhh8fxIpbvdyChKRFsPqab9J+cuyKx0W+ylg8wPnu6YO
         p5jdQeZNa88cilPb7JcaUKRVWFDoKi51qqegEWxKLtEyzLWIh/of+y9abfqRhoH0vFt5
         LryazT2fWJEAC/nusNG7AE0R//KkiANyW9z2h7PwTl2ogXhZjev63Wjzqj501Q+q9geT
         Ypn9xEBE03YIjAL/AGm2kfLoMPdDII7Q3BW2pZG0rSwUAXsMRV/+juMOFJQ95LYf+9N5
         z5AQ==
X-Gm-Message-State: ACgBeo1Aztp3hhxCoO4rWugj8xS/z37GjuKd/mEEhl0jVwidnRS0Jp7M
        WK7Xd/qDK3Dvvq5PF1S6RfG84WpmwEXCOBqIJyggLw==
X-Google-Smtp-Source: AA6agR6adncEGL6epJiFBvb7FvvzRHDp7dN9532v8AKMOIlxyCEYv+l415yM/3YSXIcselx7YV94occ/T/pXa7FdGTA=
X-Received: by 2002:a17:907:2c48:b0:73c:931e:5175 with SMTP id
 hf8-20020a1709072c4800b0073c931e5175mr13431983ejc.44.1661242379105; Tue, 23
 Aug 2022 01:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuecPu-n-ujLsv7vL8RjEJA-6rOZjc363+p1oo6v-FKKQ@mail.gmail.com>
 <CAGETcx_EpQx-QRtCbbcEDpLHSnNeYysNEnmTOQL4+vb4zzvk4Q@mail.gmail.com>
In-Reply-To: <CAGETcx_EpQx-QRtCbbcEDpLHSnNeYysNEnmTOQL4+vb4zzvk4Q@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Aug 2022 13:42:47 +0530
Message-ID: <CA+G9fYvsqiMPqeo+Yqx4WQEEhXbWqKFbRdKTnP9a1FxQGRroUA@mail.gmail.com>
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual
 address 0000000000000008
To:     Saravana Kannan <saravanak@google.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Rob Herring <robh@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Hi Saravana,

On Tue, 23 Aug 2022 at 02:09, Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Aug 22, 2022 at 7:00 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > The arm64 Qualcomm db410c device boot failed intermittently on
> > Linux next-20220822 and Linux mainline 6.0.0-rc1.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > [    0.000000] Linux version 6.0.0-rc1 (tuxmake@tuxmake)
> > (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU ld (GNU Binutils
> > for Debian) 2.38.90.20220713) #1 SMP PREEMPT @1661110347
> > [    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
> > <trim>
> > [    3.609382] Loading compiled-in X.509 certificates
> > [    3.702306] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000008
> > [    3.702380] Mem abort info:

<trim>

> > [    3.771199] pc : pl011_probe+0x30/0x154
> > [    3.778480] l8: Bringing 0uV into 1750000-1750000uV
> > [    3.783073] lr : amba_probe+0x11c/0x1b0

<trim>

>
> Hi Naresh,
>
> Thanks for the report!
>
> These two patches together should fix the issue:
> https://lore.kernel.org/lkml/20220818172852.3548-1-isaacmanjarres@google.com/
> https://lore.kernel.org/lkml/20220817184026.3468620-1-isaacmanjarres@google.com/

Reported-by and Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by and Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


> Can you give them a shot please?

I have applied the above two patches on Linus master branch and built
and boot tested on db410c the boot is successful now [1].

> Also, in general, it'd be nice if you could report issues in the
> original thread of the patch causing issues. It would make it easier
> to keep track of all the issues.

When I bisect and confirm bad commits then I will reply to that thread.

[1] https://lkft.validation.linaro.org/scheduler/job/5423144#L2005

- Naresh
