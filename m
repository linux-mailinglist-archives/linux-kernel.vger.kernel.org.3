Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0D4BDE41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377106AbiBUNyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:54:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376746AbiBUNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:54:00 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C2A2BF7F;
        Mon, 21 Feb 2022 05:53:35 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:49386.1635481058
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 247AB100135;
        Mon, 21 Feb 2022 21:53:29 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id 8927a885023a44a3b0b45b301e09b9e3 for sergei.shtylyov@gmail.com;
        Mon, 21 Feb 2022 21:53:33 CST
X-Transaction-ID: 8927a885023a44a3b0b45b301e09b9e3
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <f7782013-6a4a-e333-369c-e8caf13997b7@189.cn>
Date:   Mon, 21 Feb 2022 21:53:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 1/4] MIPS: Loongson64: dts: update the display
 controller device node
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-2-15330273260@189.cn>
 <08abcb14-f1f6-8be5-6309-cd16e0578c05@gmail.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <08abcb14-f1f6-8be5-6309-cd16e0578c05@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/21 17:19, Sergei Shtylyov wrote:
> On 2/20/22 5:55 PM, Sui Jingfeng wrote:
>
>> From: suijingfeng <suijingfeng@loongson.cn>
>>
>> The display controller is a pci device, its PCI vendor id is 0x0014
>> its PCI device id is 0x7a06.
>>
>> 1) In order to let the driver to know which chip the DC is contained
>>     in, the compatible string of the display controller is updated
>>     according to the chip's name.
>>
>> 2) Add display controller device node for ls2k1000 SoC
>>
>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>> ---
>>   arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi | 8 ++++++++
>>   arch/mips/boot/dts/loongson/ls7a-pch.dtsi          | 7 ++-----
>>   2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> index 768cf2abcea3..af9cda540f9e 100644
>> --- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> +++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> @@ -209,6 +209,14 @@ gpu@5,0 {
>>   				interrupt-parent = <&liointc0>;
>>   			};
>>   
>> +			lsdc: display-controller@6,0 {
>     Shouldn't the node name just be "display", according to the section 2.2.2
> of the DT spec?
>
> [...]
>> diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
>> index 2f45fce2cdc4..ec35ea9b2fe8 100644
>> --- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
>> +++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
>> @@ -160,11 +160,8 @@ gpu@6,0 {
>>   				interrupt-parent = <&pic>;
>>   			};
>>   
>> -			dc@6,1 {
>> -				compatible = "pci0014,7a06.0",
>> -						   "pci0014,7a06",
>> -						   "pciclass030000",
>> -						   "pciclass0300";
>> +			lsdc: display-controller@6,1 {
>     Same here...
>
> [...]
>
> MBR, Sergey

Display sounds like a panel or monitor, while we are the device that driven the display device.

Running find . -name "*.dtsi" -type f | xargs grep "display-controller"
at drm-tip/arch/ directory show that there are a number of vendors using
display controller as theirnode name, for example Atmel and STM32.


./arm/boot/dts/pxa3xx.dtsi:		gcu: display-controller@54000000 {
./arm/boot/dts/at91sam9n12.dtsi:				hlcdc-display-controller {
./arm/boot/dts/at91sam9n12.dtsi:					compatible = "atmel,hlcdc-display-controller";
./arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi:	hlcdc-display-controller {
./arm/boot/dts/stm32h743.dtsi:		ltdc: display-controller@50001000 {
./arm/boot/dts/stm32mp151.dtsi:		ltdc: display-controller@5a001000 {
./arm/boot/dts/at91sam9x5dm.dtsi:	hlcdc-display-controller {
./arm/boot/dts/gemini.dtsi:		display-controller@6a000000 {
./arm/boot/dts/stm32f429.dtsi:		ltdc: display-controller@40016800 {
./arm/boot/dts/at91sam9x5_lcd.dtsi:				hlcdc-display-controller {
./arm/boot/dts/at91sam9x5_lcd.dtsi:					compatible = "atmel,hlcdc-display-controller";
./arm/boot/dts/sama5d2.dtsi:				hlcdc-display-controller {
./arm/boot/dts/sama5d2.dtsi:					compatible = "atmel,hlcdc-display-controller";
./arm/boot/dts/sama5d4.dtsi:				hlcdc-display-controller {
./arm/boot/dts/sama5d4.dtsi:					compatible = "atmel,hlcdc-display-controller";
./arm/boot/dts/sama5d3_lcd.dtsi:				hlcdc-display-controller {
./arm/boot/dts/sama5d3_lcd.dtsi:					compatible = "atmel,hlcdc-display-controller";
./arm/boot/dts/sam9x60.dtsi:				hlcdc-display-controller {
./arm/boot/dts/sam9x60.dtsi:					compatible = "atmel,hlcdc-display-controller";

./arm/boot/dts/at91-sama5d4_ma5d4evk.dts:				hlcdc-display-controller {
./arm/boot/dts/at91sam9n12ek.dts:				hlcdc-display-controller {
./arm/boot/dts/am335x-pdu001.dts:	display-controller@0 {
./arm/boot/dts/at91-nattis-2-natte-2.dts:	hlcdc-display-controller {
./arm/boot/dts/gemini-dlink-dir-685.dts:		display-controller@6a000000 {

