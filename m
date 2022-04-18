Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B67504F70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiDRLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiDRLll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:41:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2BE1583E;
        Mon, 18 Apr 2022 04:39:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so26349524ejd.9;
        Mon, 18 Apr 2022 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jddOeVYDWIlo/cj/yYFFUXuXoX8x2AdqCL3TeKvdwUM=;
        b=ZNw8LTq4Hc4QPU/VQ5Q/h8Byof5DJNhMrdvdRJ3UUYaEHpeHSo/DfksepFIwKeic79
         POTGJWfdxHDBgh3s/mTLSyj+SeisYdPcKcwKa9O7ihwrFNnce0zsqsD50uMShZz6C9l8
         MCgxNXtiJNzKjdeUomtYxYrYTuHghJ3tzX7GrscJSiMsr0Q9LQry+6F63ka0c79SOL/y
         3YTji6ezy1qw7AGfFsTshYh/9srscRmTkKRB3kGlKtgkUE1vKQMwOmo4EcT1sURqFLdk
         tmXbB7bbmIp1het8+mJqoRI9o/prgDBmiWnCQvhf7zhyEYzBDILJCnfm6KAl4PTT9b79
         ROxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jddOeVYDWIlo/cj/yYFFUXuXoX8x2AdqCL3TeKvdwUM=;
        b=yfSlzcCB6PSc1opV7CCho37iTRRIW2wO9WdKWVynGFk9wm2rd/lzuKIje7aqs/Th6D
         TpGLBbnQDqu7na8f+6uEu0uJcGOPnUtJPJYzvu6m2VA4/ynSagymJM2A13njHGjn4iYQ
         hTpmAlRDtKOjJd15wqe2KzsvMyGVTStS4vabBvKBmcDVvDypKcGLN82w7pFhM3zxTIwp
         g1/9hisQZ5VyH2lyftI7dyKLSeY3iLRuB0ZzcD2XrGqdvD1m8snS3qJj5oc1VefX9eUR
         jqG+x3NYWQJ5fQUZMSKGYyHijzgiBRT1oF4XqBuCVSRwhZhwj8739CnQ0RGwD97jlQ8J
         /CZw==
X-Gm-Message-State: AOAM532uuo2ZASHnQzWs7L83xMRcD6cAbAKiGvTb9FX7w+cUpLYDQB8+
        iAKcbdZNhyyPcVwUQI+K1vn9K7kluVWR5XRhmsvflDXaYg7dBw==
X-Google-Smtp-Source: ABdhPJxZDO39LttWLIMlcBZJwyRo6aMGFqcjYy2+09mhcWQcH+bCrteI9PLYhCvbwwjXmMEbvblSzh3eHxMvbrq4kso=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr8724866ejc.636.1650281940410; Mon, 18
 Apr 2022 04:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
 <20220417165208.39754-1-schspa@gmail.com> <CAHp75Vc8HwheQVOpcn_Lxk-bOOMLybr=m6OdO7mJ-vE9xywBLg@mail.gmail.com>
 <CAMA88Tr6NvfEiPYnt0A60GiQKiiT6LT7X83GRku-4PDcG2EtoA@mail.gmail.com>
In-Reply-To: <CAMA88Tr6NvfEiPYnt0A60GiQKiiT6LT7X83GRku-4PDcG2EtoA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Apr 2022 14:38:24 +0300
Message-ID: <CAHp75VfcxACmuw5pwPgSB9ud06hWtHCUrMifU1rZJ+h+dwG+bg@mail.gmail.com>
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

On Mon, Apr 18, 2022 at 6:07 AM Schspa Shi <schspa@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:

...

> >   drivers/gpio/gpio-mmio.c    | 22 +++++++++++-----------
> >   include/linux/gpio/driver.h |  2 +-
> >
> > You can=E2=80=99t do it for one driver only. As I told it will require =
too much of additional churn to make this to be series.
> >
>
> It seems I have misunderstood your "too much of additional churn". Can
> you explain it?
> The gpio-mmio.c and driver.h here are the basics of other gpio
> drivers. In my opinion, these two files
> belong to the basic code of gpio, and functions such as bgpio_init are
> declared in
> include/linux/gpio/driver.h and implemented in
> drivers/gpio/gpio-mmio.c. So there is no churn.

When you change the member of the data structure, you have to change
all its users. You can't change only one at a time because it will be
a (compile-time) bisectability issue.

--=20
With Best Regards,
Andy Shevchenko
