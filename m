Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CCB5756BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbiGNVL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiGNVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:11:26 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72952445;
        Thu, 14 Jul 2022 14:11:25 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 123041B0011F;
        Fri, 15 Jul 2022 00:11:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1657833081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hkPRrVhg014vSftczUrkaj8GJSROx5XO5OafN6l7PA8=;
        b=FypAc4GMVjPAXMq6zsG+lhChm69w6J1ibMQZ9MMTENG6WiwMwoDVxgSVhU4N5opxClxCDA
        uB/MtXmPeNIW0YJn4eDQkE1REbAMH1LbLEhrGYcL68cavIQT9ttIz7Zt5yj4bJlJCt+Wxz
        xjrf9x/4D7RQFw7cVwMEQS66C+41t+YicHhpmMmFc5of0T5umeaPbgp7xRjZr5cYXDVbWQ
        mWCYIA0joNTOhLxBty89QdPGUUYupZ1I/eX2twZAqJjXveGRUU0sJqUmBDUmbsJS0RR3Tg
        +oWpGe9ZeZERW6yo78P9p8rc2EHhRzCRmftSoVa92LykkI8Q8F5gJrNZkYM9dg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id AC09E634D5F;
        Fri, 15 Jul 2022 00:11:20 +0300 (EEST)
Date:   Fri, 15 Jul 2022 00:11:20 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: media: i2c: document OV4689 DT
 bindings
Message-ID: <YtCGeBp5U18ljyuX@valkosipuli.retiisi.eu>
References: <20220712141925.678595-1-mike.rudenko@gmail.com>
 <20220712141925.678595-2-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712141925.678595-2-mike.rudenko@gmail.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1657833081; a=rsa-sha256;
        cv=none;
        b=vLgyybCLGayGmra7eX7USEJE6GUvJVYwEErSbfhWWk/AsmLt7k4JppDSqCbbCEeCVbcpA4
        jcKyJZHlhRpwjjRwGxWzhthbEXrbIKyQBUOciLWpI4uU083dJWJfwSrxJQJXJH/Nfhr2uc
        NiJFEBqpY9Wqgmub7Zy7aDAuprsU7AJpzXlXGNcJQYwPNpiI4OVW+7v5jSfdEqKspCdeY+
        XZeOTeYS6zdFe2qf0W3G/zoBPdocC2/cG6xRfpOU4sJ8fAu625K7JR4eWiaRc5pwWsjCBA
        rESHCeETGY31GIPTXYOH0YHV3mzEBi4KG+MeSouu3Gcipga9W35wlzQAzL1DXw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1657833081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hkPRrVhg014vSftczUrkaj8GJSROx5XO5OafN6l7PA8=;
        b=RWdHu8/HFe/PAfEBxex/VjLMmgwzo7f1NVHxBTWZXu+y9QQ7JyvaYfMyMVcYxw2OoJRRYg
        Z9mlKtVfqZhTH49v9OmURgZHKrmLTC9go3ovVEkbhrs/8rs15FlwlPr4Q2Lu4GnfsMKZCZ
        2R38J6UPe+BdlwYrm5tuuwm//faqpctlZaeP+NY0iy2CkLcjSAOsV1/kY4MEeKWSrIM7L2
        BBziwp1kYqXSOrfOsP5U53WsZP5/YncFYqr26rcVu3Sgq8bR4iTSgiUN9pAeIeC6K7zgdh
        8s2dEy5+LZchTqo4FEjiSQCDc4/1whptCenIJP/tLsHIJmNZBl44nfTMkqFjYQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

Thanks for the patch.

On Tue, Jul 12, 2022 at 05:19:09PM +0300, Mikhail Rudenko wrote:
> Add device-tree binding documentation for OV4689 image sensor driver,
> and the relevant MAINTAINERS entries.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  .../bindings/media/i2c/ovti,ov4689.yaml       | 122 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> new file mode 100644
> index 000000000000..6bdebe5862b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Omnivision OV4689 CMOS Sensor Device Tree Bindings
> +
> +maintainers:
> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
> +
> +description: |-
> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
> +  at 2688x1520 resolution. It is programmable through an I2C
> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> +  connection.
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: ovti,ov4689
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description:
> +      External clock for the sensor.
> +    items:
> +      - const: xclk
> +
> +  dovdd-supply:
> +    description:
> +      Definition of the regulator used as Digital I/O voltage supply.
> +
> +  avdd-supply:
> +    description:
> +      Definition of the regulator used as Analog voltage supply.
> +
> +  dvdd-supply:
> +    description:
> +      Definition of the regulator used as Digital core voltage supply.
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      Reference to the GPIO connected to the powerdown pin (active low).
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Reference to the GPIO connected to the reset pin (active low).
> +
> +  orientation: true
> +
> +  rotation: true
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +    description:
> +      Output port node, single endpoint describing the CSI-2 transmitter.
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false

The number of lanes is needed, please require data-lanes property here (as
well as add it to the example).

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - dovdd-supply
> +  - avdd-supply
> +  - dvdd-supply
> +  - powerdown-gpios
> +  - reset-gpios
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ov4689: camera@36 {
> +            compatible = "ovti,ov4689";
> +            reg = <0x36>;
> +
> +            clocks = <&ov4689_clk>;
> +            clock-names = "xclk";
> +
> +            avdd-supply = <&ov4689_avdd>;
> +            dovdd-supply = <&ov4689_dovdd>;
> +            dvdd-supply = <&ov4689_dvdd>;
> +
> +            powerdown-gpios = <&pio 107 GPIO_ACTIVE_LOW>;
> +            reset-gpios = <&pio 109 GPIO_ACTIVE_LOW>;
> +
> +            orientation = <2>;
> +            rotation = <0>;
> +
> +            port {
> +                wcam_out: endpoint {
> +                    remote-endpoint = <&mipi_in_wcam>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f468864fd268..63c4844f26e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14523,6 +14523,13 @@ S:	Maintained
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/i2c/ov2740.c
>  
> +OMNIVISION OV4689 SENSOR DRIVER
> +M:	Mikhail Rudenko <mike.rudenko@gmail.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> +
>  OMNIVISION OV5640 SENSOR DRIVER
>  M:	Steve Longerbeam <slongerbeam@gmail.com>
>  L:	linux-media@vger.kernel.org

-- 
Regards,

Sakari Ailus
