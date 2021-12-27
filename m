Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D913247FAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhL0HAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhL0HAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:00:21 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A578C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:00:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h6so6981334plf.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tZOimVOqRFiJiitBNwK82J6QSBiwrIcaMVtHxj8VnHg=;
        b=CNAD559O//+G+M7tFVdhH4AdVX3vfIWCiH2UWxQzZIbQ+cTXuaOtmHjHGDsm0gcuyZ
         hnhwLvBYl9g06EMx1lqkYzvcJd3Le44w2GURHGBV9nHB+MbayTRcpDXY7xGVF12fTF8w
         qJ7g5NFJks0QxLnSvk22ZdOunKIQZUpVT3170iEjYPTgGs9mKrQZBx91UkkN+b2O93jT
         tGr1RpeWCeAMzjQhWODRx19c1runOT4OhkQcwB7Vkj78zseTyC7WWPdVJpwYU/wg3lgP
         SbU+F3oqMcQUBnoKi0YuIVjMOIXGM3I1kXcluu8DYWxH+i/C+wNluG5uV/h+IHgMzlI9
         mowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tZOimVOqRFiJiitBNwK82J6QSBiwrIcaMVtHxj8VnHg=;
        b=f0u0B2Yb/LCVvlDLTsF6YYJ+1dqh/9KbwGPfQ5vO14xTQj7jXZPAF/WhddF+l6G/nD
         +a3/Ld2UQmnpdf5I/Sn/wXNxqOYWBZpqEaz63zdbEtUw1uf3mgcUqkUDGePshC6nMUpJ
         whQpYKA4ASMp4FwF+geG2eBhyYj2hTr2o/tDIvxRsucmsvXGUNEe7O4LlEfUx8iWqsvs
         bTXABwPkHfoH/+Q8mD8EyEQ08M2NzU8wQ8NT6TJ1rPJcZKUMRgHJfFZu+tJbJ9zT2UQv
         oK2ASZOsXctOeyfSVvEz6QD6jnyt8Jfr9ViiRe/rpOS1ilZMCXSiZHqgTLF0s7LsbrY/
         XtqQ==
X-Gm-Message-State: AOAM533C9vU3IzVqrH6yLQNSwSkTwCoA37wrcW4Phbt4ciRbWMy7pvru
        U+jdqEgPNkRI2k/ktZ9fpoEdOCVN9yR1B5Tb5Z1uetN6tyE=
X-Google-Smtp-Source: ABdhPJxw5x8A96G3a0q/J+2Xq0XTr6PKxNa5QHV5KfuPNpzLlE6w6S7+CtL77cFe5mBMDP86zp6j7tsYvtgLQMWIgEA=
X-Received: by 2002:a17:903:2041:b0:149:1a90:dbc0 with SMTP id
 q1-20020a170903204100b001491a90dbc0mr16293602pla.57.1640588420611; Sun, 26
 Dec 2021 23:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20211222094558.2098791-1-jsd@semihalf.com> <CAHp75VeQAXW0Pzo=sxrHTB_VeD9BZo_iKsDUW79No4OyLtqZCQ@mail.gmail.com>
In-Reply-To: <CAHp75VeQAXW0Pzo=sxrHTB_VeD9BZo_iKsDUW79No4OyLtqZCQ@mail.gmail.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 27 Dec 2021 08:00:09 +0100
Message-ID: <CAOtMz3NgF2Mq02PdGxKDkB33gtCq+vW7zNgW6nADUb+GMLBcxA@mail.gmail.com>
Subject: Re: [RFC 0/2] i2c-designware: Add support for AMD PSP semaphore
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 25 gru 2021 o 16:59 Andy Shevchenko <andy.shevchenko@gmail.com>
napisa=C5=82(a):
>
> On Thu, Dec 23, 2021 at 4:43 PM Jan Dabros <jsd@semihalf.com> wrote:
> >
> > This patchset comprises support for new i2c-designware controller setup=
 on some
> > AMD Cezanne SoCs, where x86 is sharing i2c bus with PSP. PSP uses the s=
ame
> > controller and acts as an i2c arbitrator there (x86 is leasing bus from=
 it).
> >
> > First commit aims to improve generic i2c-designware code by adding extr=
a locking
> > on probe() and disable() paths. I would like to ask someone with access=
 to
> > boards which use Intel BayTrail(CONFIG_I2C_DESIGNWARE_BAYTRAIL) to veri=
fy
> > behavior of my changes on such setup.
> >
> > Second commit adds support for new PSP semaphore arbitration mechanism.
> > Implementation is similar to the one from i2c-designware-baytrail.c how=
ever
> > there are two main differences:
> > 1) Add new ACPI ID in order to protect against silent binding of the ol=
d driver
> > to the setup with PSP semaphore. Extra flag ARBITRATION_SEMAPHORE added=
 to this
> > new _HID allows to recognize setup with PSP.
> > 2) Beside acquire_lock() and release_lock() methods we are also applyin=
g quirks
> > to the lock_bus() and unlock_bus() global adapter methods. With this in=
 place
> > all i2c clients drivers may lock i2c bus for a desired number of i2c
> > transactions (e.g. write-wait-read) without being aware of that such bu=
s is
> > shared with another entity.
> >
> > Mark this patchset as RFC, since waiting for new ACPI ID value. As a te=
mporary
> > measure use "AMDI9999". Once proper one will be ready, will re-send thi=
s CL for
> > review & merge.
> >
> > Looking forward to some feedback.
>
> When you will be ready, CC a new version also to Hans, he may look at
> it from the Baytrail functionality perspective.

Thanks for the hint, it will be very helpful to have this tested on
Baytrail. From other comments on this RFC it seems that I would need
to affect Baytrail-semaphore path even more than initially thought.

Best Regards,
Jan
