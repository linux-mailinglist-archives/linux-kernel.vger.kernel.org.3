Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6825F530AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiEWH46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiEWH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:56:55 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3719D63D6;
        Mon, 23 May 2022 00:56:50 -0700 (PDT)
Received: from mail-yw1-f179.google.com ([209.85.128.179]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNwXA-1oCt6f109o-00OF7f; Mon, 23 May 2022 09:56:49 +0200
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ff90e0937aso63921027b3.4;
        Mon, 23 May 2022 00:56:48 -0700 (PDT)
X-Gm-Message-State: AOAM533Y62GrmqaiDndOYhBi01Hclk8LmXDmzwBvebKeknX+mb0RprIn
        PSahQrxOqjnW8SaOMfg/W7UGMF7rRbKxLI5eQHU=
X-Google-Smtp-Source: ABdhPJw2LHiHqq0/Y/VzFvweK5WuNCUQUczMcSAr5ygjJFwwWwAtTaZ+A1Uu9aWWOiGiwQN+ltRnCtbf6WnrGsZfDuY=
X-Received: by 2002:a0d:e64b:0:b0:2ff:8745:8a75 with SMTP id
 p72-20020a0de64b000000b002ff87458a75mr14867694ywe.495.1653292607699; Mon, 23
 May 2022 00:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220517032710.451537-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20220517032710.451537-1-Mr.Bossman075@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 09:56:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0OKQYq-LPxjtRCNoD+coEcEcJD0eL_SV3aQ01BpyQVKA@mail.gmail.com>
Message-ID: <CAK8P3a0OKQYq-LPxjtRCNoD+coEcEcJD0eL_SV3aQ01BpyQVKA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Add support for the i.MXRT1170-evk
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>, dev@lynxeye.de,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Leo Li <leoyang.li@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        clin@suse.com,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/3lm2tyMCrqyIBUbjN1ELnaTuqSU2rlf93Z2B9sKQ8qXUNHw14I
 9mlt94OMk/N8pmuvdnAr0xCnSfd/HQm8HWbczKlRG+wur8EAc5nO3cPCuZcE4vxo2u8DU7t
 1Vmc1HIXEqmN7X14/bwWm5Z+IG5q5b2ycww7kBvXpuXiKIDI22I4qD3V1rrx7Z2NM3sDkY1
 mk8pI6cWCn0F7PA5VLMFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TgmQeTMQ71s=:5meSiiP1er72SQ+7NxR7Hb
 9PyBQspNrPit0h334iUaGgdkp7c0Nbzlytyd+wKITSWopE07r5MjbyZvgfxTsjl4OgFlYJqM/
 fVYIBLRSicVJefdRkbN7Wr0HyxE7mQens/xGTp181L4T8GDBcg+wMxMXBbnW6DyNbxI0gPuV4
 dxHdGeCS1+lSIv5x56IpBsmQCAwY5/6ehv45CR269GQkUY81beYsP3ugPRyeR8DH7Bi2+YH+E
 uxUg1rDCwalAGVva9SffAP0D8yJvHwsJcLnOxMlyGjdV5Rh/sw0jxzNO2n+9zTByXGDPRReTw
 TJhl5HwAEGr5zwTzJGmMpA8CNoImNKVd0CwyiUryYCPlNSY+QSGFhP1xGpaL3fMQ67Gz28wwy
 mL77ufHDF3K59TRy/B8N/mU6wHhBw4tbGCedWZEl8fKxaPmyjBDQ5lt8b9j13r30PF7UE8P5K
 k83IS6e3xUzNenPadPYDaxrAoSuu8702aNbO0cMCCE5Ph2L4kEzDlIUuDtc23vB6ohlgKZCEU
 0rynYZctG0ffU28cn4HDLtPAuhrfWhYzSw5glBHc9VI6yI7lKk05mDIXcBrVhGm/MWbNVDBxt
 i4N9b62WqM3jKx5aU2kfFhtAXZ9lEk96V/4ypxg389GlMKXmt4XQIz/G7dOWdG+hvHLujOvXS
 C5UYdarOVHNnt72pUHJYpbs3rAqhNTK9zCUWVKi38nnEd6TLYemsVA2P6ZovbJxSbL4OCe+gC
 rOChFYox60U/6t7uV3C9t+DF1ur8i0Tw4ZNaAYei2NA9OucM9B1UvFU5JfbOBRhPT3pjO203R
 GxunHtowWJ9XB/LWaHszkiWQW2zJPG15oltnVxbLCMUhHhsVHgyLzbJvRXzBy1Rxf9EG2au/i
 +HG0PcLLU1lfdEpt/mAg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 5:26 AM Jesse Taube <mr.bossman075@gmail.com> wrote:
>
> This patch continues support for the imxrt series now with the imxrt1170
>
> This patch contains:
> - Update to imxrt_defconfig
> - Devicetree
> - Clock driver
> - Pinctrl driver
> - New pll
>
> This patch also updates some documentation for both imxrt1170 an 1050.
>
> The i.MXRT1170 has a vast array of features including two cores. 2 Ethernet, 2 USB phy, and a 2d gpu.
>
> It also is featured in a new google coral board
> https://coral.ai/products/dev-board-micro
> Not affiliated unfortunately.

Hi Jesse,

As you have added soc@kernel.org to Cc in this series, it made it into our
patchwork instance at https://patchwork.kernel.org/project/linux-soc/list/
and I'll at least reply.

I expect the i.MX maintainers to pick up the patches into the individual
branches in the future, and not keep them as a single branch for your
platform, with the pinctrl and clock patches going through the respective
subsystem trees.

I have marked the patches as "Not applicable" in patchwork because
I don't plan to apply them, but they otherwise seem fine. Please drop
the Cc:soc@kernel.org in the future.

      Arnd
