Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07294C35CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiBXTXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiBXTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:23:36 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C420B16E;
        Thu, 24 Feb 2022 11:23:05 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 12so4351727oix.12;
        Thu, 24 Feb 2022 11:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9vXsvKJlW7AxtBGaO+YUrlsDVwA2t7tuHb+ZPnQHnEo=;
        b=lAG4qt7sf0vmmmGz0f75kNpOhl9lzOOFYRILikP76o15PUuGvgQNsr1tvOKp8DtygD
         y5L+CV5nOQqnklw3cUDLhsEgJsll2YER4iS9e6orMW6HQnHzSJSvj5deEaQmzRBrvx2p
         qeOA+DODZAQRwEMc6kOiwasxu3lv0myk69ZghJB6rX1OX19cLHPdcWwD5F9UqNX5XIOd
         Qf1L7mAq23j77F1rkECD5ufEZayTeO8rWoeJFqe0YlmIjFEUVRT+DJTNuAteJZjpVNJO
         yueV5cyLXKMuKWNKUun6VSniDugwJl3mNlyt3NuQeBdVDI3N0TquzRiGDdTm6tl6Wc3m
         dkDg==
X-Gm-Message-State: AOAM530jOm0d9cNEjoAEKerjU+UbbcRTvSqcHPiOoCKgyQI0x16ClYDx
        zCOFYbpN6n4swdblKy2aNA==
X-Google-Smtp-Source: ABdhPJyT5jyQjcrWS/WBfCkV0FKO13pGnYEJLcEIEnOQ4brqwyu8lTKgq6ivu/QQZeN+nm909DyY2A==
X-Received: by 2002:a05:6870:1b0f:b0:b4:10eb:c070 with SMTP id hl15-20020a0568701b0f00b000b410ebc070mr1908975oab.161.1645730584925;
        Thu, 24 Feb 2022 11:23:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bc24-20020a056808171800b002d722aead50sm176027oib.27.2022.02.24.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:23:03 -0800 (PST)
Received: (nullmailer pid 3438427 invoked by uid 1000);
        Thu, 24 Feb 2022 19:23:02 -0000
Date:   Thu, 24 Feb 2022 13:23:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU
 support
Message-ID: <YhfbFi4Cl1TfWqX7@robh.at.kernel.org>
References: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
 <20220223023157.3478540-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223023157.3478540-3-peng.fan@oss.nxp.com>
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

On Wed, Feb 23, 2022 at 10:31:54AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
> between Sentinel and Cortex-A cores from hardware design, it could not be
> reused for other purpose.
> 
> However i.MX93 S4 MU use separate tx/rx interrupt, so update
> interrupts and add interrupt-names property.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.yaml   | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index 6d056d5e16bf..f5f9d501845d 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> @@ -29,6 +29,7 @@ properties:
>        - const: fsl,imx8ulp-mu
>        - const: fsl,imx8-mu-scu
>        - const: fsl,imx8-mu-seco
> +      - const: fsl,imx93-mu-s4
>        - const: fsl,imx8ulp-mu-s4
>        - items:
>            - const: fsl,imx93-mu
> @@ -55,7 +56,13 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1

I still don't think you tested this with 2 items. You need minItems and 
maxItems.

> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: tx
> +      - const: rx
>  
>    "#mbox-cells":
>      description: |
> @@ -90,6 +97,24 @@ required:
>    - interrupts
>    - "#mbox-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx93-mu-s4
> +    then:
> +      properties:
> +        interrupt-names:
> +          minItems: 2
> +        interrupts:
> +          maxItems: 2

s/maxItems/minItems/

> +
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.25.1
> 
> 
