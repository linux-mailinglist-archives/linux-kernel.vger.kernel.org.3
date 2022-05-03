Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE495186B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiECOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiECOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:33:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D61DDBF;
        Tue,  3 May 2022 07:30:11 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MeTsQ-1oMKHu0QwG-00aRz8; Tue, 03 May 2022 16:30:10 +0200
Received: by mail-wr1-f53.google.com with SMTP id w4so23592610wrg.12;
        Tue, 03 May 2022 07:30:09 -0700 (PDT)
X-Gm-Message-State: AOAM533c1wg+rduUfhZ7NSslyNPeX1QsmZjDXTvj7Ngsb1/WHAGBJ4a8
        mAeNnRc78wyInxd5T99gBaTb8jMUe38MNvwl45w=
X-Google-Smtp-Source: ABdhPJzBrB6Hq8d9DfigwWJUnvR6JgldisGRuo8lFweHaJxUdm7WjYyRpRzeyy/XN6uA5q8KyUIXhqy6JFoQk/SEnPM=
X-Received: by 2002:a05:6000:707:b0:20c:4fd8:1d61 with SMTP id
 bs7-20020a056000070700b0020c4fd81d61mr13363100wrb.407.1651588209550; Tue, 03
 May 2022 07:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net> <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
 <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net> <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
 <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net> <CAK8P3a3S5OjkKq_u5FpnwzYv+0+typya6Z4MzTez5ZH+do00xQ@mail.gmail.com>
 <CAK8P3a3jiqf_zpBsZyvAb5ZtkwDa7KkqExqDAdpY_pYqkr_NgQ@mail.gmail.com>
 <4dcdbfe2-9edf-320b-d123-3b62c8b5e28e@roeck-us.net> <CAK8P3a0ogn1wgPBDHkT=Fb8ufA+y8Ax1Qov2-vRXfC08QqnrQA@mail.gmail.com>
 <c001d58e-9a78-6338-a533-d0f215b3dfd1@roeck-us.net> <CAK8P3a1X3YH0RqqmqgqFAaY94yreD-PfY-pvyMf+xU3nGeqvsg@mail.gmail.com>
 <04840b4f-5b9d-b29a-62f7-e5148d415313@roeck-us.net> <CAK8P3a39oiWyDwp=BHuCsBVwfzyZ802-NwL9G9r-t6X8KSr6nA@mail.gmail.com>
 <d4eb4752-d8c0-715a-1d69-829f39c88d2e@roeck-us.net>
In-Reply-To: <d4eb4752-d8c0-715a-1d69-829f39c88d2e@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 May 2022 16:29:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0tgEwEJkrcGD5A2WnLsgUhbax+a_mFr8-a+kKc-dUDow@mail.gmail.com>
Message-ID: <CAK8P3a0tgEwEJkrcGD5A2WnLsgUhbax+a_mFr8-a+kKc-dUDow@mail.gmail.com>
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
X-Provags-ID: V03:K1:HSVn/iX+FVdEK5IEwHfYjhX1cPdyQyAdi5G712ba+0brJUy62iM
 1rbmna4lcLarY0LKIetASW/ACTRqX+5lyLLLTLC9zKZK5RcoNNyiPUULeHGI7KjievG1Msf
 mLP3/+m2YGbDYGYZVgXch0B3BedoGkW8FMmSmxM3V7SgTYbQROt5sQIpdXP8MO0nMFTT+Tg
 Apl6qKukzVqiMqe656Rww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mcDpGgXBVRw=:SU9lJl+naDv5hDhnlha3Wj
 jgZBbtLlBPyFA7gCTCMEItAUEs+dQfD5fdF24XVuJ/Wz7LSCuZJwwAbotOFyElBoa0QUz1Hoy
 A/ggJJzNCU4Rpo0nvIN77Nz2PIUxjdkbC3O6kGCXWoJ7XrGchOPW/JBWTCug1nbnPk+yVbCLb
 TEpd5yI36ky7CNec/dyU/UWxqBl/ayr/3VVVV3aqJis+FQJ2SJ2NGs4vqGWfdsqecqwKhDInK
 Mf396m2qqvB+XtjEl4kIc4nW3LgkUBXoEb3oQon87LF16+U7A0MLVRJZ1gmZcnXu+zkDgiC2V
 CPKY449JrI1TrZoa3KG6opZtgYRphWJJ4YkM28vpvJtyK8mbFvtDRWyklpYkHjFpDhwWLFiZg
 N2E9GIGLiKEdDRaeBtOcLYUdxK1gOaVbJw4NMn5zgYzOytaaeG8iihofBYqzZczQ1geUnGNRD
 tvTsZ98DhPTxYg4+nVYghN00Yp7CSC0oV6Fj603gVSXtPY9f+uIptzPmzhOS1IwVJNJALXaAX
 iamIT0B40+VvAIcqKwWqZadCNgO+6Rp7Ipt+9+hQZVSAdjyrvF6XIHPrj+GSydMA91fZiu6xZ
 uHrBLVN2Vw5d3UQfAHsLDpeHeR4hXZJqJhzVAMzzSbnCJtL1XvfqP8eYhkIgKHQB6d5CpUxmT
 wpEzizUUcGtIfKdIFuMbREWrMBNyNFxLRIZYhy2zMId19FN7tw08oiJXLcdJ0iVQIEiMDxtjM
 NSbVi28DWfSruR19DOy5wAi/JpFzjX1joBUTOm4nAyDgXJ2aQEL9JrEMyOLe5HgSVwULvKeoD
 RcjhneTdeqhPru8evjetVmyAEb366fBoqUipYRTJXeFCNs8Ytk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 4:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 5/3/22 00:17, Arnd Bergmann wrote:
>
> > If you have a z2 specific config, that would probably not enable CONFIG_OF,
> > which is always turned on for multiplatform, but again that only adds around
> > 250KB in my builds (using gcc-11). This is more than I'd like it to be, but
> > still much less than 1MB.
> >
>
> Maybe it is a bit less; I only compared the size of "Image". Either case,
> it is enough to cause the problem. I am not sure if it is worth the time
> trying to track this down further.

Sure, I'm not worried about the boot regression any more, as that is definitely
explained by the size growth. The only question is whether the patches make
the kernel grow more than it should. The 40+250KB I measured seem
within my expectations, so unless you have specific data showing much
more, I think we're good.

Thanks for all the help!

        Arnd
