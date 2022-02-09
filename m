Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A114AF8F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiBISFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiBISFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:05:33 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E8C05CB86;
        Wed,  9 Feb 2022 10:05:36 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so3413864oov.3;
        Wed, 09 Feb 2022 10:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rrqbDTVf+l/3lkEom+pSeGWQAUnx5BXiYzx4YBIV+jg=;
        b=VmQ3ZKXsQBXz6GvkRUHUW5i0AFr6tExJBHqSaCrXCheewpb3nbWb0wVfRraCVbak1L
         3f4fSaMYbRQyF76w//gfWUo6qibTM/Mw4QW6MOzwKgMo0NCewus11rLVcswuEQ/6Pyui
         uzE9Wt9L02te9Etegv7gIlWqaevmFNGktQI1ihbZuBaAKzbHQ5cfZSptdIXdbYCOGotj
         yt+FlhJk1Kjc/hyCXsKQYzNL3d+LEIzDX4Xj4oZpaJXVbnZcRj7rZHBTi4YEQsPcMNkg
         BzqG56PFEFD2jPSZMjQL+jQhVTLcPDPNt2tNYe5AjZnGlD/ERnOYYzmPXbNmEeL6fcXi
         dSgw==
X-Gm-Message-State: AOAM5335LY8XB7lzLJfSqdrYxYF0y5S4JjEoWPHCAzUgkMQ0Qqu2LZi2
        akTFTGBDcl2hjDRFcrxGYg==
X-Google-Smtp-Source: ABdhPJz3iEXjzpHt+ZGMsT28WR1Pqy3a9hiM+olpWpO/ymj9Eam87OimoJYrXV3QCuWq0UpkePOEYw==
X-Received: by 2002:a05:6870:d503:: with SMTP id b3mr1270275oan.57.1644429935779;
        Wed, 09 Feb 2022 10:05:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n66sm6975722oif.35.2022.02.09.10.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:05:35 -0800 (PST)
Received: (nullmailer pid 607810 invoked by uid 1000);
        Wed, 09 Feb 2022 18:05:33 -0000
Date:   Wed, 9 Feb 2022 12:05:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, kernel@axis.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: Add bindings for TPS62864x
Message-ID: <YgQCbVwMe69MHMaX@robh.at.kernel.org>
References: <20220204155241.576342-1-vincent.whitchurch@axis.com>
 <20220204155241.576342-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204155241.576342-2-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 04:52:40PM +0100, Vincent Whitchurch wrote:
> Add bindings for the TPS62864/TPS6286/TPS62868/TPS62869 voltage
> regulators.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../bindings/regulator/ti,tps62864.yaml       | 62 +++++++++++++++++++
>  include/dt-bindings/regulator/ti,tps62864.h   |  9 +++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
>  create mode 100644 include/dt-bindings/regulator/ti,tps62864.h
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
> new file mode 100644
> index 000000000000..e3d739a37ab0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/ti,tps62864.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPS62864/TPS6286/TPS62868/TPS62869 voltage regulator
> +
> +maintainers:
> +  - Vincent Whitchurch <vincent.whitchurch@axis.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tps62864
> +      - ti,tps62866
> +      - ti,tps62868
> +      - ti,tps62869
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "SW":

Not a pattern, use 'properties'. Actually it is a pattern, so 'fooSWbar' 
would be a valid node name.

> +        type: object
> +        $ref: regulator.yaml#

           unevaluatedProperties: false

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/regulator/ti,tps62864.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      regulator@48 {
> +        compatible = "ti,tps62864";
> +        reg = <0x48>;
> +
> +        regulators {
> +          SW {
> +            regulator-name = "+0.85V";
> +            regulator-min-microvolt = <800000>;
> +            regulator-max-microvolt = <890000>;
> +            regulator-initial-mode = <TPS62864_MODE_FPWM>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> diff --git a/include/dt-bindings/regulator/ti,tps62864.h b/include/dt-bindings/regulator/ti,tps62864.h
> new file mode 100644
> index 000000000000..8db31f23d956
> --- /dev/null
> +++ b/include/dt-bindings/regulator/ti,tps62864.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_REGULATOR_TI_TPS62864_H
> +#define _DT_BINDINGS_REGULATOR_TI_TPS62864_H
> +
> +#define TPS62864_MODE_NORMAL			0
> +#define TPS62864_MODE_FPWM			1
> +
> +#endif
> -- 
> 2.34.1
> 
> 
