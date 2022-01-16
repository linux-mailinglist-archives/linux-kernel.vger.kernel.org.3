Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15748FC37
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 11:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiAPKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 05:44:51 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:48663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiAPKor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 05:44:47 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mw8cU-1mJ8pN3NlU-00s9Pb; Sun, 16 Jan 2022 11:44:46 +0100
Received: by mail-ot1-f49.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so16004756otc.13;
        Sun, 16 Jan 2022 02:44:45 -0800 (PST)
X-Gm-Message-State: AOAM530Hygi5EFzM6NBfDRVYrrnrU38e+O9R0FY1sm8W79uS07nXAWGf
        qQ8T6m8Ja1D9qAOylpE3MyCWjNp3n/DfniqPkNU=
X-Google-Smtp-Source: ABdhPJzlLWoJQBn4VnzmdYliVzW+ITzvPUzHpGKIPBeYP+3HuPIgD4eMUFAmb5UWZ8K1iXz4bS3aEgCyVe9TE/GwoaI=
X-Received: by 2002:a9d:c61:: with SMTP id 88mr9417588otr.119.1642329884423;
 Sun, 16 Jan 2022 02:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20220115193245.3777833-1-laurent@vivier.eu> <20220115193245.3777833-4-laurent@vivier.eu>
In-Reply-To: <20220115193245.3777833-4-laurent@vivier.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 16 Jan 2022 11:44:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a13g_o4mTsOO-4b=WU6TGRHubY7HCt1x1FdXpVmjy6-Sg@mail.gmail.com>
Message-ID: <CAK8P3a13g_o4mTsOO-4b=WU6TGRHubY7HCt1x1FdXpVmjy6-Sg@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] clocksource/drivers: Add a goldfish-timer clocksource
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/zxqABAkP/uHnTARIqKoj96JMUdcRt8d0RFEaRfSXKNkyCJC+Jp
 JwMgstSxkp6tkhCmTXzZH/MKk0lfeYxpwwxFCdyWTgyGYTTx7lfvM8asSPEaLIFyNP0GI4P
 6c2CqRYXNKaHfL8hnBA1uaikEYntcJhwBCHekvF25Pv5C9g4Suky100r8/d+P28IzIed4nX
 fBynf6UYmvt+30c/UWgwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5xefTgbJKy8=:hZpr/e2pQ7j06kl4NJrUBz
 HKso0/p6kafDwG5PdyApI0+DXORtR5wT6IhLZCQIxfRXgQoVczwAKJr6Gp/95xgDy6FPlJWbv
 rrylmPWyxVwrs35loHhyyewDdKTqT8eB++BTEkrY+/DMyOHqkMW8I6SwQkfPouZiushlB/a6t
 rE1KZjr4D8hIma2l201buNrIF52rkLy6dD5rMLsllWiMv/d1ZU4ugVFdFO9qI8pjeVEPbJIHb
 G0gnlwMM8za4BU4q7KwoZbpuTvU/7OJCC5soyZVT8J+qvlntk6deRFCcXbkgfFpgQd3S/c+YR
 vFGPLtYE6whhQtDTLYJZ+OAYZpjsDOIKes8vTHNwgdMblN9zEW75C7AJvkQTkXpwAt6soK673
 RUnupj51Z16diIMoQcaEQgJhlfvzI/qjh+ce4CxFA9VUFJXLti0jYEw2FWw6s4u/q6lzQsO2J
 OdwWAxFVyb+hwcqmGwlI4BV5Dy6bZO9Pnz2rPX/92SBY04ysobbmic1P3VboQlPi5ekHyJcfk
 ON9fb5E49zOvFVKUCTKBx94gwt9bXbnyOEs84hVEcJeyUk709Xcjx5HUO2HpkFpROhNmndq3t
 OPIGSH7tvt+ia6DthsWvhRn8r49ma0w1++bT1KFpLl/EQSBOn9KfPnhqGZhKk14pdgzOkr2Nc
 ZqYUW0NYsiadkM8RUVlf2CrgnHLQ+pDLZiZOQQmW0TvTKBTZXVOzjPQ4geZq87T0UzRM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 8:32 PM Laurent Vivier <laurent@vivier.eu> wrote:

> +
> +/* goldfish endianness depends on CPU endianness */
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define goldfish_ioread32 ioread32be
> +#define goldfish_iowrite32 iowrite32be
> +#else
> +#define goldfish_ioread32 ioread32
> +#define goldfish_iowrite32 iowrite32
> +#endif

This is not what I meant here, as you are breaking big-endian support
for all other
architectures in the process.

On architectures that support both big-endian and little-endian kernels, devices
(including emulated ones) can't know which type of kernel you are running, so
this has to be fixed by architecture. Ideally this macro should be in
an architecture
specific header file, but you can also just make this a check for m68k and  hope
that qemu doesn't duplicate this bug on architectures that gain support for this
driver in the future.

         Arnd
