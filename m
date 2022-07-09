Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99C256CB6F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 22:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGIUre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 16:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGIUrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 16:47:33 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F811176
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=sUNoqOKr3Tu/6aqk6b9hgMDsaxDWvMdhP4oY4f5l4lw=;
        b=rdfHxxh4Lo4znjQzElJHofxDTwWXE/d3oU8CmDWIF4YnmaVyge33Y2U2x1xCPVuSGAIt9TKqn2wDL
         pz0/3WbmNVqAxqh4c/eVdT3YbcK0oebcYMlJtsku7zisuhP936eFt3uCxk4PWgs2pz6YDk7pR9vd7f
         AMVp1DrpGBz2tNdGyF/tW6uayTEccFU9oabFaBQv5YQEMckusOvScCz29UKkQZQ9LMULtR9B7TsVQR
         0bYOGxaSxIMsxYD4yi0rP2OjY8dY9/QJR3xkRpB5QBk9vZK23DVkO+Fd8VkLtL4dSyQRf88DBOX+PG
         Kn7k2110suOcLLDjB1E/nhqhRCwXQPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=sUNoqOKr3Tu/6aqk6b9hgMDsaxDWvMdhP4oY4f5l4lw=;
        b=id6bzscFnVGcmv4gdOzXpl+0kNM4KtuVsKgc8pCSEwZCHjv8gTkR8nPLVXmEPnZLODdz07lecbBkd
         VMo2icjBQ==
X-HalOne-Cookie: f2222cbad2f8d91fdb9fea67c5ad6a212aff1d89
X-HalOne-ID: 57456efd-ffc8-11ec-be7e-d0431ea8bb03
Received: from mailproxy2.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 57456efd-ffc8-11ec-be7e-d0431ea8bb03;
        Sat, 09 Jul 2022 20:47:26 +0000 (UTC)
Date:   Sat, 9 Jul 2022 22:47:25 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     MollySophia <mollysophia379@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT35596S
 panel bindings
Message-ID: <YsnpXU2w1wsXiGrs@ravnborg.org>
References: <20220709141136.58298-1-mollysophia379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709141136.58298-1-mollysophia379@gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Molly,

thanks for the quick response to the review comments.

On Sat, Jul 09, 2022 at 10:11:35PM +0800, MollySophia wrote:
> Add documentation for "novatek,nt35596s" panel.
> 
> Signed-off-by: MollySophia <mollysophia379@gmail.com>
The s-o-b needs your real name - guess the above is a concatenation of
first name and surname.

The binding included in this patch fails the check:
$ make DT_CHECKER_FLAGS=-m dt_binding_check

You may need to run:
$ pip3 install dtschema --upgrade

Or you may have to install some dependencies first.
The problem is that the patch is missing a "reset-gpios: true"

On top of this I looked at the binding - and the description
this is copied from is almost identical.
So another approach would be to extend the existing binding like
in the following.

And this also gives a good hint that maybe this can be embedded in
the existing driver - and there is no need for a new driver.
Could you try to give this a spin and get back on this.

Sorry for not seeing this in the first place.

	Sam

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 41ee3157a1cd..913bb81ae93d 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -20,14 +20,20 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - tianma,fhd-video
-      - const: novatek,nt36672a
+    oneOf:
+      - items:
+          - enum:
+              - tianma,fhd-video
+          - const: novatek,nt36672a
+
+      - items:
+          - enum:
+              - jdi,fhd-nt35596s
+          - const: novatek,nt35596s
+
     description: This indicates the panel manufacturer of the panel that is
-      in turn using the NT36672A panel driver. This compatible string
-      determines how the NT36672A panel driver is configured for the indicated
-      panel. The novatek,nt36672a compatible shall always be provided as a fallback.
+       in turn using the NT36672A or the NT35596S panel driver. This compatible string
+       determines how the panel driver is configured for the indicated panel.
 
   reset-gpios:
     maxItems: 1
@@ -85,4 +91,27 @@ examples:
         };
     };
 
+    dsi1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "jdi,fhd-nt35596s", "novatek,nt35596s";
+            reg = <0>;
+            vddi0-supply = <&vreg_l14a_1p88>;
+            vddpos-supply = <&lab>;
+            vddneg-supply = <&ibb>;
+
+            backlight = <&pmi8998_wled>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+            port {
+                jdi_nt35596s_in_1: endpoint {
+                    remote-endpoint = <&dsi1_out>;
+                };
+            };
+        };
+    };
+
+
 ...

> ---
>  .../display/panel/novatek,nt35596s.yaml       | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml
> new file mode 100644
> index 000000000000..f724f101a6fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt35596s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT35596S based DSI display Panels
> +
> +maintainers:
> +  - Molly Sophia <mollysophia379@gmail.com>
> +
> +description: |
> +  The nt35596s IC from Novatek is a generic DSI Panel IC used to drive dsi
> +  panels.
> +  Right now, support is added only for a JDI FHD+ LCD display panel with a
> +  resolution of 1080x2160. It is a video mode DSI panel.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - jdi,fhd-nt35596s
> +      - const: novatek,nt35596s
> +    description: This indicates the panel manufacturer of the panel that is
> +      in turn using the NT35596S panel driver. This compatible string
> +      determines how the NT35596S panel driver is configured for the indicated
> +      panel. The novatek,nt35596s compatible shall always be provided as a fallback.
> +
> +  vddi0-supply:
> +    description: regulator that provides the supply voltage
> +      Power IC supply
> +
> +  vddpos-supply:
> +    description: positive boost supply regulator
> +
> +  vddneg-supply:
> +    description: negative boost supply regulator
> +
> +  reg: true
> +  port: true
> +  backlight: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddi0-supply
> +  - vddpos-supply
> +  - vddneg-supply
> +  - reset-gpios
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "jdi,fhd-nt35596s", "novatek,nt35596s";
> +            reg = <0>;
> +            vddi0-supply = <&vreg_l14a_1p88>;
> +            vddpos-supply = <&lab>;
> +            vddneg-supply = <&ibb>;
> +
> +            backlight = <&pmi8998_wled>;
> +            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +
> +            port {
> +                jdi_nt35596s_in_0: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.37.0
