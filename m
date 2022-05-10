Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E21520FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiEJIog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiEJIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:44:34 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B5F02A1509;
        Tue, 10 May 2022 01:40:37 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 9532E1C805AF;
        Tue, 10 May 2022 16:40:36 +0800 (CST)
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 10 May
 2022 16:40:36 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 10 May
 2022 16:40:36 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 10 May 2022 16:40:36 +0800
Message-ID: <d64f260d-8ee6-808a-5725-e1181f104dfe@nuvoton.com>
Date:   Tue, 10 May 2022 16:40:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V4 0/5] Add initial support for MA35D1 SoC
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        <ychuang570808@gmail.com>, "Rob Herring" <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>,
        <cfli0@nuvoton.com>
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
 <CAK8P3a1k8y8U99bBmqBYE1vYAc0q-UeaM0oLP4tTHZCpyYNOgA@mail.gmail.com>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <CAK8P3a1k8y8U99bBmqBYE1vYAc0q-UeaM0oLP4tTHZCpyYNOgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/10 下午 03:07, Arnd Bergmann wrote:
> On Tue, May 10, 2022 at 5:25 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
>> This patch series adds initial support for Nuvoton MA35D1 SoC,
>> include initial dts and clock controller binding.
>>
> This looks fine in principle, but we are getting close to the merge window and
> should finalize this quickly to make it into v5.19. I see that you don't have a
> console device, as commented in the .dts patch. Normally I prefer merging
> platforms only when there is at least rudimentary support for booting into
> an initramfs with a serial console, but this is a flexible rule.
>
> As with the changelog text for the .dts file, please explain in the [PATCH 0/5]
> cover letter what the status is.
>
> Regarding continued maintainership, we should discuss how you plan to
> maintain this platform. In particular, there should be an entry in the
> MAINTAINERS
> file for the platform, either pointing to yourself, or adding it to the  NPCM or
> WPCM450 entries if this chip is in the same family. Is this also a BMC
> implementation, or is it something different?
>
>         Arnd

Hi Arnd,

Thanks for your review.

MA35D1 is target at consumer application, while NPCM is for BMC.
MA35D1 is equipped with ARM Coretx-A35 dual-core with the M4 co-processor.

Our team has developed Linux application on MA35D1 test chip in the last 
year, and
the mass production version is wafer-out in last month. It will be 
announced soon.

We have ported TF-A, U-Boot, OP-TEE, and Linux 5.4.y to MA35D1 platform, and
have provided Yocto and Buildroot distribution for beta site evaluation. 
All the source
code can be found at https://github.com/OpenNuvoton/MPU-Family, include the
Linux 5.4.y porting on MA35D1 platform.

Yes, we have console device driver ready. Please refer to 
https://github.com/OpenNuvoton/MA35D1_linux-5.4.y/blob/master/drivers/tty/serial/ma35d1_serial.c.
But I think we have to fix coding style and have more review on it. Is 
the console driver
must for the initial support submit, or can we submit it later?

And thank you to remind us to create an entry in MAINTAINERS file. I 
will add
the patch in the next version.

Sincerely,
Jacky Huang


