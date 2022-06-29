Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB655FC83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiF2JwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiF2Jvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:51:52 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5210C3D4AB;
        Wed, 29 Jun 2022 02:51:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3177f4ce3e2so142733977b3.5;
        Wed, 29 Jun 2022 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GElelnyPu+t07uIEEMNg6LAxOxXoiqjQ91T5C4EviUo=;
        b=k5Dz9Mh62sOyTMvK1jWeC2gk1L7MIejLDCiZiyIRvcclCRkz4ozx33pOhMPnvNMVUl
         MjyFTRHSY8KdXW81PV6z5oHynmj5QMU8LplegY5n5eWyBQGtOSkfZJJuapRR8+SwYBtQ
         rROmUXBAUjkrru2etvsjnCDJFjt04o8vFd+u6AoOV49seRLM8K9wtA8GSpXsPEgQuLvF
         PJlB1eeddl4lI1TzBtc98SQsuQ4dambMemxNJPm5SW51QctVQjPoJvl7zW4nke/Ggapy
         daYEhlJkgp8BZbpn/ObnS2Cl+6FWaFTG5dxo1MoLDAvr1cwcFNQelzoDIS+o7p4Xij86
         3rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GElelnyPu+t07uIEEMNg6LAxOxXoiqjQ91T5C4EviUo=;
        b=L9TTzv8FdhtCFWDHOi5hj/gjTSBne/VLJwyvlJgLOKmH0wUKhfwJQ2Ll7im0yQhGIh
         Od/+YDJSOyaOvpRouWZtEPFJLtIS1u0i0rPbvNqDcYO1AUkOIrNiwzV4owLaacXWaPwO
         3ilEYqpH9YlbCDHEmh3Q7SNh3mmsBSEbjq8oIDK0D4Rk1ef0B5bp68EONJvNkogadr3G
         6cyPFiG+JgIiqI2g9kF9SSaHaVg/15T+14Vkx5ua1zVQiVRHbMtNlMKxusniDLIcVd1r
         C/glclTPlHeod9gbqK0stOwOW7jnaRaOsYvn4QTn5E0E/SceqKXI8fKnaKvVv2W3UgtL
         Qbcw==
X-Gm-Message-State: AJIora/wNxzOrsq3Sx3/paO/b5fPa5Kx1ICOAYFhh0jQYV/jTMzLM0Q0
        QhZmTQwlQr9OGSdMZpFaKuCYzrVCX+LQElMReXs=
X-Google-Smtp-Source: AGRyM1sLb4+78GKq6YudXBHdKWqNbrWdmM1li71d2ceRvJR5iIAkl+r/YogRx5zau14DkeHiwy1E0ClG7jr5CwzQ+j8=
X-Received: by 2002:a81:5d88:0:b0:318:31c1:56f3 with SMTP id
 r130-20020a815d88000000b0031831c156f3mr2860106ywb.18.1656496310543; Wed, 29
 Jun 2022 02:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
 <20220628134234.53771-5-ilpo.jarvinen@linux.intel.com> <CAHp75Vf36sFqX1SL4Sjz6ZgNXP41Nom0Q1s6Psgv9WMFkKtGtg@mail.gmail.com>
 <29b084c-183b-4a84-2376-2c88eff7d5a@linux.intel.com> <CAHp75VevfptcsTTkFvCRsJRxuKX6aJ2zQ5LyH0O8wP+aB4xXHw@mail.gmail.com>
 <bc54d67-e573-9ecc-1650-7e7fc35f7897@linux.intel.com>
In-Reply-To: <bc54d67-e573-9ecc-1650-7e7fc35f7897@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 11:51:13 +0200
Message-ID: <CAHp75VdsTjbEwocx4DAhMBM6nwKhuL3xgaJeZhV=ZhBPz3pdRw@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: 8250_dw: Rework ->serial_out() LCR write
 retry logic
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Wed, Jun 29, 2022 at 11:40 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Wed, 29 Jun 2022, Andy Shevchenko wrote:
> > On Wed, Jun 29, 2022 at 10:47 AM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Tue, 28 Jun 2022, Andy Shevchenko wrote:

...

> > > Eh, are you suggesting I should do write as a side-effect inside one =
of
> > > the iopoll.h macros? Because those available seem to only read?
> > >
> > > Or should I create another macro there which writes too?
> >
> > It seems to me that it would be a macro on top of iopoll's one which
> > will take an op read and op write arguments depending on the case.
>
> The thing is those iopoll macros don't return until the timeout is
> exhausted

It returns when the condition is true (in your case verify_lcr is OK).

> so I don't think I can reuse them easily for this task ("on top
> of iopoll's one")? That is, w/o some major side-effect hack (which is
> IMHO a no-go).

Basically what we need is a write-read type of polling.

With your current approach I don't like that retries assignment is
duplicated several times and decrement happens in the callee. What I'm
trying to suggest is to research alternatives.

--=20
With Best Regards,
Andy Shevchenko
