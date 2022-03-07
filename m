Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ACB4D0435
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbiCGQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiCGQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:35:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C271EE4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:34:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q17so20751785edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfUB9KGveotPC+aOW7aHf1pQvKGE3xqYGexkhlP27oo=;
        b=JlYPC5Qar4E3QrRWrYj2d2Ffe19Z0EW1k6Dze/0j/Mp07lZl63swtEggELMojXEJg8
         0Po0onHfMvKsmxs+FOdvqs/lngyzWzTAvt9OZctpMl2bqKIO0/a/eqhtvLY0qEMCM9BN
         bxX8ibL5MJFiBaSkwRtDu00nMY/1pqAwYfvatGnpqXB0+PphNwPnuZ/NzHIuhcA5xUFv
         IaHX2wt3HpRHq4qJeMplSfr8oMYez5SM/bXO4fE1OmyoiBmC4UDUeLmWt01k5hVNcvte
         5aXVP8XRQHeStYM17ha3YCoY0AE5PKCUKsg9vy9yGnEEKQSFr8l/ZdloEph4yiJ4vFm6
         wybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfUB9KGveotPC+aOW7aHf1pQvKGE3xqYGexkhlP27oo=;
        b=ffmfHSagEUUSwJbumtjSjEzP1dUh+evaubrfeGz3S1Kae79RAoPgPbuvo3DUCw/99/
         R4O5l86RjvdDsTWRba6wuSDinzs7UB1a7orwpQQziX+a9H6IBxglD8ifySCtgjSajaN/
         Zf/sL0tF4bgoW4Kq6m4eKAQcwDkjg0XNrUTSVpNvbhX74XRnCerH33doieDrFgFDd3VH
         aFtrHkE7AbR+7T3XAYqa1JKHeYc40jr1jnFoucALAadc+tGH7JW/zMfLHdGAnmk79MqE
         xklxsLznQdz5nzXb5BaBMXmT7E+A3fFoHDqRta3FXYIEA0oMuFSc1yGuVZxjr2CTy1tD
         R9tg==
X-Gm-Message-State: AOAM533Z1LLLHg0oeRC+58jyVwS5SiIZ/kJhbKLTwE158fRc10R+ZHLi
        OdjIzpK7pwKuHmeTzoLONGU9Mf0FbtBqsPB9vTnk5/cnxtk=
X-Google-Smtp-Source: ABdhPJxaNfvnooVSfaIEHSjqJdCzt1e4+5URWtDbh/itqz0kRhyya/GRKr6FRmFi8VQEZOb4W97UVMTrd8FyWF3fU7c=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr11724208edu.29.1646670869805; Mon, 07
 Mar 2022 08:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <20220307105810.1747024-1-alexandr.lobakin@intel.com> <CAHp75Vcht_T5kUJu5zjmsUvn+mN+8D5vWBUvRXKTfo+2ocHOTg@mail.gmail.com>
 <CAMZ6RqK=yxLwVnotZuGRiao4Vu4eFEfVXfPaZV1r4rEOmQARig@mail.gmail.com>
In-Reply-To: <CAMZ6RqK=yxLwVnotZuGRiao4Vu4eFEfVXfPaZV1r4rEOmQARig@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 18:33:11 +0200
Message-ID: <CAHp75VfS0wSB+5dXHvoYfQqe0qEW0dOXGChunqu7PX0BZ4orMA@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
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

On Mon, Mar 7, 2022 at 4:06 PM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Mon. 7 Mar 2022 at 22:40, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 7, 2022 at 1:00 PM Alexander Lobakin
> > <alexandr.lobakin@intel.com> wrote:
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Date: Fri, 4 Mar 2022 20:46:08 +0200
> > > > On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> > > > <mailhol.vincent@wanadoo.fr> wrote:

...

> > > > Have you fixed W=1 warnings?
> > > > Without fixing W=1 (which makes much more sense, when used with
> > > > WERROR=y && COMPILE_TEST=y) this has no value.
> > >
> > > How is this connected?
> >
> > By priorities.
> > I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.
>
> *My code* compiles for W=1. For me, fixing this W=2 in the next in line
> if speaking of priorities.

> I do not understand why I should be forbidden to fix a W=2 in the
> file which I am maintaining on the grounds that some code to which
> I do not care still has some W=1.

It's not forbidden. I said something different.

Whatever, thank you for doing it, perhaps we will have less noise in W=2 case.

-- 
With Best Regards,
Andy Shevchenko
