Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C564E87D4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiC0NCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 09:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiC0NCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 09:02:30 -0400
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 06:00:51 PDT
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699817A9B;
        Sun, 27 Mar 2022 06:00:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 311EA3200973;
        Sun, 27 Mar 2022 08:54:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 27 Mar 2022 08:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=0Poh99Zp5F+kUx
        onhOeLMx5mbCgIAbikKidBnjSuO14=; b=mk5o9K8+r5CsemyYP5iZZiLO2vXUvh
        QeHDy8TFePh/0Ltoq3PfFWCPwVD3SoUOhvnPC8P9LY2TMgfQsgxLOeKaAszy1Z4P
        tcelHY1V4whM/sIr3Ho+u7JSUW1gzBAaTDFp4R2mU2LgLK4MHXwApLvg7PUxW4t/
        HrKkl/nLygPxK0Sl2pxG0X0TIt2RGtY4RV7bPiupwhphiSNtmwoZRak7JMTAXdxZ
        uMdx9a8NLNbEnVtCLTf35PyVN4z3pxw6TL/G2ypyoPvljoejPRyuTpALcVYi0QZY
        0+7NSqfL3798c2PTinQluMpLZ1B7PKjRQyrqcKrU6MqtBmYgAqT+Jwpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=0Poh99Zp5F+kUxonhOeLMx5mbCgIAbikKidBnjSuO
        14=; b=jvzYHtT0IcVKhFVmeiTMy0Y3W6KTZpLc6mnTsvnLbUvPQtltH9jBpwJ4Z
        vmRUvhmTg1SeltMTaGhgUa+SzXeq1sZNQFD9ocYXr251HpVDUBuyU2Fw92qJpvGT
        Z8qh9V2T/j1DLp3G7h5OkiNc14Xlbj4ysK2maycFnRy9+ZtoqGAFiG+ih9MkXjnU
        6YCeFlyyZNIzKrphmaEyiQ0/o66L1FCFs/y4cD/L97pFnqfbxh5sQ1WuAy3A2ZMo
        +kZcjeUgCyk8jUdFXOarPz0fsBTsBUZ/3/bTCu8pQmjW0f2q+MyYy4ZSIToDY2ud
        z+bSHp1SLaCw0xvV9ZkXmUueKN48A==
X-ME-Sender: <xms:cF5AYsPWhGaKC4GVosNulieA6UPoZtzHTCsEVuv2VJK3AiYr9bOwDA>
    <xme:cF5AYi-_PF3ZXtj6wB-YWW7GBJqaK6Bafouidw-ZXK2RyRpzED3Uhv3BETVEQyEJ7
    jtgPh9hjRHeMWBevxM>
X-ME-Received: <xmr:cF5AYjT5VT-sVxPpm6mNjZbbQdDkaW4ilFjZUDvqZRGk_ucwcrusBtsBBiBC4Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehhedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejhfehtdefjeeuudehudevleegudethfduiedugeevudehgefh
    vefhueeguedtgeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:cF5AYks_U06sRHaVf83kuZ-wTsZkiTXz-g50lW9n6cuXnQWJ6lxLqg>
    <xmx:cF5AYkcZt8Nni4pPNht3eZ0KY43PhOwdF0o-J5pWQMtYksFTjkiQyQ>
    <xmx:cF5AYo0pBjY1B8QXRq2X19yKopKlTye4qazZ9sNYDlK6T3CZUMV4mw>
    <xmx:cl5AYoOOM0ZId1xMffmZVveh7L1GYDratW_puMOcJzDdt-4XbFCTzw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Mar 2022 08:54:06 -0400 (EDT)
Message-ID: <169412ca-9167-b214-d613-4fe0e76ad36a@flygoat.com>
Date:   Sun, 27 Mar 2022 13:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 3/6] dt-bindings: display: Add Loongson display
 controller
Content-Language: en-GB
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220327113846.2498146-1-15330273260@189.cn>
 <20220327113846.2498146-4-15330273260@189.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220327113846.2498146-4-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/27 12:38, Sui Jingfeng 写道:
> Add DT bindings and simple usages for Loongson display controller
> found in LS7A1000 bridges chip and LS2k1000 SoC.
>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
[...]
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    bus {
> +
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <2>;
> +
> +        display-controller@6,1 {
> +            compatible = "loongson,ls7a1000-dc";
> +            reg = <0x3100 0x0 0x0 0x0 0x0>;
> +            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            i2c@6 {
> +                compatible = "loongson,gpio-i2c";
> +                reg = <0x00001650 0x00000020>;
Hi Jingfeng,

Thanks for your patch.

Just curious about what is this "reg" for?
> +                loongson,nr = <6>;
Why nr start from 6?

The approach you are handling I2C seems to be wired..

Actually you can reference how network subsystem is handling
MDIO controller built-in into Ethernet controller [1] in this case. It is
basically the same problem.

[1]: 
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/net/snps,dwmac.yaml

Thanks.
- Jiaxun

> +                loongson,sda = <0>;
> +                loongson,scl = <1>;
> +                loongson,udelay = <5>;
> +                loongson,timeout = <2200>;
> +            };
> +
> +            i2c@7 {
> +                compatible = "loongson,gpio-i2c";
> +                reg = <0x00001650 0x00000020>;
> +                loongson,nr = <7>;
> +                loongson,sda = <2>;
> +                loongson,scl = <3>;
> +                loongson,udelay = <5>;
> +                loongson,timeout = <2200>;
> +            };
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    endpoint {
> +                            remote-endpoint = <&vga_encoder_in>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    endpoint {
> +                            remote-endpoint = <&dvi_encoder_in>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    bus {
> +
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <2>;
> +
> +        display-controller@6,0 {
> +            compatible = "loongson,ls2k1000-dc";
> +            reg = <0x3100 0x0 0x0 0x0 0x0>;
> +            interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    endpoint {
> +                            remote-endpoint = <&panel_in>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    endpoint {
> +                            remote-endpoint = <&hdmi_encoder_in>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...

