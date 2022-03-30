Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4F4EB905
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbiC3DsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiC3DsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:48:18 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D5A24B422;
        Tue, 29 Mar 2022 20:46:29 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:43204.462545494
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 951841002BF;
        Wed, 30 Mar 2022 11:46:24 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id 61ccf52ab94342e7af9cd1074e7c91b9 for robh+dt@kernel.org;
        Wed, 30 Mar 2022 11:46:28 CST
X-Transaction-ID: 61ccf52ab94342e7af9cd1074e7c91b9
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <0a3a29af-ad2f-9ccc-3a56-3e5b7e4c7c83@189.cn>
Date:   Wed, 30 Mar 2022 11:46:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 3/6] dt-bindings: display: Add Loongson display
 controller
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        suijingfeng <suijingfeng@loongson.cn>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20220328022835.2508587-1-15330273260@189.cn>
 <20220328022835.2508587-3-15330273260@189.cn>
 <CAL_Jsq+zO7RXzQLoPXR7Zm0mcsKCydK=8EFaNFGu-_THgJuh7Q@mail.gmail.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <CAL_Jsq+zO7RXzQLoPXR7Zm0mcsKCydK=8EFaNFGu-_THgJuh7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/29 21:27, Rob Herring wrote:
> On Sun, Mar 27, 2022 at 9:29 PM Sui Jingfeng <15330273260@189.cn> wrote:
>> Add DT bindings and simple usages for Loongson display controller
>> found in LS7A1000 bridge chip and LS2k1000 SoC.
>>
>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>> ---
>>   .../loongson/loongson,display-controller.yaml | 321 ++++++++++++++++++
>>   1 file changed, 321 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
>> new file mode 100644
>> index 000000000000..34060ed55a25
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
>> @@ -0,0 +1,321 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/loongson/loongson,display-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson LS7A1000/LS2K1000/LS2K0500 Display Controller Device Tree Bindings
>> +
>> +maintainers:
>> +  - Sui Jingfeng <suijingfeng@loongson.cn>
>> +
>> +description: |+
>> +
>> +  Loongson display controllers are simple which require scanout buffers
>> +  to be physically contiguous. LS2K1000/LS2K0500 is a SOC, only system
>> +  memory is available. LS7A1000/LS7A2000 is bridge chip which is equipped
>> +  with a dedicated video RAM which is 64MB or more, precise size can be
>> +  read from the PCI BAR 2 of the GPU device(0x0014:0x7A15) in the bridge
>> +  chip.
>> +
>> +  LSDC has two display pipes, each way has a DVO interface which provide
>> +  RGB888 signals, vertical & horizontal synchronisations, data enable and
>> +  the pixel clock. LSDC has two CRTC, each CRTC is able to scanout from
>> +  1920x1080 resolution at 60Hz. Each CRTC has two FB address registers.
>> +
>> +  For LS7A1000, there are 4 dedicated GPIOs whose control register is
>> +  located at the DC register space. They are used to emulate two way i2c,
>> +  One for DVO0, another for DVO1.
>> +
>> +  LS2K1000 and LS2K0500 SoC grab i2c adapter from other module, either
>> +  general purpose GPIO emulated i2c or hardware i2c in the SoC.
>> +
>> +  LSDC's display pipeline have several components as below description,
>> +
>> +  The display controller in LS7A1000:
>> +     ___________________                                     _________
>> +    |            -------|                                   |         |
>> +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monitor |
>> +    |  _   _     -------|        ^             ^            |_________|
>> +    | | | | |    -------|        |             |
>> +    | |_| |_|    | i2c0 <--------+-------------+
>> +    |            -------|
>> +    |   DC IN LS7A1000  |
>> +    |  _   _     -------|
>> +    | | | | |    | i2c1 <--------+-------------+
>> +    | |_| |_|    -------|        |             |             _________
>> +    |            -------|        |             |            |         |
>> +    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Panel  |
>> +    |            -------|                                   |_________|
>> +    |___________________|
>> +
>> +  Simple usage of LS7A1000 with LS3A4000 CPU:
>> +
>> +    +------+            +------------------------------------+
>> +    | DDR4 |            |  +-------------------+             |
>> +    +------+            |  | PCIe Root complex |   LS7A1000  |
>> +       || MC0           |  +--++---------++----+             |
>> +  +----------+  HT 3.0  |     ||         ||                  |
>> +  | LS3A4000 |<-------->| +---++---+  +--++--+     +---------+   +------+
>> +  |   CPU    |<-------->| | GC1000 |  | LSDC |<--->| DDR3 MC |<->| VRAM |
>> +  +----------+          | +--------+  +-+--+-+     +---------+   +------+
>> +       || MC1           +---------------|--|-----------------+
>> +    +------+                            |  |
>> +    | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
>> +    +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DVI/HDMI
>> +                      +-------+                      +------+
>> +
>> +  The display controller in LS2K1000/LS2K0500:
>> +     ___________________                                     _________
>> +    |            -------|                                   |         |
>> +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monitor |
>> +    |  _   _     -------|        ^              ^           |_________|
>> +    | | | | |           |        |              |
>> +    | |_| |_|           |     +------+          |
>> +    |                   <---->| i2c0 |<---------+
>> +    |   DC IN LS2K1000  |     +------+
>> +    |  _   _            |     +------+
>> +    | | | | |           <---->| i2c1 |----------+
>> +    | |_| |_|           |     +------+          |            _________
>> +    |            -------|        |              |           |         |
>> +    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Panel  |
>> +    |            -------|                                   |_________|
>> +    |___________________|
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^display-controller@[0-9a-f],[0-9a-f]$"
>> +
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - loongson,ls7a1000-dc
>> +              - loongson,ls2k1000-dc
>> +              - loongson,ls2k0500-dc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  i2c@6:
> NAK on made-up bus numbers. See v11 discussion for details.
>
> Rob

I am worry about when this driver is loaded before the hardware i2c(on 
the ls7a1000 bridge) driver,

and when there is no DT support. in such a case, if i2c bus number is 
dynamically assigned,

it may incurring troubles.  Made the bus number fixed is benefit to the 
whole system.

DT  serve as a purpose to passing parameters to the kernel.  bus numbers 
just a kind of parameters.

this is my understanding toward DT. why you are so disagree about this?  
what's the benefits of

disallow put bus numbers it DT? to the whole world of developers who is 
using DT?


