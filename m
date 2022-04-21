Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F95097D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385069AbiDUGp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385061AbiDUGos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:44:48 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25EE913F86;
        Wed, 20 Apr 2022 23:42:00 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 50DAE1C810D0;
        Thu, 21 Apr 2022 14:41:59 +0800 (CST)
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 21
 Apr 2022 14:41:59 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 21 Apr
 2022 14:41:58 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 21 Apr 2022 14:41:58 +0800
Message-ID: <d24391c8-6153-d835-b17a-a013ed2c55c8@nuvoton.com>
Date:   Thu, 21 Apr 2022 14:41:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/5] arm64: dts: nuvoton: Add initial support for
 MA35D1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ychuang570808@gmail.com>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <will@kernel.org>,
        <soc@kernel.org>, <cfli0@nuvoton.com>
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-4-ychuang3@nuvoton.com>
 <60e50c11-118d-431f-7120-95fcbb53eeb5@linaro.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <60e50c11-118d-431f-7120-95fcbb53eeb5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/18 下午 08:20, Krzysztof Kozlowski wrote:
> On 18/04/2022 10:27, Jacky Huang wrote:
>> Add the initial device tree files for Nuvoton MA35D1 Soc.
>>
> (...)
>
>> +	gic: interrupt-controller@50800000 {
> The unit address does not match first reg property. Don't you have
> warnings with this?

Yes, I will modify it as
gic: interrupt-controller@50801000

>
>> +		compatible = "arm,gic-400";
>> +		#interrupt-cells = <3>;
>> +		interrupt-parent = <&gic>;
>> +		interrupt-controller;
>> +		reg = <0x0 0x50801000 0x0 0x1000>,
>> +		      <0x0 0x50802000 0x0 0x2000>,
>> +		      <0x0 0x50804000 0x0 0x2000>,
>> +		      <0x0 0x50806000 0x0 0x2000>;
>> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
>> +			      IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +};
> Best regards,
> Krzysztof

Thanks for your review.

Jacky Huang
