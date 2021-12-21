Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1051747C60E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbhLUSN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbhLUSN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:13:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:13:26 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso3338849pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Se/jMdO3lDy18GPtd6C/UaFTcUtBEhTlI63VIgUJKbI=;
        b=OAAGJZ/k6du3aY4MYLwbI7qVREdnfHW/lIsDSfbXDKoDVOk6b4z1UaVA6Mu7yL+6Ea
         dHweB4V1bq+rIpTz4/crOaiR0D1tRqtpv0dA+pesstD1a0VUgrXa8xwZD7uwIqoJ0X9s
         smJlNw0NHYX+cdI26ZId2BH7F+e9nnfExjYXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Se/jMdO3lDy18GPtd6C/UaFTcUtBEhTlI63VIgUJKbI=;
        b=g3J65/cYrGngiW+tR6ThxGnbbSVuun4lWcnuU+YydPpZp3dD8CjKA4gfVOWY7SHfWL
         uyLK+Av6TksEEFvzTUdqTVr/Cfq8SwMqy00o/fECDZ3BGxxVAbJcBNJmAWmhGkfPKO3q
         7VcOvrunyDnlC9HyRCutoTTyWgM8qaoJT7ftnqVO2bG3QU5imsjw2Ck7H+m3MfVycH5k
         rliMnlgkHyFIaiZJNMUmyfccpbQhaC2h3ez7if0VoaVD6FL/xDZ8zpSbsINUOWmWDfzA
         gMl4n4BW9NqhoZ8cuduB8QDRprEJp/cqy8XrdcawJOclkIUKoQMfl/gKMfHg1AbLELng
         sq4Q==
X-Gm-Message-State: AOAM531ccc7cxZc2j2ZMUSv3Dfut9bJgIY0csCB5iiJVKhujOv4vYpHF
        7VcrC6d9PLJYZDDX8nzt7SZUp7VI+LR3JA==
X-Google-Smtp-Source: ABdhPJxMWCOBUCub4b9rjNK8hQv27SLOFpQ9UiBRViFVtqdTe2LtF2gt8yV/LuqpyEdj59T6qBk/uA==
X-Received: by 2002:a17:90a:d792:: with SMTP id z18mr5361008pju.182.1640110406172;
        Tue, 21 Dec 2021 10:13:26 -0800 (PST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id nk23sm3085985pjb.16.2021.12.21.10.13.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:13:25 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id b22so18885pfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:13:25 -0800 (PST)
X-Received: by 2002:a63:f254:: with SMTP id d20mr3992697pgk.127.1640110404524;
 Tue, 21 Dec 2021 10:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20211220234346.2798027-1-rrangel@chromium.org>
 <20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid> <YcE+xrSnS7qw0G1/@google.com>
In-Reply-To: <YcE+xrSnS7qw0G1/@google.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 21 Dec 2021 11:13:13 -0700
X-Gmail-Original-Message-ID: <CAHQZ30ASMkwR32iT+cs2hq5q9ZYNuJY2ezqnC_HfKhgQ1=f90g@mail.gmail.com>
Message-ID: <CAHQZ30ASMkwR32iT+cs2hq5q9ZYNuJY2ezqnC_HfKhgQ1=f90g@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: elan_i2c - Use PM subsystem to manage wake irq
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        linux-input@vger.kernel.org, dianders@chromium.org,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Matt DeVillier <matt.devillier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 7:41 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Raul,
>
> On Mon, Dec 20, 2021 at 04:43:45PM -0700, Raul E Rangel wrote:
> > @@ -1368,11 +1367,13 @@ static int elan_probe(struct i2c_client *client,
> >       }
> >
> >       /*
> > -      * Systems using device tree should set up wakeup via DTS,
> > +      * Systems using device tree or ACPI should set up wakeup via DTS/ACPI,
> >        * the rest will configure device as wakeup source by default.
> >        */
> > -     if (!dev->of_node)
> > +     if (!dev->of_node && !ACPI_COMPANION(dev)) {
>
> I think this will break our Rambis that use ACPI for enumeration but
> actually lack _PRW. As far as I remember their trackpads were capable
> of waking up the system.

Looks like the _PRW was only added for the atmel touchscreen:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/coreboot/src/mainboard/google/rambi/acpi/touchscreen_atmel.asl;l=42

I'm assuming this was before we had the `drivers/i2c/hid` chip driver.

>
> I think we should remove this chunk completely and instead add necessary
> code to drivers/platform/chrome/chrome-laptop.c (I suppose we need to
> have additional member in struct acpi_peripheral to indicate whether
> device needs to be configured for wakeup and then act upon it in
> chromeos_laptop_adjust_client().

I think that's a good idea. Should I add all the mainboards defined
here: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/coreboot/src/mainboard/google/rambi/Kconfig;l=48
?

>
> >               device_init_wakeup(dev, true);
> > +             dev_pm_set_wake_irq(dev, client->irq);
> > +     }
> >
> >       return 0;
> >  }
>
> Thanks.
>
> --
> Dmitry
