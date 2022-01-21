Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCC49663E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiAUUMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiAUUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:12:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB374C06173B;
        Fri, 21 Jan 2022 12:12:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id s13so3033123ejy.3;
        Fri, 21 Jan 2022 12:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWFhQ8AyYyJtKJhYHxbzZAy/uyi61n/qj66gr+QR1JU=;
        b=C8EOiSjCDvxrWY2Ruh48zw6GmmqDRMiC4Xh4oNcfGcsAk4QxT/4WpK9v30k7R8BJTP
         Ox33CjNanCQL5JyR5uyLDlkgeLcOdifO5g9DsCa0rbRNbnWai+SokHAOH8jjHzhYibLU
         +zS9PNDuW/W449Hl6zRgYlVFU1GH8q3F2fwCNvg0PKdCaFYlX1Oi9gpQMYDiEgeBBn4E
         gepuFb5h9afDmvRCUqdyNzK+46+J1POQ0Dw50E6frm5NfGq4duBsbIy48/Su6VdUdePn
         8FaHt4DcROcLF95bgfpKvTH6CankmVX8ujX+aQajQ6ivme+VErteaMSP9P5K3Gatceg+
         C3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWFhQ8AyYyJtKJhYHxbzZAy/uyi61n/qj66gr+QR1JU=;
        b=gWDzKTdcP9JrRU/Q4pUA6Ov+KCNcvk2raJiEhNKJS4ncMXPDZ40zkQhM5h0pxYCQ5y
         azS8bM1Aq2qRYMkrqf8VqxDgep5vnYMApmPkAvwB1NFAqIL64Lye0w+saeyv2/PbixiC
         CkSc6kvB7L8MY7O4Ld0i5L853tbQ/GGh8LKHd3AenCM9dsf1cV4DDOA9t/qcWVTxBang
         i+o1z5HVkQ8X8jAGKwSd9Eke1zOzV0/lUtlC8ZPc4i5rstwWtjB876bo946gPimueacX
         8WZFFB4ngj0T1+0dv9wuxQauIcCP/7uASO6c0THpioT9pA5vM8XYaxZtYmtTGep/MF9K
         3B0Q==
X-Gm-Message-State: AOAM532ZzETPGpZkaYQ6dKHa41rx4ZnupIL9IeKOlXqAodRgd+gdYzq7
        uG5hwMos9A0fi+6I1S9E5jxTlU7R0G0VtKduQpkmNTkhLB8=
X-Google-Smtp-Source: ABdhPJxiTTwzTmbtx9DNC7Ah5PIXbFyKWQWSb2hxPEtw2WvBrKl7feHCqB0yc+Flx4KZez6dtVy+19KCludTGmAPY9M=
X-Received: by 2002:a17:906:3004:: with SMTP id 4mr4419944ejz.579.1642795940215;
 Fri, 21 Jan 2022 12:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
 <20220118145251.1548-6-sbinding@opensource.cirrus.com> <CAJZ5v0g0n201FPcG9LBNG3e4UdNYSWmj_1sN3MxLxmK=GoF+tA@mail.gmail.com>
 <a3522b5e-fb36-b959-d2ea-d141d3ad9999@opensource.cirrus.com> <CAJZ5v0h8MWb3sSuqWHUcm9TVWP0uJ+=GmzAuqVtNag2LP+0kYQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h8MWb3sSuqWHUcm9TVWP0uJ+=GmzAuqVtNag2LP+0kYQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jan 2022 22:11:43 +0200
Message-ID: <CAHp75VekU6j4vB_ej8k1f5JcTrAfm10aeekZo8_=jenK1KRbUA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] platform/x86: i2c-multi-instantiate: Move it to
 drivers/acpi folder
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lucas tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 9:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jan 19, 2022 at 6:33 PM Lucas tanure
> <tanureal@opensource.cirrus.com> wrote:
> > On 1/19/22 16:53, Rafael J. Wysocki wrote:
> > > On Tue, Jan 18, 2022 at 3:53 PM Stefan Binding
> > > <sbinding@opensource.cirrus.com> wrote:

...

> > > Why are you moving it away from platform/x86?
> > >
> > > Adding SPI to the mix doesn't seem to be a sufficient reason.
> > >
> > > If this were going to be needed on non-x86, that would be a good
> > > reason for moving it, but is that actually the case?  If so, why isn't
> > > that mentioned in the changelog above?
> > >
> >
> > It was a request made by Andy Shevchenko:
> > https://lkml.org/lkml/2021/12/3/347
>
> But he hasn't given any reasons why that'd be better.

My thoughts were that these are related to ACPI handling the serial
buses in one place. However, counter arguments might be that the cases
of the resources like this are found only on x86 hardware (while ACPI
should be agnostic to that) and that the i2c and spi already do ACPI
stuff on their own. That said, there are pros and cons and I'm fine
with either choice at the end of the day.

-- 
With Best Regards,
Andy Shevchenko
