Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6924FC46C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349287AbiDKSyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349257AbiDKSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:54:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D22289A4;
        Mon, 11 Apr 2022 11:51:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j8so14623909pll.11;
        Mon, 11 Apr 2022 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1BCMMRF3CrZheQ3rPnfn8JyTdF9qShSSMiaTLCvnnj4=;
        b=Xiqvl4o/2+hIidChDn64wLimWimfz389Tthk3lSF03NF+hBYj3gCXWUOk0EyXq9KQE
         E9b27GxBWIhpr82aFSU7Uo9x4bYXY3viYnzGd1beNNRSA2aYPj35kWz8UnUgN5/FLTtI
         xtrnkCWFqsfgntAbtNZ1onk2dUlXlqWM1XaKlnL6N2KgP5AeN4lnFBdzPWncg9rPv91I
         Ld+O5UCnUp6LX9qYUVi0LGVPb9OdlvZrpBX9PnTbHdq6ARDmDYR+j21/6LOh4N6Wf45Q
         qnSm7nJrFyeuWEbqRY5j0XsaRsvgVEJkZ9dIcUKowoqJ4RWTg1XlMXovK7E+tnvjv0lX
         pFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1BCMMRF3CrZheQ3rPnfn8JyTdF9qShSSMiaTLCvnnj4=;
        b=XgpnnRU1Y/90w9MkmaMN8kIEK2Wbr/WrZdRtqFko8imDhSORFJnnPtzuRtF2zWIq4O
         TY408IdVNcwPAtlzf0UcigZ95Ijes9VdIdDbf4nuuTYwIfyUDKoBCIZLX9M1jQmIHyWj
         URqDHsOM0OWQ+x77+aw7eN5rpv01MhSQmek5ufXt6QoRvEIWob4DH8kAAVjpQiuy+nRA
         FF03yofyCrNKZ8D0vsW5W+/gzkL+kMqUOwm7tp8sjFwEsgxWJ0/IvtygKqQXMS+6vtKR
         VTonMtgq0ZGdN6hesN5pMKP35Am0osJ8rK68e6NDqk0Ch4H3cb1CHZQAvXkQiw6oKU5A
         Hkiw==
X-Gm-Message-State: AOAM531CCHISXhzTZA8LHQUwzPBRZ536UbFSA8f6YspyG+tvMtEoAOGJ
        fruZNYxaUwvwAmFs1I1flcaoNvsn54gHosZuEWU=
X-Google-Smtp-Source: ABdhPJwYCr7lDRAfP3drRG6tTDeVIUFS6Td0V/gFhTVaWu+af2sRfHMLN+JurTf3e7+WgQwQ8fY30yp/XQ5rWOHoH9s=
X-Received: by 2002:a17:902:b684:b0:156:80b4:db03 with SMTP id
 c4-20020a170902b68400b0015680b4db03mr34263860pls.16.1649703110302; Mon, 11
 Apr 2022 11:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220407115406.115112-1-hadess@hadess.net>
In-Reply-To: <20220407115406.115112-1-hadess@hadess.net>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Mon, 11 Apr 2022 11:51:38 -0700
Message-ID: <CANRwn3QSx=FpCT0=E1y88W0zuFLmChqmYe_y7uSs0bANNk4rvw@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Correct power_supply type
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <pinglinux@gmail.com>
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

It seems that the USB type was chosen to fit into a upower heuristic
that still exists (see [1], [2]). Looking at the upower code I suspect
that swapping to the Battery type will at least cause
"UP_DEVICE_KIND_TABLET" to no longer be used for our dongle-based
wireless devices (Bluetooth-based might still be fine though). We
haven't sold dongle-based devices in a while, but they're definitely
still out there. If the batteries in those devices are seen as system
batteries that could cause a problem -- e.g. triggering hibernation
when the tablet battery gets low.

I think it would be wise to test this first to see if there's any
obvious real-world fallout from the change...

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D96983296281507f049425b84f0d244c40d506eba
[2]: https://cgit.freedesktop.org/upower/tree/src/linux/up-device-supply.c

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Thu, Apr 7, 2022 at 1:52 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> POWER_SUPPLY_TYPE_USB seems to only ever be used by USB ports that are
> used to charge the machine itself (so a "system" scope), like the
> single USB port on a phone, rather than devices.
>
> The wacom_sys driver is the only driver that sets its device battery as
> being a USB type, which doesn't seem correct based on its usage, so
> switch it to be a battery type like all the other USB-connected devices.
>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/hid/wacom_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 066c567dbaa2..620fe74f5676 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1777,7 +1777,7 @@ static int __wacom_initialize_battery(struct wacom =
*wacom,
>         bat_desc->get_property =3D wacom_battery_get_property;
>         sprintf(battery->bat_name, "wacom_battery_%ld", n);
>         bat_desc->name =3D battery->bat_name;
> -       bat_desc->type =3D POWER_SUPPLY_TYPE_USB;
> +       bat_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
>         bat_desc->use_for_apm =3D 0;
>
>         ps_bat =3D devm_power_supply_register(dev, bat_desc, &psy_cfg);
> --
> 2.35.1
>
