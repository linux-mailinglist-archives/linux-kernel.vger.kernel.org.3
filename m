Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508F2538B53
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbiEaGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiEaGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:20:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176558DDE4;
        Mon, 30 May 2022 23:20:35 -0700 (PDT)
Received: from mail-yb1-f182.google.com ([209.85.219.182]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUok5-1oM4xf0f33-00Qje0; Tue, 31 May 2022 08:20:34 +0200
Received: by mail-yb1-f182.google.com with SMTP id v106so15255754ybi.0;
        Mon, 30 May 2022 23:20:33 -0700 (PDT)
X-Gm-Message-State: AOAM532Lg2zvR74NfzminsBOx7Gky2HJfNQHF6zxz62udFQIk0xZFr31
        EJl2SXC4565Cdz1S5T9XLTBwG090WB96jhgt49c=
X-Google-Smtp-Source: ABdhPJyjJwXBPGiLFwJcPL8LpszFynK7r8RQeXSulMT/bC7rn948af4y1kE1ObqEbOMAyT3J0meiIKAhEtryxXOB8TY=
X-Received: by 2002:a25:db8a:0:b0:65c:b04a:f612 with SMTP id
 g132-20020a25db8a000000b0065cb04af612mr13375290ybf.106.1653978032886; Mon, 30
 May 2022 23:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220406201523.243733-1-laurent@vivier.eu> <20220406201523.243733-5-laurent@vivier.eu>
 <3b783435-e734-5391-e758-d709e0462839@infradead.org> <64ce78bf-b81b-1eec-74f3-650a72f2874b@vivier.eu>
In-Reply-To: <64ce78bf-b81b-1eec-74f3-650a72f2874b@vivier.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 May 2022 08:20:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mF9CuWC2Tw3VvDVGFgpjAwtMHSjoNa49bny7gMEw8sQ@mail.gmail.com>
Message-ID: <CAK8P3a3mF9CuWC2Tw3VvDVGFgpjAwtMHSjoNa49bny7gMEw8sQ@mail.gmail.com>
Subject: Re: [PATCH v16 4/4] m68k: introduce a virtual m68k machine
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fWVDVDmwfvq9MFlZ28krXFaULaYGmlrGpPHwT141bFJQre1uJEK
 OBk+laHiPkf9Up47c++giO1iSu8ZmwM3gPEfj9z93WBFUUzkjpozJnnqAYeTvegM9KnRbZL
 kpJWYaUWaaO2g+4YCTWa03ZrzZbMSMuXrzyqNHsQuEcFF4488Bab/2JS3oHD05XIy7IPbUu
 8V7VIl3cmOG4HaEctvraA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6CpOo7Bgy4I=:wKwx9FM1rhDcDw23KWTjYd
 nySXykUf8gwH2a4wN9K88SgSqC3Ot55fyR7iUF/4koSeHyh8BbSuoXP4cmoX6tYMRwCsnoEha
 eGuMEZOfEcTe2TAQL0Lipt9Sp0p0gr8GnfR+q5/Rjgndia/uWa0yAjipXedGBukB8aQKNsw8+
 HljNBjAXOpgrRS/Xd8ce5u6mb500FFDcx41t/JgxHzkzSrXsbDM/iaAIt7y3xrFzmGz8A6jrc
 zYHgtGJzrR8sloG3/0hOM2t8U+jjPG2MEv4CXvNWasBcqpCTTDVXu1rxHbvIjkhHhOM5j0RCs
 WfvUSE69p6MosecxMde1Xcka2UStTui96Zm/zcsUNnURZ4sxGdWz81FlJohm9YWW+8lAglOh6
 dzY4f3LedXo8JqkeDUkY6n4TCdnDiLZsLrJUgjhS5Qt5/A/UVDYdyMF992oxnk8hMVKMR60zI
 swWD0XUx+2iNenwvJkP2d+99yoqKg4z1PjCBXef5bBntiNIaoq6d6O9nsFFhXcu8dim0Uj3m7
 3XQ2Aai1eqyT5bBywkIZV0PDlz5neFhPYOoKhP5zo7kyObqkbgbUwrXNxzzVuVjN6W1feXnhH
 +l9eicj4yfer0XCpqsJcmge83vMIJuU7c94RfPDLaERtj8DxNLDySFHxU0p2UtBn7EZggkix7
 FuRyMqxiLCPOCpaFnGeDwqrQUSN4U/UeU7oji6xqWgeauYb6bOAoPjJYzTx4ska8kAs4DiyIX
 wuiubSgIxNvVbdVo0PMXysbGmqe07G/LhSx6uuTXgqxlAWVCCA+B7pJFEQtR8NH/1pUUcE28x
 04ivG7eqppRPmJuLg2cNuXBf8X8guY95MoyHhcUp107XiJYIrVTWekzKJxalfUgzold26hrC7
 ZpAcam5MYg6LFR8aYRjw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 8:05 AM Laurent Vivier <laurent@vivier.eu> wrote:
> > This select VIRTIO_MMIO can cause a kconfig warning:
> >
> > WARNING: unmet direct dependencies detected for VIRTIO_MMIO
> >    Depends on [n]: VIRTIO_MENU [=n] && HAS_IOMEM [=y] && HAS_DMA [=y]
>
> In my repo, VIRTIO_MMIO has no dependency on VIRTIO_MENU:
>
> ./drivers/virtio/Kconfig
> config VIRTIO_MMIO
>          tristate "Platform bus driver for memory mapped virtio devices"
>          depends on HAS_IOMEM && HAS_DMA
>
> >    Selected by [y]:
> >    - VIRT [=y] && M68KCLASSIC [=y] && MMU [=y]
>

The dependency is expressed differently here, but this is the
same as writing 'depends on VIRTIO_MENU':

menuconfig VIRTIO_MENU
        bool "Virtio drivers"
        default y

if VIRTIO_MENU

config VIRTIO_MMIO
        tristate "Platform bus driver for memory mapped virtio devices"

endif


        Arnd
