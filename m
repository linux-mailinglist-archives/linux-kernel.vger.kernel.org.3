Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332F652BA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiERM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiERM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:26:14 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B523158
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:26:12 -0700 (PDT)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MqK2d-1nVyQT2pzn-00nUHC; Wed, 18 May 2022 14:26:10 +0200
Received: by mail-yb1-f176.google.com with SMTP id i11so3333506ybq.9;
        Wed, 18 May 2022 05:26:10 -0700 (PDT)
X-Gm-Message-State: AOAM532zG8E9QxeoYTjizOUDigvxGU9HqUSHGI1jRTih85ajn3BHMHGI
        rQaScaRoTZF6W4B1Tmy1TWo6QeP0dssL3tGArYY=
X-Google-Smtp-Source: ABdhPJzmVlopyCfoOGgm87Os5G3QW/G9c0usDcCbEYvhYj8aqb9XG0oZHtflqu+F8nKb6UZfd6bLOqHBJIobSYwhMHY=
X-Received: by 2002:a25:5e09:0:b0:64d:8543:627d with SMTP id
 s9-20020a255e09000000b0064d8543627dmr16981158ybb.394.1652876769340; Wed, 18
 May 2022 05:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220518065639.2432213-1-gerg@linux-m68k.org> <20220518065639.2432213-2-gerg@linux-m68k.org>
In-Reply-To: <20220518065639.2432213-2-gerg@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 13:26:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1gd6ggDgKu66bQ-qQ-K4g60uLo5VOuO5gOKsO99Bi0dw@mail.gmail.com>
Message-ID: <CAK8P3a1gd6ggDgKu66bQ-qQ-K4g60uLo5VOuO5gOKsO99Bi0dw@mail.gmail.com>
Subject: Re: [PATCH 1/3] m68knommu: fix undefined reference to `mach_get_rtc_pll'
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YNRhJGh9ToQapzUXgx/DrsuWRXMLxTSWN594wMBabhiJEIaIoeS
 JbVnnNCMNLEfckiqGecFNadSlbPCCyil7i90xj/Ayg/wvjd9DnNZByNqkwqcF+78UZvfp+A
 hLt0dPABrkdEMHvsT8NuRiJSbCPhdJqFhjA9MbCFzDpc2muSQeDdkYL0K9ECfL0FwRh9zu5
 +NHv+1iNt7lKbOGCSTyeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m388vcAbaoA=:kPUqBJp/V1dAvNOh2cwLo3
 3DqU9MK3vhP0prNuzaGr+zso7z16bMQ6qbRDYRGXw5sGoVfstBckcR1Mk25TzgODrQgHmCX5i
 eAbVKI1PRklHay72FzRSRRh37x37IQ9MQ/31zV3lN2M5zefdOqYStwgfiASAmq114MG7NiNWl
 3/j5G6jdYx/72DR1i2nbTVULyAYq+Bpbn0ujya0uJsV+PDDF3xquBu6tthstos0FGXzAokfKe
 aQnz2xbYB7FEyjMy8OMy4tL6jOMm/yOuYCE1NKUUCl3ML6go/yDeajjrmMkBZtjOmIxEeaRqJ
 YhldK4my9kLUzp7wPbyNUANEY6pR1BbheFaOSWzu3/y8gc6qoxkuHeyTI4+O1CoKmdStefTac
 F3UCbVIWH5wxM2O8Wr489yaCx8UHtzQRCZfKsX772VbprgnK/pVp5fIw6LJgLapSyR/nV4ghR
 Ihtm4xPwz9lp5iZSsA7wEOPWiv6TBxcRv1zc9M4xf3XTAiqYhAdJ0OfqjIYFy43k/s5XbIQSg
 JFncuPvIdLTB1F15tEr2pVyz1SmqmFg31Zx+kogj/MzyOXxWzOhXJl99GVLGFCfmP8r19WVMV
 fizGd94sKrr3S241aDiVvhl8UQjWZd9Gk7kh1NjHsGXdX/O2ymuIHuuzkK1KJL3K9dsVxQ2b8
 Oi0GQ0VOlPhXkFXYUM4apgHGqycICP+IU5DdIHYoRkoGmumrIjncAUT277AcboMaywAW2z5X7
 SdwO4dKKOYzxMx6DNIwRhDPHhBsdcl3r5EsvLstzUDG0TIr0Y0Ljkf/wuDMAhH9JeaMthR+1w
 k4EiiAB6V5NbNswnucISuulS4VA3D1wXyU/puliY1h3Q1V8pQLp5Q1QOo0aOxUGOePWMiotq5
 HVGW0JB+T2tM1Vz5aQvNVuFl1JWlyGINgcL3196N4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 7:56 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> Configuring for a nommu classic m68k target and enabling the generic rtc
> driver (CONFIG_RTC_DRV_GENERIC) will result in the following compile
> error:
>
>    m68k-linux-ld: arch/m68k/kernel/time.o: in function `rtc_ioctl':
>    time.c:(.text+0x82): undefined reference to `mach_get_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xbc): undefined reference to `mach_set_rtc_pll'
>    m68k-linux-ld: time.c:(.text+0xf4): undefined reference to `mach_set_rtc_pll'
>
> There is no definitions of "mach_set_rtc_pll" and "mach_get_rtc_pll" in the
> nommu code paths. Move these definitions and the associated "mach_hwclk",
> so that they are around their use case in time.c. This means they will
> always be defined on the builds that require them, and not on those that
> cannot use them - such as ColdFire (both with and without MMU enabled).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Right, this seems to be the best solution

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
