Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352346B193
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhLGDp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhLGDp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:45:26 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279BC061746;
        Mon,  6 Dec 2021 19:41:57 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id l24so23994291uak.2;
        Mon, 06 Dec 2021 19:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WjCLq5iyPbhZoOVbo+nvWb9Wp/JdlLnIPR31C337C8=;
        b=mZiJ1JWBFc1OWU2CphwdToWib2Fs7VeoMvRyd6OGAUdTYE7JuVX3y18pFnbL9d0SYR
         qnkGAcFy4HWByFCmfen3y9B+gsUBd2Z4vpiAY8cExnT/X6456PRBzYpHz5lzE8xWOBLE
         /Opn0hwl+/WEjMpD3cFa2zhWfG+2VM8IZAoAwDwKw4uis+328EKo2LCeWhkZKeKEAT9k
         n3UXrAemi7nOM0I+lBZxbPlnpXZXWks7fOWw21TwqOUg6+DtBOdhLAZp7S1avVtceNWO
         6hIZiEiJ4irNSwTkZ0WAOuxz06b1U7vebIqVBU87ZImLwZxD31NuI/0Q7jK48HpCxsG6
         jbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WjCLq5iyPbhZoOVbo+nvWb9Wp/JdlLnIPR31C337C8=;
        b=5b7/eFbJEOeL9ZNIuyZyAlpO52UWbGZLaf1bg2jfeQ4GVl9evTE4oJzyD9m1cSI9P/
         DVPyXnB3/68ID+cisJSTq0toGmcK37hgecZUF+s5nTmSNshi7xyjIvERRCANsf5p2Cef
         yJcC3400mMfT63OzCTqBEdCLqzU8xaCSeUwhc4bGPHFTFKW2b3+ptNWmWBzWiIc0kMa9
         vZG8GfYGc42M+t896RoqpVEKnJpiKiqgug+D23TQaG32kECWATHpfW8SP/GLfqEUa5hf
         WwNhY9eNgtRg13me9cjXzUQuEuMd15/WNRvBlpPMtNKPGOv6A2JBl3sGakYnONJo0rIu
         Ki8w==
X-Gm-Message-State: AOAM532t6a257QWxIXJkyZ7p6GAsPVSWe/vD+jR6CfEsncfkwhk3ZcV8
        X+LhJLOcsUU2w0747qhtduReT7g/GebIhBzAkg0d1blr0+c=
X-Google-Smtp-Source: ABdhPJx6RQZ3n6olyV3sCz9AbKmYBKhNAk0yZ773fOAPjf8R3q9XrHTi0PcC2P6/Zcqz0XN+NMNLS7cMSGYejK/S3F0=
X-Received: by 2002:ab0:6813:: with SMTP id z19mr46872879uar.28.1638848516162;
 Mon, 06 Dec 2021 19:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20211206182616.2089677-1-f.fainelli@gmail.com> <20211206182616.2089677-6-f.fainelli@gmail.com>
In-Reply-To: <20211206182616.2089677-6-f.fainelli@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Mon, 6 Dec 2021 19:41:29 -0800
Message-ID: <CADtm3G5Sh5sFhq7ye=aJbzd0v_FiqOPt_RAE3v_qWFQ+jH5bEQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:26 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
> validation.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
