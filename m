Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E195659AF3B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346670AbiHTRmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiHTRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:42:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65E1C10D;
        Sat, 20 Aug 2022 10:42:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id n21so5328828qkk.3;
        Sat, 20 Aug 2022 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LVnKGcQgPuy+mBjKHzLpHnlGnV+JMdVIAnIO/y4nwdQ=;
        b=VC39Q9D2BiCSp5q1A+cqEWnpMc5T4knYFxJsgUAcvklXOYkVhwREr4kodA4G0wUnzf
         YhSsD1FVcPHQqO+H+sqbXKDk798/cSIjorkjCh4ZAR2cvcqIgOd31UAruU5Iue86DcgK
         ZS2DcSym31f4Rd9qoqLfE9zJ31ne487yn0a+Uz07QF2N4pgSCBwg80md/3LH0F6OfcRZ
         RoxdwhrL9He+0P44BCp9ysWZ5sVv5jWQm4vBJ2P3qhrMWNQR6gx8n2o3ZdklmSoCAxw1
         Gh3hIGqClOuHcq7QDMQmHE1qRgls0e8yAwhEVB+uQ2MnYVZnPMkSFcrxypazK4zCdp5N
         VNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LVnKGcQgPuy+mBjKHzLpHnlGnV+JMdVIAnIO/y4nwdQ=;
        b=gtJJTB09ioT30BfVuvhsS3RpPflGv5wR0ugn14jt5ssxC/a0Whn/dxA33GeBQaYUl7
         Vcxs3kl3hsIZyC8jdeSqVsIsAClVcXPeoz7nb52HqtbzxzwbDK3EpP4KUfGmozxE83G3
         KOKe9AjmUZcEQ19jG8v4rwel8st2aGLjAV0QhNPSkTeCDh2LR4Zq/6R4Oa39zg4SA+0k
         vITf7eYO5uo57GDIw0uAkc8CMDSmKGDBVWIcsnW0UQkQR3eBacBwtlu/F3V/H1V2XWI6
         Oc4Yp8q3Xt5kce6EzlPPYzNniYvp1jZ9PU4XxP4q4enXiZK0DHZMDTWp+t801TEyWVIZ
         Q6cA==
X-Gm-Message-State: ACgBeo0r9OanRJpFWPa9WzUp4mcoM9BqB1+CGMFyeziyt/UNWS8xfulH
        LArUhesEpkB6JjC1FDXFVSGVYD758F7QZOu+XhEo5UjJCXoVFw==
X-Google-Smtp-Source: AA6agR63nkvnQP3NVG/82+frpSYXo3I9mBiuZCZw9yyjkVVdnUzlAv3/RD7/ZH3YWCW+++dNnbfW+Q8FHwtFo+dWvTs=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr8618567qkp.734.1661017335875; Sat, 20
 Aug 2022 10:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
 <20220820122120.57dddcab@jic23-huawei> <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
 <CAHp75VdoKtc2QqFcDuJ00KBz6mjg0fnM_WhyVqhCmDVo_3K6kg@mail.gmail.com> <01fec744-f3d4-b633-d3ce-bcd86a153132@gmail.com>
In-Reply-To: <01fec744-f3d4-b633-d3ce-bcd86a153132@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 20:41:39 +0300
Message-ID: <CAHp75Vd3vyAZbWpZT9SmyD=ecGTAdVNWK=fs_n4OSAqGtGj_gg@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using devm_regulator_*get_enable()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
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

On Sat, Aug 20, 2022 at 8:30 PM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> On 8/20/22 19:09, Andy Shevchenko wrote:
> > On Sat, Aug 20, 2022 at 4:45 PM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:
> >> On 8/20/22 14:21, Jonathan Cameron wrote:
> >>> On Fri, 19 Aug 2022 22:19:17 +0300
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

> >>> For the whole static / vs non static. My personal preference is not
> >>> to have the static marking but I don't care that much.
> >>
> >> I'd like to stick with the static here. I know this one particular array
> >> does not have much of a footprint - but I'd like to encourage the habit
> >> of considering the memory usage. This discussion serves as an example of
> >> how unknown the impact of making const data static is. I didn't know
> >> this myself until Sebastian educated me :)  Hence my strong preference
> >> on keeping this 'static' as an example for others who are as ignorant as
> >> I were ;) After all, having const data arrays static is quite an easy
> >> way of improving things - and it really does matter when there is many
> >> of arrays - or when they contain large data.
> >
> > But still the same comment about global scope of the variable is applied.
>
> I don't understand why you keep claiming the variable is global when it
> is not?

It is. The static keyword makes it global, but putting the entire
definition into the function is asking for troubles.

I guess some C standard chapter describes that in non-understandable language.

> > As I explained before, hiding global variables inside a function is a
> > bad code practice.
>
> I don't really get what you mean here. And I definitely don't see any
> improvement if we would really use a global variable instead of a local one.

The improvement is avoid hiding the global variable to the local namespace.

-- 
With Best Regards,
Andy Shevchenko
