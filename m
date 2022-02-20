Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE154BD0A5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbiBTSXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 13:23:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiBTSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 13:23:16 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C9E45509;
        Sun, 20 Feb 2022 10:22:54 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 25E3C58011E;
        Sun, 20 Feb 2022 13:22:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 20 Feb 2022 13:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=mT/hndLP02vHoM
        wJt7GXmeWBo6eRejzgcBxnXIZrd8E=; b=e4f4bDXFIbiU98Pj/NaVbYRxOYVm9c
        jWs9EKL64OBxrRNQCJ1T3+KCYdd8BDvuRUmFn9GckQJjOZ5vfggkpLcwWv8pNQrV
        vKXVmUwEmLGQtWmEvCJJ7aNKWT3uCO+hw0Ewj0rbvlf8BRmm5+0n6K/qkTcCEWmu
        5SuAsLN3cljhmdET1tBQFZAFxpTm8ahX8siBx7QB6uB1cClFbtGHhMBQsPkFh9Vq
        fv3NVB53DMPGKs44GQMAKtUUzycgRWAIDxY5/Yx1XLbmy0+Q9JAhw4nsEhmKPMBS
        93a5/ydPO6TFXcyXyk76IzOcEYvmYlKr60ytaSMTsVUNkLWeYyhf0Vpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=mT/hndLP02vHoMwJt7GXmeWBo6eRejzgcBxnXIZrd
        8E=; b=oRbSmJV80B2eHaSsXQkviBzea8nzJNgn3mLneu/Zuc1osS1og1vVbdTzU
        zg+cI3WDMYuACoG1evo5UGymx4vVSB3wowe1741LuUw+Pk/zx2rEK/DKCJ6dl3kz
        lGUy5DRZg7i+aUKd6i8wkFC2LORriP5QqLg/RgQU0hfohU8HalZ7ttznY4e0OTzg
        YsDzUgFePPyJ8k/yxgO03+kZXmSkRkM6+79BR81nIhQSLP081SyWEQNCPPXxXRrS
        ptE1ezJeJ45E+Af0mkXDKUEBFQ88b69f98yFUUvHr41ke28xMdfOU2kxerx5iLDv
        xufe+bi5uoVpJVgpHH9sAfiWXGi5A==
X-ME-Sender: <xms:_YYSYlP2AwZaR7ia5v0mMQJIAqWi1L98FSKjDkNm_I8kbUQv4LWZ5Q>
    <xme:_YYSYn-PeHU8Cg1d0wzEuUNyffAvaTOfMD2mgZAr-1EjVtonOKoWV8Hdj4R2DL1St
    wMkTL4uPKKXvp3Znm0>
X-ME-Received: <xmr:_YYSYkSLtbdpLSUSGeUbnYwwb9iQ5so735XIwCRjzV6K1togYY3vzX_Z7_Bw6gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeggdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeeggfeiffegfefgffeugeeijeelleffvefgjeetuedvjefgtdev
    jeeghfetjeduvdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
    rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:_YYSYhvQ_vLJMuMgHJ04exsZC22dS6d548z6Eky2AF7EnLquV2cHVw>
    <xmx:_YYSYtehnuRoR3X0d5C5eJDgyTytQlRpqcQ9BERGIbxAmZnnFNtLkQ>
    <xmx:_YYSYt2uDAJkPMsKRKhjSFmhcCv1SJv0QkxhNJ3WB4LEyP_qlWokcA>
    <xmx:_oYSYvcqTrBF48FuziXJ_zDtznGpEPfGX2QowWTEGkGv8iMcgTC-1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Feb 2022 13:22:50 -0500 (EST)
Message-ID: <4dd5949f-2699-b83b-0fbf-c1b7beb0fa9a@flygoat.com>
Date:   Sun, 20 Feb 2022 18:22:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v10 2/4] Documentation/dt: Add descriptions for loongson
 display controller
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
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-3-15330273260@189.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220220145554.117854-3-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/2/20 14:55, Sui Jingfeng 写道:
> From: suijingfeng <suijingfeng@loongson.cn>
>
> Add DT documentation for loongson display controller found in LS2K1000,
> LS2K0500 and LS7A1000.
>
> v2: DT binding docs and includes should be a separate patch,
>      fix a warnning because of that.
>
> v3: split dt-bindings from other changes into a separate patch.
>
> v4: fix warnings and errors when running make dt_binding_check
>
> Reported-by: Rob Herring <robh@kernel.org>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>   .../loongson/loongson,display-controller.yaml | 122 ++++++++++++++++++
>   1 file changed, 122 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
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
Given that it is possible to have output subnodes I guess 
additionalProperties
should be allowed?

Thanks.
- Jiaxun
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
> +        };
> +    };
> +...

