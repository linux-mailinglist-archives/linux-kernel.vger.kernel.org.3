Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288BB4FFE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiDMS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiDMS62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:58:28 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70B5C647;
        Wed, 13 Apr 2022 11:56:06 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id m16-20020a9d73d0000000b005f8edc0599eso80783otk.11;
        Wed, 13 Apr 2022 11:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HMhybcheRcGSweV7LIGaBaLpBUWrj9ciib2Np2r6dcs=;
        b=1Lzq3ab+j0kS6HEBk+0wrU3c1vmfJha3ky6XUh2fcyV2vrRjhFAf+NdX5WlS/C8ykg
         9bjUWChepWXwBkvKhJhmU75daUhEK3DKmfdMcbBMLPO4RPs8IqQLz7UrEOwObyIFxFLH
         fnbOBnqjYhzxAsVg03w6quahvAvPlQLuUDxEomw8+71ZC81+gGRS1ygLY31ci4YAIPK2
         5PtlQUfKCGcSDq1lt8BdptBdwNpj+Q80iGATFKuoOw7v+LiI/ruMup0bnAowVLgKUf+i
         egIbIm6fcoliG6/23uR0QaBNiwSqiG6/gWUvtM0KatLHWRCMbb0zxYe5nBi2+etiQPYK
         Y+Zg==
X-Gm-Message-State: AOAM533GIbKy8LcqJvClGD5r9ffhbLnAJcBnZQHUEGz41uQAYLSxdTf9
        wTCA0wQXP4/RIfSJR9/Zjg==
X-Google-Smtp-Source: ABdhPJxyYSAicqv+uK0Jwen+s6Jag+PUSCGdYsmme/IUpuB5pEHHNG02Yy9wTNLZ5QVh3u92QLUNIA==
X-Received: by 2002:a05:6830:1b78:b0:5c9:48b3:8ab with SMTP id d24-20020a0568301b7800b005c948b308abmr15533851ote.235.1649876165337;
        Wed, 13 Apr 2022 11:56:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg39-20020a056820082700b00324c8eba341sm14432288oob.18.2022.04.13.11.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:56:05 -0700 (PDT)
Received: (nullmailer pid 3641502 invoked by uid 1000);
        Wed, 13 Apr 2022 18:56:04 -0000
Date:   Wed, 13 Apr 2022 13:56:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: uniphier: Use
 unevaluatedProperties and common bindings
Message-ID: <YlccxAQ9adSZh22F@robh.at.kernel.org>
References: <1649317533-21139-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649317533-21139-1-git-send-email-hayashi.kunihiko@socionext.com>
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

On Thu, Apr 07, 2022 at 04:45:33PM +0900, Kunihiko Hayashi wrote:
> This adds common bindings thermal-sensor.yaml and this is preferred for
> unevaluatedProperties instead of additionalProperties.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/thermal/socionext,uniphier-thermal.yaml         | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> index c5b25ce44956..537c93da1397 100644
> --- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> @@ -14,6 +14,9 @@ description: |
>  maintainers:
>    - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>  
> +allOf:
> +  - $ref: "thermal-sensor.yaml#"

No advantage to adding this as this schema still has to define the value 
for "#thermal-sensor-cells".

> +
>  properties:
>    compatible:
>      enum:
> @@ -40,7 +43,7 @@ required:
>    - interrupts
>    - "#thermal-sensor-cells"
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.25.1
> 
> 
