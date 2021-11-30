Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0046345C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhK3Mha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:37:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52670 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhK3Mh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:37:26 -0500
Received: from [IPv6:2a01:e0a:120:3210:b422:9841:4afb:11b5] (unknown [IPv6:2a01:e0a:120:3210:b422:9841:4afb:11b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F38FA1F4500C;
        Tue, 30 Nov 2021 12:34:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638275643; bh=QqCRwQ2875SMqv/AolhMllnqBqyumXGxkjHr+hKDVS4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SZv1pYFCv6I+Dv3ozDVt5uFZcr7IZWZ4XeRoUyUMIu/ya8qzbMH+OqsGwWlocMyer
         M7/Hrb1A/4u6vSeEBrdlsCP/7G+yUagSHtd3jRIlMf6kSiEEPFBadpWQrLKrbzyi8p
         YXNRs9cz+fF3JWny8VN6FeLwlXvlEe3xgdEnClYQeUat17GBZpZV6nUteVZGmJZA+f
         /K6CMe0H8I7epGn2tNPJC5U583cLPxILjslPRTHwuF7CwFf63mRzp47ZSzbhVZ0pOP
         3Itfn5ShA2oXAjcuNcYpDQ59v30KaQCErVpQrqWZIErawQcftI6/f9O7YHL1y4ljwZ
         EDQZOosbH/Ovw==
Subject: Re: [PATCH v9 02/13] dt-bindings: media: nxp, imx8mq-vpu: Update the
 bindings for G2 support
To:     Adam Ford <aford173@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        hverkuil-cisco@xs4all.nl, emil.l.velikov@gmail.com,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org, kernel@collabora.com,
        Chris Healy <cphealy@gmail.com>, Rob Herring <robh@kernel.org>
References: <20210407073534.376722-1-benjamin.gaignard@collabora.com>
 <20210407073534.376722-3-benjamin.gaignard@collabora.com>
 <CAHCN7x+HOMoVNq-swqA2p3ddGKft_8QkB2qm00-CN8Dujaw52Q@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <f6754878-50bf-8873-ac4b-ea54a5074e23@collabora.com>
Date:   Tue, 30 Nov 2021 13:34:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7x+HOMoVNq-swqA2p3ddGKft_8QkB2qm00-CN8Dujaw52Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 29/11/2021 à 21:13, Adam Ford a écrit :
> On Wed, Apr 7, 2021 at 2:37 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>> Introducing the G2 hevc video decoder requires modifications of the bindings to allow
>> one node per VPU.
>>
>> VPUs share one hardware control block which is provided as a phandle on
>> a syscon.
>> Each node has now one reg and one interrupt.
>> Add a compatible for G2 hardware block: nxp,imx8mq-vpu-g2.
>>
>> To be compatible with older DT the driver is still capable to use the 'ctrl'
>> reg-name even if it is deprecated now.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> I need to edit the yaml file to add support the imx8mm, but it doesn't
> appear that this series has gone anywhere.  I know there is still some
> waiting on the vpu-blk-ctrl driver, but it seems like the 8mq could
> split the codecs out using syscon in place of the blk-ctrl until that
> driver is available.  If that doesn't work, I might have to introduce
> a separate yaml file for mini which could be somehow merged with the
> 8mq in the future.  I am just not sure which way to go right now.

To summarize Lucas a have a branch here: https://git.pengutronix.de/cgit/lst/linux/log/?h=imx8mq-vpu-blk-ctrl
where he try to enable blk-ctrl for imx6mq, it is working for G1 but not for G2.

You can find the thread about that here:
https://www.spinics.net/lists/devicetree/msg450831.html

Regards,
Benjamin

>
> adam
>> ---
>> version 9:
>>   - Corrections in commit message
>>
>> version 7:
>>   - Add Rob and Philipp reviewed-by tag
>>   - Change syscon phandle name to nxp,imx8m-vpu-ctrl (remove 'q' to be
>>     usable for iMX8MM too)
>>
>> version 5:
>> - This version doesn't break the backward compatibilty between kernel
>>    and DT.
>>
>>   .../bindings/media/nxp,imx8mq-vpu.yaml        | 53 ++++++++++++-------
>>   1 file changed, 34 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
>> index 762be3f96ce9..18e7d40a5f24 100644
>> --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
>> +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
>> @@ -15,22 +15,18 @@ description:
>>
>>   properties:
>>     compatible:
>> -    const: nxp,imx8mq-vpu
>> +    oneOf:
>> +      - const: nxp,imx8mq-vpu
>> +      - const: nxp,imx8mq-vpu-g2
>>
>>     reg:
>> -    maxItems: 3
>> -
>> -  reg-names:
>> -    items:
>> -      - const: g1
>> -      - const: g2
>> -      - const: ctrl
>> +    maxItems: 1
>>
>>     interrupts:
>> -    maxItems: 2
>> +    maxItems: 1
>>
>>     interrupt-names:
>> -    items:
>> +    oneOf:
>>         - const: g1
>>         - const: g2
>>
>> @@ -46,14 +42,18 @@ properties:
>>     power-domains:
>>       maxItems: 1
>>
>> +  nxp,imx8m-vpu-ctrl:
>> +    description: Specifies a phandle to syscon VPU hardware control block
>> +    $ref: "/schemas/types.yaml#/definitions/phandle"
>> +
>>   required:
>>     - compatible
>>     - reg
>> -  - reg-names
>>     - interrupts
>>     - interrupt-names
>>     - clocks
>>     - clock-names
>> +  - nxp,imx8m-vpu-ctrl
>>
>>   additionalProperties: false
>>
>> @@ -62,18 +62,33 @@ examples:
>>           #include <dt-bindings/clock/imx8mq-clock.h>
>>           #include <dt-bindings/interrupt-controller/arm-gic.h>
>>
>> -        vpu: video-codec@38300000 {
>> +        vpu_ctrl: syscon@38320000 {
>> +                 compatible = "nxp,imx8mq-vpu-ctrl", "syscon";
>> +                 reg = <0x38320000 0x10000>;
>> +        };
>> +
>> +        vpu_g1: video-codec@38300000 {
>>                   compatible = "nxp,imx8mq-vpu";
>> -                reg = <0x38300000 0x10000>,
>> -                      <0x38310000 0x10000>,
>> -                      <0x38320000 0x10000>;
>> -                reg-names = "g1", "g2", "ctrl";
>> -                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>> -                             <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>> -                interrupt-names = "g1", "g2";
>> +                reg = <0x38300000 0x10000>;
>> +                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +                interrupt-names = "g1";
>> +                clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
>> +                         <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
>> +                         <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
>> +                clock-names = "g1", "g2", "bus";
>> +                power-domains = <&pgc_vpu>;
>> +                nxp,imx8m-vpu-ctrl = <&vpu_ctrl>;
>> +        };
>> +
>> +        vpu_g2: video-codec@38310000 {
>> +                compatible = "nxp,imx8mq-vpu-g2";
>> +                reg = <0x38300000 0x10000>;
>> +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>> +                interrupt-names = "g2";
>>                   clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
>>                            <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
>>                            <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
>>                   clock-names = "g1", "g2", "bus";
>>                   power-domains = <&pgc_vpu>;
>> +                nxp,imx8m-vpu-ctrl = <&vpu_ctrl>;
>>           };
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
