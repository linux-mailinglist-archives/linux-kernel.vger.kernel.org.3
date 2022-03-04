Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465A04CD5CF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiCDODb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbiCDOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:03:28 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A9911A0F;
        Fri,  4 Mar 2022 06:02:38 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id q4so6634144ilt.0;
        Fri, 04 Mar 2022 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzBK5WA3QVrcuQnQd4ntSERHlUAQ+GXLljw8Z7OoM1w=;
        b=gql0/NZ9ElEaLpJcoudiGif5RN5qPMlJiaKX7m517j2VwmaKvsNpJNz6gM45g/JcS9
         rsA5xoUm06axa8boCk+7Xp850UdRUPuMKH5xG6Lkut3tfvpxqOLjyEUEhItI9Cx/ADrs
         Wa6gHbviGEDvLPDtQ5jcEv+3U4ZB0hLc9bgvVIv6h5jbsZCec8FFoNLo5KjnbOvdvqIc
         meJk1l1uqgbFn3BjJoiTQhsNYBAAhUH7VyPFDg1S1U7FsKsO+Di1Wgc9Ka21lL0oStys
         Hi3CztQlo27qYQ4BSVxZhEp8tOJwTETLgG2xBJGMOnjtUmXbWCHca00E0YAZ7GnulxTp
         aI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzBK5WA3QVrcuQnQd4ntSERHlUAQ+GXLljw8Z7OoM1w=;
        b=N2K50vgB1OAaIIsWQw2bUBOfdjwDWnn8ylvqSNwfAnwJG0OLn13nwLel54Gu0eoGw4
         SKOeV8Gr/2AAYeBL44M2uCDg5LuRFFraun7ZzKF4UeAx59qt7D8O3nZDSNztXnRAdiH/
         HD1XqGDrhMlLYAKgT1r0hLpwtyJR8bvsTbKm8aPsOZBfsTyOO+GhciUy83MexIsA7Vus
         /sT/zWsW7NTYGsUSwlf99ZMimAyZatzMXaK+5F9Yctoy4mMqaNnX/B0GPOo1PhHNGKs2
         Mi6DBqnZaPiKrcmf5FX9Kt/e4jhNwY5R9bT7bSLsU2B3rZLSF66iMDTBccGDgy0vH/xF
         dcJw==
X-Gm-Message-State: AOAM533jcAQ6dV2/lfgnhRk3pIntioKyAkw+vM6WhXpQNkSSaAD0KjQg
        3S0vN7+mi6SyqHanEr3VWZbBmeEuAOo7IkEZUgw=
X-Google-Smtp-Source: ABdhPJwN3WEErb2vH6B5dP6UVI1dEFWdcimvNqhP0CYrCi0JEKnjM0RGkRw2NrXmb/cu+Z/9c+O/3Qw3B9+ytktZl+E=
X-Received: by 2002:a05:6e02:198b:b0:2c2:c454:ea7 with SMTP id
 g11-20020a056e02198b00b002c2c4540ea7mr27132602ilf.151.1646402557663; Fri, 04
 Mar 2022 06:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20220127151945.1244439-1-trix@redhat.com> <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com> <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
 <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com> <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
 <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org> <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
 <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org> <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com>
 <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com> <9dc86e74-7741-bb8e-bbad-ae96cebaaebc@redhat.com>
In-Reply-To: <9dc86e74-7741-bb8e-bbad-ae96cebaaebc@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 4 Mar 2022 15:02:26 +0100
Message-ID: <CANiq72nsKijH4zgLoEpiiq4462r1zYmaiDs13SEHDYR3aQziUw@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Tom Rix <trix@redhat.com>
Cc:     Joe Perches <joe@perches.com>, Finn Thain <fthain@linux-m68k.org>,
        Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
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

On Fri, Mar 4, 2022 at 2:46 PM Tom Rix <trix@redhat.com> wrote:
>
> The churn level will be very high.

Nobody is planning to reformat the entire kernel, at least not until
the tool is close enough to the kernel style, which will take a while.

> Until clang-format has an opt-in mechanism, I do not think clang-format
> should be used.
>
> .clang-format should be moved to staging/ to reflect its not being ready
> status.

What is not ready about it?

It is a fairly useful tool that some people is already using, either
for full file formatting or for sections within their editor.

Cheers,
Miguel
