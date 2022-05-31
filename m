Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720EC538FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiEaLpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343891AbiEaLpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:45:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857A68DDFF;
        Tue, 31 May 2022 04:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33D15B80FB3;
        Tue, 31 May 2022 11:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE74C385A9;
        Tue, 31 May 2022 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653997518;
        bh=jODhV9sVWgDMOncckTb9rlVg7HE1GMWluvYU3vHcQQw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T/jM5cQwlJy5RlsQ3RmAF2rR6nSCTb4ZafGhYV1lwqUVtBw/IIcpex8bHtTjeaI3/
         52K2AUShelO3J/lvZ4XtohN6LhEXMjdDRLkd8g5lG6MjMfFhUShnkM9PON6Wj0ONRq
         ctpaD2Kwind/XUNcsB/4fajLbaFJumhG5/C4LOY1OS+O7OsAvH1DSSjTUBlLUkTXIa
         cOYZn2esO2vxTbayF24reFPQfPXtum95iCaZ7yrL9E164SXhingiBnsicdTRqfkE5P
         3/zjGsRQqvlYG+ISpTGljlJmqKG2AX7Yxo1vxgbZApXwDYjlnj1V3JTXr/tpfM50zV
         J/4Hlfk8UeyZw==
Message-ID: <26603540-8887-ef8d-8f4d-26f2f33d2a6f@kernel.org>
Date:   Tue, 31 May 2022 14:45:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220531111221.22963-1-s-vadapalli@ti.com>
 <20220531111221.22963-2-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220531111221.22963-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth,

On 31/05/2022 14:12, Siddharth Vadapalli wrote:
> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
> that are not supported on earlier SoCs. Add a compatible for it.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       |  5 ++++
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index fa86691ebf16..e381ba62a513 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -48,6 +48,11 @@ patternProperties:
>      description:
>        This is the SERDES lane control mux.
>  
> +  "phy@[0-9a-f]+$":
> +    type: object
> +    description:
> +      This is the register to set phy mode through phy-gmii-sel driver.
> +

Is this really required? The system controller has 100s of different such registers and it is not practical to mention about all.

>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> index ff8a6d9eb153..7427758451e7 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> @@ -53,12 +53,21 @@ properties:
>        - ti,am43xx-phy-gmii-sel
>        - ti,dm814-phy-gmii-sel
>        - ti,am654-phy-gmii-sel
> +      - ti,j7200-cpsw5g-phy-gmii-sel

Why not just "ti,j7200-phy-gmii-sel" so it is consistent naming.

>  
>    reg:
>      maxItems: 1
>  
>    '#phy-cells': true
>  
> +  ti,enet-ctrl-qsgmii:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Required only for QSGMII mode. Bitmask to select the port for
> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
> +      ports automatically. Any of the 4 CPSW5G ports can act as the
> +      main port with the rest of them being the QSGMII_SUB ports.
> +

This is weird way of doing things.

The Ethernet controller driver already knows which mode the port is
supposed to operate.

e.g.
+&cpsw0_port1 {
+	phy-handle = <&cpsw5g_phy0>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 1>;
+};
+
+&cpsw0_port2 {
+	phy-handle = <&cpsw5g_phy1>;
+	phy-mode = "qsgmii-sub";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 2>;

And it can convey the mode to the PHY driver via phy_ops->set_mode.
So you should be depending on that instead of adding this new property.

>  allOf:
>    - if:
>        properties:
> @@ -73,6 +82,19 @@ allOf:
>          '#phy-cells':
>            const: 1
>            description: CPSW port number (starting from 1)
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,j7200-cpsw5g-phy-gmii-sel
> +    then:
> +      properties:
> +        '#phy-cells':
> +          const: 1
> +          description: CPSW port number (starting from 1)
> +        ti,enet-ctrl-qsgmii:
> +          enum: [1, 2, 4, 8]
>    - if:
>        properties:
>          compatible:
> @@ -97,7 +119,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    phy_gmii_sel: phy-gmii-sel@650 {
> +    phy_gmii_sel: phy@650 {
>          compatible = "ti,am3352-phy-gmii-sel";
>          reg = <0x650 0x4>;
>          #phy-cells = <2>;

cheers,
-roger
