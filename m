Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FC647346B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbhLMSzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:55:53 -0500
Received: from smtpcmd15176.aruba.it ([62.149.156.176]:43333 "EHLO
        smtpcmd15176.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhLMSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:55:52 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id wqUEmOI9uz3hmwqUEm7d6Y; Mon, 13 Dec 2021 19:55:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1639421749; bh=Cb8yDKe+vKl1iJIq7lyfihTS5kSTk9qVqiQ2TP9bKF0=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=MZ5tsXl45hVfQziw4jd0nMMP2wL7noXBbFtUEMuoL7ZimqHLAra4JKxeB5lpu77sn
         1g88864uAndW1V+oa5Tv+YsofEn30xfCWTWDwZpox5gxZt7BA7jGEaBhLu/0w3uWMO
         G6HLEID4rWdLX94zR91E5tpy/TEdQQutiVe+npVgaoVEeYkzkjpQQjjfNd+QE5Ap8z
         95TjI1uZj4nog49abAeseaChfIBZ0zuKT899+oNy3ACKQfxawkkKsxOZKaPyDcnnrK
         MEkCn73Sa7euX/+gR02oXb8IAtzRG+lMo+2pz6ZfiOD2DxNB800UYfPDcA6HjuZyuE
         U+JtUEbu4OVDg==
Subject: Re: [PATCH v4 06/13] dt-bindings: clock: imx: Add documentation for
 i.MXRT clock
To:     Jesse Taube <mr.bossman075@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-imx@nxp.com
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ulf.hansson@linaro.org, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, adrian.hunter@intel.com,
        jirislaby@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
 <20211204061042.1248028-7-Mr.Bossman075@gmail.com>
 <20211206223849.554F6C341C6@smtp.kernel.org>
 <9dab64ca-0d91-3bea-f873-3c2da6ef1645@gmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <08719926-e550-c401-bf9a-4fa161062afe@benettiengineering.com>
Date:   Mon, 13 Dec 2021 19:55:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9dab64ca-0d91-3bea-f873-3c2da6ef1645@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLyqWYqoqNtgmolppAqUYOcTI+ioV02UCgPm3Ar5zGAo8hDVSujJh1zalj+zthf+Npu0j52doK1X+8VEUqn4ktLzPCvWWPMx4AjPvjnhU/ldZn+kJF4I
 gKBe9PBC2q5hHcmd5xg2Cvyo4s51glbHSbregp7Jo/HOXy+HlZ0VOZOt1AfhGqYftDiIi94AGpUNiLivmPsQEhwyMYxKUnfKvc2bKC23cjH9xJLqE6+H8LsB
 Ct44a13pr4YidE4nm2xznmlOTMnsmb8kMfeJJV/UTO2xaHO/ypOnrwV/d9gwXlrRwA+Gw9D3pZGKARngC3jYnNEUxraGnq5kBeNPPjI1HTvlE2u3qVdzQmcZ
 fZHQovdAERxYiq3/ehYkmc7a4aw8LUTWDTN+NobfPI9w6/3xZmLdZXksiqOo5R2i6oj+Y9ClI6Y9ghtvmj5ERT/uTbjo0e8kHlmCBoLXvh7h6z7V77a9UbfD
 Ac4iv7ra6vr4w+VTc7Rk1NWAWL0FyyZGIQ1P02fXy4kopRxPErO5hBnB4tmlkaql5leG5TMEIdNcu1DR/J4gzsOZ4tbPzY3+VeZSOjxm+VUgQrA76BquDp/n
 8UUHMcs13rhHaQEuxmmGiCXq2SvUaeoYno11WHYdAz6PJqiQKQsod+AwT956LL6foU0NXVhCN3Ye4B0Z0m+ehZ6o2LA2Mtwl7BZog/KtqnuIvtXJ3icg/uzf
 mUNqvVRo4UqxuSghAOlTXBx1+ROA0kG6npWvTtSLyKwjx9KHUWwXNhCBtRZYNtg/25GTI2MFpYDfF+XjYrQP/Y6iwUPjuEkr+6VaBTo6kIIM2EXjufosOm4j
 U+iHFW1hHAz3Ag29EY4Zxg7Wr3PrLeagSp48NfdIhVgm37dbZPzvPHGhTDJCmGKIFiNErG00qbw7hyVovD+s+OQUdtaGSzOKFmGEdv7DOqmy87rdLFowuPYQ
 fbpii8ZP8jooWjvFKpSft0yJanQCNVySJAuP5MBT8fiVbnnhJB2KhTP/lw1Z2yTKUIh7AM7UMYL9re4/J0lyLWhMXUG1CW8E9Oy4hV3oLwZDKZ/7iGf4MQsW
 qtmdkN8kpmh4+8FPblpO4LAXaFUsWP2BzRp5h6V/NUlAgvSF0vBTjDjfbYybuC71vCyMIdR++Q6BX/9Y9CDnEgbyJN2BpSAiPohL5cMeka7L2sbnt8tcZ6rI
 vE60pXeh9Ivqx/lzEKLXBg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On 07/12/21 03:32, Jesse Taube wrote:
> 
> 
> On 12/6/21 17:38, Stephen Boyd wrote:
>> Quoting Jesse Taube (2021-12-03 22:10:35)
>>> diff --git a/Documentation/devicetree/bindings/clock/imxrt-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt-clock.yaml
>>> new file mode 100644
>>> index 000000000000..8af48c59ff99
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/imxrt-clock.yaml

here the file name should be imxrt1050-clock.yaml

>>> @@ -0,0 +1,67 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/imxrt-clock.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Clock bindings for Freescale i.MXRT
>>> +
>>> +maintainers:
>>> +  - Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> +  - Jesse Taube <Mr.Bossman075@gmail.com>
>>> +
>>> +description: |
>>> +  The clock consumer should specify the desired clock by having the clock
>>> +  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imxrt*-clock.h
>>> +  for the full list of i.MXRT clock IDs.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: fsl,imxrt1050-ccm
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 2
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>
>> Why minitems vs. exactly 1 for osc?
> because i don't understand yaml yet.
> I'll look into this.

on clocks and clock-names you have to specify the only available clocks 
that can be an input to ccm, in our case only "osc", which description 
will be "24m osc".

Check this file as reference:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml

Kind regards
-- 
Giulio Benetti
Benetti Engineering sas

>>> +
>>> +  '#clock-cells':
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>> +  - '#clock-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/imxrt1050-clock.h>
>>> +
>>> +    ccm@400fc000 {
>>
>> s/ccm/clock-controller/
> 
> This made my day!
> 
>>
>>> +        compatible = "fsl,imxrt1050-ccm";
>>> +        reg = <0x400fc000 0x4000>;
>>> +        interrupts = <95>, <96>;
>>> +        clocks = <&osc>;
>>> +        clock-names = "osc";
>>> +        #clock-cells = <1>;
>>> +    };
>>> +
>>> +
>>
>> Nitpick: Drop extra newline
> sorry will fix.
>>
>>> +    lpuart1: serial@40184000 {
>>> +        compatible = "fsl,imxrt1050-lpuart";
>>> +        reg = <0x40184000 0x4000>;
>>> +        interrupts = <20>;
>>> +        clocks = <&clks IMXRT1050_CLK_LPUART1>;
>>> +        clock-names = "ipg";
>>> +    };
>>> -- 
>>> 2.34.0
>>>

