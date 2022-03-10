Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC32B4D549D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbiCJWbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbiCJWbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:31:31 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CED6E780;
        Thu, 10 Mar 2022 14:30:29 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id k2so7506864oia.2;
        Thu, 10 Mar 2022 14:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QgsxXyFOq3l25bXti8NLl84pw0GBdK3rJLSXLxd5bVM=;
        b=QwmvtKpKgHy4ag2jEelgtJmC+utVJaQNPBDtC8ixbm8GbZ4xEZcMBlkMatgvcRKj7G
         21nDupUvc6jqWfvp+sOfJDLZ9WzHoIQ0ghVOrI7wghFQDHcz1Ij7u2QM+7JxoIDk8sFT
         V9Nv3yyI/TEIwLrTBVgvbDmSIaEQmA/2HmBYRtEbIL2bsV2q+Z2WjS/+bE+o0yb4F7wb
         F41cQ0djgDGXqobX4um1PgFAwVKKwxBG7GwI07RYyRhkTVbzLUwyp/+unagTPHjVO3S0
         IRBRllgdVRI40Lt7oBAlYyPFgtPTLeNOKj0Lm2tGHSRZZznYqJs66pLkSK2kFYSwRMIn
         06tg==
X-Gm-Message-State: AOAM530ogGX2YWOEvHEF9f+mUfElyBDW2M99rrR1lyvz8Bxjr31kwT8T
        rShIY8zJGQEEksViSBFMs+2Ys8fmNA==
X-Google-Smtp-Source: ABdhPJw8UgGUb+MPsmipA4UiovKQSeBz5DUILfrQ84BK1zdLiAlN7+stCSQ0BUoZDDLGNiSmsey7wQ==
X-Received: by 2002:aca:be09:0:b0:2da:1e9b:e866 with SMTP id o9-20020acabe09000000b002da1e9be866mr9227944oif.208.1646951428619;
        Thu, 10 Mar 2022 14:30:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b000ccfbea4f23sm3178331oae.33.2022.03.10.14.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:30:27 -0800 (PST)
Received: (nullmailer pid 2204129 invoked by uid 1000);
        Thu, 10 Mar 2022 22:30:26 -0000
Date:   Thu, 10 Mar 2022 16:30:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: display/panel: Add Leadtek
 ltk035c5444t
Message-ID: <Yip8AiKNOILjf0uj@robh.at.kernel.org>
References: <20220308130643.260683-1-cbranchereau@gmail.com>
 <20220308130643.260683-5-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308130643.260683-5-cbranchereau@gmail.com>
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

On Tue, Mar 08, 2022 at 02:06:43PM +0100, Christophe Branchereau wrote:
> Add binding for the leadtek ltk035c5444t, which is a 640x480
> mipi-dbi over spi / 24-bit RGB panel based on the newvision
> NV03052C chipset.
> 
> It is found in the Anbernic RG350M mips handheld.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---
>  .../panel/leadtek,ltk035c5444t-spi.yaml       | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml

We have 18 SPI based panels already:

$ git grep -i 'spi.* {' Documentation/devicetree/bindings/display/panel/
Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml:    spi {
Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml:    spi {
Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml:    spi {
Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml:    spi {
Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml:    spi {
Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml:    spi {
Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml:    spi {
Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml:    spi {
Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml:    spi0 {
Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml:    spi {
Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml:    spi {
Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml:    spi {
Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml:    spi {
Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml:    spi {
Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml:    spi {
Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml:    spi {
Documentation/devicetree/bindings/display/panel/tpo,td.yaml:    spi {
Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml:    spi {

Most except for the Samsung ones look like they'd fit in our definition 
of 'simple panels' which primarily means 1 supply.

So I think it is time for a panel-simple-spi.yaml binding to combine all 
these. But I'm not going to make the person adding the 19th case to do 
that, and this otherwise looks fine:

Reviewed-by: Rob Herring <robh@kernel.org>

With one nit fixed below:

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml
> new file mode 100644
> index 000000000000..9b6f1810adab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/leadtek,ltk035c5444t-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Leadtek ltk035c5444t 3.5" (640x480 pixels) 24-bit IPS LCD panel
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +  - Christophe Branchereau <cbranchereau@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: leadtek,ltk035c5444t-spi

'-spi' is redundant, so drop.

> +
> +  backlight: true
> +  port: true
> +  power-supply: true
> +  reg: true
> +  reset-gpios: true
> +
> +required:
> +  - compatible
> +  - power-supply
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel@0 {
> +            compatible = "leadtek,ltk035c5444t-spi";

And update the example...

> +            reg = <0>;
> +
> +            spi-3wire;
> +            spi-max-frequency = <3125000>;
> +
> +            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
> +
> +            backlight = <&backlight>;
> +            power-supply = <&vcc>;
> +
> +            port {
> +                panel_input: endpoint {
> +                    remote-endpoint = <&panel_output>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
> 
