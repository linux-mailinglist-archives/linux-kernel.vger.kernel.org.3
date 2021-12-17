Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116E7479738
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhLQWdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhLQWdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:33:36 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1CC061574;
        Fri, 17 Dec 2021 14:33:36 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id s11so2762180ilt.13;
        Fri, 17 Dec 2021 14:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yE8la0z1Yb5Il0TQrxnrbz4ISRGAjwDQ0dRrxCEanlU=;
        b=flb41hWv8e4gBzb8Hq3/2/Bgs6JszRACWO/Q0HyO1HgmbgoWj55EOzC2gs1qcWGKkW
         GqTFyYuvPjcLe0mOxrgp1PTajPgeN2+luuElM12/Os9cFkVYRzWTrHRuKr82Sp8bSgCu
         N7UaJPel/IHWzbYfR3VtUbj9tJUBGeDJlfRvDo/Rbl3N2vXm/hoGbMDSLrCwKiEDSbBT
         X6XVNFEh72oos1dgWJoOoK4fwm7OaixL1Y0rO4hj87g5hU/3+HThaZU9CAGt3x8UyCkL
         ZeEVnkAib+p2CQfsJoY4dtIdGJ+CRKurRNeWeDCIwIpgpelWihOxpQRyo9IPCqVDow8U
         u96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yE8la0z1Yb5Il0TQrxnrbz4ISRGAjwDQ0dRrxCEanlU=;
        b=ssJq2K/W34ZDqxw/tbVEdtgHnBubO9okiYxxi7i/y9vR8ZtR1omM5Y/R33DsLuQCSB
         H2EZq/J5wkyTndtWi5fdnM+l3D/eG8nHVWLKuODO3Fgul/lQzRm04JbaQkFpHDBmBQP5
         tGdAaXVgbCVMg+JmdMxmIRGMBLcq3NuFDqKYvs0kpbRXiwx/l4Y3Cei7hzKzkXqotmEa
         aVp9EngOlxuUf8SMlZ0l+lUJLvKs5Fr8OgwzJvcnGjc5VJcOKpaY0SzEBFR0iszFGQEA
         ZoYID+vJ6WECY5pljJvNjq8NTpJdSg4rVZqbm4yMTF6Q8N46ttaVqf4x5KQ30Lzjd5qP
         Itcg==
X-Gm-Message-State: AOAM530yCLLuqRGExJYkbIEiwGnmF2Hi2P8aue6ntUJugRZVZZarUTH/
        9dR/XoPnHZljTCfEaTRzQZAGFFXNTMQmW7kGy7XjINA7QT0Qvw==
X-Google-Smtp-Source: ABdhPJyvYOa00dhZtNEY+FyFP7eWq3wl0wQ64P/1xmpxkpz/lDO5Uvr+S5wYBKY0kAz2WV62/+JSUrLE0Y198TWPLwY=
X-Received: by 2002:a92:c089:: with SMTP id h9mr2671128ile.289.1639780416087;
 Fri, 17 Dec 2021 14:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
 <20211217164307.1514192-2-eugene.shalygin@gmail.com> <20211217215233.GA490048@roeck-us.net>
In-Reply-To: <20211217215233.GA490048@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 17 Dec 2021 23:33:24 +0100
Message-ID: <CAB95QATUTvoopfCUez3exhStcGtPGacpyAYW-rswGnVSw-cmjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G=C3=BCnter,

On Fri, 17 Dec 2021 at 22:52, Guenter Roeck <linux@roeck-us.net> wrote:
> There is a lot of complexity around mutex_path in this driver, yet there =
is
> always exactly one entry for each board, and the name of the mutex is alw=
ays
> the same for all boards. This doesn't make sense. Either the code is need=
ed
> or it isn't. We don't usually add complex code like this into the kernel
> "just because it may be needed at some point in the future". Either give =
me
> a use case, or drop it all.

When we discussed this approach which utilises an ACPI mutex, Andy and
Denis were sceptical about its maintainability. One of the objections
was that the mutex name is internal to the DSDT code and can be
changed by ASUS. I know when older AM4 boards received BIOS updates
for Ryzen 5000, their BIOS changed completely and I overheard that the
DSDT code changed too. Unfortunately, I have no samples at hand. So I
went ahead and added version support. I can, of course, revert that
and apply it if somebody encounters such a BIOS update. To some extent
I wanted to demonstrate how overcoming the problem with possible
changes of the mutex path can look.

Best regards,
Eugene
