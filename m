Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5F853FAB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbiFGKC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiFGKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:02:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012065F8A;
        Tue,  7 Jun 2022 03:02:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b8so5598211edj.11;
        Tue, 07 Jun 2022 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22+arTrvo1OVycmSNW1K2UlJf5Gwa3d1qjbfOB+SNko=;
        b=cV86jW/RsJl2yp7PQbKCu9MZT5W0tt917FmbE7LQFsCFYKR/+6cET4Vpqo+25wnjgH
         Ci5V7Bp8Up8EuYPAHO3jjHCFOBeJI7/y0JtD40tZDk70n9SRsYlWwMacFdyJcej3MuYn
         YHa1NFtpw1UpHqmRDJa3JE3i5kgVJ3QHciWa5nTAtSXl7gRaFiBHwF4eWIhTJgRiGA/C
         +ZBOFxeyZcCWx0n9g9uJaPaZdkng+08RtBfYgdDS8e0bch4RuB5Fzy4RQ99dxKSxDKtE
         SknIlasik/AwzDThv+THmwyXu9IDv6Z71IpqojJstsxoNAnln7n4A1fBPYwV1yj/pa2q
         Qz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22+arTrvo1OVycmSNW1K2UlJf5Gwa3d1qjbfOB+SNko=;
        b=kF7fF8IrGnRruTDbxjpLctGz+sZFD/aWXX17GwwpcexadwC28p7xWcJbvhgR7lGF3o
         yENTQPosTkjt1eW/LZSkAEFIwHVXDRk7PuDpfQdgYJYrXPrD4jegnuIFGBkCqcjwEVdT
         sdhmUjCfbxQ7Qwf5EwOKA12phvfxq7EA6IVwabEleFEbY6F0/fI/gci28iEbhM2ldU6J
         f5U3phExocZ2ZcpdXyThtozeyWq+YxiBouVs5dQwnAiywprw4dUOE4P/V9ccqGekc6d/
         N+ccrhRjP0Sz3BbJyIM5E+rduUHCClgggUjeoSlIvhLH19WjuOp1OyenB9J8oLaVx+vY
         xf0Q==
X-Gm-Message-State: AOAM531DpHL4HnR19lCSpaFwhn9E9Eyi074nLzZmPg0530JQl98BA6UB
        eyOlnZo/aDSJ7Tb+Ixei5kgql6lfZKq3m7VVJEDw9dOykjwIVQ==
X-Google-Smtp-Source: ABdhPJxS6upelYsko+7tcj8nHvCDiiy+DHldiJIy/Cp1PC5H7P/jz3xowxK1vVGqmmk/JXNwgtJXZ91S87U3T6RKsbE=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr32390900edr.209.1654596140504; Tue, 07
 Jun 2022 03:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220602083128.22540-1-jslaby@suse.cz> <20220602083128.22540-2-jslaby@suse.cz>
 <CAHp75VfsR6sVwO9iF6RA0bhVjMF1jC1_JEkv106TubPgL_m8YA@mail.gmail.com>
 <4d4549ef-f8f8-d0cb-6d27-e6200aa14048@kernel.org> <CAHp75Vd4H2AOcDV-cWug+MCup5RY0udTZX2uq3rzP+czy0uiJg@mail.gmail.com>
In-Reply-To: <CAHp75Vd4H2AOcDV-cWug+MCup5RY0udTZX2uq3rzP+czy0uiJg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Jun 2022 12:01:44 +0200
Message-ID: <CAHp75VeTHUe=VCs-mq27ffk6uFXZ-vkPvb=r7S1S8-_oi1FtJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty/vt: Makefile, add --unicode for loadkeys invocation
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
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

On Tue, Jun 7, 2022 at 11:58 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jun 7, 2022 at 7:42 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > On 06. 06. 22, 16:35, Andy Shevchenko wrote:
> > > On Thu, Jun 2, 2022 at 12:30 PM Jiri Slaby <jslaby@suse.cz> wrote:
> > >>
> > >> For a long time, we generate unicode tables using loadkeys. So fix
> > >> Makefile to use that flag too.
> > >
> > > generated
> >
> > We still do, but I didn't even know there is even a rule for that ;).
>
> I understand, but here is English stylistics like this. You need to
> use past ind. or present perfect ("for a long time" dictates that).

Okay, now even more explanation, present perfect should be used here.

we have generated


-- 
With Best Regards,
Andy Shevchenko
