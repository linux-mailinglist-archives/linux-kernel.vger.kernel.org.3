Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7001D50B834
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447876AbiDVNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382795AbiDVNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:19:40 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA09E25E5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:16:46 -0700 (PDT)
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MvJwN-1nzh7M0svR-00rHxG for <linux-kernel@vger.kernel.org>; Fri, 22 Apr
 2022 15:16:45 +0200
Received: by mail-wm1-f52.google.com with SMTP id p189so5077493wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:16:45 -0700 (PDT)
X-Gm-Message-State: AOAM531iGHFXeGUwVj8Gmh3RsmMJ0VUNiVvWjhI6oI3kJ2snBJKdlV/I
        z6Qj2CNbPM/LkEK3kSeZ/9MrzFWP8QBVR45lh8A=
X-Google-Smtp-Source: ABdhPJxeDeGlM4KsxTL2fJVmPu/+29E0jbGm2nSe2StzLYwh7apsoD80pUq0biSCyqwgmsTxzw01zlCwk3xa5LHZS6k=
X-Received: by 2002:a7b:ce15:0:b0:38e:b7b0:79be with SMTP id
 m21-20020a7bce15000000b0038eb7b079bemr4115953wmc.71.1650633404925; Fri, 22
 Apr 2022 06:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220421192132.109954-1-nick.hawkins@hpe.com> <20220421192132.109954-5-nick.hawkins@hpe.com>
In-Reply-To: <20220421192132.109954-5-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Apr 2022 15:16:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com>
Message-ID: <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uCubFCJcZ/N0eeONv2BVz5YBAevzgnX+2Q71dXA8hfxHeMV93ph
 o0+CrLtcKUie79rTeJA9iKTxDNDQ26ANC4m8YdrgZL2Rge1NsT6lBoJXLZk7hJU/h0vZaaM
 0c+8hfAWnGSdZh3UynnIDrahD0qvf3hDmN8EIpva9wHhX7xIHDJ6hOBYRd+GBZB+wWkWa5E
 vYpsRT743p4vwk0h0v8KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5RGaKzJ3408=:S1QyO4YzN5p0goxYBxCLvB
 uWTRuRTWJ39/S98VAksGJPHACHoEkFVPSZiVPevdELrGiD4lzTmucZUF562HYwCzhANPerwPA
 uuxMneArso5mAkKty/1AECPfe5OChe5tlIzY/VVBFWIQ0fMkdT0U+j3i3oAhfUWaDwRQs3HZa
 mgjzp4EqlfgUH5ffbfMhCA/MS0E/CKXDWnpMNIQmt/UhHFdA7zzrGe1cMQtc8oCfUovXTsYWk
 mBCjXUqyV4DyTcXB29tjCa2G9C+V+LajeSQHJH1ZDoNM5ipoQKMtBmVWBrxbb5m48ZYdf8C52
 2L+5cgNuwa2dPlmwrQhyuAcXjzWb9xssQR21r9VO1JXaWBqFpH/u411jxeKzRl4q8H8bdt2vy
 bNtVkHZK4VlNxq0lkJ0BVeMssyYyT1hhDcRndt9CaQ5X3ZDOF61O5iTejdnA7c3RXqhZHyUW6
 2b6X5ufDBzjYROL1pX/nYotnU4/w8nsJYgC5sIi1tQ+WWf9dDzxt42TgNW2WyRue/tQDjpiwx
 38qpdBMLk+JI0pAAfS3y52p7GM6k30oxpReM+P4QHTERNb6GXfcFx0XsyYMqEuMwd7Mfm7F4Y
 Nw3Ow4YchzXJ+jXZvm+JDgTfzwvO+LamDDB3isO2Pkm3ZPEv9oaqrBh2hafaiVZmhZDtlKDMt
 9OrdJelyYlvYDW/aasgjyFCA47Q+nCbLb41YkNws7CfiSbE87fWlI4O3csthvhDKi3XDR0wu8
 yrSh0b9yAtFQ/KuibvC/9SzT1Ih2XijqtbWE2qi3fC96uRwNiHMkrvwnmj6xlfh4yS1FqB7Gi
 MFj7nyZyhwWdkdlSTt5vAvGCtTVX5TuYHXYNVzbVxUWly3GLeg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:21 PM <nick.hawkins@hpe.com> wrote:

> +
> +static struct platform_device gxp_watchdog_device = {
> +       .name = "gxp-wdt",
> +       .id = -1,
> +};
> +/*
> + * This probe gets called after the timer is already up and running. This will create
> + * the watchdog device as a child since the registers are shared.
> + */
> +
> +static int gxp_timer_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +
> +       /* Pass the base address (counter) as platform data and nothing else */
> +       gxp_watchdog_device.dev.platform_data = local_gxp_timer->counter;
> +       gxp_watchdog_device.dev.parent = dev;
> +       return platform_device_register(&gxp_watchdog_device);
> +}

I don't understand what this is about: the device should be created from
DT, not defined statically in the code. There are multiple ways of creating
a platform_device from a DT node, or you can allocate one here, but static
definitions are generally a mistake.

I see that you copied this from the ixp4xx driver, so I think we should fix this
there as well.

      Arnd
