Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5763148E2CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiANDGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:06:11 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:63627 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbiANDGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:06:10 -0500
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 14 Jan
 2022 11:06:08 +0800
Message-ID: <5d99ac02-a246-5bcc-2ecb-371b0d193537@amlogic.com>
Date:   Fri, 14 Jan 2022 11:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock
 controller
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220113115745.45826-1-liang.yang@amlogic.com>
 <20220113115745.45826-4-liang.yang@amlogic.com>
 <20220113212957.768FFC36AE3@smtp.kernel.org>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220113212957.768FFC36AE3@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.106]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for your quick response.

On 2022/1/14 5:29, Stephen Boyd wrote:
> [ EXTERNAL EMAIL ]
> 
> Quoting Liang Yang (2022-01-13 03:57:44)
>> Document the MMC sub clock controller driver, the potential consumer
>> of this driver is MMC or NAND. Also add four clock bindings IDs which
>> provided by this driver.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> ---
>>   .../bindings/clock/amlogic,mmc-clkc.yaml      | 64 +++++++++++++++++++
>>   include/dt-bindings/clock/amlogic,mmc-clkc.h  | 14 ++++
>>   2 files changed, 78 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
>> new file mode 100644
>> index 000000000000..a274c3d5fc2e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,mmc-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic MMC Sub Clock Controller Driver Device Tree Bindings
>> +
>> +maintainers:
>> +  - jianxin.pan@amlogic.com
>> +  - liang.yang@amlogic.com
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - "amlogic,axg-mmc-clkc", "syscon"
> 
> Why is it a syscon?

The register documented by reg is shared with SD/eMMC controller port C, 
and it need to be ops on NFC driver.

> 
> .
