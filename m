Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28F4EEA30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbiDAJQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbiDAJQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:16:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF362106;
        Fri,  1 Apr 2022 02:14:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id p15so4510019ejc.7;
        Fri, 01 Apr 2022 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsrH6lo/DuV4Px4EXvnPoTR1hR5ZaTVHAh03QaHrq6A=;
        b=JmWHvJBisgImhvOyUD8tzZMza46HKn1xukfz2TVuVZcwQiW9r9bWuZyTHbZLLjJ7YL
         X7BQgSpD2BU67vo8E0YuDzJiVY3X8CerJ7uQqa8FIEfl8GMq1q7RgFDVX4ai82UeSHBA
         4tut4Lm5wrlvMi5icLLJpU/0bXRjZFaesEVK9O6S5oseWYrhc2zW4yH8AzF5AJz7xHfP
         vei6msMEn0JTcdKwSKeEs/fDy2Pho8f/JBbBurn86M97KSq3LGE6wFvoXcsMqqgTIHvi
         p36K9x3StE7pLaRVB4BA3VHheIcxA8UUmz0nn9FoszQvo4dpAWHyEt85XpscOyqKY1ol
         OVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsrH6lo/DuV4Px4EXvnPoTR1hR5ZaTVHAh03QaHrq6A=;
        b=VIr47Pm78nEj5/WRcB91tco+w25ByDcQOaDc+71IV/4MwlBWC2friBCmB5guvpcH8v
         /TeuiSkn+WYgk+Nr1JExW03n+zzo9f3XNaTNt6d3qXeogj4pbNsQc2+MK8fo4J1/DuPy
         7s2ojNceBnHXuSEsE6M1BevdBO+RU0E9cmjFFJaSBix9cUFAHdvz54eWwb1aTxeZcGaF
         PHJuHIKj3dismTaw6q1RzKiIqAARtRkpUesayTPZYbpsbWLtb5YjWbHxLq2aEdhr/Fqy
         P1xDpDMXU2qbcgOWbahXo/N8MTZI5Nrl0LDyIwtH7nGReWBsvCm4alpuPrmglInfsSCD
         stew==
X-Gm-Message-State: AOAM530pfk8KgzUmG/BUm0OEpWXpK/wxLd6A6KQr/lnB6BC85xAhycYq
        Jlv/AXBRHgKKVugMv33JG4OMZehnI/ezvcSUc+I=
X-Google-Smtp-Source: ABdhPJyTnf43naj3nJDmc6O7XIWY7gMqZWU+WWhlCaIeW80QNYOMdTnt+kvt5LZoJvx6LXwsuS005Jw0OlQBDMx+QOo=
X-Received: by 2002:a17:907:160b:b0:6e1:116e:7a59 with SMTP id
 hb11-20020a170907160b00b006e1116e7a59mr8365081ejc.579.1648804472914; Fri, 01
 Apr 2022 02:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <1648540212-9790-1-git-send-email-unSimple1993@163.com>
 <CAHp75VdwLPkzE9AHkXg=+vsagh4SGam40vz8uRdSRUpr6Cyv7A@mail.gmail.com> <2e3426e0.2d71.17fe315bdb6.Coremail.unsimple1993@163.com>
In-Reply-To: <2e3426e0.2d71.17fe315bdb6.Coremail.unsimple1993@163.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Apr 2022 12:13:27 +0300
Message-ID: <CAHp75Vcs+HG-e=BHhgWP6Ndh5nZWXXnqhZ2jfN33Fs0qu5U_Bw@mail.gmail.com>
Subject: Re: Re: [PATCH v1] pinctrl: ralink: rt2880: Check for return value of devm_kcalloc()
To:     unSimple <unsimple1993@163.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Yan <yanaijie@huawei.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
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

On Fri, Apr 1, 2022 at 6:06 AM unSimple <unsimple1993@163.com> wrote:

>
> The main consideration of the 'continue' in the patch is that those statements are inner a loop.
>
> The next allocation may be successful so I think it is better to use 'continue' here.

Please, do not top-post!

What you explained is logical from APIs point of view, what I was
asking is about functional point of view.
Why do you think the skipping iteration is fine?

You need to explain this in the code/commit message.

> At 2022-03-29 19:45:50, "Andy Shevchenko" <andy.shevchenko@gmail.com> wrote:
> >On Tue, Mar 29, 2022 at 11:36 AM QintaoShen <unSimple1993@163.com> wrote:
> >>
> >> The memory allocation function devm_kcalloc() may return NULL pointer,
> >
> >may --> might
> >
> >> so it is better to add a check for 'p->func[i]->pins' to avoid possible
> >> NULL pointer dereference.

...

> >> @@ -266,6 +266,10 @@ static int rt2880_pinmux_pins(struct rt2880_priv *p)
> >>                                                 p->func[i]->pin_count,
> >>                                                 sizeof(int),
> >>                                                 GFP_KERNEL);
> >
> >> +
> >
> >Stray change. Also it seems it has trailing space character(s).
> >
> >> +        if (!p->func[i]->pins)
> >
> >> +            continue;
> >
> >Why is 'continue' the proper choice here? No clarification is given in
> >the commit message.
> >
> >>                 for (j = 0; j < p->func[i]->pin_count; j++)
> >>                         p->func[i]->pins[j] = p->func[i]->pin_first + j;

-- 
With Best Regards,
Andy Shevchenko
