Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67254B9B50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiBQImr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:42:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiBQImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:42:44 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A400E207564;
        Thu, 17 Feb 2022 00:42:30 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id gb39so5466923ejc.1;
        Thu, 17 Feb 2022 00:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hime8aGfAW5sJ8cZVOKC+RpupkrcgnsKX1i4Uz8X/xw=;
        b=twPTvGBbap0PZFZK7HoqwA17b5VR+excNsys+zr9Wdy4+TlZk2DwlWr5HhOzUy7id5
         MZlqmfiUIjAIOD+nmXuOQZltfunToCIWEIu859a1wf/qDlHb9dUg/IcSda62cdvbTLct
         b9ESChLnZyrWZ9wrUVYv1vT+p3X8YmFSM/jj7lcYxOyukqVXNVcmwSeSQQk0OuIXdaGA
         MKMG736K7F86OgYFfl9KED2pqmuFIbFSgjijhWeW5w+E9waLJMzl+Ag9OBoIxlZpPmV5
         rztJeopOwljl7m8xtjxy9XDu0NEOutYIV+hQN1DNq3a0YS+Kd4+asp/LngieBFDt4Nsz
         vlfQ==
X-Gm-Message-State: AOAM531SphXdxTpWqNk+hMPNoH1pte5abYCnDBPJR04MHX7vU7nmx72N
        6qQ1OF4dkx+dviYG0py5kyk=
X-Google-Smtp-Source: ABdhPJxKbIrcYL5bmiSC2JNRAKvbQiGYgDIOvD6Fxqj+82np/3U18ObRDa5+PWoEHvt+Gj3HvV6blw==
X-Received: by 2002:a17:906:2daa:b0:6cf:3c6:dbb7 with SMTP id g10-20020a1709062daa00b006cf03c6dbb7mr1491522eji.688.1645087348921;
        Thu, 17 Feb 2022 00:42:28 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id n2sm956100ejl.55.2022.02.17.00.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 00:42:27 -0800 (PST)
Message-ID: <687aad50-6e37-dab9-71a0-4df89abbd9d4@kernel.org>
Date:   Thu, 17 Feb 2022 09:42:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 2/3] MIPS: Loongson64: dts: update the display
 controller device node
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
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
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220216181712.1493400-1-15330273260@189.cn>
 <20220216181712.1493400-3-15330273260@189.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220216181712.1493400-3-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 19:17, Sui Jingfeng wrote:
> From: suijingfeng <suijingfeng@loongson.cn>
> 
> The display controller is a pci device, its PCI vendor id is 0x0014
> its PCI device id is 0x7a06.
> 
> 1) In order to let the lsdc kms driver to know which chip the DC is
>    contained in, we add different compatible for different chip.
> 
> 2) Add display controller device node for ls2k1000 SoC
> 
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>  .../loongson/loongson,display-controller.yaml | 114 ++++++++++++++++++
>  .../display/loongson/loongson-drm.txt         |  16 +++

Please split dt-bindings from other changes into a separate patch, which
should be first in the series.

>  .../boot/dts/loongson/loongson64-2k1000.dtsi  |   8 ++
>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |   7 +-
>  4 files changed, 140 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson-drm.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> new file mode 100644
> index 000000000000..64d8364b50ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/pci0014,7a06.yaml#

The file name looks different than ID. Does this pass `make
dt_binding_check` validation?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson LS7A2000/LS7A1000/LS2K1000/LS2K0500 Display Controller Device Tree Bindings
> +
> +maintainers:
> +  - Sui Jingfeng <suijingfeng@loongson.cn>
> +
> +description: |+
> +
> +  Loongson display controllers are simple which require scanout buffers
> +  to be physically contiguous. LS2K1000/LS2K0500 is a SOC, only system
> +  memory is available. LS7A1000/LS7A2000 is bridge chip which is equipped
> +  with a dedicated video ram which is 64MB or more.
> +
> +  For LS7A1000, there are 4 dedicated GPIOs whose control register is
> +  located at the DC register space. They are used to emulate two way i2c,
> +  One for DVO0, another for DVO1.
> +
> +  LS2K1000 and LS2K0500 SoC grab i2c adapter from other module, either
> +  general purpose GPIO emulated i2c or hardware i2c in the SoC.
> +
> +  LSDC has two display pipes, each way has a DVO interface which provide
> +  RGB888 signals, vertical & horizontal synchronisations, data enable and
> +  the pixel clock. LSDC has two CRTC, each CRTC is able to scanout from
> +  1920x1080 resolution at 60Hz. Each CRTC has two FB address registers.
> +
> +  LSDC's display pipeline have several components as below description,
> +
> +  The display controller in LS7A1000:
> +    ___________________                                     _________
> +    |            -------|                                   |         |
> +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monotor |
> +    |  _   _     -------|        ^             ^            |_________|
> +    | | | | |    -------|        |             |
> +    | |_| |_|    | i2c0 <--------+-------------+
> +    |            -------|
> +    |   DC IN LS7A1000  |
> +    |  _   _     -------|
> +    | | | | |    | i2c1 <--------+-------------+
> +    | |_| |_|    -------|        |             |             _________
> +    |            -------|        |             |            |         |
> +    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Panel  |
> +    |            -------|                                   |_________|
> +    |___________________|
> +
> +  Simple usage of LS7A1000 with LS3A4000 CPU:
> +
> +    +------+            +-----------------------------------+
> +    | DDR4 |            |  +-------------------+            |
> +    +------+            |  | PCIe Root complex |   LS7A1000 |
> +       || MC0           |  +--++---------++----+            |
> +  +----------+  HT 3.0  |     ||         ||                 |
> +  | LS3A4000 |<-------->| +---++---+  +--++--+    +---------+   +------+
> +  |   CPU    |<-------->| | GC1000 |  | LSDC |<-->| DDR3 MC |<->| VRAM |
> +  +----------+          | +--------+  +-+--+-+    +---------+   +------+
> +       || MC1           +---------------|--|----------------+
> +    +------+                            |  |
> +    | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
> +    +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DVI/HDMI
> +                      +-------+                      +------+
> +
> +  The display controller in LS2K1000/LS2K0500:
> +     ___________________                                     _________
> +    |            -------|                                   |         |
> +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monotor |
> +    |  _   _     -------|        ^              ^           |_________|
> +    | | | | |           |        |              |
> +    | |_| |_|           |     +------+          |
> +    |                   <---->| i2c0 |<---------+
> +    |   DC IN LS2K1000  |     +------+
> +    |  _   _            |     +------+
> +    | | | | |           <---->| i2c1 |----------+
> +    | |_| |_|           |     +------+          |            _________
> +    |            -------|        |              |           |         |
> +    |  CRTC1 --> | DVO1 ----> Encoder1 ---> Connector1 ---> |  Panel  |
> +    |            -------|                                   |_________|
> +    |___________________|
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls7a2000-dc
> +      - loongson,ls7a1000-dc
> +      - loongson,ls2k1000-dc
> +      - loongson,ls2k0500-dc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1

You need also maxItems. If you have only one interrupt, then just
maxItems:1.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    lsdc: dc@6,1 {

node name should be generic: "display-controller"

The unit address does not look like matching the reg property. Is this
how it suppose to be?

> +        compatible = "loongson,ls7a1000-dc";
> +        reg = <0x3100 0x0 0x0 0x0 0x0>;
> +        interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&pic>;
> +    };
> +
> +...


Best regards,
Krzysztof
