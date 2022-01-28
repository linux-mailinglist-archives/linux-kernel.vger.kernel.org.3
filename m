Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3749FB50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbiA1OGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344330AbiA1OGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:06:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C39AC061714;
        Fri, 28 Jan 2022 06:06:49 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a8so16318351ejc.8;
        Fri, 28 Jan 2022 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V90r59PqZxvu1aYpRHwQxj9CjfznCDlFhS5gKOQxDqI=;
        b=F9hGRyzkpH2M5+KDdfdNdn7LwMNCxKlT2MfqGjs6wNBz/hl7zuOwFkhU42+kl1tJpn
         mChrQE7ABryFYz5r/27dCKspkGbVlO3pkKNbZppwi0Qof6zTbX+s2XPmEM0QHNMIx7Zg
         U8p0+kKlmtpsTihYIwhqh3DrnBnzh2ZkZScq8zse/yH7ymgiOrFo7ctBEaY/IYHv8AR1
         bnhy/xmkTz0iQa3q5hejXpRT+o0ixt1QqodzsjYUkOyRtq9U9/BRBy7wCZMfarD0KGTJ
         55qQ5HEV46F58kiN9SH5BAk1A4clrurJWt6YIO54m1aHsDKfb3X0E5OMOWVqIZsKR4IG
         d+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V90r59PqZxvu1aYpRHwQxj9CjfznCDlFhS5gKOQxDqI=;
        b=eep8dTZtjNOm6XIk2j/hZiZPuWl8na3AOvIhQROejb7ABvusnUrYuYDGZvXDBQD0YO
         veYfpC7XEb/9uXwtZZX7y49KQ6JRFd52VIEDMob66aYj53Cu+HuYBETdJYgkINoc4w0H
         +yvIGHgIwJJgnTMChfc8xPKqSxbFPOdL3uwLAKf9MW5eNcAMDn+ezi6jI6IjcRrxC0Bb
         i19iYHdlgK5KdmNuD0aKoiz9yrIQ5W0Pww0HKtCIzaJq/5wL5cwlyCUoFjQsNqyIWb/B
         9FEDVMULoxUNWquzw8rHgPBqi3ijERI0GihKAK7M93K/LXtMyXVWnkV1D6UdZbElP9Ql
         nDTA==
X-Gm-Message-State: AOAM5335dOqASPYqeDiUSN4UqnjDcoEXRIUwU1G1olaWC47N0ALsPUDU
        J4x4fzm+xRHB0P7BqY2l/kInvKrImKRLoI6WiuCc2In/vn0f91WG
X-Google-Smtp-Source: ABdhPJytN1RgypEc3MnBCQEniu6x9owRgmxL1r5jJqWOr08GuE/9g+DHM6rJ6NXg2bSu4IOzO48Ts3xUWDMylyjFKI4=
X-Received: by 2002:a17:906:604d:: with SMTP id p13mr6820778ejj.639.1643378807748;
 Fri, 28 Jan 2022 06:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20220128055604.2077738-1-kai.heng.feng@canonical.com> <CAHp75Vcz01FwHUF5NAUhn4mfTgzoHBMEBkqPbfPHU=tNr_9Zdw@mail.gmail.com>
In-Reply-To: <CAHp75Vcz01FwHUF5NAUhn4mfTgzoHBMEBkqPbfPHU=tNr_9Zdw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Jan 2022 16:05:09 +0200
Message-ID: <CAHp75Veti6hPmESaeD8obV0F3zZ7cpcK8mXdReJXb8+1oPp_hg@mail.gmail.com>
Subject: Re: [PATCH v2] Input: adxl34x: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 4:01 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jan 28, 2022 at 7:56 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:

...

> >  drivers/input/misc/adxl34x-i2c.c | 7 +++++++

Hold on, why in this driver and not

drivers/iio/accel/adxl345_i2c.c
drivers/iio/accel/adxl345_spi.c

?

-- 
With Best Regards,
Andy Shevchenko
