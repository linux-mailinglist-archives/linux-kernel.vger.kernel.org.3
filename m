Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D29580E48
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiGZHvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGZHvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:51:48 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D81EAFF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:51:47 -0700 (PDT)
Received: from mail-ed1-f53.google.com ([209.85.208.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MeToK-1nfo8r48V2-00aXEq for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022
 09:51:46 +0200
Received: by mail-ed1-f53.google.com with SMTP id z18so4414440edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:51:45 -0700 (PDT)
X-Gm-Message-State: AJIora849xUXtoHmDzJ68Z+rJVCyeiWNagV2zQLRFtLonaT6Mn/k89MA
        luxKWTYuceCeoauvwX0igVaORzvZd4B3KiFgJeQ=
X-Google-Smtp-Source: AGRyM1tkHpOyDYQvLCvxuAWWeArDG7tyHRoTLDIckJF8w6j5U4aqaDQ0DjwPkjdSc+MnBobuoc2TKRz/qD1jDB2W4uc=
X-Received: by 2002:a05:6402:28c4:b0:43a:cdde:e047 with SMTP id
 ef4-20020a05640228c400b0043acddee047mr17266227edb.368.1658821905683; Tue, 26
 Jul 2022 00:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf13JA+5vuAKqvBSs3MkcF-gbE_8vd9nSvStQga55vW80VA@mail.gmail.com>
 <20220725065308.2457024-1-jiho.chu@samsung.com> <Yt5cFBgiTLwGXv17@kroah.com>
 <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcms1p5>
 <20220726020952epcms1p59c06fabb55776e195dcbeac549c98ef7@epcms1p5> <8b69b813-d030-2666-37f1-a731b1d52f4e@linaro.org>
In-Reply-To: <8b69b813-d030-2666-37f1-a731b1d52f4e@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Jul 2022 09:51:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3xhAcokq1p0_PzK2JzR9BGNcaohA_nan9nS9NioW4_rQ@mail.gmail.com>
Message-ID: <CAK8P3a3xhAcokq1p0_PzK2JzR9BGNcaohA_nan9nS9NioW4_rQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Samsung Trinity NPU device driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Yelin Jeong <yelini.jeong@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XtYXEDlOlB5amvS735B4GKVK7Rsf8Ye0xwrYAWboexSgL4eZGtg
 54cyWZ28MCCXsO7j9zPYGNyPDIATjB0ZoGC4yeSlPOvt1qwSkAh+sPC+K/X1aKtHtspVLl1
 hNI9DH2voDXlbxUMyzdkbLiy8bv8IQxwtoN72VgH80bjGKSg36/47k1MwcM8GIOSC2KZ5UM
 KyzHnuuSLwmW2E6w9Wrjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T6+7c5nwmpE=:S2b8G4+ggPIcSfBunGnFfO
 eZdH2L510sDAFmKjMWkgcfm83BkyW5OUJ+kFhtwqV+dC41s7pgtSBVrhzXoV8ZTT/efkAT9iZ
 sXMgVX1BymXcWbGpexvA/njOruM8hV7zzya5PeuilDvk37WMyzNIsbhLQpu8a7kARO9fxrz54
 ZFel7PuXT1A41xMOH1XGJcQst2aLw3fcJjUCrcKOrGMwbsJK0JTDl3UCGOsW81rFU0IzZOBK8
 urmOnr8LO0am4XNfU4EsA9jncKI0LnuLWUutV5cImTdrMbKAd+NeV8U9HdkWQsyZZ0y0nXCjS
 EwMXFWxwB9r905xYEAFk+vxM9EBjVlPAsLeJG1ejRDC0j7anrhz86VXVnmuNetawhDFNuMtN0
 KxqqWdnM5PCsx8m6DlMui+mjsDZGnJlLAIyYtk6uXC9aIU38qzZD1P4tZaTwFw3V8GWW1fHfG
 F9CclQnuA44Gp1bK6TXeKCCK+hCBGLeYGnBfDPIUzI6JPxliCfjqlW4sQ+i8CjeZSoJxZCIVy
 x55CKIB6ezCwHq4KJ1U91im/jJdXpOt2OwIK1//TTUi0KLbPwtKns+H0oVTsnFilUI2ZgcHA2
 ifLoGhAYl8FTp6eTYFWOEUWWAzewMiF1Bi90adzLNrXQWqI5bvkiVr1aPJoICD9SxOPE2l1sX
 oT7o44bUKzGn+w7yTZNwXQPaD0UBno+U5dGsvYf66afvcLGWsxHATpie0xS7ps4VRteCkCYTF
 zcgcM6yWzQs9EjwXhJkkE5y6E0K/X14F+tqJlQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 8:59 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 26/07/2022 04:09, MyungJoo Ham wrote:
> >> Hi,
> >> Why isn't this submitted to soc/ subsystem ?
> >> Don't you think that would be more appropriate, given that this IP is
> >> integrated into application processors ?
> >>
> >> Thanks,
> >> Oded
> >
> > This series (Trinity-V2.3, V2.4, A1, ..) is being integrated to multiple SoCs,
> > not limited to Samsung-designed chips (e.g., Exynos).
> > It's a bit weird to have them in /drivers/soc/samsung.
> >
> > CC: Krzysztof and Alim (Samsung-SoC maintainers)
>
> If it is not related to Samsung SoCs (or other designs by Samsung
> Foundry), then it should not go to drivers/soc. Based on cover letter,
> it looks this is the case.

Agreed, and I also don't want to add any drivers with a user interface
to drivers/soc/. The things we have in there mainly fall into two categories:

 - soc_device drivers for identifying the SoC itself from userspace or
   another driver

 - drivers that provide exported symbols to other kernel drivers for things
   that do not have a proper subsystem abstraction (yet).

This driver clearly does not fall into those categories. As long as there
is no subsystem for NPUs, the only sensible options are drivers/gpu
and drivers/misc/.

     Arnd
