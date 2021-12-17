Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05793478115
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhLQAHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLQAHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:07:53 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414AAC061574;
        Thu, 16 Dec 2021 16:07:53 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id s11so387497ilv.3;
        Thu, 16 Dec 2021 16:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMuIk+47x3s4KpscvxEDy8ls/dZRCTh3L6EHdqgxJeg=;
        b=gfJzoNvxEql+KFUv6k/sKfVyqM+KFIQr4MCApsmE3qk3MS8GNbWhH/vwq86rRjTr1q
         KgjeqWaRem0swd/Yuri6jvBETjjDtAhKpnIWnm/PrKXxBa8OyLxiNnPSfCvaLycPNmwV
         UHmeH70TK9rxT5b3Kt4ApiMziZaSAC2vRVLIDIt6A0eHGk8dVNgls+aDVWoP/f8TC++V
         PKQKa09eTh+9uEdbIL/yqj1BbovmozyQhUUih63162FhiHbfzkRrfKQ9fbiwjfSwRDy7
         RbyvBDVhwiD9bn0ydRx9Qo8/tKBMRWBvPjMX1wpEDKYlz8s08dc/2IrbDsINYMHnvQiu
         W8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMuIk+47x3s4KpscvxEDy8ls/dZRCTh3L6EHdqgxJeg=;
        b=qP3o0jFXQVogRj3f1TDA42xbhKvwwg2Qt7NHlVn3QjW0AFt5PN/vvkvPsHjfsb8gAU
         vBM947YXYyo1JKeuEpYReY2N8698gJ0leJzd0Vmtw4tdRezxCJs7BRTNkwawXHOZFPef
         nKnYHeosSUVNNtOVqadub66eopo3DO67gjp27w+JRiVKKwZI+mTYzTfWKk74VeZUjQQ4
         r5u2YsADlvOr2Wpoicv6A0eqPOteRh91gZBYsoR2o3JXKeUEbJef5NOCsGohgKjcYeCN
         8pchVgyNhZFOASFAdyrZWRCoEnlF0Gsu6VlL9EMeTbUxfnO1RjwVl/P4oGfpvp+jovkp
         /YQg==
X-Gm-Message-State: AOAM530B1gsgbsX+3gn3VIzUCqvDuM6gRgiF28lurSHWDhJcscNms2sp
        qJb+9ZM3m3BbYtjcAUv5ljWbt7DWm0h+cKZ+p2HopCUK3B6jk1De
X-Google-Smtp-Source: ABdhPJyx8dEogaBaodh2Km2K02ZO+V29sTf/77eBOfXw11zwLkKc4rL+O5H9avz+ziDt/1OuQm3zeoumlaINai8H934=
X-Received: by 2002:a05:6e02:1aa1:: with SMTP id l1mr100114ilv.187.1639699672540;
 Thu, 16 Dec 2021 16:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20211216205303.768991-1-eugene.shalygin@gmail.com> <CAHp75VeERqjxrt7C4hrDnJpY1aCQPtF=CQ=MLY8e9Gik57P3DQ@mail.gmail.com>
In-Reply-To: <CAHp75VeERqjxrt7C4hrDnJpY1aCQPtF=CQ=MLY8e9Gik57P3DQ@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 17 Dec 2021 01:07:41 +0100
Message-ID: <CAB95QARFT8V-kMTtdRJHPAhXFk2BrF=5jxY2+CT0DvMrn6vKOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 at 22:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > to the EC, in the same way as the WMI DSDT code does.
>
> How do you know that this way there is no race with any of ACPI code?

Because this mutex is exactly what the ACPI code uses to avoid races.

> _LOCK_DELAY_MS and drop useless comment
>
> I think I gave the very same comments before. Maybe you can check the
> reviews of another driver?

I understand your frustration, sorry. In all those similar reviews I
must have missed some emails. I'll fix what I can.

> > +static const struct ec_sensor_info known_ec_sensors[] = {
> > +       EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a), /* SENSOR_TEMP_CHIPSET */
> > +       EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b), /* SENSOR_TEMP_CPU */
> > +       EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c), /* SENSOR_TEMP_MB */
> > +       EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d), /* SENSOR_TEMP_T_SENSOR */
> > +       EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e), /* SENSOR_TEMP_VRM */
> > +       EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0), /* SENSOR_FAN_CPU_OPT */
> > +       EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2), /* SENSOR_FAN_VRM_HS */
> > +       EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4), /* SENSOR_FAN_CHIPSET */
> > +       EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc), /* SENSOR_FAN_WATER_FLOW */
> > +       EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4), /* SENSOR_CURR_CPU */
> > +       EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00), /* SENSOR_TEMP_WATER_IN */
> > +       EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01), /* SENSOR_TEMP_WATER_OUT */
>
> Instead of comments, use form of
>
>   [FOO] = BAR(...),

Was unable do that because the SENSOR_ enum is a flag enum. But given
this suggestion and the one about bit foreach loop, I will convert the
enum to bitmap.

> What's wrong with post-decrement, and I think I already commented on this.
> So, I stopped here until you go and enforce all comments given against
> previous incarnation of this driver.

I missed these ones, sorry.

> > +       for (i = 1; i < SENSOR_END; i <<= 1) {
> > +               if ((i & ec->board->sensors) == 0
> > +                       continue;
>
> Interesting way of NIH for_each_set_bit().

Will convert to bitmap.

> > +       acpi_status status = acpi_get_handle(
> > +               NULL, (acpi_string)state->board->acpi_mutex_path, &res);
>
> It looks awful (indentation), Have you run checkpatch?

Yes, but some warnings remained.

Thanks,
Eugene
