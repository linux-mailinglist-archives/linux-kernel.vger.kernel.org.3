Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E34B9DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiBQK5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:57:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiBQK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:57:45 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40831295FD2;
        Thu, 17 Feb 2022 02:57:28 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id f17so8951262edd.2;
        Thu, 17 Feb 2022 02:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M3e7mx5k5NMbWVbjczqCykQR7v8yJGLEFmzV0ogAmRw=;
        b=teSk+Kcb/TpY8cCR4cBHIssnhCoggcSZgrAI2apsf39bWdB+HyRDFOP9zJ9Mnh1NWp
         aRChvNQQ8AOrWDEosBAcdIjhylop92dS5iZqHusbfPFQmVzq2JwxfKhXXwKnD+/34MAO
         RnZWvKhGNIAInnIADFqbY7A0wvMS/pxuGkmkPyCX9BXDzqux3Oeu3NcowNCJPAJdxBCx
         K5d6J6VRHloZhwWr8bxCKDeEiRPehyd3On7gJWp1XM/4ywaIV3MqP8I6kgRLko2MWgmP
         uuEuK1iDnZ7LMy0PzSzGjyVpvgqYQ1fqI7F89QEBpLyBCCkkx/inVKTzKNGvPLBUnJIQ
         JF5g==
X-Gm-Message-State: AOAM532FU6fSTXPINFBNcbgrbRQvzVQCtc2SzI4WQJl1nyxCQzTQS4LT
        Zgmb/55moX/jpR9cnaSl/AY=
X-Google-Smtp-Source: ABdhPJzdcJvIkE/xnI3Airtm4grRt8mWc6C1SZCYJ1ZG2gZ8Rkd4+4IYzW3RPliBpPHomPvCIUDEzA==
X-Received: by 2002:a05:6402:110a:b0:408:e478:9618 with SMTP id u10-20020a056402110a00b00408e4789618mr2017659edv.344.1645095446544;
        Thu, 17 Feb 2022 02:57:26 -0800 (PST)
Received: from [192.168.0.111] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id 9sm1067336ejk.28.2022.02.17.02.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 02:57:25 -0800 (PST)
Message-ID: <0ed34852-990d-af07-afd7-1d8ce3a2baf9@kernel.org>
Date:   Thu, 17 Feb 2022 11:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 3/4] Documentation/dt: Add descriptions for loongson
 display controller
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
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220217105523.1525122-1-15330273260@189.cn>
 <20220217105523.1525122-4-15330273260@189.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220217105523.1525122-4-15330273260@189.cn>
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

On 17/02/2022 11:55, Sui Jingfeng wrote:
> From: suijingfeng <suijingfeng@loongson.cn>
> 
> Add DT documentation for loongson display controller found in
> LS2K1000, LS2K0500, LS7A1000 and LS7A2000.
> 
> v2: DT binding docs and includes should be a separate patch,
>     fix a warnning because of that.
> 
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>  .../loongson/loongson,display-controller.yaml | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> new file mode 100644
> index 000000000000..94229519022a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/loongson,display-controller.yaml#
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

No need for minItems, if you have maxItems:1.

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
> +    lsdc: display-controller@6,1 {
> +        compatible = "loongson,ls7a1000-dc";
> +        reg = <0x3100 0x0 0x0 0x0 0x0>;
> +        interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&pic>;
> +    };

I still do not think you actually tested it with dt_bindings_check...


Best regards,
Krzysztof
