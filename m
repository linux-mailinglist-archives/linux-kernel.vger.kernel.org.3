Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58E504F72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiDRLnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiDRLnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:43:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75414B1D7;
        Mon, 18 Apr 2022 04:40:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u18so17171856eda.3;
        Mon, 18 Apr 2022 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K56PTbb7GjfFd5b/W1QIJxR8w2GP6yixT9oeMfbJrEQ=;
        b=M6MjeKSYWD8ZG+Kd0x/gxcOI3riCtJTijbKNJ+sOt0kcBGenaQuWWKM2GbATxsBMWF
         zDinVXgiz2zv9vSQM1tuU7BmxETJ0tU48Sa3iPIxpaat0Wh/hublw3Ui06jIGSM7s0h8
         KUnkXDSJPQbOkam9etlm9MoPlxWEx209BLPlL7q5XR9eUpMvrgsyH7giv6L1RTd6IR8C
         g6MvB+yhna/fKXjpvFr+8HtVQ8UEER8+k6CMC51LCXzXQcSunfwiLD/JxF+26NaW8kYx
         ubHMHVmXJLilKYTM+yQFFRysqE6cjl/lbYnzZ0+K3n17DCYZAPQM2Pp6lW5/8XsCXFxx
         7kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K56PTbb7GjfFd5b/W1QIJxR8w2GP6yixT9oeMfbJrEQ=;
        b=Z98/YmA+3SmAFmDIt4xjvjFG3FKqHzHshmMZt0aMKMVvYALscLyh3rpb1vS12g9hBA
         XFnNzlNgScycmonNzrbgvcpsOW+lwX8l16r3+kFjnkSHBzGKJhjYhTfGat6krR07yyi7
         9ZfYJ5kpt3VlVKGam1FwMFNeah5Jn3ywP4b/LrpjTuEAgDDtGArK3ic2f4b8/Qds0WOn
         5gGNbCxmYSdem2SamvTw/HYiMI1+KFm1CHmxe/0d3KhtTBwE/cluHDpZpRTxvBJPTHBG
         emZ/x9lur9wOieFlnhjYaLyzsm+JVRv+MTT7SDaiZsuftRc2RQsDPkE7k+xuBYB1nxOM
         KWHA==
X-Gm-Message-State: AOAM5332j5SeutrF1I83662tgeGpzA9HLWMF9wT2itd4Hd3VdAMOsdd2
        19Uk9YDsyfHZ5SLnYdA9VlXFKkN5qtMNagaoYPU=
X-Google-Smtp-Source: ABdhPJw1k24oYlzjOvYt33bqPIUetE7j2Rd0cPOIHU+mC8gdp4Nhzys+oouUwDELJGmPRWyYtZ5qH2rAhiei0Ptw23Y=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr11438257edu.158.1650282032779; Mon, 18
 Apr 2022 04:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
 <20220417165208.39754-1-schspa@gmail.com> <CAHp75Vc8HwheQVOpcn_Lxk-bOOMLybr=m6OdO7mJ-vE9xywBLg@mail.gmail.com>
 <CAMA88Tr6NvfEiPYnt0A60GiQKiiT6LT7X83GRku-4PDcG2EtoA@mail.gmail.com> <CAHp75VfcxACmuw5pwPgSB9ud06hWtHCUrMifU1rZJ+h+dwG+bg@mail.gmail.com>
In-Reply-To: <CAHp75VfcxACmuw5pwPgSB9ud06hWtHCUrMifU1rZJ+h+dwG+bg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Apr 2022 14:39:56 +0300
Message-ID: <CAHp75Vchpi0Cvkz5krA0LEZBj-fQTXxbEBzpKxU96mcDRGY--A@mail.gmail.com>
Subject: Re: [PATCH] gpio: use raw spinlock for gpio chip shadowed data
To:     Schspa Shi <schspa@gmail.com>
Cc:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "hoan@os.amperecomputing.com" <hoan@os.amperecomputing.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opendmb@gmail.com" <opendmb@gmail.com>
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

On Mon, Apr 18, 2022 at 2:38 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Apr 18, 2022 at 6:07 AM Schspa Shi <schspa@gmail.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
> ...
>
> > >   drivers/gpio/gpio-mmio.c    | 22 +++++++++++-----------
> > >   include/linux/gpio/driver.h |  2 +-
> > >
> > > You can=E2=80=99t do it for one driver only. As I told it will requir=
e too much of additional churn to make this to be series.
> > >
> >
> > It seems I have misunderstood your "too much of additional churn". Can
> > you explain it?
> > The gpio-mmio.c and driver.h here are the basics of other gpio
> > drivers. In my opinion, these two files
> > belong to the basic code of gpio, and functions such as bgpio_init are
> > declared in
> > include/linux/gpio/driver.h and implemented in
> > drivers/gpio/gpio-mmio.c. So there is no churn.
>
> When you change the member of the data structure, you have to change
> all its users. You can't change only one at a time because it will be
> a (compile-time) bisectability issue.

Answering your question here, it will require moving to union with an
additional member and corresponding core changes, convert all drivers
one-by-one, and remove the old type. It's not worth doing it, but as I
said let maintainers decide.


--=20
With Best Regards,
Andy Shevchenko
