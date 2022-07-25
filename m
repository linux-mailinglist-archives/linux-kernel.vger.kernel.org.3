Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B25805A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiGYUaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiGYUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:30:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EEC26F8;
        Mon, 25 Jul 2022 13:30:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m8so15419849edd.9;
        Mon, 25 Jul 2022 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGiLPxDzhs5DzTm0Q7KOkKqc68yALSJCaG0MVt2d3Bo=;
        b=qSnjCxXcMIEKC2hKuEYGjtRVQxfLdLQZPWamsT/EKIOGAuWBwJmmvkzPzDx+BU+qJ8
         WQSQc+Qwwn8Ew7odBh8x1SZ6L6fLruTRZ8GJY0PyE5bQSURCk4ljqPT7GFTrPysBTb+C
         X9IGKgV0ClJ6a9zyHHEAWDREJlMNkp0p8BAzvbeRyX7hlvw1hWlYrD8wnNWQugb9V8kQ
         /vKkzaGj4wWA/e0Eygq/PDuJqFpVERl5fTa+2vn8K0/qWu1vR6iBgS6syJp0Fe+U8+hS
         p3M1E4tedPzj54EsAisKtedD2BWi3nVKFIBDHNfM3KhsHR2bPq1nOH/F/5UcgYV1Bqv7
         0PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGiLPxDzhs5DzTm0Q7KOkKqc68yALSJCaG0MVt2d3Bo=;
        b=EbzduVrYFqH3Mw47XiXViJrwoQOxf+zXEut1WrvPVQ8qwKktZUw20PzxEoPCxBzKFR
         nXcmB6szEXY2TVnuaMxbUWTYC1pNuFLzGDeFKgDR0odLelET0edXnBArxFvKuyrGrfAS
         LBlLX+qpxoels0CTKkxXNs4j+yEOgq22TJZVy9BWjPP2r2YnwV53JCS/lcVXjHaTnSeE
         KB9udFoaNKQ+FpWEPtJIGZGgkIxfDBvTEpeu/I8JPkd6n4Ci0OP0fQDNiMF4RLZXlArL
         BJtzxaGdjYC6ra/Q/Kg54MMAxFQ3FDIEWGWwLmJUORqhFf5pBHkhYqqjjfCfsaN+GzmZ
         0mRw==
X-Gm-Message-State: AJIora9J2pucLIfFFMtHyk2HumXKqoKWEMHao11iJgk8E7TtDLWShG1a
        7JQwizTeep/ZOs6ZI3Fa9sOoP1KeVh6BLYLuEhY=
X-Google-Smtp-Source: AGRyM1v203+pQvF3wPtPOxUgVQcpVbocuHjseuhqyPUxKlDe7PG86NUrZhAJfIf+dRNmgYJI4ZCLWZOheS6nDxI5U3s=
X-Received: by 2002:a05:6402:d53:b0:43b:a0cf:d970 with SMTP id
 ec19-20020a0564020d5300b0043ba0cfd970mr14632305edb.277.1658781010950; Mon, 25
 Jul 2022 13:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220721073909.23318-1-srinivas.neeli@xilinx.com>
 <CAMRc=Mefhk4i8_1j2=JO63SwfHEb3TrRMj45+CC1i1DUr8VULw@mail.gmail.com>
 <CAHp75Vdr3yM_b_8bDgAhNLrHUuyoq2nkVcj84wdvTzvLLetkNg@mail.gmail.com> <CAHp75VdWS9DKd=xs8Kitoo9GZCsiNf7gt5HjfZn-9zNXBdvMEg@mail.gmail.com>
In-Reply-To: <CAHp75VdWS9DKd=xs8Kitoo9GZCsiNf7gt5HjfZn-9zNXBdvMEg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 22:29:34 +0200
Message-ID: <CAHp75VeB0Tago2foASYcGn_YUoh_HigDDag_X5WMTibRXxi72Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-xilinx: Fix integer overflow
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        neelisrinivas18@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        srinivas.neeli@amd.com, Srinivas Goud <sgoud@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:21 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 25, 2022 at 10:04 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jul 22, 2022 at 9:19 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Thu, Jul 21, 2022 at 9:39 AM Srinivas Neeli
> > > <srinivas.neeli@xilinx.com> wrote:

...

> Reading again... You mean that
>
>   unsigned long x = y << 32;
>
> wouldn't work?

Yeah, I even checked this in asm, and indeed it doesn't work. Don't
know what was that about me...


Thanks for the fix,
Reviewed-by: Andy Shevchenko <andy.shevchenlko@gmail.com>


-- 
With Best Regards,
Andy Shevchenko
