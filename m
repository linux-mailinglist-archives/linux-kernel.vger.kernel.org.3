Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01EE47D0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244573AbhLVLRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:17:40 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:40609 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbhLVLRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:17:35 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mzi3l-1mDXm12Pth-00vddY; Wed, 22 Dec 2021 12:17:32 +0100
Received: by mail-wr1-f52.google.com with SMTP id j18so4215804wrd.2;
        Wed, 22 Dec 2021 03:17:32 -0800 (PST)
X-Gm-Message-State: AOAM531vWTHNTzykq4unpDUrfNwuUJ+/nOAAmKTnJ1uadF/vyhcAuVHH
        RhuLOcWUL/S5AfsnTtruvuIoMug3jpXzbfwSXdc=
X-Google-Smtp-Source: ABdhPJyaaVKk3ij7jkLGVaEFAO4sePbkYDGdbMYrYwErWCECxFNczxoRpepU5YVttAHlwzlBujezG7fVoMI9BRWHIQU=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr1764720wru.12.1640171852021;
 Wed, 22 Dec 2021 03:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20211222015244.2464671-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20211222015244.2464671-1-Mr.Bossman075@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 12:17:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2TujT7u4Y2hOce0h9SyRWuQP9+8wbXhZEzgNp5FSTwSg@mail.gmail.com>
Message-ID: <CAK8P3a2TujT7u4Y2hOce0h9SyRWuQP9+8wbXhZEzgNp5FSTwSg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] dd initial support for the i.MXRTxxxx SoC family
 starting from i.IMXRT1050 SoC.
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JSF0KGb40Rsnqn+Ec99D13zUGQFmbby/CsYvqtXFH0U2ucRnHpG
 fOah2SnCbsQQZ5D4RLIy2JnSaIjR5maVUsfFxaYYl8BV2W2nfmRpprO27BqOqPJUvzcHZSp
 f8yAOWapaolaUQfuv6wKIB9QaeG609kx9MgYPInFOsptOhTFl/2mC8HAgnELthnkzoPI8kq
 Ah+iQhM8OkhMNl7wwxOpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wi0as2i4V30=:KAiE78GeuH52oUCbNDM5+Z
 +RGVpN0TuMOpzn2tUl+vksRaTJ9aPfACVN7TUTnEzimoeqh6H2OX+RkryQeyDrCQK6uLlKBgO
 YIpW0cJuhLY2lseFit2K1icu6IkR1Cmmer17nfz5tnhyS3ABjNF3uCqaI41olK9k1fYEUmUDe
 damZlhruOP3Z4vw7+O1/+ung+o0h34QNkDLngrKhNRU6WVTuJ9oAP2ms1kfbNHnftf58bKMPW
 H6aTT+GBTz5V7zp+HNTnmEeDlpHr0Y3GesesEjmd6AVp2AzgOLC4HoqgAHSvqgUQ8ozNQ0jxy
 jb7hW6bNqankFyD+zehzULqHpY5auhtx/EZDSqGAbaU4tS9bHfJInmdI1J3RhwfbabX5OWHxI
 lpbaGiuOigUByMi5yhcK/7MRHGLpO2MC0eWeLLlEXRvjxgc/sLP9YPTCuWdJok24hNxSQ9f2T
 fKAcBpmRzHGgIbwDHRcpf/ZFSS6IWKLAZ16vk88m7wSlVRImfY/uLPSyQLmQmIRJxp1Vc/1BN
 1C1M4L8a0djq4YwOPt8gFe0Hg5qR44JPDjEy2Xr21lpNTpf2Oo3sDFpuEr6Wmu8iR265KPFhr
 y1AYrifgP+1gj/P9l87QYVtqNFeUsDQOP4aOnn6+oOIneLy819ZGz/zrbYI88Wsr8E/6WOiBB
 CULsl5Zx1rO5oeoGCITn8/FkDuT2yqANECDhCqsl1hw4cOuL1xsEIpXraCF9Kw6GbdVJ9btqN
 MP1NeQt+sKHqebH1Fijuch0gcPXB2Sx4Gk6tCJyI0wWMF5X94vQVh0S52zpJU6VHMw8KYazMM
 1GHmzyOqVFvfmaHPiBid1h1hNIUO+Co96Fbf2VkI6qk1WafIYY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 2:52 AM Jesse Taube <mr.bossman075@gmail.com> wrote:
>
> This patchset contains:
> - i.MXRT10xx family infrastructure
> - i.MXRT1050 pinctrl driver adaption
> - i.MXRT1050 clock driver adaption
> - i.MXRT1050 sd-card driver adaption
> - i.MXRT1050 uart driver adaption
> - i.MXRT1050-evk basic support
>
> The i.MXRTxxxx family that could have support by Linux actually spreads
> from i.MXRT1020 to i.MXRT1170 with the first one supporting 1 USB OTG &
> 100M ethernet with a cortex-M7@500Mhz up to the latter with i.MXRT1170
> with cortex-M7@1Ghz and cortex-M4@400Mhz, 2MB of internal SRAM, 2D GPU,
> 2x 1Gb and 1x 100Mb ENET. The i.MXRT family is NXP's answer to
> STM32F7XX, as it uses only simple SDRAM, it gives the chance of a 4 or
> less layer PCBs. Seeing that these chips are comparable to the
> STM32F7XXs which have linux ported to them it seems reasonable to add
> support for them.

I'm in the process of finalizing the pull requests for 5.16, this came
up since you
have soc@kernel.org on Cc, but it looks like you don't have an Ack for the
clock driver, and I have not heard from Shawn or Sasha about whether they
want to pick it up in a separate branch or I should pick it up.

I suggest we leave it for this time then, let's plan for 5.18 instead.

          Arnd
