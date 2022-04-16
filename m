Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D586503451
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiDPCHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiDPCGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:01 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354692194;
        Fri, 15 Apr 2022 18:59:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 91AF53202184;
        Fri, 15 Apr 2022 21:59:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 15 Apr 2022 21:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650074358; x=
        1650160758; bh=DsIZSVRAwE42Gn8ZixFtjn0uMkrlMndqIZ6G0Y5AI/4=; b=v
        ofQvzTSJzQ9MkUg0exyz/hODYtwDf1fGYIm3zRStBhNtrkRlgowagO+bOWO8cUzh
        q23DqehxcTwcrRlb4RfTk3fZO7kOhZWcRyzVf3KmVDHn3eRXjFIaBV9WLcCWbq2a
        RU3rEmvtfGNhsbbC2LlpCuOzV2RXVIDhLCJXJ87rCIxE4KuofTPeNiJrHYVNhDsR
        2bn378XD2Mn48LTLZMYMIc2snNQ6XeI8eIiLsvTSf09OdL67+q1WmtqZgxqA4AUn
        QpzkdfOdaXX3ccjSqaUyqKyCfE/yDYKNctOEUoTXgr+hgnpcAXUWXNN93gZ57NZf
        5SMLiqXmGRi2gSn/lDJyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650074358; x=1650160758; bh=DsIZSVRAwE42G
        n8ZixFtjn0uMkrlMndqIZ6G0Y5AI/4=; b=bYVuTgUYBsQTNnlxU5US0jyiPBbXZ
        mFG6lTqRrEr42liDgqrarHGFmcWTM3tAAE/8WhCz2EsgxzGoMFti1oHtWF64G3Ss
        yrDzkMM5P3QgAeixj3hzJwfqda2x2KBtcTqjHRXxOzLIj8Y0Avio6yaJblorrK0Z
        hS/JXCOtbLwu2ERmhWfDJagU3nMqUNctjRzGax38Shhk1yu43esCLMHYAUBzeU3w
        2sBADRZJGDwuLDdo73dbxjpSJQLN50TL4hHfUHTc9qYXy9TWSmCPRWBpIfneQdDr
        MMTNowdfCXZTHpc7mqr6nHzjPEYLK+trxeIGkIZ0mO66rmNll7p5zWeZA==
X-ME-Sender: <xms:9SJaYvpc2lX9S77Y_psFb_TnC2je-Wlk1MQe_tfJyC7_IPLiPFALYw>
    <xme:9SJaYppO8Ie-u9jC4_2nnMypdN9K32jQZk4WBnZ0E0IH8--zOEoMENqikEnDB2ExS
    H3woy9YAY-C6rcb0A>
X-ME-Received: <xmr:9SJaYsMrSMF-8DAbhBq7N3BcxdY-2JM88babmgpCyWtpYOf-95uQhD94IyAVSY4zj2dlSqUK7kvvis1sjTHoWyxJLelH2YcLHTFhp7WwN3AcM7PE78Az6XCE-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeliedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffeigfelvdfgtdetleduveevgfdutdeiuddtveetvdfhffejlefh
    heetjeetvdelnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:9SJaYi5As9kW734rNq9qWZhgGxtOhnvlUmZL_v-yrLAXRFHVFcrGMQ>
    <xmx:9SJaYu5rpwcaHozDnmeQ0KRPrMDDeBN-VLpR3VTrQ_RUfKcJ04HUJA>
    <xmx:9SJaYqhkjxHh8wMLMpeP9SJtZstFEHq2IJ6gblbyz0Gtug3ilQuXeA>
    <xmx:9iJaYhqU14ncJuMjdwFgtppOKgNv_VuguB75Be41zWPEUje1WYVizg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Apr 2022 21:59:16 -0400 (EDT)
Subject: Re: [PATCH v3 1/4] dt-bindings: media: Add Allwinner A31 ISP bindings
 documentation
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-2-paul.kocialkowski@bootlin.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <19aa74b7-0096-87c5-ef2c-9a135ad5505a@sholland.org>
Date:   Fri, 15 Apr 2022 20:59:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220415153708.637804-2-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 10:37 AM, Paul Kocialkowski wrote:
> This introduces YAML bindings documentation for the Allwinner A31 Image
> Signal Processor (ISP).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> new file mode 100644
> index 000000000000..ffca216b841f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tree Bindings
> +
> +maintainers:
> +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun6i-a31-isp
> +      - allwinner,sun8i-v3s-isp
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock
> +      - description: DRAM Clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: mod
> +      - const: ram
> +
> +  resets:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: CSI0 input port
> +
> +        properties:
> +          reg:
> +            const: 0
> +
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +        additionalProperties: false
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: CSI1 input port
> +
> +        properties:
> +          reg:
> +            const: 0

Should be "const: 1".

Otherwise,
Reviewed-by: Samuel Holland <samuel@sholland.org>

> +
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +        additionalProperties: false
> +
> +    anyOf:
> +      - required:
> +        - port@0
> +      - required:
> +        - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
> +    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
> +
> +    isp: isp@1cb8000 {
> +        compatible = "allwinner,sun8i-v3s-isp";
> +        reg = <0x01cb8000 0x1000>;
> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&ccu CLK_BUS_CSI>,
> +             <&ccu CLK_CSI1_SCLK>,
> +             <&ccu CLK_DRAM_CSI>;
> +        clock-names = "bus", "mod", "ram";
> +        resets = <&ccu RST_BUS_CSI>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                isp_in_csi0: endpoint {
> +                    remote-endpoint = <&csi0_out_isp>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> 

