Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B62476B80
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhLPIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:12:32 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:36439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhLPIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:12:31 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MBBCI-1mnIH51hMs-00ChmN; Thu, 16 Dec 2021 09:12:29 +0100
Received: by mail-wr1-f53.google.com with SMTP id t26so6292350wrb.4;
        Thu, 16 Dec 2021 00:12:29 -0800 (PST)
X-Gm-Message-State: AOAM532jBxpQm9ksWTOw8+xqpY5m8BYgCXecQ+hPxaINLRGRn96+9Vb4
        UjgK+glJtyv4jFSi1K90GrZ5dwGUEj9knRmzBwM=
X-Google-Smtp-Source: ABdhPJwYtMqPfFg9GzXhBmcOdn3sobd8196nSbV6WVDDL6Nge+uAQIhproVVltF/DqDDBiffqjQeaiRNaadsUjb/qKo=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr653391wru.12.1639642348958;
 Thu, 16 Dec 2021 00:12:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639560427.git.qinjian@cqplus1.com>
In-Reply-To: <cover.1639560427.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Dec 2021 09:12:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Doh8GY9iFZsvmd6wASHoPqyR+roXx0G5XidnmHNkGaA@mail.gmail.com>
Message-ID: <CAK8P3a1Doh8GY9iFZsvmd6wASHoPqyR+roXx0G5XidnmHNkGaA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add Sunplus SP7021 SoC Support
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VHBQGMx5BnEGZ2O1OFfBBwmcuSZLc/m3GiIghGM6bV3Mcn9QVnM
 SskyLOGbhEPurF0ZNNk8H3dVvLIV4lIRAiy0AnzWvbuAtSP/AM/lRuSp8nnfyzTbnWW+qR4
 pDlpsFoGU0yPLE4tdFCU1juXj1dOBv3veKT+iqmd7hP7HH0F0s8CcWRMxBqgoDiBqzdkJVE
 Cx6sm0kycPDxbBK8X3udA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ABBbp6E+X8c=:W/6H1wkZsMHq2Nvgw57WMQ
 Lap7/jmIIS5gC1LMYiEtRAY1T0WaMOijuZZJ2sQdvcl3bWyfDDcrwyXwTy4Xlwffkj87d+oWd
 qxTMPF30w/l8JjA3stM4ayXDRuAz6GbHA7JT8Sd4Rb/FnAwVQAdTeZquPP9R8Kcs7O6C6XoTl
 4j2wTWt07IOJp8EGFN+M8r9t0K749IDX5CLeQ9Qq4QmUA90Z2IzLGG6ueYa485aP0f4864KG9
 gBRPEdTSnd4Y0FC69ZkQpJKadYF5N24B6Lf7pl+//WLLKNh3Yme33ZvyPO5KVzynv7RhKjn78
 5bLtp3PNBlOb7ctv9b5UMG1nVjLhEdZ7siG2QNYW0GbB33HkBNwz7adXslzNSm38tcHwOQy8d
 Ux4O6r1bBL5R6aTdiAcStWiD86kTTaplZ6OpOEhxS9ofbQKcxBwOq1hVmcXSh45wECCwB7A90
 bx8I0CP7n65c8NSMslaAcyHvKE3tu4WVx/sUUJ0WVwvapwM2b1Y7pIBdMR+VEHunrKvEBuJj1
 Cen4NzM406ad639kOpcWaWrc8IhkbVNAN43dnYeav1vgZGn/av7ojiuzTv9dhvDKiqwoT2hFa
 99RkQD+YSi6EFVvJ4obyLuq1VHTRkg2g152updp7UkpZpOhktBXZm4ByuA+e6gIccHayDOoXk
 RnlFX+SxrgC/HB/eUGDvNoKoTbBRLEJnkuDK7kocjWwtMfRRcH5R69elyVs7zqvMOWMuNX+bi
 SJOIfOykiweIM7v0/z6gLdAV8wJj910DDvdrKoWHDa3Hf+pLeDjLA6JAxEG1Iixm6+dugRRnI
 Jw1dU2Elc9IBRLMh4R+W+ok4YHI6aX6pK8DmALbBvMBMhemr38=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 8:08 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> This patch series add Sunplus SP7021 SoC support.
>
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates many
> peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and etc.) into a
> single chip. It is designed for industrial control.
>
> SP7021 consists of two chips (dies) in a package. One is called C-chip
> (computing chip). It is a 4-core ARM Cortex A7 CPU. It adopts high-level
> process (22 nm) for high performance computing. The other is called P-
> chip (peripheral chip). It has many peripherals and an ARM A926 added
> especially for real-time control. P-chip is made for customers. It adopts
> low-level process (ex: 0.11 um) to reduce cost.
>
> Refer to (for documentations):
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
>
> Refer to (applications):
> https://tibbo.com/store/plus1.html
>
> Refer to (applications):
> http://www.sinovoip.com.cn/ecp_view.asp?id=586

This looks all good to me now, it just needs a review for the clk,
reset  and irqchip drivers. I'll won't be pulling any further branches
after the 23rd for this release, so it appears unlikely to still make it
into v5.17, but please keep going anyway. Either Olof will be able
to take the series when I'm gone, or we can do it early for v5.18.

Ideally this should come as a pull request to soc@kernel.org once
you have the remaining Reviewed-by tags, with the text above copied
into the (signed) tag description. If you send it as patches, I'd suggest
adding the text to the description of patch 9/10 instead, where
you add the board code. This way it still becomes part of the git
history for reference.

        Arnd
