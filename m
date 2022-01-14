Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60FD48E2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiANDIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:08:07 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:6736 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiANDIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:08:06 -0500
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 14 Jan
 2022 11:08:05 +0800
Message-ID: <34b86361-a823-4de0-0426-0e0fbc79e550@amlogic.com>
Date:   Fri, 14 Jan 2022 11:08:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 2/4] clk: meson: add emmc sub clock phase delay driver
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
 <20220113115745.45826-3-liang.yang@amlogic.com>
 <20220113212928.28C10C36AE3@smtp.kernel.org>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220113212928.28C10C36AE3@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.106]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/14 5:29, Stephen Boyd wrote:
> [ EXTERNAL EMAIL ]
> 
> Quoting Liang Yang (2022-01-13 03:57:43)
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index b3ef5f67820f..c450f38d3801 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
>>   obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
>> +obj-$(CONFIG_COMMON_CLK_MESON_PHASE_DELAY) += clk-phase-delay.o
> 
> Sort by Kconfig symbol?
ok, it will fix it.
> 
>>   
>>   # Amlogic Clock controllers
>>
> 
> .
