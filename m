Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D389446D0A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhLHKNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:13:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15304 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLHKNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638958218; x=1670494218;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y6oYwfVK4H1EdFEveLnJz6XsiGqlKM/VYn5RyroBPTk=;
  b=jo8j/WuS85cEjvHL7yK3TKEZboIWdDs/hM+53H0vh47ctfyGB81wj72s
   ibHjrqSYwlL9DuiqOO1MAGE2npsZRnoPLMwDAvvVLkjGZoz7ouMcl9VwP
   ab0cmy0wEDW3UkH9Ufmjhub88jH/RnT+yDUYlObNNB9JUDEC9TRZvlZQD
   +gX25IFYtYxbvOiitdCKkmmjSDA5ZUzmm77AZHBKKbAKZQzRZJ+XxImPZ
   bNcv0JxxjwZUM9PQw/tXvRIGOUUO9gZk7KddJewcib7gs2EIgKW6Y6LhD
   y88e28xofg3iCGcmXi4U51FfXySlPkWdqvEIDPOjSkOUZcX4AMZHeqFpt
   g==;
IronPort-SDR: mjMxSwesKdPjM8WUO4voYhArBV0e5rGacEZq2dDJ0egjKr/cYVo9ktKlmIxLOWHKMayHPx0TpE
 /DhJrem8Xwly24lLLJwFxbsMsRBjki95S8KXsTYMD3JsQGTkgClLa48g4wYIxQEX9UZ/iKNBon
 +LLQXwhMIX6P2F7MSvvm6vq9wQYpmtqLrRFIfiwiiBmKPE0LON887MCK3XPT6694wNA+Ddv6qf
 Il62zlPAiV8VdlKG6/1m70PUzqryYp3ExRU01pbvTFu8M2IGAw3Lva5nb6s65Mv5i2BnolVALP
 lsyN9xklU4gjNQ4dIX0hKm5V
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="146500441"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 03:10:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 03:10:17 -0700
Received: from [10.12.73.2] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 03:10:15 -0700
Subject: Re: [PATCH v10 0/3] Add driver for lan966x Generic Clock Controller
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        <robh+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, "Claudiu Beznea" <Claudiu.Beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Manohar.Puri@microchip.com>
References: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <8198b69e-44ba-3636-c02f-115c7851a664@microchip.com>
Date:   Wed, 8 Dec 2021 11:10:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2021 at 07:19, Kavyasree Kotagiri wrote:
> This patch series adds a device driver for Generic Clock Controller
> of lan966x SoC.
> 
> v9 -> v10:
> - Removed .name from lan966x_gck_pdata struct.
> - Removed "_clk" in fw_names like used in bindings
> 
> v8 -> v9:
> - Added Acked-by to dt-bindings and Documentation file.
> - Changed clk_name "timer" to "timer1"
> - Updated devm_kzalloc in probe function.
> 
> v7 -> v8:
> - Defined new constant DIV_MAX.
> - Corrected and updated prescaler divider condition check.
> - Added Acked-by.
> 
> v6 -> v7:
> - Added Kconfig and Makefile entires for lan966x clock driver.
> 
> v5 -> v6:
> - Added Acked-by to dt-bindings file.
> - Removed "_clk" in clock-names.
> - Added Reviewed-by to Documentation file.
> 
> v4 -> v5:
> - In v4 dt-bindings, missed adding "clock-names" in required
>    properties and example. So, added them.
> - Returning proper error - PTR_ERR.
> - Removed unused variable "ret" in probe function.
> 
> v3 -> v4:
> - Updated "clocks" and added "clock-names" in dt-bindings.
> - Used clk_parent_data instead of of_clk_get_parent_name().
> 
> v2 -> v3:
> - Fixed dt_binding_check errors.
> 
> v1 -> v2:
> - Updated license in dt-bindings.
> - Updated example provided for clock controller node.
> 
> Kavyasree Kotagiri (3):
>    dt-bindings: clock: lan966x: Add binding includes for lan966x SoC
>      clock IDs
>    dt-bindings: clock: lan966x: Add LAN966X Clock Controller
>    clk: lan966x: Add lan966x SoC clock driver

3 patches added in clk-at91 branch which will be merged in at91-next 
consumed by linux-next.

I plan to issue a PR for at91 clock patches soon.

Best regards,
   Nicolas

>   .../bindings/clock/microchip,lan966x-gck.yaml |  57 +++++
>   drivers/clk/Kconfig                           |   7 +
>   drivers/clk/Makefile                          |   1 +
>   drivers/clk/clk-lan966x.c                     | 240 ++++++++++++++++++
>   include/dt-bindings/clock/microchip,lan966x.h |  28 ++
>   5 files changed, 333 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
>   create mode 100644 drivers/clk/clk-lan966x.c
>   create mode 100644 include/dt-bindings/clock/microchip,lan966x.h
> 


-- 
Nicolas Ferre
