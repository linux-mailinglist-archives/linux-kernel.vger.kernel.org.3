Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD52F521003
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiEJIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiEJIyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:54:14 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47EED1B5495;
        Tue, 10 May 2022 01:50:18 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 805DD1C80FD8;
        Tue, 10 May 2022 16:50:17 +0800 (CST)
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 10
 May 2022 16:50:17 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 10 May 2022 16:50:17 +0800
Message-ID: <47b7ec9f-1ed5-642e-5acc-b1398ca31774@nuvoton.com>
Date:   Tue, 10 May 2022 16:50:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V4 3/5] arm64: dts: nuvoton: Add initial support for
 MA35D1
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
 <20220510032558.10304-4-ychuang3@nuvoton.com>
 <CAK8P3a1tbvE+PTB-qy2y7o3_i3VP0zkgMueDy3zBd64BsGKssw@mail.gmail.com>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <CAK8P3a1tbvE+PTB-qy2y7o3_i3VP0zkgMueDy3zBd64BsGKssw@mail.gmail.com>
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



On 2022/5/10 下午 03:01, Arnd Bergmann wrote:
> On Tue, May 10, 2022 at 5:25 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
>> Add the initial device tree files for Nuvoton MA35D1 Soc.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>> +
>> +/ {
>> +       model = "Nuvoton MA35D1-EVB";
>> +       compatible = "nuvoton,ma35d1-evb", "nuvoton,ma35d1";
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
> Something seems to be missing here: you set the console to the serial0
> alias, but that is not defined anywhere, and the ma35d1.dtsi file does not
> appear to define any UART at all. Are you still missing the driver for this?
>
> Please add a more detailed description in the changelog text above that
> explains what kind of SoC this is (maybe a link to the product web page,
> if there is one), and a status of how complete the support is: which drivers
> are already merged, and which ones are still being worked on?
>
>          Arnd

Hi Arnd,

The serial driver is ready 
(https://github.com/OpenNuvoton/MA35D1_linux-5.4.y/blob/master/drivers/tty/serial/ma35d1_serial.c),
but we have to review the coding style and porting it from Linux 5.4.y 
to 5.18.

In the next patch version, I will added a brief introduction about 
MA35D1 in the cover-letter [PATCH 0/5].

Thanks for your review.

Sincerely,
Jacky Huang



