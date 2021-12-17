Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA36478A74
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhLQLyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:54:12 -0500
Received: from smtpcmd0871.aruba.it ([62.149.156.71]:49388 "EHLO
        smtpcmd0871.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhLQLyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:54:10 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id yBoMmGIqJAiELyBoMmk6vi; Fri, 17 Dec 2021 12:54:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1639742048; bh=Cg6MxKPvLr6Syz/mZJuzyddObRpzBUMOq66KSTVgZcY=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=YsK1gOTHau77ToD4V3DSSMyI7USDTkBZwjl/woPrapr/aTfPHPS0/GTxklvDY8ec4
         Jm1+a2tF0knFjA8/Jx/yNjAIk3WpE4DeAkr58+XhjYn4nxMmBUHj2fWzUWwVI6052I
         e+xTjt7/WaN21gWO7T7lCwQoi0OlwHjZFRcvo+ByNiUL6UlLOklSFoPPgSbZQzxXMc
         dLgBd92UMup1b6Bc9e4CF6dWRCfohLkugosh37uTaJmvkvden7X9le4bd1G1Bf4VbO
         L7LXWJTT1QrasjtS7fa/uj3C16xs4UMTvGYkliZYnToAYR7sKcd+jBlDoOPQz5E1mR
         QorLYS3xfKQrw==
Subject: Re: [RESEND in plain-test] Re: [PATCH v5 0/9] Add initial support for
 the i.MXRTxxxx SoC family starting from i.IMXRT1050 SoC.
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jesse Taube <mr.bossman075@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
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
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
References: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
 <CAK8P3a29tzgd_4WncippZBEJra9n0bQTysBkPBp_WA0sb28gTg@mail.gmail.com>
 <1360c4fe-4a09-a8a1-3224-7f1d4af59f6f@benettiengineering.com>
 <CAK8P3a1oZK1qMRBE3D8otCTY6Lg4jMXxVpAZHQzLTA8woA3_UQ@mail.gmail.com>
 <634e9304-2eba-4ea9-65ac-5d4f5d011b70@benettiengineering.com>
 <CAK8P3a3kpzi6ozLkTH9GtWqvs=JHkm6mp=dLs2vOHjrW=FoYdw@mail.gmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <88f5ec3a-8765-48b2-0429-d182402826be@benettiengineering.com>
Date:   Fri, 17 Dec 2021 12:54:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3kpzi6ozLkTH9GtWqvs=JHkm6mp=dLs2vOHjrW=FoYdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJkrPNgY2+yCcbV01jLFZAj1mqsZnNe8M/nRv60DgHLOmija7PShQ+EryWAp90sIzvVBOOmU9lzp3hN/5wtsXuLUTv/PpOoR3jJE3ByA5PuCx+8ImBF6
 bNNvhhw1qf58KbFLdL+BjpDhoXoFBJlwBgcSb8c2H2lpAUuufgHAfRiAHrka1/R/SampTSjjHwiQlgKjj71a7MoVRj4IPbd4M53DKvluKfROlfQTFJv7UqHM
 ROMGiZEO/UrWyowI8X8RUja+FsHyXMqgFhvmnc2mf5fPJfXjgAABfTU/Tae437yyToK/lMzhSoc8fw7ZWn09WfT7+5vjVeGLsQGPhN29R63yQgC5lh9jSckL
 eNm4oWEFDxh5xbihmqI1SOXV4xLya5KmgiehLCj8U9LPteR1kMPjALtPShU/YgZIewwT0jt92y6tnAtCsgkqwjdkZxA1L1c6MyHhmPYxFW80h6cWExblQhMg
 /aPT/EURA/fgwS4/JgDj/RPiWdIsB3zD857uNDnMzlP9Auq6yr/t0ZnylZ+I7NYjfvAwOZeiNeUxRz5+hhpjW5CBrP/eLegkCl3tTXgwezY6HkM5ikYJE+OS
 v9XT6jlGaKNj0ZJybeUWzGQ9zq32CPNoJPMlTFtxpK2FAEfxXOofQHbTp9umQ367/Ib5L+hZP3SHszgNze0QRSghRq+UZ0VCFQwlm6y9BKOGSYrV1FF2azBD
 UZxPArzt+mvZEja2/thGmIHLhDn3kKsgCsmBzbIpOadwU986xSOaVWqBj9a7s3TG3RMY3OtBPrdvD17mkvOK599Z0P2x18yGxpBXT9WvEMmy+EoGU3Jj1iCR
 0PZNREN2Ia4Xtm9FpftLzuhgeUR1OtuDIqIn+SmjZMbsm8ImNXlfAe2EB0Tu8+RqOMGH831DwHK8CJCdq/06uOaG0bMQB5Pw4xaWZZGThJ5bRLPROHxj7Vuu
 xXm5iaGAzsiwptM6t16hU/4vS0xgpnZmLPGKaPlbXsCiZHI9kpVYoMh4rBbs7MtRjsM3Opiir7z/ZH4fZ5xIB9Skwr5lgVTo/4MPheKkXtLSI6d0Y3rlkowo
 VK6P7nIbxg/7rPJLqPaRtZhw4NoTzOECAWzFqxsCepa0W+o0ZbkkiOJqJJ5Wz/lAStg8Ypm/VM00P4QpuH+qAa/uw2ZANULR0KTElLNKAPibBwRv8rKqpzdJ
 ReshPf2u4Q5p1FV2JBFzWQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/21 11:28, Arnd Bergmann wrote:
> On Fri, Dec 17, 2021 at 10:54 AM Giulio Benetti
> <giulio.benetti@benettiengineering.com> wrote:
>> On 16/12/21 22:13, Arnd Bergmann wrote:
>>
>>> Vladimir has put some work into making Cortex-R work in the kernel, and
>>> he may have some other thoughts on this question.
>>
>> I'm curious if he has something specific to Cortex-R to tell.
>>
>> I've found that Cortex-R82 has a MMU:
>> https://www.arm.com/products/silicon-ip-cpu/cortex-r/cortex-r82
>> but I can't find any SoC that uses it. Also, I don't know how many
>> people could use it honestly.
> 
> R82 is fairly new, but I expect that we will see support in Linux in the
> future. Aside from having an MMU, it also 64-bit-only, so we'd treat
> it like a normal ARMv8-A core in arch/arm64.

Ah yes, that's fine. So let's wait for the future, in the meanwhile we 
focus con i.MXRT :-)

Thank you
Best regards
-- 
Giulio Benetti
Benetti Engineering sas
