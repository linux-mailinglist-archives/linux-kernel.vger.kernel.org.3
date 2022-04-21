Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB435097C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384960AbiDUGmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384922AbiDUGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:42:23 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 521F3E0A9;
        Wed, 20 Apr 2022 23:39:33 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 089D01C810D0;
        Thu, 21 Apr 2022 14:39:31 +0800 (CST)
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 21
 Apr 2022 14:39:30 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 21 Apr 2022 14:39:30 +0800
Message-ID: <caf4867f-7f71-9262-f190-463325eb13ab@nuvoton.com>
Date:   Thu, 21 Apr 2022 14:39:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 5/5] dt-bindings: arm: Add initial bindings for Nuvoton
 Platform
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ychuang570808@gmail.com>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <will@kernel.org>,
        <soc@kernel.org>, <cfli0@nuvoton.com>
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-6-ychuang3@nuvoton.com>
 <fd9316a6-7df6-e1fa-50dc-ff50934afb5c@linaro.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <fd9316a6-7df6-e1fa-50dc-ff50934afb5c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/18 下午 08:11, Krzysztof Kozlowski wrote:
> On 18/04/2022 10:27, Jacky Huang wrote:
>> +properties:
>> +  $nodename:
>> +    const: '/'
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - nuvoton,ma35d1
>> +          - nuvoton,ma35d1-evb
>> +          - nuvoton,ma35d1-iot
>> +          - nuvoton,ma35d1-som512
>> +          - nuvoton,ma35d1-som1g
> This does not match your DTS and does not look reasonable (SoC
> compatible should not be part of this enum). Check some other board
> bindings for examples.
>
>
> Best regards,
> Krzysztof

I would like to modify it as follows:

description: |
   Boards with an ARMv8 based Nuvoton SoC shall have the following
   properties.

properties:
   $nodename:
     const: '/'
   compatible:
     oneOf:

       - description: MA35D1 evaluation board
         items:
           - const: nuvoton,ma35d1-evb
           - const: nuvoton,ma35d1

       - description: MA35D1 IoT board
         items:
           - const: nuvoton,ma35d1-iot
           - const: nuvoton,ma35d1

       - description: MA35D1 SOM board with 512MB DDR
         items:
           - const: nuvoton,ma35d1-som512
           - const: nuvoton,ma35d1

       - description: MA35D1 SOM board with 1GB DDR
         items:
           - const: nuvoton,ma35d1-som1g
           - const: nuvoton,ma35d1

additionalProperties: true



Thank you very much.
Jacky Huang

