Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94921477AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhLPRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:33:38 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:33337 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhLPRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:33:37 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id xudJmDZ2Fcwd9xudKmYmm2; Thu, 16 Dec 2021 18:33:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1639676015; bh=A8eMZCtxOA9Ba5uPd7vUcY0GtY/sLZiclhzdTw82N8Q=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=S/vw1/ZNYB91iYK4VSL1R4rTuOK3zASjeHdT6Q+hTKNqx65Y4v0QxkyefjnZtl4JN
         Q1juvDREmGhO7JHYaYUOPYE628c42o6Tl1KzmnUgwDuyBq1kQlIbghCIFM3ubPvvGT
         UmbKUzQTUk7DC2/ORtrwQBQD+x0msqTDCR8oLuBfgXQC6H2amlg8WZEXWYodXrLIgU
         XD6ENrq5f4DXFS/+E3KfaxDIT7Pmm3impjViha/r9CRqH1qgK/gF5qOpasyEYqKCFI
         0zdEkWfzqODSdHYJQX5lQQktUrZzkVd0sVgA82g2KvGej9Aq/np8eY8PY997G7Rc53
         p2WGB+cRBQQyA==
Subject: [RESEND in plain-test] Re: [PATCH v5 0/9] Add initial support for the
 i.MXRTxxxx SoC family starting from i.IMXRT1050 SoC.
To:     Arnd Bergmann <arnd@arndb.de>,
        Jesse Taube <mr.bossman075@gmail.com>
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
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
 <CAK8P3a29tzgd_4WncippZBEJra9n0bQTysBkPBp_WA0sb28gTg@mail.gmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <1360c4fe-4a09-a8a1-3224-7f1d4af59f6f@benettiengineering.com>
Date:   Thu, 16 Dec 2021 18:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a29tzgd_4WncippZBEJra9n0bQTysBkPBp_WA0sb28gTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAKLbP6Es9h/dlQpArqdvaYAmRkL+39EPSYjSfBt4bKPMLTLfg/QQqj4PLOESjv/btMzHCOslpjxEiyQIp9bnudTd5MLSzGt5nna0qdrnDKPfDA1Wu5D
 TG5iaTdC2iIplr+Or/i7Qz2cpFSyIA5My6HqtBQ8mGcCIm9bzdzTkhy0k2c2hJLBz/KpuDdDmHoYzZXTobfjRV2ZVTG4xtUKfIzgYm/fzaFuusNZFR0356Gv
 dFr0lCxPG6XFU/2Yi72xA9SOwFzrs6pIsvd6Ru+93WD5DCOfLaJ3XWRmptmbNe+FLFEwo/tL/Bge41BlGenDru2BWjrCYj4gaYpSIcK/hgxGt7UmOivsMVCd
 nmFHYK5sVz8XSZBwbqf8/JwHOA4v26vCAEOLGdNsxrKjmG3OD+7YMofPLkKgl++eNkEq381tXi4Z2g94yvmmwJCXNU4r2P11fSYyZYfoCprAOCW2z1InGLN2
 3cHbNYuvz4QfvPqhttat3bK/lFhYD9bwsYMzVUnyiSvpNx0XG+7PaVrPqgkn8T294miP9eQjAWd9Psm5C37obMSC06cwPWViFFG9ZPv2oqsd6HqtguYUNoIQ
 MC9a5BFtUNpptAwy6o430bIFdVANiaIlqlpsgLsfZwedfDKqCQK6qVrNS/C2ng+oEqNUB3+vtWypssp48tRPqqsxuL/ypuPV9rdjnO+VLwil3YeNVghkfGqc
 h4he/yBBxlkWH2YuXkvwuLfxJ4AXNeIutJU6wQsOYG1Gxd86RvTp7wsAu2eBYujeWEsPwXSapIId/aj7aGdZ1gqUgiMXGXnHNb59Hb1n/DvCWHi57XWcZ6Z2
 nF2dxo4eQ9UTY4LGojYmpHVy2C4vn/DcgwGvNxE3TumDVzEnyLK8M2Hpg9Psdq6gpaZdkAhDy/1D8M30lJ1UZJzAvRpkTSYu45GMrdauscaz2HKzjjj6rE1+
 cF2kRMmb4Zc2FEYQ+Y3LX1KvMpVscIe7UI180M2omrBwKSw1DCGpCBRSB8pp2kkbKuvRjBZCGukk7pyxWPoFnH21C+REKFN1XW27+iuKhNthGfPXH/j/fRmz
 XGfvqgAAfY6uMJdQtzA8wnODk26IcmRMoxvAfcmAlbMgRWhz9RFie2/+VfFNa53GPnEnpW+8S7eY4iWuL3asQLMqR0h+PeZomys=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Jesse, All,

sorry for previous HTML e-mail(I was on mobile phone),

