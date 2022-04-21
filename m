Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EAA50A43B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390116AbiDUPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390087AbiDUPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772EB33A32;
        Thu, 21 Apr 2022 08:29:21 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MkYLW-1oBuQD30Nq-00m5ng; Thu, 21 Apr 2022 17:29:19 +0200
Received: by mail-wr1-f41.google.com with SMTP id x18so7248616wrc.0;
        Thu, 21 Apr 2022 08:29:19 -0700 (PDT)
X-Gm-Message-State: AOAM532F1OQBCsQtktVjZKRSJK64LtqU9nFHY6KcFd2iVZkNYZEmagbp
        C3L8OX7rHNS0jY7BBOIrve6JXjLvwveEHNE0VcU=
X-Google-Smtp-Source: ABdhPJxKpospiPlAgrLUewrHWmh0snRbQc7E1OFrJMr7NkFWoVWNdjC/+qxZuhyVxJOjyOGXkiqrvZW6ZgPa03gRamE=
X-Received: by 2002:adf:e106:0:b0:20a:b31b:213d with SMTP id
 t6-20020adfe106000000b0020ab31b213dmr199757wrz.219.1650554959163; Thu, 21 Apr
 2022 08:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org>
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Apr 2022 17:29:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1s_8_hfZdFN9-H_PoCMQSjhYcaS3peDqc7LWBUj_YqbA@mail.gmail.com>
Message-ID: <CAK8P3a1s_8_hfZdFN9-H_PoCMQSjhYcaS3peDqc7LWBUj_YqbA@mail.gmail.com>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
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
X-Provags-ID: V03:K1:VpvU5C0aiwrphWSBK+To00JHYs2UD49gYqNafJvfmZ6SA8ouFSO
 Y6orZvpb50igM1GRNMF7jP4c1XA3zImGl9kE7VRPtd6EnE6T3xvEgBnF455ZBSFYazNTVSu
 ix0ABxZLwEjWNNGvv65fRXWFI9L2Qgko/G/zLwyoU3QLdq0N/zn0kEXH2OtVT4MWwTRl0B5
 ZKm4Y5B08EkUvTiozMtdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8YtkNir8MkE=:4uPl7TslyU5ucHsASQ+olD
 pZLSr3VniYuw2pteQB/wHqdtkRjP1q0ozN13VXFJUZ36ue+Ltx/Iv1QdPhcgFDjhWyftQZAyi
 QbrRHd8Icn26U2FsiJGuhKxZ5Zl4grMoxjbaUlWo3HIt/BYxzif5nSCj1vsUvEAKJfmQFPqtg
 zEy7uiZSDhTJ/u8AqlWQyOwNk2cIe9c98NAlZYCcaa2p3fBn4HlP0XbujgUpvw3P0NUKq3Pj6
 wFcAHbgLdroT0seYpCaXaCdG3qsd5c1FtSLYVMVYLJdwdHs5b6aO7AbexVik6YF5Z4KeTsuYr
 h/mtpp/IAwIDEpKKwe1tNHxMmq8On5foB5wV9p6KIQ5fkKnArVVoOoUWBlG4mv6jYFQFXvKdL
 PAe3fkzncoHT9mw0vlt05SzEVb+UXvHCwZlwmYnmzYRt9g19u0X9ojfjMIRUUc9usnI3gtUPf
 4J4YlT2TrS2S0W13C2GDXNvaqhN0pBWiAVNVj+tIefAcedlxCxp9FXvaxn97FXDOX798qwNI7
 WFo6pfGwkguGVV0nmlAmtvgaQz9j7jZ5vsOeYy9IktMajvrt6LfAYATxKdGAoTpYE2c1eZZzE
 kVWJZ2233QpTxSpWIqQXnVj8ubPhZqC8iwicuam/2v++KSX6S8SL+RswyTSEJagejDCkUXrwT
 XcqgF7UdkZZQaJ95peTH6t+xJ3aLKZOMt2cEd4H4rKgHvVSJ3PQQytl7NaxTZpJPpvF7tYXLF
 OJhYozDyLF42ds0ozPclYzSVNPW1V4xeupHCw10USUu41VHVUzPivTF7ztkRcO9RE+SbFv1NB
 T86l3zXv563Min5axBE9nVemp+mM1mTcppUh3rQbcwnFexQtrI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 6:37 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This revisits a series I sent a few years ago:
>
> https://lore.kernel.org/lkml/20191018154052.1276506-1-arnd@arndb.de/
>
> All the other ARMv5 conversions are under way now, with
> OMAP1 being the only one still not in linux-next yet,
> and PXA completing the set.
>
> Most of the patches are unchanged from before, furtunately
> the PXA code is fairly stable. I addressed Robert's comments,
> pulled in two patches from Dmitry, and added the last a the
> final four patches to finish off the multiplatform conversion.
>
> I hope someone is left to test these on PXA: if this works,
> I'd like to merge it for 5.19. A git tree with these is available
> for testing at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=pxa-multiplatform-5.18

I have updated the branch based on the feedback I got, and
done a preliminary merge into the for-next branch, so this work
should show up in linux-next. I expect to rebase this particular
branch before the merge window, to add further Acks or
fix regressions in place. (I don't do this for the other branches).

Let me know if there are any show-stoppers or patches that need
more work. I realize that this is a lot to review and that there is
limited reviewer bandwidth as most of the original developers
have moved on from PXA a long time ago.

       Arnd
