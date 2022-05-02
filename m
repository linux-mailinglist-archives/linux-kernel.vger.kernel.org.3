Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13C8517013
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385193AbiEBNQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351348AbiEBNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:16:31 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35894C0C;
        Mon,  2 May 2022 06:12:58 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id z144so13497137vsz.13;
        Mon, 02 May 2022 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Q9PzyxjQuHY1spsfkApUPqmCQWtSz+AxNkiNIjpbrU8=;
        b=mJDEqDsVQSGSuhg63i6rSSlbP++q3ToYeRW7DKxkb1Mgg6ahghRFMAMYVO8Z248Wpv
         /zMAOvyhuFpiRAqn2VhRMA3uu9E2VH6ACglzHVwKn/4w8bGMp9mQx2Xcx1aHcJFCULwd
         /WzVHWm330mmycVGKOMDo98gNZZW3mekRi0x/PDJGRx9yPLvbhVlqTbbAjcKUl3QFBOx
         r5f57N5BwI9bpueFyyiPE8lmhgNPHdUr+4NejTLlWU9CozHtjS9GpXqjB0SCJG7l9tFN
         reM2aggIX8NxhU2uBmPxOp9y1Y09HDqTmQmXVatCdmw685GsgJmU9inIuFvA4fvUDJ4+
         S/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Q9PzyxjQuHY1spsfkApUPqmCQWtSz+AxNkiNIjpbrU8=;
        b=VdLAWV52D5pn2k1CuyI1OZbZNcpOhc/XnOrelEDMdscMbG8L7ox9QW1ANuX38m3SxA
         qUWwAq1KsqKFxPo6SRmiU4tZuEs5OWeElZEykY1UofV0mOdYuTd7KZCpYq9aFcZ5T7X9
         cLpCzu5L0S8KDLq9f+yZp62fa2cSL2cpe//6uhAW89DonLd6V/iFcKKe9SNU7uprLNIj
         iSXfnkkInNYMkkRyhRqKlMx3EFBG3ik4oTO0w/RaMYbRYw7Da227lfYLOu1fc85s4K3Q
         mBsHF3rNK3eUi8XQXTjno44ISuOYjXx5AzDUZgOlY2Of1rrzq2n5LZIo06VwN4j8h6vZ
         Yn7g==
X-Gm-Message-State: AOAM531D+AaEh5TE2UYiOlLG9PhmKgW9WvB54Xje1xzfHINbv6LNGY/j
        F7ai/IkOOjBwoqexkneSV/Lj+C0Gx16BjRak/2RYXwdybpjQwTF7
X-Google-Smtp-Source: ABdhPJxbInO0MY7QS0qnVFBBJNpXUEKl/C28qXUrrFqVm+asE7qWtoiTdPab5crnAQKYbzgVZXYAV22vfuroIRfDXxo=
X-Received: by 2002:a67:c107:0:b0:32d:3ac1:1e71 with SMTP id
 d7-20020a67c107000000b0032d3ac11e71mr1332770vsj.41.1651497177274; Mon, 02 May
 2022 06:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com>
 <20220426131102.23966-9-andrea.merello@gmail.com> <CAHp75VdLiBkg100UjFN36rW_vaOObOoJ_Mv9n=4LjSWb+dQWMw@mail.gmail.com>
 <CAN8YU5PzwmeQ9XA3qod7HejG6cCLCrPvda5eomCh5hUze_DWcA@mail.gmail.com> <CAHp75VfOZpD135q_eERnLk0NorXwPxY8DFbKMu+eKV8XahGC1A@mail.gmail.com>
In-Reply-To: <CAHp75VfOZpD135q_eERnLk0NorXwPxY8DFbKMu+eKV8XahGC1A@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 2 May 2022 15:12:45 +0200
Message-ID: <CAN8YU5P_vGV0vrhdy273ef9GH2Y2=TbXbsiho=V9vG44NXAujA@mail.gmail.com>
Subject: Re: [v5 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

Il giorno lun 2 mag 2022 alle ore 12:12 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:

One inline comment. OK for the rest

> > > > +#define BNO055_ATTR_VALS(...)          \
> > > > +       .vals = (int[]){ __VA_ARGS__},  \
> > > > +       .len = ARRAY_SIZE(((int[]){__VA_ARGS__}))

[...]

> And my point about readability. The reader, and even the author after
> some time, may have no clue in this forest of the macros and castings
> what's going on.

While I'm OK wrt your point in general, consider that it's just a
three LOC macro, used only in a few structs just below. I wouldn't say
it's so inricated; I've seen by far worse in the kernel :)

> > but about avoiding as much as
> > possible bugs caused by mismatched attr_vals, attr_aux and
> > ARRAY_SIZE() arg. e.g:
> > bno055_sysfs_attr_avail(priv, bno_foo_vals, ARRAY_SIZE(bno_bar_vals),
> > bno_foobar_aux, vals, len)
> >
> > I used to make quite a lot of mess until I grouped all the stuff in
> > one struct :/
>
> If something you want to prevent at compile time, consider to utilize
> static_assert() and / or BUILD_BUG_ON() depending on the place in the
> code (the former is preferred).

I would be happy to get rid of my macro and use those assertion
things, but I can't see how exactly. Do you have any advice about how
to take advantage of them for catching bugs like the one above in this
specific case?
