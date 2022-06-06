Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07C953F05F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiFFUoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiFFUoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:44:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E705F33BD;
        Mon,  6 Jun 2022 13:39:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so31151717ejj.10;
        Mon, 06 Jun 2022 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wcrwg+5kpusbUv6mM8nbAt914joU1P7QO7DYSLgfbnI=;
        b=hG6c1HAkk4iy0xcKIdNNZsdOuZOT49l0YicDt6SMRjScPtsjE3PTe0e5XO10BfG+cW
         2Ajn2ksBfIBJX/nZoXrbs+eFlDZT8lFtSBhAv+jJsbhqrV+qR7xENo9opmBxqrgkAK2s
         Kus0HwEnFYcIYXMfZIaom57Xmc2MJ7x0tQ4f73LW7TeMmLC7IQXilETyXvD0UTun35Zo
         /30B8NezejluftCu47wls8OFiO2n3pNND4OOPA/SA/AIbSQACw3vimoFBZVjXlEy2IGn
         /68SBpSwWWAlCniGiWJOlkk3qkM7E4Mf4HGP5o2+G74gDWev4/BUp46wq5LOztC3z4rq
         aiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcrwg+5kpusbUv6mM8nbAt914joU1P7QO7DYSLgfbnI=;
        b=M9Qisoya7P5KS+uz6G7w0JDB0RSOAtgc/fDprdjWdwpjH67s9YXkiIH80z6EaEfZCK
         5wrnUUGzm1fuzX7Grnlwj3AalLlrbQvaX1WUkxxr3KpbuE1jzljL7IFKKgOAIZGKHJwd
         laGRE/9+rzYfJgOeMypVWmzMX8hDLhMSwuVssA/mS8qCZg6HJzklyMECSuKcMD7rGN1j
         WGS16Lu9OtuQYAC/zhomHy4fY91vPmsQjIu8/6u1E01MMd5cZw8qfIKN6h+G28I7X0+/
         wI9Vq/0PuDEL7zVfNAqTyuekgTxrfhC6MA0lkaJCi2nq2cCi22gED7gDTMp5i2rCB4W1
         pVNg==
X-Gm-Message-State: AOAM5301wYBGHFzdAT7wp4+FhdmSyIDjeeKtIgdpS5R7yJhV9u1n2eNt
        ryqgCeHqJjFsQfdMRgDwRs/WvNbJSKiRP3h8g2d3jB2ozggIEw==
X-Google-Smtp-Source: ABdhPJzRBPIq2f0KX08oiamErCtsNsQ+t7PKyD4s10gN2LPnxLwGP5Go/5ir9YXLAGN3nnRdHciPXmDPjZYFJBAkSxY=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr19987923ejc.132.1654547954422; Mon, 06
 Jun 2022 13:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
 <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com> <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
 <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
 <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com> <CAHp75Vek_O9MJHGXkgJQZT1w-QbdiU0Bpc_PqcA+P6yEBJcEpA@mail.gmail.com>
 <20220606194046.gbt4ghz2yvazsfo4@pengutronix.de>
In-Reply-To: <20220606194046.gbt4ghz2yvazsfo4@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 22:38:37 +0200
Message-ID: <CAHp75VdiJFtLnEJfW6KXwaVFsKWSSTSMgKQLvikSEQj7x3tgLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr read
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Jun 6, 2022 at 9:40 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Jun 06, 2022 at 07:01:15PM +0200, Andy Shevchenko wrote:
> > On Mon, Jun 6, 2022 at 6:54 PM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Mon, 6 Jun 2022, Andy Shevchenko wrote:
> > > > On Mon, Jun 6, 2022 at 3:55 PM Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > ...
> >
> > > > But more importantly I do not see the reason for the Acked-by tag w=
hen
> > > > SoB of the same person is present.
> > >
> > > I just repeated what Uwe gave me. Maybe he didn't notice he was alrea=
dy
> > > there as SoB.
> > >
> > > This situation is anyway a bit more complex than usual. The line I to=
ok
> > > was part of Uwe's much larger patch initially (which was fully revert=
ed)
> > > so his SoB was carried over to preserve the authorship. As I made a
> > > non-trivial modification to his original patch by removing almost all=
 of
> > > it, I added my SoB too. Given this situation, I kind of thought he Ac=
ked
> > > (approved) the post-modification version of it.
> >
> > I believe you haven't preserved the authorship that way (since From
> > line is different), but since you have done non-trivial changes and
> > Uwe is okay with them, the straightforward tag chain would be (with
> > your authorship implied):
> > Co-developed-by: Uwe
> > SoB: Uwe
> > SoB: yours
>
> I don't care much, but IMHO the initial set of tags made sense to me.

> It
> has my S-o-b because the change is (somewhat) taken from me and it has
> my ack because the modification looked good to me.

According to
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when=
-to-use-acked-by-cc-and-co-developed-by
the SoB already implies that you developed that, but Ack if not. It
also clarifies Co-developed-by for cases like this.


--=20
With Best Regards,
Andy Shevchenko
