Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91C49354F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351958AbiASHSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:18:21 -0500
Received: from smtpcmd14161.aruba.it ([62.149.156.161]:40320 "EHLO
        smtpcmd14161.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbiASHSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:18:20 -0500
Received: from [192.168.50.220] ([146.241.178.108])
        by Aruba Outgoing Smtp  with ESMTPSA
        id A5EWnaozcNVvLA5EWnhZOS; Wed, 19 Jan 2022 08:18:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1642576697; bh=mJN2JzB66nhzQ/3dLiZz1vk067KP4+Y0QiJnGlWs43w=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=kT7f0RNpEyFgKoct160Th8nr5N7jy5yk+An5U97QHYIWmI4O+BYpFqDk6zhinBqBa
         3nrRkicW64KbVpfJY2W7yZyj9AW6Q5jmNYlJOfuFkQTJrny6PxiFSZaQvcmMtJfXZi
         gIPLE0xqqGoRbmCvOiqd/Ck95WTrbLpkwjYo5jAVk7QehcGssQc/L/xHpuaD260b0I
         RVlRgE/JEbRwX4llXAztV9/1IgWWoxkMJ41c4I3WEZgJ/Lo3QeqrbdsLmMLz9JwFZT
         kLmBllVCsGQoz8HqSq9oxHh0TAz6m0vdS5xsObFGFB6glzT1ntcqj5qHQYgY5GSxTb
         Vk30DeEtlDaYQ==
Subject: Re: [PATCH 0/7] Fix wrong static ip autoconf in some dts and
 defconfig
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <15227efe-0a85-b36d-41dd-28b93e3d35b3@benettiengineering.com>
Date:   Wed, 19 Jan 2022 08:18:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211102235456.710617-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOWKvyd8chqFGfnfQ8iHIc7WmNyH2l7dxsRKNKk2ldRelx9vHYvzURLnUyjIz2fc/WU8I+UrjBf6Cdp4QiOHO7Z6OsVikwvCvgEvQZ523O68rSMhZUt5
 G5j5f7X1P7thcK9ge5aTTkLOlszSQCKlOJHfp9lnhd9KaUaxWyUOVQS84Inm6H7Zon/Z9cwzcXLhD8CH3nPEYBBhFLNKEOkyMGLCpq8x/ZeBtlJA8J2l36jj
 OJzHfQmZpPVBMZJAELZCHqfibUNHamoQOfcvxRcLQhENni8gIdztFwsP3ysTFzTthzqEWof76wDAnzCOI5Oma/ShOJ4JU7tSQfLP6w9grUkKHAn5Mih1Kemk
 JeMJd2mfTcX6A6jgD2JhXSPMxUBBz2ekxHyszCCEWlzw5CCGpMy/opWOnrG2eSpEyqM/XCESKF6foyJq74XpfvdJEhFdHLsnbRaq81HYgF0tCt8yeo5tahjZ
 oOtsnXBr7eaxLvNCFWvT0C+A39k67k8aKy0Pc3a/xFNTlqsnjBZChtMyvxO2fHUq0weeg8YKCnHBkltlle3UVBtCptxwxT/I9Nnc/BTWL0bT+aXkF+Q+jkfM
 Uk48hp8aoPE1E+CTN7894flif4dAWn79MDi/jgVlUmo6YsiZXabO6VpwVlx2GZdkocA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

kindly ping,

On 03/11/21 00:54, Giulio Benetti wrote:
> While trying to have a working nfsroot through RNDIS on sunxi I've found
> that in bootargs <autoconf> must be set to 'off' to use a static ip setup,
> but I've also found that the following boards have it set to 'on' that is
> not the <autoconf> setting for static ip as stated here:
> https://www.kernel.org/doc/Documentation/filesystems/nfs/nfsroot.txt

the documentantion states "<autoconf> must be set to 'off' to use a 
static ip setup"...

> And most of all on sunxi RNDIS it doesn't work as static ip nfsroot.
> 
> Unfortunately I don't have such boards to give a build and a test, so if
> there is someone who could give a try it would be great.

...so I don't even think it really deserves a test IMHO.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> Best regards
> ---
> Giulio Benetti
> Benetti Engineering sas
> 
> Giulio Benetti (7):
>    ARM: dts: mmp2-brownstone: fix wrong static ip autoconf
>    ARM: dts: pxa168-aspenite: fix wrong static ip autoconf
>    ARM: dts: pxa910-dkb: fix wrong static ip autoconf
>    ARM: mmp2: update mmp2_defconfig to fix wrong static ip autoconf
>    ARM: pxa168: update pxa168_defconfig to fix wrong static ip autoconf
>    ARM: pxa3xx: update pxa3xx_defconfig to fix wrong static ip autoconf
>    ARM: pxa910: update pxa910_defconfig to fix wrong static ip autoconf
> 
>   arch/arm/boot/dts/mmp2-brownstone.dts | 2 +-
>   arch/arm/boot/dts/pxa168-aspenite.dts | 2 +-
>   arch/arm/boot/dts/pxa910-dkb.dts      | 2 +-
>   arch/arm/configs/mmp2_defconfig       | 2 +-
>   arch/arm/configs/pxa168_defconfig     | 2 +-
>   arch/arm/configs/pxa3xx_defconfig     | 2 +-
>   arch/arm/configs/pxa910_defconfig     | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
> 

