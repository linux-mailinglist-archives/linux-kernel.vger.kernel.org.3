Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64429478837
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhLQJyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:54:51 -0500
Received: from smtpcmd0871.aruba.it ([62.149.156.71]:38717 "EHLO
        smtpcmd0871.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhLQJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:54:49 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id y9wmmE4RXAiELy9wmmiOfW; Fri, 17 Dec 2021 10:54:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1639734887; bh=SZpxkK7voOVV6I9udbetrLHOGGCCs8Xt0yuASUFvYww=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=VYOwqyw+gYObPpq5d0SwF1zxdtyJ2bR9+h9nHOW/BpYCwPu1u9f58uB9lioNjxORH
         upzt4BP8Mvma18ZqTivxKzdDyUCmxS7s/K2Wn08QgSXpFqdhzoBEFt9Kw8fu1qUgHF
         NlhFcMQ7YnEwP9w83AJmAOOZxUNW+YZesus1sDPJFa9a45jbIXpnHKiFnH5ofs0cCx
         nl1Lwnz8DRV0/rY6P8pvnEVNrONfvJT2Bxo30LOHiC60PCIQbRo3CVBN1Iu8rkkpFm
         oorf/K9I1O29cIOar84O3jC2clxKj8uMOCaonhoVd1D5nnI8H44nKPWlhqXbLPpDxM
         TZrkcOMYdzh3w==
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
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <634e9304-2eba-4ea9-65ac-5d4f5d011b70@benettiengineering.com>
Date:   Fri, 17 Dec 2021 10:54:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1oZK1qMRBE3D8otCTY6Lg4jMXxVpAZHQzLTA8woA3_UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCO5ZxBkSOe6VyonaZaERyIFPW9nQXKE7kgm/BIFTSsLWOxmM3ufVMlenl7VhAwO/hNSogkLP9ETYHuxlCP8ovNM+DsknmjkKeRS6OoClIrA/Cje3uBR
 iUktLT8tvgvm3O5Zmac+WtEVC/ukanqHnUyB00NA4bFw6753FaUxo/FOZtlp5KPYOkFGIWPNFwt96L2n1J7AH1rcyZbkOaTt+Z59xYp60J1se8IO1kXxkzEM
 et3ySZ4h6VK+MhuKaI3+drInuvkSbbiCIAVNfFuWEf1PiMiwDn537NT9WDQD208VrLZkfdm2t0ZB5vTMWj4We/mpRQDQmyV8c3N70B0UyHih0BJjzNMQVPo0
 Ydt6oz8csA0Vgqbc0m0KuDARJojBOe7GIzu9nwHYr3qhRFcyKR4OQZ8UFABASZ3C96D0p/1ALHmYzSs0IWOPAb60+3HGp1lDrO9BjMHvcM4T0vc29jOBw0UL
 veqYMBar0zXMBY6FREn2I+MswhfeMG4EmwE2hAj/wPXTlpiRpJ33nh4TKnxc9PEsY7cfKrLBRFW18bhJj15CHCGHihVV/+/RUwKHY6zPFJCj0iq6gMYwJfDm
 loYYHz6P1Ya0G77HVeGL4f0yUWMR8Xitrx/o/G7jRiwooqIhAyctSvquOcpjuN6H2EajrnzdxwGCJokRX3xOjYzXPEhCap18dec3z6oLaeswj+FksC/mwqOf
 hZfTT4ohICqxAz3RNQMVUpNcVFNI8Ggp2sq51fP983x2r3v4fgM9DmqBqrAgjp1TB89ieG0J5ybGNiMVysjrrqtOM6+uBqWRHrOG9NPjoBsyH2N+Q4SWJnJh
 5+XzBQwJF6VLbNDw10MJQmpaXjKAc9pwIP8RqByFSUeAJKVr0hPsXKEn8Ga6QrR6g3fnbjpou7uq9d8HhzfNRpsozQMF23rS9wWSU3m9SCrEldyMIVuk+iUk
 fVUu8U63Eflmn80WncPSUwRiIfvxDvNGfvhAu/IMI2xDw+5XnkOPKU33F6A0j9K/dfiTTonoJZtAuy/eVfdaKzW3uievQ/Kx66D49emKSU37TYYVS/nKiDgs
 E1iakE8DA7DplABPwW/yjgiXFwwF/MW+93IOac97O7zTLRChCS2gZwNAao2gxXMhoEMag7fxWNT3aZ/eIT5BxBjG8SExyN3qqPIsNosVYVr7SnFdaxAjF3Nr
 rMeXuCZwap3Q0w5jOUMa5w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 16/12/21 22:13, Arnd Bergmann wrote:
> On Thu, Dec 16, 2021 at 6:33 PM Giulio Benetti
> <giulio.benetti@benettiengineering.com> wrote:
>> On 16/12/21 09:26, Arnd Bergmann wrote:
>>> On Wed, Dec 15, 2021 at 11:05 PM Jesse Taube <mr.bossman075@gmail.com> wrote:
> 
>>> As a more general comment, it's always nice to see newly added SoC
>>> platforms, especially when they are this well implemented and done
>>> by hobbyists. However, I do think you are being overly optimistic
>>> as to how useful this is going to be to other people: interest in NOMMU
>>> ARM platforms has dropped a lot over the past 5 years, and as far as I
>>> can tell, it is only being kept alive for existing stm32 customers
>>> as the economics do not favor Linux on Cortex-M for new products
>>> compare to Linux on Cortex-A or some RTOS on Cortex-M.
>>>
>>> The existing users will inevitably stop updating their kernels at some
>>> point, and then it's most likely just you and Vladimir Murzin that care.
>>
>>
>> About this will you accept support for the other SoCs in the family?
>> We would like to add in the near future:
>> - i.MXRT1020(uboot support is already upstreamed)
>> - i.MXRT1024(almost equal to 1020)
>> - i.MXRT1060(almost equal to 1050)
>> - i.MXRT1064(almost equal to 1060)
>> And
>> - i.MXRT1160/70 new family with faster core clock(1Ghz) and a cortex M4
>>
>> We need to add missing lcd(uboot upstreamed), usb(uboot upstreamed),
>> ethernet(wip) supports for i.MXRT10xx family.
> 
> Sure, anything you want to work on supporting can be added to the kernel,
> the important bit is that it's well written and can be maintained going forward.
> 
> My best guess is that we'll end up ripping out all NOMMU support in
> a few years, when we get to a point when both of these things happen:
> 
> - the number of actual users that still update their kernels becomes
>    really low
> 
> - There is some treewide refactoring that isn't easily supportable without an
>     MMU unless someone puts extra work into it.
> 
> At the moment, we still support NOMMU kernels on a bunch of architectures
> (Arm, riscv/k210, sh/j2, m68k/coldfire, xtensa and h8300). Out of these,
> Arm is by far the most active, and if Arm NOMMU support was to go away
> for some reason, the others would likely follow.

Ok, I understad now.

>> This is to organize with Jesse also about buying evaluation boards and
>> timing.
>>
>> We’ve meant this porting also as an exercise to deal with Linux deeper
>> for us and for the other newbies.
>>
>> We’ve been also asked about a possible support for s32s(quad cortex-R52)
>> on initial emails but it has no mmu too.
>> While I’m seeing that some cortex-R is landing inside Linux.
>> Would it be interesting anyway?
> 
> I brought that up during the initial review, but I think this is even
> less interesting
> than Cortex-M support from the perspective of potential use cases. While
> Cortex-M MCUs have some advantages over larger SoCs in terms of
> power consumption and cost, this is generally not true for running Linux
> on Cortex-R. The Cortex-R and Cortex-A cores are closely related, so
> they tend have similar power/performance/area characteristics, but
> the lack of an MMU makes the Cortex-R much less useful. If there was
> an advantage to running with the MMU disabled, you could actually do that
> on a Cortex-A as well, but clearly nobody does that either.

Yes

Thank you for the answer

> Vladimir has put some work into making Cortex-R work in the kernel, and
> he may have some other thoughts on this question.

I'm curious if he has something specific to Cortex-R to tell.

I've found that Cortex-R82 has a MMU:
https://www.arm.com/products/silicon-ip-cpu/cortex-r/cortex-r82
but I can't find any SoC that uses it. Also, I don't know how many 
people could use it honestly.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas
