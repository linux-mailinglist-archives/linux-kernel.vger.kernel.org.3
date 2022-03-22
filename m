Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040284E47DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiCVU5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiCVU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:56:54 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C455BC30;
        Tue, 22 Mar 2022 13:55:25 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id i8-20020a4a6f48000000b00324ada4b9d9so53836oof.11;
        Tue, 22 Mar 2022 13:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PdC3E4qaPnZZNFTNYFLxJGsk5AS6T7uPKXTafMYdgQI=;
        b=i835bAqOtrIsCic4NadUh1xSFxg44BTjxESUNI3+YpXyuDY1XldyHV5YOfCTOaNGlz
         Ypu/9FMVpOePZdiGVpevgq0QhlSMphXVnzVYYpcMTpmnCr+5LCBkjtULX9O4nfdvr8Yc
         hXlEBLG41gYjeCfDBNmSL5VHIGcld8hfCjBprupLUdlQqUBcQeyBSH/uSfRU2snqTYlf
         Mz8S5zN481SBSVrMauJWgv6SzDZeg/jCGicrY0SJkaVjkoudq82oohzL0KUh9VkASMdj
         pffqZ42584fPdG3+wDoUtnZJHfn1T4YVraiQgJplAnN4uLTHHO7USZug5rJyNeRNB7UV
         DxsQ==
X-Gm-Message-State: AOAM532zkc6bY4TifpBEfHBhRcIuE5JgWbnNOWBMagpgoSL4wmWv89rt
        2YEneqnzmrTZU+hhhTdlYA==
X-Google-Smtp-Source: ABdhPJzmeSYmnMa0uGdA/0qg5EdBfNdQTOomNICVd5//jKRvuWiuCqzpe2kJle2BZrFv15ZEpA8R+A==
X-Received: by 2002:a4a:e865:0:b0:318:4b66:ffe0 with SMTP id m5-20020a4ae865000000b003184b66ffe0mr9070591oom.80.1647982524760;
        Tue, 22 Mar 2022 13:55:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u9-20020a4ab5c9000000b003182df292f7sm8372141ooo.18.2022.03.22.13.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:55:23 -0700 (PDT)
Received: (nullmailer pid 2491290 invoked by uid 1000);
        Tue, 22 Mar 2022 20:55:22 -0000
Date:   Tue, 22 Mar 2022 15:55:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
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
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 5/7] dt-bindings: display: Add Loongson display
 controller
Message-ID: <Yjo3umi9bJ0xb2Gl@robh.at.kernel.org>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-6-15330273260@189.cn>
 <YjkITWpbnCmhKaX+@robh.at.kernel.org>
 <f7eb61bc-6784-c77a-083f-7408c0a17e05@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7eb61bc-6784-c77a-083f-7408c0a17e05@189.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:33:45AM +0800, Sui Jingfeng wrote:
> 
> On 2022/3/22 07:20, Rob Herring wrote:
> > On Tue, Mar 22, 2022 at 12:29:14AM +0800, Sui Jingfeng wrote:
> > > From: suijingfeng <suijingfeng@loongson.cn>
> > > 
> > Needs a commit message.
> > 
> > > Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> > > Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> > Same person? Don't need both emails.
> 
> Yes,  suijingfeng@loongson.cn is my company's email. But it can not be used
> to send patches to dri-devel,
> 
> when send patches with this email, the patch will not be shown on patch
> works.
> 
> Emails  are either blocked or got  rejected  by loongson's mail server.  It
> can only receive emails
> 
> from you and other people, but not dri-devel. so have to use my personal
> email(15330273260@189.cn) to send patches.
> 
> > > ---
> > >   .../loongson/loongson,display-controller.yaml | 230 ++++++++++++++++++
> > >   1 file changed, 230 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> > > new file mode 100644
> > > index 000000000000..7be63346289e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> > > @@ -0,0 +1,230 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/loongson/loongson,display-controller.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson LS7A1000/LS2K1000/LS2K0500 Display Controller Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Sui Jingfeng <suijingfeng@loongson.cn>
> > > +
> > > +description: |+
> > > +
> > > +  Loongson display controllers are simple which require scanout buffers
> > > +  to be physically contiguous. LS2K1000/LS2K0500 is a SOC, only system
> > > +  memory is available. LS7A1000/LS7A2000 is bridge chip which is equipped
> > > +  with a dedicated video RAM which is 64MB or more, precise size can be
> > > +  read from the PCI BAR 2 of the GPU device(0x0014:0x7A15) in the bridge
> > > +  chip.
> > > +
> > > +  LSDC has two display pipes, each way has a DVO interface which provide
> > > +  RGB888 signals, vertical & horizontal synchronisations, data enable and
> > > +  the pixel clock. LSDC has two CRTC, each CRTC is able to scanout from
> > > +  1920x1080 resolution at 60Hz. Each CRTC has two FB address registers.
> > > +
> > > +  For LS7A1000, there are 4 dedicated GPIOs whose control register is
> > > +  located at the DC register space. They are used to emulate two way i2c,
> > > +  One for DVO0, another for DVO1.
> > > +
> > > +  LS2K1000 and LS2K0500 SoC grab i2c adapter from other module, either
> > > +  general purpose GPIO emulated i2c or hardware i2c in the SoC.
> > > +
> > > +  LSDC's display pipeline have several components as below description,
> > > +
> > > +  The display controller in LS7A1000:
> > > +     ___________________                                     _________
> > > +    |            -------|                                   |         |
> > > +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monitor |
> > > +    |  _   _     -------|        ^             ^            |_________|
> > > +    | | | | |    -------|        |             |
> > > +    | |_| |_|    | i2c0 <--------+-------------+
> > > +    |            -------|
> > > +    |   DC IN LS7A1000  |
> > > +    |  _   _     -------|
> > > +    | | | | |    | i2c1 <--------+-------------+
> > > +    | |_| |_|    -------|        |             |             _________
> > > +    |            -------|        |             |            |         |
> > > +    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Panel  |
> > > +    |            -------|                                   |_________|
> > > +    |___________________|
> > > +
> > > +  Simple usage of LS7A1000 with LS3A4000 CPU:
> > > +
> > > +    +------+            +-----------------------------------+
> > > +    | DDR4 |            |  +-------------------+            |
> > > +    +------+            |  | PCIe Root complex |   LS7A1000 |
> > > +       || MC0           |  +--++---------++----+            |
> > > +  +----------+  HT 3.0  |     ||         ||                 |
> > > +  | LS3A4000 |<-------->| +---++---+  +--++--+    +---------+   +------+
> > > +  |   CPU    |<-------->| | GC1000 |  | LSDC |<-->| DDR3 MC |<->| VRAM |
> > > +  +----------+          | +--------+  +-+--+-+    +---------+   +------+
> > > +       || MC1           +---------------|--|----------------+
> > > +    +------+                            |  |
> > > +    | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
> > > +    +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DVI/HDMI
> > > +                      +-------+                      +------+
> > > +
> > > +  The display controller in LS2K1000/LS2K0500:
> > > +     ___________________                                     _________
> > > +    |            -------|                                   |         |
> > > +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monitor |
> > > +    |  _   _     -------|        ^              ^           |_________|
> > > +    | | | | |           |        |              |
> > > +    | |_| |_|           |     +------+          |
> > > +    |                   <---->| i2c0 |<---------+
> > > +    |   DC IN LS2K1000  |     +------+
> > > +    |  _   _            |     +------+
> > > +    | | | | |           <---->| i2c1 |----------+
> > > +    | |_| |_|           |     +------+          |            _________
> > > +    |            -------|        |              |           |         |
> > > +    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Panel  |
> > > +    |            -------|                                   |_________|
> > > +    |___________________|
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^display-controller@[0-9a-f],[0-9a-f]$"
> > > +
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - loongson,ls7a1000-dc
> > > +              - loongson,ls2k1000-dc
> > > +              - loongson,ls2k0500-dc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +  i2c-gpio@0:
> > > +    description: |
> > > +      Built-in GPIO emulate i2c exported for external display bridge
> > If you have i2c-gpio, that belongs at the DT top-level, not here.
> > 
> > > +      configuration, onitor detection and edid read back etc, for ls7a1000
> > > +      only. Its compatible must be lsdc,i2c-gpio-0. The reg property can be
> > No, there's a defined i2c-gpio compatible already.
> 
> This is different from the i2c-gpio already defined under drivers/i2c/busses/i2c-gpio.c,
> By design, my i2c-gpio is vendor specific properties, lsdc device driver create the i2c
> adapter at runtime. These are 4 dedicated GPIOs whose control register is located at the
> LSDC register space, not general purpose GPIOs with separate control register resource.
> So i think it is the child node of display-controller@6,1, it belongs to LSDC.
> It seems that put it at the DT top-level break the hierarchy and relationship.

Okay, I see. Then just 'i2c' for the node names. You need a reference to 
i2c-controller.yaml for these nodes too.

The compatible should not have an index in it.


> 
> > > +      used to specify a I2c adapter bus number, if you don't specify one
> > > +      i2c driver core will dynamically assign a bus number. Please specify
> > Bus numbers are a linux detail not relevant to DT binding.
> > 
> > > +      it only when its bus number matters. Bus number greater than 6 is safe
> > > +      because ls7a1000 bridge have 6 hardware I2C controller integrated.
> > > +
> > > +  i2c-gpio@1:
> > > +    description: |
> > > +      Built-in GPIO emulate i2c exported for external display bridge
> > > +      configuration, onitor detection and edid read back etc, for ls7a1000
> > > +      only. Its compatible must be lsdc,i2c-gpio-1.
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: output port node connected with DPI panels or external encoders, with only one endpoint.
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: output port node connected with DPI panels or external encoders, with only one endpoint.
> > > +
> > > +    required:
> > > +      - port@0
> > > +      - port@1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - ports
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    bus {
> > > +
> > > +        #address-cells = <3>;
> > > +        #size-cells = <2>;
> > > +        #interrupt-cells = <2>;
> > > +
> > > +        display-controller@6,1 {
> > > +            compatible = "loongson,ls7a1000-dc";
> > > +            reg = <0x3100 0x0 0x0 0x0 0x0>;
> > > +            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            i2c-gpio@0 {
> > > +                compatible = "lsdc,i2c-gpio-0";
> > > +                reg = <6>;

'reg' needs to be documented with some description of what 6 and 7 
represent. If they are the control register offset, then make the 
address translatable (use 'ranges' and define the size).

> > > +                sda = <0>;
> > > +                scl = <1>;

These need a vendor prefix.

> > > +            };
> > > +
> > > +            i2c-gpio@1 {
> > > +                compatible = "lsdc,i2c-gpio-1";
> > > +                reg = <7>;
> > > +                sda = <2>;
> > > +                scl = <3>;
> > > +            };
> > > +
> > > +            ports {
> > > +                #address-cells = <1>;
> > > +                #size-cells = <0>;
> > > +                port@0 {
> > > +                    reg = <0>;
> > > +                    endpoint {
> > > +                            remote-endpoint = <&vga_encoder_in>;
> > > +                    };
> > > +                };
> > > +                port@1 {
> > > +                    reg = <1>;
> > > +                    endpoint {
> > > +                            remote-endpoint = <&dvi_encoder_in>;
> > > +                    };
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > +
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    bus {
> > > +
> > > +        #address-cells = <3>;
> > > +        #size-cells = <2>;
> > > +        #interrupt-cells = <2>;
> > > +
> > > +        display-controller@6,0 {
> > > +            compatible = "loongson,ls2k1000-dc";
> > > +            reg = <0x3100 0x0 0x0 0x0 0x0>;
> > > +            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +            ports {
> > > +                #address-cells = <1>;
> > > +                #size-cells = <0>;
> > > +                port@0 {
> > > +                    reg = <0>;
> > > +                    endpoint {
> > > +                            remote-endpoint = <&panel_in>;
> > > +                    };
> > > +                };
> > > +                port@1 {
> > > +                    reg = <1>;
> > > +                    endpoint {
> > > +                            remote-endpoint = <&hdmi_encoder_in>;
> > > +                    };
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > +...
> > > -- 
> > > 2.25.1
> > > 
> > > 
