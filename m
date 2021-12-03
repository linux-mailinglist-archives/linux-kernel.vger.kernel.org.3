Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB144466E72
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbhLCAYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:24:21 -0500
Received: from smtpcmd0987.aruba.it ([62.149.156.87]:37490 "EHLO
        smtpcmd0987.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhLCAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:24:21 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id swJnmyXe7q3qKswJnmEwWe; Fri, 03 Dec 2021 01:20:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638490854; bh=2LjACOrDxyh4Vq04KPQqLKnV2CuYf0EUGRxt70YYlQQ=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=ebYXG4DJCu9IT3vvPgCkpAJS2wtdXKhkE7YzEmLq67Yg0OQp9Fu/f1FOjrnn4mzso
         GjK0AFpGP/n2qXdPSzkeOHvFgFulNb/8sWdFsKV5AsRlhNz6yPS0sBjrCTwTmeFy4q
         UyydFPOsVemUJmb1BMYK44O35NmAEozHWIxfjKMXKG5vRbfqspwFPuHls84u/yGaM9
         NUQgCOgr1m/oQQzsbbJDX9Vhj4MXmXCx5HAzOlgPhb3DpZJBoj79Y75TrHQcIjbjMD
         Qh3r2x5TIvzkO94SuAfVQppvF0rC4Mom8bDjP+LKOwDRRjvT0PteHHxkyIn0u9BWAU
         vyjloNBhrLg/A==
Subject: Re: [PATCH v3 12/13] ARM: dts: imx: add i.MXRT1050-EVK support
To:     Rob Herring <robh@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
References: <20211125211443.1150135-1-Mr.Bossman075@gmail.com>
 <20211125211443.1150135-13-Mr.Bossman075@gmail.com>
 <YaOxu441l41qPvTj@robh.at.kernel.org>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <c488ed94-ad0e-a326-adda-c4d782dbd6ef@benettiengineering.com>
Date:   Fri, 3 Dec 2021 01:20:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaOxu441l41qPvTj@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK8Tdp5T8tvvNmUT9UohQNCeGYnR9anIwxRjKM+y92PDZdL/7HkbCiy6B2m0+SCOO4s5E5LaPzSkdeQvV6Xn9LlcdR0ZzyFCRw4gOntPgC3rx5wfYna1
 Ce3Q7eNiM9qhi1JGlE8GLRmv3N3jDfKwIFQ6gDozWSI3X/9ayBxnXpbsNCKxdyPj/DR1Pv4BbMlEdOSN4nypGyJqovucliUq/snrle2ja+qgjSAA72hYSa6I
 mq66Jmj1S7hGpd/AEIjU+xSjdOOKxS+Do/lrjRQVuPOiEBl8A5/iSQHNC0uiX+CxFl5bcS1YH8MQQx5WdjzGE1GG47CfwDajLgcF9WJFkgTgZ5evEmQ1UCHO
 vi1zGYr9AQRy0LzlChz6SL5y5U3ivQL+L+nErv1iCTJj43gl2hdodzVMDh2jmdEAJy9GRzzl3exPrT+VKMQDURH0Uyv2jbAXGxBP1W76oy+bDeIJ0VXzXEzw
 j4qUPk2YSPJWtFNtKFPZm6zU1JO2+h8RcJPerlnhHAvpT731hKOMcukiGP6s8WUJ75ZfCFiK3iHuhbDoWh4D3wBszJ9iLDtJjViIBCVOjblUL5VKpavZ69DD
 CdHmyB2ST/8oWivEFKzgS0VOQmsxxAqXPLsOKxjMQwVX048FbISdBxwSXVq8UgI9muy9nFYrFb2YwckQRhmDkdiy07wHqNeJClZHiUlwS09NcC7rDVoO9y1A
 SGiiBDhB8TBAYb/ctDvDTzPagKmZj/D2dpUiAigXdrN0t229QFaWCghi+TQJDNC/IbqM/rlRf0OGb9QxOmYuboIOPMI+K4dzap11j+kSxBXXSn8PuskeaFsA
 hozZ8GIen728YS9Rx+grG55BvQzOZAN5+d5jvIHfJeSIduVyBQDilw9bMbkTqqUoU4qXRM3mYPSFvdrCVddlHS+DLc765Q7p9zOLRBj3RSkkPbt8Fuz4AMuR
 xlAg7kV9nw5f+EUZ+QbhHt1w00NWBSS4uNO0PL3eEuUzIE3iB89HVHLP71NEfvcmyY9OUYzh/CZgih9g+PN4rKoxMRLKHAY27x9ZtlaeDBPXKksHbBWagQSL
 Pq6UzehbAQcm15FzeeXZIJcTnYP0xBBdxGmMznk/5c3ExHHBRj5Tf2ZCWrI1dfCjEWTa5BT/Zo1ka9GlY9i4RJbb7z/92TOCzxY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Jesse,

On 28/11/21 17:43, Rob Herring wrote:

[SNIP]

>> diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
>> new file mode 100644
>> index 000000000000..35943a6896fa
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imxrt1050.dtsi
>> @@ -0,0 +1,165 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2019
>> + * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
>> + */
>> +
>> +#include "armv7-m.dtsi"
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/imxrt1050-clock.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
>> +	clocks {
>> +		osc: osc {
>> +			compatible = "fsl,imx-osc", "fixed-clock";
> 
> fsl,imx-osc is not documented. IMO, just drop it.

Regarding this ^^^, you're right, so we avoid to add "fsl,imx-osc", but 
at this point, does it make sense we create a patchset to remove it from 
the other .dts(i) files that use it? And same goes for "fsl,imx-ckil", 
"fsl,imx-ckih1", "fsl,imx-ckih2"?

I see that those try to repeat the name of the node itself so they are 
useless. If you say so I send a patchset for that.

Thank you
Best regards
-- 
Giulio Benetti
Benetti Engineering sas
