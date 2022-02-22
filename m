Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F274C050F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiBVXDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiBVXDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:03:03 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700B78AE54;
        Tue, 22 Feb 2022 15:02:37 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id k2so12542345oia.2;
        Tue, 22 Feb 2022 15:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6NMNgjpMH0rJqe9W2px91jdR184ky7Ff9IefMqODMA=;
        b=cBdaGY/Uh0tEbrlZo46lbjqDH4K4Gl/Z1+bLV1w1Lfh0FmOEZ3A7A11JHnTS+nalau
         9r7+08LQ7JSgtQ9etXuu6RQ8FYtAYGlkpitP6EFQgqw5Ka/oerkLZREcrYkAOua2jz6p
         ecRcNmrbSjELQqBJ7b2Saf06wP7f3jD9QTjbS/6n1H9VHm+ByV12JNkoUbnXF7Bb8Kn9
         QiVfDGFyQVREUn8rZbUZyAiP0drS0AfRBoyK02T9OC/GnO7V4Qgq/lTQeP02a41M82tD
         tGe1iNYW7IJodGBjAw578CPtUFqxq9rk1vVYdZHN91w0sNuOgAstY1XUDXFX10z+ldu9
         q5Xg==
X-Gm-Message-State: AOAM532rzppROh8l91Dg8KvzpM0CXWD7k7mxLL3mS9jPUvex6CM+V8Pk
        JwGLDQULq3Lp9NMfvLFDsQ==
X-Google-Smtp-Source: ABdhPJyJ30kZqNC1ZDZBZMmAjEJgXkLFmJ3LtezCgaHxYtAREtjokF4HlGFTwewJeEPi/yZQK0XFEQ==
X-Received: by 2002:aca:502:0:b0:2cd:c24:278f with SMTP id 2-20020aca0502000000b002cd0c24278fmr3103957oif.150.1645570956534;
        Tue, 22 Feb 2022 15:02:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s27sm2738598oiw.38.2022.02.22.15.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:02:35 -0800 (PST)
Received: (nullmailer pid 3759205 invoked by uid 1000);
        Tue, 22 Feb 2022 23:02:34 -0000
Date:   Tue, 22 Feb 2022 17:02:34 -0600
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
Subject: Re: [PATCH v10 2/4] Documentation/dt: Add descriptions for loongson
 display controller
Message-ID: <YhVrigEnXTiNgk67@robh.at.kernel.org>
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-3-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220145554.117854-3-15330273260@189.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 10:55:52PM +0800, Sui Jingfeng wrote:
> From: suijingfeng <suijingfeng@loongson.cn>

Follow the conventions of the subsystem for patch subjects. It should be 
evident with 'git log --oneline Documentation/devicetree/bindings/display'.

Something like this:

dt-bindings: display: Add Loongson display controller

> 
> Add DT documentation for loongson display controller found in LS2K1000,
> LS2K0500 and LS7A1000.
> 
> v2: DT binding docs and includes should be a separate patch,
>     fix a warnning because of that.
> 
> v3: split dt-bindings from other changes into a separate patch.
> 
> v4: fix warnings and errors when running make dt_binding_check

What happened in versions 5-10? You've sent 10 versions in 3 weeks. 
That's not a rate that gives people time to review. Also, it looks like 
all the changes you've made are either documented things to do or not do 
or are errors the tools (checkpatch.pl, 'make dt_binding_check') will 
tell you to fix. 

>
> Reported-by: Rob Herring <robh@kernel.org>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>

What did we report? That's generally for fixes.

> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>  .../loongson/loongson,display-controller.yaml | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> new file mode 100644
> index 000000000000..ee1a59b91943
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/loongson/loongson,display-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson LS7A1000/LS2K1000/LS2K0500 Display Controller Device Tree Bindings
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
> +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monitor |
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

How do you know how much VRAM you have? That's going to need a binding 
for the VRAM.

> +       || MC1           +---------------|--|----------------+
> +    +------+                            |  |
> +    | DDR4 |          +-------+   DVO0  |  |  DVO1   +------+
> +    +------+   VGA <--|ADV7125|<--------+  +-------->|TFP410|--> DVI/HDMI
> +                      +-------+                      +------+
> +
> +  The display controller in LS2K1000/LS2K0500:
> +     ___________________                                     _________
> +    |            -------|                                   |         |
> +    |  CRTC0 --> | DVO0 ----> Encoder0 ---> Connector0 ---> | Monitor |
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
> +  $nodename:
> +    pattern: "^display-controller@[0-9a-f],[0-9a-f]$"
> +
> +  compatible:
> +    enum:
> +      - loongson,ls7a1000-dc
> +      - loongson,ls2k1000-dc
> +      - loongson,ls2k0500-dc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
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
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    bus {
> +
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <2>;
> +
> +        lsdc: display-controller@6,1 {
> +            compatible = "loongson,ls7a1000-dc";
> +            reg = <0x3100 0x0 0x0 0x0 0x0>;
> +            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-parent = <&pic>;

Don't need 'interrupt-parent' in examples.

This certainly looks incomplete given you have 2 outputs you are going 
to need to describe what's connected to them.

> +        };
> +    };
> +...
> -- 
> 2.25.1
> 
> 
