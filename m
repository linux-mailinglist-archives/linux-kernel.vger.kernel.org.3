Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC451A5A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353514AbiEDQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiEDQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:40:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C015711;
        Wed,  4 May 2022 09:37:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d6so2321472ede.8;
        Wed, 04 May 2022 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xf0XnIUXSUk6cizryQBZy/YJHjA9ZjdH2YsUOzyDnc4=;
        b=aSXtoSMHDvZNXMhWaihhLP25nQOQhiEHCKB91OUlWvLZD0yCipp8z5dzqA69y0ms61
         Lq8x67iU3jxnqIMy4JG6m3PIEmXpy6R1DEZDGGSdgtjRu07/Xsd77YBZQ43e6zWVaYQ5
         MP1lZaWwaOiuqf2Ddf4OPGhE53cKuuXZoPSktz7O+xjodz7Tbtl9invbFlKBgWRh2q8K
         Bp6XRGmdhMHMvAcPYe5A7MxC9Wu76/YGcQW8qLUMreFTu1O1DCin2OiWNE1GSjYs8Zrx
         u5Y0jwDXFcbnRPgCQa0UEB7k08nXH/WpKUg6QkZ9ml4hyJYfsm2oLkuNaLHDW36+8h82
         yAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xf0XnIUXSUk6cizryQBZy/YJHjA9ZjdH2YsUOzyDnc4=;
        b=6sExnOamH6OLNhCg3fHPq6eYJ9D9QxOntpKJFDzhMyWSkanhiGiPkL7xoQXvL/Ho0r
         6jKTvKNeOz2GaHCzGS+4W9iIq75I8BMlFlV04r46rdW0R+7kyBmQV2hRh6T+hAFOrody
         ZAPXIVeiNQTtuY9+aFQck2kT1ys3xBZ2TDAy+Mu7MoZ3TYxLmqmaaX9j0qcUWKN1XOIw
         hKO7mpACf/XMWSoHF+ONVoI5JRW+w5Qe4GtuR4fNEpB1clb0NiJkmJEzd+u8ZUY/7f+/
         WADTG7OCLvkYc3cSBdqLS7spypshN6/z9OTwh+JJJXUSCSu53a1c9YIhFfet3//BrlZW
         XNdg==
X-Gm-Message-State: AOAM533l5IG29udDARzm8ZPDqzY/721uaucsVkHqtlgYrIr3aiUr9l2g
        +abbNDAU0ku3rv6/caEQnCYlyI7k5OlS5o/RwCRBWi4UMYDGAdDp
X-Google-Smtp-Source: ABdhPJzvVj4QAu2vJSNQvv5AulXPLXlXytMRH0aeuSwaDWF3GIZlKBljGm3kzbhGM2ilk0akA+eSiBvblyYOUScdFNE=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr23790727edu.158.1651682229586; Wed, 04
 May 2022 09:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
 <20220308193522.26696-1-henning.schild@siemens.com> <YnJ2tYjCpJi7yc4j@smile.fi.intel.com>
 <20220504171951.0d569632@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220504171951.0d569632@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 May 2022 18:36:33 +0200
Message-ID: <CAHp75VfhzYrCRd_Ne_JPdzXgNaaHz8Eg_Rr+n83umWVFtoTzfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] simatic-ipc additions to p2sb apl lake gpio
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
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

On Wed, May 4, 2022 at 6:16 PM Henning Schild
<henning.schild@siemens.com> wrote:
> Am Wed, 4 May 2022 15:51:01 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Tue, Mar 08, 2022 at 08:35:20PM +0100, Henning Schild wrote:

...

> > Second question is could it be possible to split first patch into
> > three, or it has to be in one?
>
> I assume one for leds one for wdt and finally drop stuff from platform,

Yes.

> and i will go with that assumption for a next round based on your tree
> directly.

> Can you explain why that will be useful? While it is kind of a
> separation of concerns and subsystems ... it also kind of all belongs
> together and needs to be merged in a rather strict order.

The main case here is that it's easy to review during upstreaming and
in case of somebody looking into the history. It keeps each of the
changes logically isolated. I.o.w. it adds flexibility, for example
changing ordering of the WDT and LED patches in the series in this
case.

I admit that for _this_ series my arguments are not strong, but I'm
speaking out of general approach. The pattern
  1) add new api
  2) switch driver #1 to it
  ...
  2+n) switch driver #n to it
  3+n) drop old API
is how we do in the Linux kernel, even if the changes are coupled
together from a functional / compile perspective.

-- 
With Best Regards,
Andy Shevchenko
