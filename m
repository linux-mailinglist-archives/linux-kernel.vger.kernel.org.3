Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59B58B4DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbiHFJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiHFJs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:48:58 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AA15831;
        Sat,  6 Aug 2022 02:48:57 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m22so3421588qkm.12;
        Sat, 06 Aug 2022 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=soTs+6aBLXvB/CSHeZwohpV8hY/yAbdVbAL5FwGeUow=;
        b=LRnlJQYrRQdAsd9T2wR4Gl0wFRGlIbQGiUMW8t9OUIiGKzTguv2UsdsLA/1UTQIiHA
         7gL+mvAQ7M9kwBzByzOwII730LNy0bMFdSw6znr/JV1r3Ym9TaReBNflEUCwdBultSHe
         KeY8OWIguL/EwnWQUhAWXWAyGovestG+7Wt4nlma9UuyznwakF9y5OFsa14L1JZtGe7i
         E7m1UA8BMHi/1C9feLaOXc7c7Wy7FTtNo2DPSmA1k2S5ZMxSfH3VWWkPsFWlEOjdYTx5
         FiBS5l2zk1ZuvSRG8strxYasg89XrhP39GJQyQ8OJ3WOr8gqR5Sc3EAaH/u0xMlUkt+Q
         n9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=soTs+6aBLXvB/CSHeZwohpV8hY/yAbdVbAL5FwGeUow=;
        b=4VGGrFyI7cbDyw6nLZRwXPHkdoAwTvaYeR0Z77F20OlSS9usrtFvtPzn+afJyRrLcq
         TinupiVnu/sw6UnZuuBsyN82o6AzSypEuUVDvd4V6HRM+H+Y8bjcsgTDE61JqGfn+jtm
         DU/Ir+XZldbbwoaUaxn8RrwNoJRM0OFCa7p3V1aLqlCffKom1KFH6olWOZdtreHM85Oq
         DwesMlXJXyp4m6AlX7hgthtmuvBFXY6j0powX93DmtHW8jc7cw296ziJZREFaNGAEKeO
         aJFgUdASrPVX7kqogiUmFTzmdCUQXSQo2ALB+RarFsuVqoMm3r4b/IVNz+NkeDf1sVV5
         +TmQ==
X-Gm-Message-State: ACgBeo3VIBdqmBnqQ9ufWLNkVnl1YeFuHzzY94eocf2QGIb49XTWr/jP
        w/qRFJwSC2jCbKeiM5QDB789cEVOJZUNk+Huedc=
X-Google-Smtp-Source: AA6agR5Zv1HxbcMB8RhDvBBr//rirLD6qa4dQw+fo0lmiY3ehB886wydTx2U+du+/ax2zCN2RWr9H2HNvfrZeAfjRSo=
X-Received: by 2002:a05:620a:31a:b0:6b9:1f1a:7e13 with SMTP id
 s26-20020a05620a031a00b006b91f1a7e13mr3658459qkm.748.1659779336348; Sat, 06
 Aug 2022 02:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <CAHp75Vd4iEGkAE1Ds_Zyqi0P+gQbOyqvGoJctpOHNmMD7cUG0g@mail.gmail.com>
 <J6T6GR.SW0RXSJSYG9R1@ljones.dev>
In-Reply-To: <J6T6GR.SW0RXSJSYG9R1@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 11:48:18 +0200
Message-ID: <CAHp75VcdmFk4k6Vvcv7aMgJ7Cw21YMKsq28G4aO0XyUj1-5rRg@mail.gmail.com>
Subject: Re: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Aug 6, 2022 at 11:33 AM Luke Jones <luke@ljones.dev> wrote:
> On Sat, Aug 6 2022 at 11:10:37 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:

> > There are so many patches
>
> This is what Hans requested that I do after the previous submissions,

No, what I'm referring to is that it was so many versions of the same
patch(es) that are floating around and it's too messy to understand
which version is which and what to consider.

> >  and versioning of all of this is completely
> > broken.
>
> I was unsure how to handle this as the previous patches were
> individual, I thought perhaps this patch series is a good place to
> restart since the work done is a bit different.
>
> I will try to better track what I do in future.

Thanks!

> > You really have to clean up the mess and realize what version
> > of this is. To me it looks like this series is v5 or so of the
> > previously sent patch(es). Also you missed the changelog between
> > versions so we can see what you have done from vX to vX+1 for the
> > whole range (1 ... X+1).
>
> As described before I thought this would hopefully be a good point at
> which to reset due to the changes requested by Hans which meant that
> the underlying structure is different.
>
> I do have another version already prepped, so I will do my best to
> address the previous submissions and your concerns in the cover letter
> along with a changelog.

Thanks. For the less confusion continue this versioning than (v2 will
be the next one for the series).

-- 
With Best Regards,
Andy Shevchenko
