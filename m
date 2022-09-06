Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D35AE557
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiIFK15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiIFK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:27:15 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DF3108B;
        Tue,  6 Sep 2022 03:26:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id y9so4999402qvo.4;
        Tue, 06 Sep 2022 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tXv008SlH69T3a4TyUho92ufuuVkbM9XizBJ17tqxYs=;
        b=n35iD03EAO+a8Q5l+GH4wZqoZrhn7FYOOn2f2vh8Wei5XaEnrSk7Uv1QLK9spM+xw7
         gf8EL6yv2GKuT6zyh2PLtG9GScSynjvAlM99ZTehNwZgj3NzXFAy65cIicUUXOAfCjw1
         ihJ9PFPRImhmX8sWdmdxOThluyBjXDqk+yIRI9+XxzvGMsUMPtHIZUNEbs+J0GM3BqCU
         5R1fyhfeQxM0QXriLj1pOY+Vv0JImZS3babiiFInRC0vXeTO6MWXq8rygy6248MpwEcC
         plC6gfyUNADgJY5bJsgTMLgzwjQ5zN9oDsK2walnglio9zr3EstEab+kJj3U2qOFaEhW
         23Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tXv008SlH69T3a4TyUho92ufuuVkbM9XizBJ17tqxYs=;
        b=jNUPqRlUMiQ9R77Z/d9hgml7bz3r+Z6H19D4K0gvfGxkBwkKNXeWdA3L2I6HmGpRk+
         hvPSTM0/lj6mByYN9cM8CT7nk+EQUEJxhKopx15i2jYCrHiQ0eKbEjQnG9pMmXaiOHbn
         ZUs1KVDQG/oCxyBmpQ+FEYMHAuAtm+Y10GO9PQLzlJBtJ/ogLnIel/hdc9hquvbUELUC
         2xbCx5UYZbthD6stWztfK9bxMeB1C+e7ipqEBa303a/LjTDhJYIzTMoyHVWwdVIXA7o+
         Zh9SZ/zqJP4QMGCH9yiVWUhU6Z+f66ErmxOUE6epgJRfDH0kR9Urhj7yXHt3x8eijAj1
         LZTQ==
X-Gm-Message-State: ACgBeo0LMcWOCystJz9Wv46llSoEd5+4KNtQHE2ZuHEsNvanq04te4Fl
        qR+hoN3+NlOnzoGqKSHVJ/YZAdwOXZpk9SWSAgQ=
X-Google-Smtp-Source: AA6agR465qTH7nx1ElzS/70y3gN16WMCoUHxnwsPzWxhikcrzS4pRgVIzt/mCjCA6j19DPHKH1Sj8kkP7SJbGPIkRME=
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id
 r15-20020a0562140c8f00b0049921ebba3bmr25343673qvr.97.1662459992865; Tue, 06
 Sep 2022 03:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
 <20220902182650.83098-3-andriy.shevchenko@linux.intel.com>
 <CAHp75VcNGEVRnkWeVThaq4zNYoiZGSY-+KfbV5_9zG_5XoriMg@mail.gmail.com>
 <YxXyTCSKzL42PF1D@smile.fi.intel.com> <CACRpkdY4nJuXAxM7tYviWSPeqmCc6o4D--Vq0CZRPNjWNj+E_A@mail.gmail.com>
 <CAHp75VcbucZ_3+bvJCsLk78D6egwckN=rMAdttmVwt8H9MfCSw@mail.gmail.com> <CALNFmy0Hu-BUH8DLMk+5L=5OW46pM_dP47Jy8iKJeixDUW815w@mail.gmail.com>
In-Reply-To: <CALNFmy0Hu-BUH8DLMk+5L=5OW46pM_dP47Jy8iKJeixDUW815w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Sep 2022 13:25:56 +0300
Message-ID: <CAHp75VcP6yMKQJ87Fq5ZYDGMF_39pg_qcKCa4EOz0PQEZ4A0rQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/17] pinctrl: cy8c95x0: Allow most of the registers
 to be cached
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Tue, Sep 6, 2022 at 11:36 AM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Hi,
> I've tested the patch series on my OpenBMC platform and it works fine.

Thank you!
I guess we may consider this as an equivalent to the formal Tested-by tag?

> I don't think it's worth the effort to implement virtual registers for
> the muxed pin configuration,
> but I won't stop you.

It's not a high priority to me anyway, but it is a good feature to
have since regmap allows us to dump registers. Moreover the listing
files in debugfs currently take a lot of time, that's how I come up
with this.

> On Mon, Sep 5, 2022 at 3:37 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Sep 5, 2022 at 4:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Mon, Sep 5, 2022 at 2:57 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 02, 2022 at 09:42:00PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Sep 2, 2022 at 9:36 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > It's unclear why many of static registers were marked as volatile.
> > > > >
> > > > > the static (yeah, forgot it)
> > > > >
> > > > > > They are pretty much bidirectional and static in a sense that
> > > > > > written value is kept there until a new write or chip reset.
> > > > > > Drop those registers from the list to allow them to be cached.
> > > > >
> > > > > This patch is not correct due to indexing access. It's sneaked since I
> > > > > forgot I added it into my main repo. The proper approach should be to
> > > > > create virtual registers and decode them before use. This allows to
> > > > > cache all ports and as a benefit to debug print all port actual
> > > > > statuses.
> > > >
> > > > To be clear: With this one removed from the bunch the rest can be applied w.o.
> > > > any change.
> > >
> > > I'll give Patrick a day or two to test/review and then I'll just apply
> > > them all except this one, they are all pretty self-evident
> >
> > Sure!
> >
> > > except ACPI
> > > things which have obviously been tested on hardware
> >
> > Yes, I have a Galileo Gen 1 board which has been used for testing.
> >
> > >  so from my
> > > point of view it's good to merge.
> >
> > Thanks!


-- 
With Best Regards,
Andy Shevchenko
