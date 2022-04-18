Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFF505C03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbiDRP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbiDRPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:55:52 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529133E2A;
        Mon, 18 Apr 2022 08:43:26 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id m14so12972325vsp.11;
        Mon, 18 Apr 2022 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L+e1IwjPtrx8G13TcQrLOhPqxxbNlCk3hLHky4qfcOw=;
        b=EJytDbeMBURt5rxmwjAU1L64BLz3FG+Ha6vj8642LRiUF/KP6mq8RUcOfKm5CEp2Sa
         1pil1DOrqtnuIO+KzckywwE0qbOLQ+02sZbdMJJ7+9UYKhdrLaBy0zhpVbwsAu+ikM7W
         /MF2dbWBAEoPqaIps0oKUi5XQB41eDZobexjouej9FImFZrX7o1igHJ4aPrnR4iVAxMK
         QMiMD3Flr3Z0CQ74o+wImQBWNUhnOrweeKlHkGVAKKUo0n+arufcBMbcXe4FGu+bTxFI
         eI2IiS04i8PBjGsEB61FjxdrZHHL5QIsqgdKlkuf33pw/dDc4yIEZt19hIxgWSinY9LR
         KYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L+e1IwjPtrx8G13TcQrLOhPqxxbNlCk3hLHky4qfcOw=;
        b=ZIjrjrY00Exbj9pVVy4KqugU6xSfUIhgY0HxdZCIHOzxTdeeW1Bu5Ww5/MwWlbwLE+
         a6YYrtzOE6MljkVMRUgGyjZfxAOGwvoq7E0KGu2aVwXfZc4S1qEvt6issmdEDcPv4Z7n
         POynyqheL9UHVDQP0fR9LYlVVKYkOlNv5GsKFsorxdjzcQnpZVYCX2HqlMX/0KuaBSn7
         CjuuMDXn//R6pkJvb/9Wdb0e0YW5LeKGfpvy/8ypmGZ4LdFUZXurhg3o8DgcC7nwa+PJ
         6wisKpEzT534B/Q7yTLP1q7gLM57NIZTRBCxRDfwuE/9I4A7tDIC1rWQY+SO/yVZpoaf
         vknA==
X-Gm-Message-State: AOAM531fKdavp+1GK744bgYyTgI8HTxdoP7ey1lVjvhGnfySdeUiWiMo
        d/uj8aVYVacdTsJOE0ArkSUZZakO/ZWigs3M4mrPODWPEpEgXigK
X-Google-Smtp-Source: ABdhPJwMY77Df/u7eQj1RsI6svvKlcNXcbpyqqK+8V8MjEalSfH0xmmviPMBT+4PI06eb9M0VJxgUYB7OdTYrR9xPfA=
X-Received: by 2002:a67:a44d:0:b0:320:601b:2a08 with SMTP id
 p13-20020a67a44d000000b00320601b2a08mr3051790vsh.70.1650296605300; Mon, 18
 Apr 2022 08:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
 <20220417165208.39754-1-schspa@gmail.com> <CAHp75Vc8HwheQVOpcn_Lxk-bOOMLybr=m6OdO7mJ-vE9xywBLg@mail.gmail.com>
 <CAMA88Tr6NvfEiPYnt0A60GiQKiiT6LT7X83GRku-4PDcG2EtoA@mail.gmail.com>
 <CAHp75VfcxACmuw5pwPgSB9ud06hWtHCUrMifU1rZJ+h+dwG+bg@mail.gmail.com> <CAHp75Vchpi0Cvkz5krA0LEZBj-fQTXxbEBzpKxU96mcDRGY--A@mail.gmail.com>
In-Reply-To: <CAHp75Vchpi0Cvkz5krA0LEZBj-fQTXxbEBzpKxU96mcDRGY--A@mail.gmail.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Mon, 18 Apr 2022 23:43:14 +0800
Message-ID: <CAMA88TruFbCZbvq84ep5NbSdxDgi-mPX2iXWk4c2qA-etMA8QQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: use raw spinlock for gpio chip shadowed data
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>
Cc:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "hoan@os.amperecomputing.com" <hoan@os.amperecomputing.com>,
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

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, Apr 18, 2022 at 2:38 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Apr 18, 2022 at 6:07 AM Schspa Shi <schspa@gmail.com> wrote:
>> > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>
>> ...
>>
>> > >   drivers/gpio/gpio-mmio.c    | 22 +++++++++++-----------
>> > >   include/linux/gpio/driver.h |  2 +-
>> > >
>> > > You can=E2=80=99t do it for one driver only. As I told it will requi=
re too much of additional churn to make this to be series.
>> > >
>> >
>> > It seems I have misunderstood your "too much of additional churn". Can
>> > you explain it?
>> > The gpio-mmio.c and driver.h here are the basics of other gpio
>> > drivers. In my opinion, these two files
>> > belong to the basic code of gpio, and functions such as bgpio_init are
>> > declared in
>> > include/linux/gpio/driver.h and implemented in
>> > drivers/gpio/gpio-mmio.c. So there is no churn.
>>
>> When you change the member of the data structure, you have to change
>> all its users. You can't change only one at a time because it will be
>> a (compile-time) bisectability issue.


Yes, I understand and will take for bisectability use case for the next tim=
e.

>
> Answering your question here, it will require moving to union with an
> additional member and corresponding core changes, convert all drivers
> one-by-one, and remove the old type. It's not worth doing it, but as I
> said let maintainers decide.

Okay, sorry for my misunderstanding, I thought you were saying it's
bad to modify too many different files in one patch, so I split the
patch into a series of patchsets.

So, let Linus Walleij or Bartosz Golaszewski to decide for it ?
I have the same options as you, it's a small change, and no need to
trouble everyone for it.

Because this structure will be used as the same instance in multiple
files, even if we change this variable to union first, it can be
compiled, but the program will still not work properly. This is
because bgpio_init is initialized with the type of raw_spinlock_t,
but is still accessed as spinlock_t in other drivers, which is a
serious abnormal initialization.
