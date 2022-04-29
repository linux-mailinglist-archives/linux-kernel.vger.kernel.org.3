Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B022515744
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiD2Vuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiD2Vua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:50:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4AF66224;
        Fri, 29 Apr 2022 14:47:10 -0700 (PDT)
Received: from mail-yb1-f172.google.com ([209.85.219.172]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mna0x-1oAIQr2BZF-00jYkX; Fri, 29 Apr 2022 23:47:08 +0200
Received: by mail-yb1-f172.google.com with SMTP id j2so16794830ybu.0;
        Fri, 29 Apr 2022 14:47:07 -0700 (PDT)
X-Gm-Message-State: AOAM530xFvgaS6E7YleebaxYuHKbztMb8/4ph6JAKkapt9mvY51Aq0Ot
        ghcHJQm/ZtGSH1zgWh+MyICM7xk9gzphi+BehZs=
X-Google-Smtp-Source: ABdhPJwtcBUeQCwBE/wHCTNSMt9GmZKG8b0zElf3XSRBB+ltEsvmy5fENkUQ3EnsgyBJ9WDIgobY6XmBd5vZorZaAUk=
X-Received: by 2002:a25:d3c2:0:b0:645:74df:f43d with SMTP id
 e185-20020a25d3c2000000b0064574dff43dmr1535991ybf.394.1651268826333; Fri, 29
 Apr 2022 14:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net> <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net> <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net> <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net> <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net> <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
In-Reply-To: <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Apr 2022 23:46:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
Message-ID: <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:aUt4162Q8o+llL/MljFLEZxLfqetFKE837pmri7fn06Ux+pHE2E
 HUT40C4ROecFrWGMuh7FZHUctHZLox8PPsZXleJUgvy9mYBXJ8pKhdYxSRIruSY/aMB/RDF
 U1BEI7N5/2VG8u6N+C3m4+nlZOlEtD7a52T70wiK6/at/danyT6j0f35GJC0igmu+zlPp3o
 hPSAJrfl8wT08SeKcbKDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B6AOKPVl318=:2wVX5LiQoMRiBhVxLqNc5a
 6bfir268MD5gQH7DLEuFEsI6WBBc1Y0Ecs6EnhuRsx1K24LuPMh07aYEIpKkcwNAAZfYMwflw
 pGzfeN1TqZ/DZE0Y6jB9FtL7K+04AeCNHTMZ//8xkL4V0xYBxZAP9BTVlcnEyvTsUYwS2Btg4
 vlnJGv66VRl18T+sqQf7xxVhibK8Wq70YGqiM+Po4/0hQXeq8MB/INm4yKnqmNUInDxTfWLHT
 +mmUB0ji5qRvID6/tQH6xrbVdNsZo18KfNLKu/B1CiwzBdT/gKJkj4pXgPVXoMq36ig2Ctu3M
 adeEof/gPY3eELgS/LtY8Tbwxt40i+enALDiuH+GuPG8sIJGRQ0u8jm4WbQbxpqtQReV/BoN/
 /0RaUvbG5bCVJ2ZEbQ75GA30AyoYlAIl5/wde1yMLwwVxBXeLmxlq3y/5eFktLuUskS6GspAY
 H1p4xOJbdwpqwlZHG7GYDtZtFwFoQe2yR7IlaVupWMwQ5kJ/5ARJKy1MGSNGWNv9ynnIW+16q
 3r268R/MBM52lW3YHXF62SBnvoquSaaU0AJxZ9zbLVABj6pPn6KV9tk5Ri1US3zrFLmBPLvvv
 Pd2lciRs/sx2sA+uA6qqK5g0AxTGPfqYDnIHsA76v0M12oIDEVwlBMOnEAJdPKnF+gy/ZbI0Y
 CtrOeY8EtfkkI4G1vJ1cBEfVKh2jeGqkGpPNTOEJVIAhIn/1s31hjRkhpC7US2ZEOj5g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 4/29/22 10:48, Guenter Roeck wrote:
> >
> > I tried the pxa-multiplatform-5.18 branch. Its failures match
> > those in v5.18-rc1.
> >
>
> Uuh, wait, the build wasn't complete. There are still some
> failures. I'll report later.

Sorry about the breakage, I got a few more reports about minor build errors
and warnings, the newly uploaded branches should address all of the ones
I got reports for.

        Arnd
