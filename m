Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC258518268
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiECKh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiECKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:37:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DBC20F6D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:34:19 -0700 (PDT)
Received: from mail-yw1-f181.google.com ([209.85.128.181]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3KDM-1nvQc403O6-010OMa for <linux-kernel@vger.kernel.org>; Tue, 03 May
 2022 12:34:18 +0200
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2f7d19cac0bso174490657b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 03:34:17 -0700 (PDT)
X-Gm-Message-State: AOAM530/H8duqrlsNjG2ggiQv49PuEvPiaPyouL5rCVB0JLFXGtDcBAf
        kfwap7fDUtcS+pCUtH0Ptp5wdC2o+zM8L6Atvc4=
X-Google-Smtp-Source: ABdhPJzUhd/SRVeuLHKrdLGjDxrwdOOO1gscgt/p427vKURvKahU6VmLi/hh2DlrSJ/efTw+kpU2KUf0BD/9dSUwBjk=
X-Received: by 2002:a81:5594:0:b0:2f8:f39c:4cfc with SMTP id
 j142-20020a815594000000b002f8f39c4cfcmr11730580ywb.495.1651574056880; Tue, 03
 May 2022 03:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220502204050.88316-1-nick.hawkins@hpe.com> <20220502204050.88316-4-nick.hawkins@hpe.com>
In-Reply-To: <20220502204050.88316-4-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 May 2022 12:34:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19pe=ehX1CR9RQz6MH=4YmTN9s7aW5LGFOPypDYjckbg@mail.gmail.com>
Message-ID: <CAK8P3a19pe=ehX1CR9RQz6MH=4YmTN9s7aW5LGFOPypDYjckbg@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] clocksource/drivers/timer-gxp: Add HPE GXP Timer
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>, nick@hpe.com,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QxOKCPXCF4ZeVm8KcSaZ0o3DY4KlpjC3PXU121O6TGMGC1e7iwD
 HnUcUZSFpTKE2ycjw6ptLUA5C8meOfiGPZVPnnMhIO4Qr7b3GMpYa6aQZC/RebaabPGEx4j
 NlKQbh8VZmmX/BSJKDcKOrq/ru55XVqtB2BCp9ommga21PGBk7MZxu3fHNHoNS1N8JULEt6
 ztx+oCUMnM+6YuMKU4Sdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4sBHvXa30Wc=:uhDU3lOCbuXV5GL/KOWCJm
 T00MPZYnCmmiUttgU2XdZ/CNXJSRdCMQacO7EVurdg++0vndMJnBwxrO/R0PjrpxPGXSqIKxB
 oOuysm/Vz4Kboyg+xpXmfSQHrr/z9hyG7Oim8zqCT3qz0e7NBhQi3MQz5Zy6hxB6YQxw0Fffb
 L++gq7ZdpTQ6B0qt1Wvr1kfs7KvDjyBdRWcTqYW6KBAcKqfQ74DTZBjQw2GtlotCvn/DpKt3q
 +V9OnMPEqhXDPSkRtV6whOZvT5Bqu7vUqV46MiMeTjZ9hLbFtZjgt1m5RUtsJ+waO/MNmphbj
 zJSF0rdtWADU+H4LgGHV4BR6IriAARFbkZXrZp6+MiAjKGHl28afly3Jhn67iQ5EhEsBuhCw+
 xeiYMp/qMBZjcOG00b8E/7T5bYOrEMrG22q6J2ZxmNL2gwpVRatqNHP4rSH5ujA6Rmz5q+VHv
 M0KfILhDyemygWRQO4Awj3togfse5lZZ69q+oMVLvGobJzWl1sGuSasC/7gGF1o9+5kYZqYPo
 LWcxNHEDKomZo7FcLikaKx1+1PPjU51V/Va6jE0Qat5MA7rSAD69xvtwH8+2EmmgWXqwczjGd
 fO91RniBps5iVqJCBhVLerxFTvIrnZQJFq5IyC1aa6URhOyIr+4ZyFtmM0osfHtyHL0dcIMwy
 eX3D3v3L7ZMWOnIEspwo7+6GrH6tN7j6uo50xEIgtbvKt/tHgCRwZYYDcIcwkiV/Kc4Y=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:40 PM <nick.hawkins@hpe.com> wrote:
>
> +config GXP_TIMER
> +       bool "GXP timer driver" if COMPILE_TEST
> +       depends on ARCH_HPE
> +       default y

I don't think this does what you intended: with the COMPILE_TEST option,
you make it possible to disable the driver when ARCH_HPE is set,
but you don't allow enabling it on other platforms, which is actually the
point of compile testing.

Maybe instead use

config GXP_TIMER
       bool "GXP timer driver" if COMPILE_TEST && !ARCH_HPE
       default ARCH_HPE

Also change the prompt to be more specific and mention HPE,
as the 'GXP timer' is not a particularly obvious name for random
users.

You probably also need

        select TIMER_OF if OF


> +/*
> + * This probe gets called after the timer is already up and running. This will create
> + * the watchdog device as a child since the registers are shared.
> + */
> +
> +static int gxp_timer_probe(struct platform_device *pdev)
> +{
> +       struct platform_device *gxp_watchdog_device;
> +       struct device *dev = &pdev->dev;
> +
> +       if (!gxp_timer) {
> +               pr_err("Gxp Timer not initialized, cannot create watchdog");
> +               return -ENOMEM;
> +       }
> +
> +       gxp_watchdog_device = platform_device_alloc("gxp-wdt", -1);
> +       if (!gxp_watchdog_device) {
> +               pr_err("Timer failed to allocate gxp-wdt");
> +               return -ENOMEM;
> +       }
> +
> +       /* Pass the base address (counter) as platform data and nothing else */
> +       gxp_watchdog_device->dev.platform_data = gxp_timer->counter;
> +       gxp_watchdog_device->dev.parent = dev;
> +
> +       return platform_device_add(gxp_watchdog_device);
> +}

This looks good to me now.

        Arnd
