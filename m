Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4354BE4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377150AbiBUN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:58:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiBUN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:58:25 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A19A1A39C;
        Mon, 21 Feb 2022 05:58:01 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.31:59254.195918271
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 563A2100135;
        Mon, 21 Feb 2022 21:57:58 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 790f91e6d89f49e2b448534c2e4e6940 for krzk@kernel.org;
        Mon, 21 Feb 2022 21:58:00 CST
X-Transaction-ID: 790f91e6d89f49e2b448534c2e4e6940
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <50e3d6c3-93a4-c248-e6df-8ec1636f5da8@189.cn>
Date:   Mon, 21 Feb 2022 21:57:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 1/4] MIPS: Loongson64: dts: update the display
 controller device node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
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
 <acf6d02d-0e17-b84a-5bd8-9f5165f73915@kernel.org>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <acf6d02d-0e17-b84a-5bd8-9f5165f73915@kernel.org>
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


On 2022/2/21 18:01, Krzysztof Kozlowski wrote:
> On 21/02/2022 10:19, Sergei Shtylyov wrote:
>> On 2/20/22 5:55 PM, Sui Jingfeng wrote:
>>
>>> From: suijingfeng <suijingfeng@loongson.cn>
>>>
>>> The display controller is a pci device, its PCI vendor id is 0x0014
>>> its PCI device id is 0x7a06.
>>>
>>> 1) In order to let the driver to know which chip the DC is contained
>>>     in, the compatible string of the display controller is updated
>>>     according to the chip's name.
>>>
>>> 2) Add display controller device node for ls2k1000 SoC
>>>
>>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>>> ---
>>>   arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi | 8 ++++++++
>>>   arch/mips/boot/dts/loongson/ls7a-pch.dtsi          | 7 ++-----
>>>   2 files changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>>> index 768cf2abcea3..af9cda540f9e 100644
>>> --- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>>> +++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>>> @@ -209,6 +209,14 @@ gpu@5,0 {
>>>   				interrupt-parent = <&liointc0>;
>>>   			};
>>>   
>>> +			lsdc: display-controller@6,0 {
>>     Shouldn't the node name just be "display", according to the section 2.2.2
>> of the DT spec?
> lcd-controller, led-controller. As I understood from the bindings, this
> is not physical device displaying something (like a panel) but rather a
> device controlling such panel. Therefore display-controller feels
> appropriate.
>
>
> Best regards,
> Krzysztof
Extremely correct.
