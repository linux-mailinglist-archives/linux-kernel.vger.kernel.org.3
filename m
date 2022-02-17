Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050B44BADBD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiBRAAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:00:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiBRAAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:00:48 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D43346B1E;
        Thu, 17 Feb 2022 16:00:19 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id h125so6370985pgc.3;
        Thu, 17 Feb 2022 16:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SoRwOTnJQj6kK0mSNjv2umu6XpU3nx+Y+EN/LPgrWOM=;
        b=oAEH/A2SUmkuegDHSU+evXjiiRrYm7AJJRBw+6z/TXNww7IxnrM/8be8CT/tOuaZE9
         82KJD2vn194/DdkQixDilMYSF51xQ9YjRrDKS2BZQH6BiumXMHWPANG3jTwtRPmmggqM
         w9U+mmtP3vKswLOvGB3XEkJJfDVHgxrB9hO5+OT7Mh6Mahzv5+hpuAAdwN+T+CUX1TtD
         tIe7D1klA4KrpFDHjOu81c6Q3YpiNpws5hQ9+Ak4Qc0UX01jZ3frQJJjrC6aYj0VHGfc
         ZOL1cRf8bHa+fYzKyQvlx66iXXpA8JGR4uG2r5RkZkLF6h6kA86Wq3HM2dubhxexy0i/
         xb1A==
X-Gm-Message-State: AOAM53259reHT90rmIdVhN3a0QXp2hf8AjqZ5F/P46SDz3bK1TdVd1Ng
        cenZ/J5i5E4njkC9MJkeLsCJC0hcvg==
X-Google-Smtp-Source: ABdhPJw/kmEhnBfh2GFirjwVXPImHpsMauK1etqmp7WpKmzDJ+NCY4z+VfpN7NxiRwz0dTmGV2nSkw==
X-Received: by 2002:a92:c610:0:b0:2bf:b493:3425 with SMTP id p16-20020a92c610000000b002bfb4933425mr3441704ilm.166.1645140240853;
        Thu, 17 Feb 2022 15:24:00 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r13sm2810676ilb.35.2022.02.17.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:24:00 -0800 (PST)
Received: (nullmailer pid 3964338 invoked by uid 1000);
        Thu, 17 Feb 2022 23:23:58 -0000
Date:   Thu, 17 Feb 2022 17:23:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU
 support
Message-ID: <Yg7ZDoH1HBkOZvIH@robh.at.kernel.org>
References: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
 <20220211060301.1852772-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211060301.1852772-3-peng.fan@oss.nxp.com>
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

On Fri, Feb 11, 2022 at 02:02:58PM +0800, Peng Fan (OSS) wrote:
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
>  .../devicetree/bindings/mailbox/fsl,mu.yaml   | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index 6d056d5e16bf..f0a7e693ebf8 100644
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
> @@ -57,6 +58,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: txirq
> +      - const: rxirq

'irq' is redundant. Drop.

> +
>    "#mbox-cells":
>      description: |
>        <&phandle type channel>
> @@ -90,6 +97,20 @@ required:
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
> +          maxItems: 2

minItems is enough.

> +        interrupts:
> +          maxItems: 2

You haven't tested this with 2 items. It will fail because the main 
section has a limit of 1 item.

Rob
