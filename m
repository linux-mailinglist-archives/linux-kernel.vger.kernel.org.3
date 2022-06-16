Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0653054E5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377627AbiFPPZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376858AbiFPPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:25:16 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0036179;
        Thu, 16 Jun 2022 08:25:15 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id s1so1175084ilj.0;
        Thu, 16 Jun 2022 08:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y1YrCLGCWgqcE9VSgcEP/DpmziXDe/63yV+d7p5oWSI=;
        b=OfDVgf2mVx1RnrIFHlKyVwmZKQ0pNGntCxe75/r0nGR3lukfNGeqJRxIVx82DX/rJO
         PgbUjV3nOV6935bI5Kd9wBtNHt7uL81efd71PXQQTJyYgbVX0ZnmWO2tkD3dSEFZYU3T
         UjA87boKIBgnHEYvld2Smenu2+6i0j27NzHkDXOCXItyAbauAN/KD0tR9xthIhCISqUB
         vMSqMmeqY5ZsYuSj11gQd3B49ITKucM8MlHwthE21RQRU/gOH1QGgqk1K+q7JADbEA9G
         M5+5nluXgmaDz2PYli41DUDXZ6xWRU+HGl82i9lSQI0n29vUUdd1isGPefIU7gyDrLJg
         OkzQ==
X-Gm-Message-State: AJIora94x0N3H6grVmbeziZUR7PcLKhhNNy9u5VBOC3fZSRCvFJSM5uO
        VqbaZEe1WXJIP/C8V4bhFQ==
X-Google-Smtp-Source: AGRyM1uHshZPKfDOFM0JkV7l1XiWpFbQYKRVOip7hYFIDYiZPdJ+6MQyWW98n+bTLuelOCUKeiTKKw==
X-Received: by 2002:a92:d786:0:b0:2d5:3707:e446 with SMTP id d6-20020a92d786000000b002d53707e446mr3011076iln.244.1655393114712;
        Thu, 16 Jun 2022 08:25:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id d19-20020a056e020bf300b002d18e3dcb67sm1099580ilu.46.2022.06.16.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:25:14 -0700 (PDT)
Received: (nullmailer pid 3501441 invoked by uid 1000);
        Thu, 16 Jun 2022 15:25:12 -0000
Date:   Thu, 16 Jun 2022 09:25:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM devicetree
 bindings documentation
Message-ID: <20220616152512.GA3499420-robh@kernel.org>
References: <20220615070813.7720-1-romain.perier@gmail.com>
 <20220615070813.7720-2-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615070813.7720-2-romain.perier@gmail.com>
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

On Wed, Jun 15, 2022 at 09:08:09AM +0200, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> MSC313e RTC driver, it includes MSC313e SoCs and SSD20xd.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/pwm/mstar,msc313e-pwm.yaml       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> new file mode 100644
> index 000000000000..82f2357db085
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/mstar,msc313e-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mstar MSC313e PWM controller
> +
> +allOf:
> +  - $ref: "pwm.yaml#"
> +
> +maintainers:
> +  - Daniel Palmer <daniel@0x0f.com>
> +  - Romain Perier <romain.perier@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:

Don't need oneOf with only 1 entry.

> +      - items:
> +        - enum:
> +          - mstar,msc313e-pwm
> +          - mstar,ssd20xd-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: pwm@3400 {
> +      compatible = "mstar,msc313e-pwm";
> +      reg = <0x3400 0x400>;
> +      #pwm-cells = <2>;
> +      clocks = <&xtal_div2>;
> +    };
> -- 
> 2.35.1
> 
> 
