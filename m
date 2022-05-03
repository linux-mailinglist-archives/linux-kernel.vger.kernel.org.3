Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C78517E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiECHV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiECHVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:21:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FEA393D4;
        Tue,  3 May 2022 00:17:40 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MwQGj-1o4Y5v28NZ-00sKu1; Tue, 03 May 2022 09:17:38 +0200
Received: by mail-yb1-f181.google.com with SMTP id m128so29711496ybm.5;
        Tue, 03 May 2022 00:17:37 -0700 (PDT)
X-Gm-Message-State: AOAM530ac8FQ+e8bk0f0/Xn4zgo2T5XODBgBL4nzIrlzyyER6M7QCQsf
        9N54883iJJ+z0CX6Go0spAlXoXPyuvUPt15MEZ0=
X-Google-Smtp-Source: ABdhPJxCVe3OWFLSxYuaWnZW2jE5tiG+RIFx0DlFR531d1DfX2PVw0Rn1+OoRgTZrm5UkwICv0JqKul27jNY+A9f6J8=
X-Received: by 2002:a25:c604:0:b0:645:d969:97a7 with SMTP id
 k4-20020a25c604000000b00645d96997a7mr12300750ybf.134.1651562256127; Tue, 03
 May 2022 00:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
 <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net> <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
 <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net> <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
 <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net> <CAK8P3a3S5OjkKq_u5FpnwzYv+0+typya6Z4MzTez5ZH+do00xQ@mail.gmail.com>
 <CAK8P3a3jiqf_zpBsZyvAb5ZtkwDa7KkqExqDAdpY_pYqkr_NgQ@mail.gmail.com>
 <4dcdbfe2-9edf-320b-d123-3b62c8b5e28e@roeck-us.net> <CAK8P3a0ogn1wgPBDHkT=Fb8ufA+y8Ax1Qov2-vRXfC08QqnrQA@mail.gmail.com>
 <c001d58e-9a78-6338-a533-d0f215b3dfd1@roeck-us.net> <CAK8P3a1X3YH0RqqmqgqFAaY94yreD-PfY-pvyMf+xU3nGeqvsg@mail.gmail.com>
 <04840b4f-5b9d-b29a-62f7-e5148d415313@roeck-us.net>
In-Reply-To: <04840b4f-5b9d-b29a-62f7-e5148d415313@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 May 2022 09:17:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a39oiWyDwp=BHuCsBVwfzyZ802-NwL9G9r-t6X8KSr6nA@mail.gmail.com>
Message-ID: <CAK8P3a39oiWyDwp=BHuCsBVwfzyZ802-NwL9G9r-t6X8KSr6nA@mail.gmail.com>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FMzsgWqwV+5A3vF2F+NmVabemxm0c086701qqBK1iJ49eZSURqN
 xPj+RXTf/Nz3+i8FvbYCQB7Db9uIAh7dxjHjWVdHRRJM+n8I9VNfLTNvK29tc3dMS3XwFlP
 edT5+EpDEG6xeXgx6SauaFl7Oy/uDeARG+6oyhCC77qymUOA3Ei/UWMpfCv+p1j4n7vrv+G
 vzNhtWmjBIFpRl/q+pJMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y9+PRathUfw=:P04xd6FUI2drJc7Dg5HxSc
 lUH5LqPZ9ERWB2UaEVoYmELLlK8A6+EFJ56CaFrd/okMBOn6EApJ7kVPHG1LOI0A5sPh4MAkb
 JzyTcjsl4WuDSs8AxbSmABltJc0aUAD5oRFet3fhBhAjotbJdxYz71HIJy7mFzE2eXVu2sofg
 PideLortlpfnbgtbtv8PHebkan8dJ17/XKbUYiHfO7C55KSTkuqtILldaRJ3busyU1qlGrAvL
 nidJZDzJEHCzM7u/BXOU+rnRj6HcA1TpGIRT4deDZEvTLpbMZU5BiHvHvkL72vDMWohTPHkCd
 OXzJWLF5S4jHfRzNw4HfvWvctaDGIqdP1wFfvcZAOakn3j0cb4QLeWP/jjhRT0shu9q665A+d
 lt1s9fpVlN04IXzy9aa/xJzOGMEPtLzSadBpJfPkKv4drlTSPqL4Y3vLk/RKwT88Gzx6wumQc
 ne0c1bB5v9Eopo0tOQCa1VAgR9GMq7J74EoPW30/foU0ivvQ2hbrzTpAXARJXz42j7zNBj1UZ
 qA2m/hjrhp7SmxUgbDqkgovHF532o9oGCK6Qa9msalFg4xauk7dYzhXcUXdGtndSA5hf4Aapd
 e1/pV+yt2OP6pLmGhLs2U7sj4LfWD2cbugX2q74y15Q+FVbQ9bq2H9RmMPhSkA7HAuVGWba7A
 2RT0ZZS6t6OTA26S6RDG3vIChw5KGbHow/pvZzMIgYYNPSen3r+Ez7DFAqNfcYp0f6WSkIggw
 bAjsGJM+Du4B8Y5SNq5OlQCv2s4j+m8AFlUngHiCAEplNCptnYwnCC7NcXlcuf25xZfA4Qx1N
 5+ZOKQArg0Fst6clEov4EcNI4HoFtoDtT0IOR06O2rYjE1YNW4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 4:55 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 5/2/22 14:03, Arnd Bergmann wrote:
> > On Mon, May 2, 2022 at 10:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >> On 5/2/22 12:21, Arnd Bergmann wrote:
>
> qemu puts initrd in the middle of available memory. With the image size
> being ~1MB larger than with v5.18-rc, this is too much, and the kernel
> overwrites part of initrd. This causes it to be corrupted.
>
> It looks like that would have happened eventually, your patch series just
> made it happen now. The kernel is just getting too large to run on such small
> systems. I worked around the problem in my version of qemu by loading initrd
> at the end of the (small) RAM. With that, I no longer see the boot failure.

Ok, thanks for confirming. If it's just the image size that changed,
then I think
we can live with it. Having the kernel image grow by 1MB seems excessive
though, I'd like to understand better where that increase comes from.

Starting out from pxa_defconfig, I see a 40KB increase from the final patch
that moves to multiplatform support, which I think is fine.

If you have a z2 specific config, that would probably not enable CONFIG_OF,
which is always turned on for multiplatform, but again that only adds around
250KB in my builds (using gcc-11). This is more than I'd like it to be, but
still much less than 1MB.

        Arnd
