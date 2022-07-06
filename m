Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EEE569114
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiGFRtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiGFRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:49:45 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409602AC40;
        Wed,  6 Jul 2022 10:49:42 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c89111f23so97464557b3.0;
        Wed, 06 Jul 2022 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hxTslvLVwC01aY6geFBuJCKUK0+HS1strSnRpGPxitU=;
        b=WTAVi865N4c5hRg+l+I3ZgdaYss3RCuA4gG02qSw2FCnZ/qB0L+Rerz3CzYxdKNtmR
         N8JIy42JnvVtsYbBJEwbwGBq+mmyOBgKh3x74Z/35AA816/VuDL4Z1GIQp/a4GAfUWn+
         SqZmfACsY6R1u3pg0dTPbm34yCI3t1NzixXuF28feZ4s0FcCrVtqFnFPRN/igXiITfmt
         Fy2spcEDuIt30Slyowh/RZV7pSA5MzxKM3utTvNKgC/USWoPaAB7+iARz3UaR22uoT69
         1YrSQJc40l1o0ENH3LNuor1sEo2Z/FmzjWkrhqHR1MtUg1EqQ7R60qeSLi7tTmQRRWp7
         p6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hxTslvLVwC01aY6geFBuJCKUK0+HS1strSnRpGPxitU=;
        b=x4BgUXKGjrZAAZCiISMgJJkFxX1Wp0tofCv1iTdfEUekHDFHpKNFFRSP2jq2RXOZea
         ccHV8lkUOpcBTBkJISrnDG1BOoEBm24nbhuSgClC3LrLKRB38SvIGldwtnmWl8bkrnQ4
         zZ4+UFXPpHtfWpnOYkS76P4la5N09xDsktgEzkou/8FnmyjqO2Jmgiz5NN6HYL71ZbbZ
         Lq/NlhKuZfF48vlK33nkvw3cwexaQoSQay2pKU9fuwFeFtUpyqZZEWVq69wzJYJbA2cI
         c+vaaWhEFnqm/2dRVxl4zLz0XguDwhy1W0N1yGHFIlsJgkMUlnWzbH0OAouQmHwgz1DD
         jfXg==
X-Gm-Message-State: AJIora8NmIKFRK8ZiUPSbL/5jGkdVtgSNDlnlVR+AZfRQXn4hwDITsze
        hJS1QGg3AfpU7/aEyxqQy3ry/8CysT/6fs/wyfY=
X-Google-Smtp-Source: AGRyM1tR3KVZvvsZqpTS+caFqZHgncqVJoW9H8eSG4Xhs43JoeL3dasG+VJDVV+kd0K7qOXvPFt3mAX8DCpe/G+dh5M=
X-Received: by 2002:a81:13cc:0:b0:31c:ad64:352c with SMTP id
 195-20020a8113cc000000b0031cad64352cmr16022413ywt.185.1657129781362; Wed, 06
 Jul 2022 10:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
 <CAHp75VdBv8BJVzBCMzWKpm0RrqX=K_QPQ4cgdshqXP3Uy+hVHQ@mail.gmail.com>
 <b9280ecbf78424882878ef2ff6c3da6671064ed5.camel@gmail.com>
 <CAHp75VcEAtpVsfp2CCtJR_e_eSSFaMkODFwd-ZuHKGsNPcVWfA@mail.gmail.com> <dd655cf6e49cac219a5ae29bff1a19fd026c6ea5.camel@gmail.com>
In-Reply-To: <dd655cf6e49cac219a5ae29bff1a19fd026c6ea5.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Jul 2022 19:49:04 +0200
Message-ID: <CAHp75Ve+jUBW4b7zTEk8M_PpDUdmG3XcTjLt6sU-WpnmWF=YuA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: pressure: bmp280: Adds more tunable config
 parameters for BMP380
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 4:39 PM Angel Iglesias <ang.iglesiasg@gmail.com> wro=
te:
> On mi=C3=A9, 2022-07-06 at 14:42 +0200, Andy Shevchenko wrote:
> > On Wed, Jul 6, 2022 at 12:51 AM Angel Iglesias <ang.iglesiasg@gmail.com=
>
> > wrote:
> > > On Mon, 2022-07-04 at 22:08 +0200, Andy Shevchenko wrote:
> > > > On Mon, Jul 4, 2022 at 2:41 AM Angel Iglesias <ang.iglesiasg@gmail.=
com>
> > > > wrote:

...

> > > > Why do you need to copy'n'paste dozens of the very same comment?
> > > > Wouldn't it be enough to explain it somewhere at the top of the fil=
e
> > > > or in the respective documentation (if it exists)?
> >
> > No answer?
>
> Apologies, I'll fix the duplicated comments. Would be a good place for th=
e
> comment before the function "bmp280_write_raw" or at the start of the swi=
tch
> block?

I believe you may find the best place yourself. My point is to see no
duplication, that's it.

--=20
With Best Regards,
Andy Shevchenko