On 16/12/21 09:26, Arnd Bergmann wrote:
> On Wed, Dec 15, 2021 at 11:05 PM Jesse Taube <mr.bossman075@gmail.com> wrote:
>>
>> This patchset contains:
>> - i.MXRT10xx family infrastructure
>> - i.MXRT1050 pinctrl driver adaption
>> - i.MXRT1050 clock driver adaption
>> - i.MXRT1050 sd-card driver adaption
>> - i.MXRT1050 uart driver adaption
>> - i.MXRT1050-evk basic support
>>
>> The i.MXRTxxxx family that could have support by Linux actually spreads
>> from i.MXRT1020 to i.MXRT1170 with the first one supporting 1 USB OTG &
>> 100M ethernet with a cortex-M7@500Mhz up to the latter with i.MXRT1170
>> with cortex-M7@1Ghz and cortex-M4@400Mhz, 2MB of internal SRAM, 2D GPU,
>> 2x 1Gb and 1x 100Mb ENET. The i.MXRT family is NXP's answer to
>> STM32F7XX, as it uses only simple SDRAM, it gives the chance of a 4 or
>> less layer PCBs. Seeing that these chips are comparable to the
>> STM32F7XXs which have linux ported to them it seems reasonable to add
>> support for them.
>>
>> Giving Linux support to this family should ease the development process,
>> instead of using a RTOS they could use Embedded Linux allowing for more
>> portability, ease of design and will broaden the scope of people using
>> embedded linux.
>>
>> The EVK has very little SDRAM, generally 32MB starting from
>> i.MXRT1020(the lowest P/N), although the i.MXRT1160/70 provide instead
>> 64MB of SDRAM for more functionality.
>>
>> At the moment we do not support XIP for either u-boot or Linux but it
>> should be done in the future. XIP will also save SDRAM.
>>
>> Another interesting fact is the amount of internal SRAM, as the P/N
>> increases the SRAM will reach up to 2MB(some could be for cache and
>> some would be for video).
>>
>> Also, some parts have embed flash of 4MB that can be used for
>> u-boot/Linux, if both correctly sized it will leave the SDRAM free.
>>
>> External flash can be Quad SPI and HyperFlash, so throughput would be
>> decent.
>>
>> The i.MXRT11xx series supports MIPI interface too.
>>
>> The family in general provide CAN bus, audio I/O, 1 or more
>> USB(otg/host), 1 or more 100Mb/1Gb ethernet, camera interface, sd-card.
>>
>> All this can be used for simple GUIs, web-servers, point-of-sale
>> stations, etc.
> 
> This looks all good to me now, but the drivers need to be reviewed by the
> respective subsystem maintainers before we can merge it into the soc
> tree. As with other new SoCs, I'm happy to merge the support as a combined
> pull request that includes the drivers provided that the driver subsystem
> maintainers have reviewed them.
> 
> Ideally the i.MX maintainers would pick up your series into a separate
> branch and send that to soc@kernel.org the same way as the other topic
> branches that are usually split out between DT, drivers, soc code etc.
> 
> With the Christmas break coming up, the timing may not be sufficient
> before I'm off next week, so it may end up too late for 5.17 but should
> be fine for 5.18.
> 
> As a more general comment, it's always nice to see newly added SoC
> platforms, especially when they are this well implemented and done
> by hobbyists. However, I do think you are being overly optimistic
> as to how useful this is going to be to other people: interest in NOMMU
> ARM platforms has dropped a lot over the past 5 years, and as far as I
> can tell, it is only being kept alive for existing stm32 customers
> as the economics do not favor Linux on Cortex-M for new products
> compare to Linux on Cortex-A or some RTOS on Cortex-M.
> 
> The existing users will inevitably stop updating their kernels at some
> point, and then it's most likely just you and Vladimir Murzin that care.


About this will you accept support for the other SoCs in the family?
We would like to add in the near future:
- i.MXRT1020(uboot support is already upstreamed)
- i.MXRT1024(almost equal to 1020)
- i.MXRT1060(almost equal to 1050)
- i.MXRT1064(almost equal to 1060)
And
- i.MXRT1160/70 new family with faster core clock(1Ghz) and a cortex M4

We need to add missing lcd(uboot upstreamed), usb(uboot upstreamed), 
ethernet(wip) supports for i.MXRT10xx family.

This is to organize with Jesse also about buying evaluation boards and 
timing.

We’ve meant this porting also as an exercise to deal with Linux deeper 
for us and for the other newbies.

We’ve been also asked about a possible support for s32s(quad cortex-R52) 
on initial emails but it has no mmu too.
While I’m seeing that some cortex-R is landing inside Linux.
Would it be interesting anyway?

Best regards
—-
Giulio Benetti
Benetti Engineering sas
