Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC154A0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347654AbiFMVFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352125AbiFMVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:04:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59899344E5;
        Mon, 13 Jun 2022 13:38:13 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA3FD6601687;
        Mon, 13 Jun 2022 21:38:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655152691;
        bh=PZkwmDEMPHlMVYu46SGLuTz7ZFvWU8pB2VTaRlvFwiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRsmNCUb0UyZdvroSbeDYzV+HZKrogRGU1DzzKl105cp5S3RXSNz5gdrsWVOK+Ael
         muB45NmzAKVwrDkhN+ihSkz2mWtHReTERwNJlVotC7nr2dcDaBCZJGffST95c+PgBD
         mRgDNCqpSD2Pcc5XLpONQ1ZTaT6tzGrzlsDcXr3M8oxYxlkLbfkB8x2fELgrCqD/Wj
         XNGqXavYGRKhddltYnZCJZEJ8iesNuCZVNyg45QcnM5MPgkjsLkvLC79THFcIRa4Ee
         zaji90f6/DIDchoUWlLt9cGnGQhcR0cN2Gs7lg+UKBu3sxUHRpubF3nJ0mYPuEdS2+
         59t251l7Xr5cA==
Date:   Mon, 13 Jun 2022 16:38:04 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: usb: Add Type-C switch binding
Message-ID: <20220613203804.3d23gxidkw657ggq@notapiano>
References: <20220609181106.3695103-1-pmalani@chromium.org>
 <20220609181106.3695103-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609181106.3695103-4-pmalani@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

thanks for the patch. Please see sugestions below.

On Thu, Jun 09, 2022 at 06:09:42PM +0000, Prashant Malani wrote:
> Introduce a binding which represents a component that can control the
> routing of USB Type-C data lines as well as address data line
> orientation (based on CC lines' orientation).
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes since v1:
> - Removed "items" from compatible.
> - Fixed indentation in example.
> 
>  .../devicetree/bindings/usb/typec-switch.yaml | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> new file mode 100644
> index 000000000000..78b0190c8543
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/typec-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB Type-C Switch
> +
> +maintainers:
> +  - Prashant Malani <pmalani@chromium.org>
> +
> +description:
> +  A USB Type-C switch represents a component which routes USB Type-C data
> +  lines to various protocol host controllers (e.g USB, VESA DisplayPort,
> +  Thunderbolt etc.) depending on which mode the Type-C port, port partner
> +  and cable are operating in. It can also modify lane routing based on
> +  the orientation of a connected Type-C peripheral.
> +
> +properties:
> +  compatible:
> +    const: typec-switch
> +
> +  mode-switch:
> +    type: boolean
> +    description: Specify that this switch can handle alternate mode switching.
> +
> +  orientation-switch:
> +    type: boolean
> +    description: Specify that this switch can handle orientation switching.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph binding modelling data lines to the Type-C switch.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Link between the switch and a Type-C connector.

Since you have a single port, you can omit the ports node.

> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - ports
> +
> +anyOf:
> +  - required:
> +      - mode-switch
> +  - required:
> +      - orientation-switch
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    drm-bridge {
> +        usb-switch {
> +            compatible = "typec-switch";
> +            mode-switch;
> +            orientation-switch;
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    anx_ep: endpoint {
> +                        remote-endpoint = <&typec_controller>;
> +                    };
> +                };
> +            };

So instead of ports you would have just 

               port {
                   anx_ep: endpoint {
                       remote-endpoint = <&typec_controller>;
                   };
               };

And the same simplification on patch 4, for the anx7625 dt-binding.

Thanks,
Nícolas

> +        };
> +    };
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
