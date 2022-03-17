Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D014DCF26
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiCQULu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiCQULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:11:49 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8A29EE3E;
        Thu, 17 Mar 2022 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1647547824; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBhB5mnj+yU5UQCD6yhog64770XneXJJnfqfginvPmo=;
        b=eIHZgUYBBumSPI4xw5meu79N9cSbfki0qgEzFAf/RVYUvpkeFP4EkLreDOAlI+5YSidDqX
        c6BqiOViZLrayAJTMhSeN9IYJXETgI0f5ZqnktWoBauBv7mzqNwgrAi3uS8UFmwXzi/aWc
        TMl+T5IsLybiEqIOSn6YeyoWf2HzXAo=
Date:   Thu, 17 Mar 2022 20:10:14 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 4/4] dt-bindings: display/panel: Add Leadtek
 ltk035c5444t
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Message-Id: <21OW8R.3JWZ0IT11MIP2@crapouillou.net>
In-Reply-To: <20220311170240.173846-5-cbranchereau@gmail.com>
References: <20220311170240.173846-1-cbranchereau@gmail.com>
        <20220311170240.173846-5-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven., mars 11 2022 at 18:02:40 +0100, Christophe Branchereau=20
<cbranchereau@gmail.com> a =E9crit :
> Add binding for the leadtek ltk035c5444t, which is a 640x480
> mipi-dbi over spi / 24-bit RGB panel based on the newvision
> NV03052C chipset.
>=20
> It is found in the Anbernic RG350M mips handheld.
>=20
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>

Applied to drm-misc-next.

Thanks,
-Paul

> ---
>  .../display/panel/leadtek,ltk035c5444t.yaml   | 59=20
> +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.ya=
ml=20
> b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.ya=
ml
> new file mode 100644
> index 000000000000..817a9bed7d5a
> --- /dev/null
> +++=20
> b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.ya=
ml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id:=20
> http://devicetree.org/schemas/display/panel/leadtek,ltk035c5444t.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Leadtek ltk035c5444t 3.5" (640x480 pixels) 24-bit IPS LCD=20
> panel
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
> +    const: leadtek,ltk035c5444t
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
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        panel@0 {
> +            compatible =3D "leadtek,ltk035c5444t";
> +            reg =3D <0>;
> +
> +            spi-3wire;
> +            spi-max-frequency =3D <3125000>;
> +
> +            reset-gpios =3D <&gpe 2 GPIO_ACTIVE_LOW>;
> +
> +            backlight =3D <&backlight>;
> +            power-supply =3D <&vcc>;
> +
> +            port {
> +                panel_input: endpoint {
> +                    remote-endpoint =3D <&panel_output>;
> +                };
> +            };
> +        };
> +    };
> --
> 2.35.1
>=20


