Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB6E470BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbhLJUWo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Dec 2021 15:22:44 -0500
Received: from aposti.net ([89.234.176.197]:46794 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234163AbhLJUWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:22:37 -0500
Date:   Fri, 10 Dec 2021 20:18:43 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v11 3/8] dt-bindings: display: Add ingenic,jz4780-dw-hdmi
 DT Schema
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Message-Id: <7R1X3R.HSAT8MYJAY6M2@crapouillou.net>
In-Reply-To: <YbOF/pwib/VXoqkx@robh.at.kernel.org>
References: <cover.1638470392.git.hns@goldelico.com>
        <ac147196cd7744a7d50cf25197fe08bf9e81f88a.1638470392.git.hns@goldelico.com>
        <YbOF/pwib/VXoqkx@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le ven., déc. 10 2021 at 10:53:18 -0600, Rob Herring <robh@kernel.org> 
a écrit :
> On Thu, Dec 02, 2021 at 07:39:48PM +0100, H. Nikolaus Schaller wrote:
>>  From: Sam Ravnborg <sam@ravnborg.org>
>> 
>>  Add DT bindings for the hdmi driver for the Ingenic JZ4780 SoC.
>>  Based on .txt binding from Zubair Lutfullah Kakakhel
>> 
>>  We also add generic ddc-i2c-bus to synopsys,dw-hdmi.yaml
>> 
>>  Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>>  Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>  Cc: Rob Herring <robh@kernel.org>
>>  Cc: devicetree@vger.kernel.org
>>  ---
>>   .../display/bridge/ingenic,jz4780-hdmi.yaml   | 78 
>> +++++++++++++++++++
>>   .../display/bridge/synopsys,dw-hdmi.yaml      |  3 +
>>   2 files changed, 81 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml 
>> b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
>>  new file mode 100644
>>  index 0000000000000..49ae1130efded
>>  --- /dev/null
>>  +++ 
>> b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
>>  @@ -0,0 +1,78 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: 
>> http://devicetree.org/schemas/display/bridge/ingenic,jz4780-hdmi.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Bindings for Ingenic JZ4780 HDMI Transmitter
>>  +
>>  +maintainers:
>>  +  - H. Nikolaus Schaller <hns@goldelico.com>
>>  +
>>  +description: |
>>  +  The HDMI Transmitter in the Ingenic JZ4780 is a Synopsys 
>> DesignWare HDMI 1.4
>>  +  TX controller IP with accompanying PHY IP.
>>  +
>>  +allOf:
>>  +  - $ref: synopsys,dw-hdmi.yaml#
>>  +
>>  +properties:
>>  +  compatible:
>>  +    const: ingenic,jz4780-dw-hdmi
>>  +
>>  +  reg-io-width:
>>  +    const: 4
>>  +
>>  +  clocks:
>>  +    maxItems: 2
>>  +
>>  +  hdmi-5v-supply:
>>  +    description: regulator to provide +5V at the connector
> 
> Being part of the connector, that belongs in a connector node.

I believe that means adding .atomic_{enable,disable} callbacks to the 
display-connector bridge (drivers/gpu/drm/bridge/display-connector.c) 
which would enable/disable the regulator.

Unless it messes up with e.g. cable detection (which I believe requires 
the regulator to be enabled), in that case unconditionally enable it in 
the connector's probe function.

>>  +
>>  +  ports:
>>  +    $ref: /schemas/graph.yaml#/properties/ports
> 
> You need to define what each 'port' node is.

Have a look at 
Documentation/devicetree/bindings/display/ingenic,lcd.yaml for an 
example on how to do this.

>>  +
>>  +required:
>>  +  - compatible
>>  +  - clocks
>>  +  - clock-names
>>  +  - hdmi-5v-supply
>>  +  - ports
>>  +  - reg-io-width
>>  +
>>  +unevaluatedProperties: false
>>  +
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
>>  +
>>  +    hdmi: hdmi@10180000 {
>>  +        compatible = "ingenic,jz4780-dw-hdmi";
>>  +        reg = <0x10180000 0x8000>;
>>  +        reg-io-width = <4>;
>>  +        ddc-i2c-bus = <&i2c4>;
>>  +        interrupt-parent = <&intc>;
>>  +        interrupts = <3>;
>>  +        clocks = <&cgu JZ4780_CLK_AHB0>, <&cgu JZ4780_CLK_HDMI>;
>>  +        clock-names = "iahb", "isfr";
>>  +        hdmi-5v-supply = <&hdmi_power>;
>>  +
>>  +        ports {
>>  +            #address-cells = <1>;
>>  +            #size-cells = <0>;
>>  +            hdmi_in: port@0 {
>>  +                reg = <0>;
>>  +                dw_hdmi_in: endpoint {
>>  +                    remote-endpoint = <&jz4780_lcd_out>;
>>  +                };
>>  +            };
>>  +            hdmi_out: port@1 {
>>  +                reg = <1>;
>>  +                dw_hdmi_out: endpoint {
>>  +                    remote-endpoint = <&hdmi_con>;
>>  +                };
>>  +            };
>>  +        };
>>  +    };
>>  +
>>  +...
>>  diff --git 
>> a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml 
>> b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
>>  index 9be44a682e67a..9cbeabaee0968 100644
>>  --- 
>> a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
>>  +++ 
>> b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
>>  @@ -50,6 +50,9 @@ properties:
>>     interrupts:
>>       maxItems: 1
>> 
>>  +  ddc-i2c-bus:
>>  +    description: An I2C interface if the internal DDC I2C driver 
>> is not to be used
> 
> That too is already defined to be part of the connector node.

Just remove the property then, since you don't use it in the ci20 
bindings.

Cheers,
-Paul

>>  +
>>   additionalProperties: true
>> 
>>   ...
>>  --
>>  2.33.0
>> 
>> 


