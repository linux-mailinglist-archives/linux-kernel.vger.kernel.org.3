Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64459AC28
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbiHTHTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344259AbiHTHSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:18:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C853883073;
        Sat, 20 Aug 2022 00:18:51 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m5so4728392qkk.1;
        Sat, 20 Aug 2022 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RfHnMtcUMETMR/Aa5CV8kPSlFBKpFrMW9OaR7NTF/mw=;
        b=gErxLB/H9EPF/1o1mS8x9cvyBOD3vCmxe0xHdLOMdgdrrHDot66YlGqsTRSS3Za0nW
         7uudGW4aoWfPavvjHQWv6p6GLXRfPhtO9uRZvnAPDNKfCsvYLELF3ObwXlWxdA84ukYT
         9RbDlyybycQwsDqDoEGRNUXwGWykstwGmqhd/zSlxqR7I2kn1gair8nLqF9uU4JtVQLv
         21Szigiu0we8EpjFIu+w/EpCpeazOi7eyoKhKLOyNPCxm525RbbCXSPVLFthmg1njgld
         hZ06fVPfOmmM8367dduaQQ/sWZrvNrWpg2xX1UMyoY479Gxuc3claNaCabt+9MT5Cm//
         E2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RfHnMtcUMETMR/Aa5CV8kPSlFBKpFrMW9OaR7NTF/mw=;
        b=SrjjZXyx9BndxtPK2bA6r+VHeZH53lYi3QSE596JPg5nfqXeCQAR9gSdJNDYcH6yqr
         yppLC2pudPaVijBmWeLJAviEx1YKcSlxVzOLe/R5eEDn3v7GwUczOMbyn4F/U5vhmSQf
         GYuN56fSVQlWGnEgpWv/998nRRx26Eu8MhUl63cT1c2I7uRONwNn5GmNkMb3zx6khWyR
         ydvmTUzjAdWLjTpWPcKCZ5c806qtzYPrA3nPgA9zShPqOIwwI+v1yDhrYS6V9RiubM4h
         sJD44gHMqkezsZBmzkm7mc+wk2APhSDc2+cLQZvXCSXvnVs3xnyHb+q9u8laj9991ZKq
         lvzQ==
X-Gm-Message-State: ACgBeo1gLwYhXnosLlmSnW3niet+90zNH98OqYKsUGKflJtNIZuI8js2
        YvycyAF5rPJlTohvfcKBPBKSuEl4sefvXbqK/J70LT+dYZPllA==
X-Google-Smtp-Source: AA6agR51iJY4HTrrDAV07jAOvPgX/Gd8/EHqlA7xQFEYvWuz7ZiSh9uMxBez6zihroZyU+XxYQOxMhACGd1VBbCQkQk=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr7336251qkf.320.1660979930527; Sat, 20
 Aug 2022 00:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
 <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com> <CAHp75VdGhXpD8YgwkVPLCBEMmupBiTDS4FChocJFVo+BBZ-2KA@mail.gmail.com>
 <0823a6e8-b325-78c5-d060-c5f9442e3df8@fi.rohmeurope.com>
In-Reply-To: <0823a6e8-b325-78c5-d060-c5f9442e3df8@fi.rohmeurope.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 10:18:14 +0300
Message-ID: <CAHp75VdMA5mkxkMrtiRTGn5F-5GWjxKyuD5iBuj3HKWqZZMxkg@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using devm_regulator_*get_enable()
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Sat, Aug 20, 2022 at 9:48 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
> On 8/20/22 09:25, Andy Shevchenko wrote:
> > On Sat, Aug 20, 2022 at 9:19 AM Vaittinen, Matti
> > <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> >> On 8/20/22 02:30, Andy Shevchenko wrote:
> >>> On Fri, Aug 19, 2022 at 10:21 PM Matti Vaittinen
> >>> <mazziesaccount@gmail.com> wrote:
> >
> > What did I miss?
>
>  >>>>           struct bmg160_data *data;
>  >>>>           struct iio_dev *indio_dev;
>
> This does already violate the rule.

Indeed, I am reading this with an MTA that has True Type fonts, and I
can't see it at the first glance. But this breaks that rule slightly
while your added line breaks it significantly.

> >>> this case you even can move it out of the function, so we will see
> >>> clearly that this is (not a hidden) global variable.
> >>
> >> Here I do disagree with you. Moving the array out of the function makes
> >> it _much_ less obvious it is not used outside this function. Reason for
> >> making is "static const" is to allow the data be placed in read-only
> >> area (thanks to Guenter who originally gave me this tip).
> >
> > "static" in C language means two things (that's what come to my mind):
> > - for functions this tells that a function is not used outside of the module;
> > - for variables that it is a _global_ variable.
> >
> > Hiding static inside functions is not a good coding practice since it
> > hides scope of the variable.
>
> For const arrays the static in function does make sense. Being able to
> place the data in read-only areas do help with the memory on limited
> systems.

I'm not sure we are on the same page. I do not object to the "const"
part and we are _not_ talking about that.

> > And if you look into the kernel code, I
> > believe the use you are proposing is in minority.
>
> I don't know about the statistics. What I know is that we do have a
> technical benefits when we use static const arrays instead of non static
> ones in the functions. I do also believe placing the variables in blocks
> is a good practice.

Yes, and global variables are better to be seen as global variables.

> I tend to agree with you that using local, non const statics has
> pitfalls - but the pitfalls do not really apply with const ones. You
> know the value and have no races. Benefit is that just by seeing that no
> pointer is returned you can be sure that no "sane code" uses the data
> outside the function it resides.

Putting a global variable (const or non-const) to the function will
hide its scope and it is prone to getting two variables with the same
or very similar names with quite different semantics. That's why it's
really not good practice. I would rather see it outside of the
function _esp_ because it's static const.

-- 
With Best Regards,
Andy Shevchenko
