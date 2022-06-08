Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71715435C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbiFHOxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiFHOwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:52:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C6362C5D;
        Wed,  8 Jun 2022 07:51:04 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h8so723999iof.11;
        Wed, 08 Jun 2022 07:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpPfGx+ya8x2JljdpaaMlVFLU3uBTp8K04ETijPhfOM=;
        b=Q1xeIDMuqLyFdRqQZAtgNJPonnA6yjfZ/5TdL/6F042QoOPUpO3ZpHP9ncEn+cVXjb
         Zy5BdcRqz7CIcVmYbP0jWszCM63GgNt7cL7WcGvZ9gTprvkOrA+cKTPKdkJvLSiDosIr
         sPmCNpvFvq/Rx2G4j38qsUSOXsD+nHFzGcaNrNxzZcr8rYE37kLOLKDkmGl20BzsYCVk
         qHUcZxkfVnEnyLvdq6Sjy2r4LxA2P5glf5B4YnDF2pFd05lr2MwOSAtLNeeI2Opx1PhB
         boxyNJXdvXNmXdqWhDG8ay5Ipvum45d2cQI2b7LmrtPn+PNm5j9uEwC5r9U8t8CWHh6l
         ZLCQ==
X-Gm-Message-State: AOAM5329VASdYBNQ1QOwimDwmjZV20qKi65oQD0f2KmjEu4CcBGqhGNe
        iNAdvodOrrYZIUPqezC2dz6FBtgVaw==
X-Google-Smtp-Source: ABdhPJzOnYPieiilKsMevnIGVxmRS85Gff9BgZOBvO3la3EOiMcvigdWjz8nadOg8Epv471+N3K7Ww==
X-Received: by 2002:a02:164a:0:b0:331:5661:75b2 with SMTP id a71-20020a02164a000000b00331566175b2mr18458434jaa.122.1654699781569;
        Wed, 08 Jun 2022 07:49:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id cv12-20020a056638498c00b0032b3a7817acsm8092684jab.112.2022.06.08.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:49:41 -0700 (PDT)
Received: (nullmailer pid 1375513 invoked by uid 1000);
        Wed, 08 Jun 2022 14:49:39 -0000
Date:   Wed, 8 Jun 2022 08:49:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: phy: add binding document for Allwinner
 F1C100s USB PHY
Message-ID: <20220608144939.GA1366879-robh@kernel.org>
References: <20220608070452.338006-1-uwu@icenowy.me>
 <20220608070452.338006-3-uwu@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608070452.338006-3-uwu@icenowy.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 03:04:47PM +0800, Icenowy Zheng wrote:
> Allwinner F1C100s has the most simple USB PHY among all Allwinner SoCs,
> because it has only one OTG USB controller, no host-only OHCI/EHCI
> controllers.
> 
> Add a binding document for it.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  .../phy/allwinner,suniv-f1c100s-usb-phy.yaml  | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
> new file mode 100644
> index 000000000000..180fa8840bf7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/allwinner,suniv-f1c100s-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner F1C100s USB PHY Device Tree Bindings
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +properties:
> +  "#phy-cells":
> +    const: 1
> +
> +  compatible:
> +    const: allwinner,suniv-f1c100s-usb-phy
> +
> +  reg:
> +    maxItems: 1
> +    description: PHY Control registers
> +
> +  reg-names:
> +    const: phy_ctrl
> +
> +  clocks:
> +    maxItems: 1
> +    description: USB OTG PHY bus clock
> +
> +  clock-names:
> +    const: usb0_phy

*-names is not needed with only one entry. Plus, just using the module 
name is not a great choice.

> +
> +  resets:
> +    maxItems: 1
> +    description: USB OTG reset
> +
> +  reset-names:
> +    const: usb0_reset

Same here.

> +  usb0_id_det-gpios:
> +    maxItems: 1
> +    description: GPIO to the USB OTG ID pin
> +
> +  usb0_vbus_det-gpios:
> +    maxItems: 1
> +    description: GPIO to the USB OTG VBUS detect pin
> +
> +  usb0_vbus_power-supply:
> +    description: Power supply to detect the USB OTG VBUS
> +
> +  usb0_vbus-supply:
> +    description: Regulator controlling USB OTG VBUS

Why the 'usb0_' prefix?

Are these GPIOs and Vbus supply connected to the phy? If not, these all 
belong in a connector node (as that is where they are connected to in 
h/w).

> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - reg
> +  - reg-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/suniv-f1c100s-ccu.h>
> +    #include <dt-bindings/reset/suniv-f1c100s-ccu.h>
> +
> +    phy@1c13400 {
> +        compatible = "allwinner,suniv-f1c100s-usb-phy";
> +        reg = <0x01c13400 0x10>;
> +        reg-names = "phy_ctrl";
> +        clocks = <&ccu CLK_USB_PHY0>;
> +        clock-names = "usb0_phy";
> +        resets = <&ccu RST_USB_PHY0>;
> +        reset-names = "usb0_reset";
> +        #phy-cells = <1>;
> +        usb0_id_det-gpios = <&pio 4 2 GPIO_ACTIVE_HIGH>;
> +    };
> -- 
> 2.36.0
> 
> 
