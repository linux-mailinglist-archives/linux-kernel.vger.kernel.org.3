Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329CC518CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbiECSzv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 May 2022 14:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiECSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:55:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A7F3E0E0;
        Tue,  3 May 2022 11:52:16 -0700 (PDT)
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MfpjF-1oInGp2N1F-00gLLA; Tue, 03 May 2022 20:52:14 +0200
Received: by mail-wm1-f44.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so1769167wme.4;
        Tue, 03 May 2022 11:52:14 -0700 (PDT)
X-Gm-Message-State: AOAM531mzLg7si5OAq0avNV7Ha2RpN2utcqpOAAJNsLPB1OYJjpgBt4d
        vwYVHNzEcBtKbozSwA5OdlfT8VdifWlYpNA3a1I=
X-Google-Smtp-Source: ABdhPJyFxZHeczulnRk5F/j/XWW7voWgdpSEJbZ4in7QcrhpmS9ObsygrzvxaEaLCYD+JtFscKTMOPnYlEX8WarqA8s=
X-Received: by 2002:a05:600c:3798:b0:394:454a:df74 with SMTP id
 o24-20020a05600c379800b00394454adf74mr4638390wmr.174.1651603934090; Tue, 03
 May 2022 11:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220502204050.88316-1-nick.hawkins@hpe.com> <20220502204050.88316-3-nick.hawkins@hpe.com>
 <c0262cf4-dfeb-c9a9-bcb2-24af006e6d4d@roeck-us.net> <PH0PR84MB1718D28F1846F54DB5766E6D88C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <d88523a8-a240-915d-9ae7-54b2277e424a@roeck-us.net>
In-Reply-To: <d88523a8-a240-915d-9ae7-54b2277e424a@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 May 2022 20:51:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3t7-ozDHu18vMKEWxfNS4yd_BNHUh7hQ24rfS20tssDg@mail.gmail.com>
Message-ID: <CAK8P3a3t7-ozDHu18vMKEWxfNS4yd_BNHUh7hQ24rfS20tssDg@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:U4Q3GC1XA3xQUfqfYUAqUs40vRqbuQ4M4ZUBsrPkjaagSx/jyAQ
 J3MK6Z/c6xsuExGG6rYPEuC1OzYjwVUoUZQEaw9v4RrefEuaS8OQQLA/B8um/lhv/pnbMOM
 J3c8pUl3Ay7x5rELZK8VeIpt8D6IRWbipD/JSwl6QD/ySHMuIj4R0x4d+K1gULdGqENm4hj
 6K8U7fcnotJEkw/lX8GHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mXH/6uPB0SQ=:TQj7BbkSos/c8vFS/FfPZo
 k2+zWJClfrIg25JFLA7FHiSiqLn/vqxyPkXofUHSbowXYlSkDMx9ez5HwQ1lhOo9KF0X2wmf2
 Ts1ucpiGFj628/af05DUOKG1wey72uJrnqyZMSnl9AHOqyRY8cl0qfPMN19hRZJv18RAzK/QV
 p5XQw4sxtkLUOwylzZvXfJiF0PGvQIz0x5/ghdKNPY8EPp8JTWbvhEIDTAPKdOq6b9QKyYWFP
 M8wTaFMtuLGRALxUcL8Rk4vlZj3faYwoo8XE0/CbdyHpnfIN+Kg4mEIUhewGUOcWwGPUfXsIm
 s7uQaqNBAplOd64gUgz7nyz0IoDO7WrcbWh+PbHtc6e7znl4BG3YBo500nUdme+HGVbG6w75A
 MJq9aHg1OHYKEQ89szzkZUDVcIvYiBt9PcFoYQszyxYlA7vgIi1cH2CQbfuGnwhvj5BaTfLc0
 8lK6mgvjR/UmHvoP+ddbCDT0Ti3e0ZY/T7ViYZFTyR1+dtjNUEMXAreQzoUE25vXmZ/6nCSkP
 OGAT0Oa93kTKu7ejJzQUI0gxKnrNl5o2ZELpqajGRNXekasaxALrcPcGWsqGtrKblxM4/Jf1b
 AQtyVjo1bhjQBT0fNbTz5D9/78LZuXjH3Tn7bw31aycmxH3dd4SoT1RDAGJFeuos6LUQ4iIlo
 1QQmJTpGFhscOgDAC2oNkeeCrPS95o78N92b0Jq3453My/fxY9OfpsPVdzbKPkr6A8/ga1ROf
 v7l8cm4u+o3HUAhfloMuNi49t4sTsyzLp1B72yrEh7/YJD3LrPZWkolHsFVHe13wbS2NVLinV
 +DrM9bL7hOs9YgGhEj2oPCk0whFqPewVYqkBBddeKBL3artB4Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 6:53 PM Guenter Roeck <linux@roeck-us.net> wrote:

> > Just to clarify for my understanding are you asking that in the device structure I use the "void *platform_data" to pass "struct *resource"? If I am incorrect here can you elaborate on what you would like to be done? Based on feedback in review for the device tree; the watchdog is being created as a child to the timer. Therefore the conclusion reached was there should not be a gxp-wdt listed in the device tree files. I took this implementation based on what I found in ixp4xx_wdt.c.
> >
>
> One bad deed tends to multiply.
>
> No, I didn't ask to pass a struct resource as platform data.
> That would be no different to the current code. Resources
> can be added to a platform device using
> platform_device_add_resources(), and the platform driver
> can then use platform_get_resource() to use it. This
> would make it independent of a "private" mechanism.

Unfortunately there is no resource type for __iomem tokens,
only for physical addresses, so you'd end up having to do
ioremap() of the same address twice to map it into both the
timer and the watchdog driver . Not the end of the world
of course, but that doesn't seem much better than abusing the
device private data.

       Arnd
