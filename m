Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4B4E2507
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346661AbiCULLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiCULLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:11:35 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8369393C9;
        Mon, 21 Mar 2022 04:10:09 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id r13so5120473wrr.9;
        Mon, 21 Mar 2022 04:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJplpyeeR7XtbntRv+MY0xuLRt56XHf4jWPWATDu+vI=;
        b=p5p1VrQD9bKhdQCZUETMZEKk5ykW53khLtRP6nfFoYbp+DY1LRfxq60DLaNU4Ampe+
         HACX3QvuUNf0L0ULATa3fZnw1NKTNyA2dCloK0ZeqmnyRlhEzP/egBBLb16ihiFTc7SC
         Wp6BYtfh6e7vf8vC2b+zLBGRnRWJ1wS8eWunmT7JR5tn9oaK+Q2EqZk1Yh25hEcBjhC6
         +vex71GzKRomCqifJ/Oo27lqEAREmRTklgJtemxL7y7bjqr8ynMlse1H6E7q2YW7pJBr
         2N96BOTUF5iA8GWfh3Ay7Rp/O9MZozVy575EoxgNWerVrj9xDJzQMeVYl06vrZJRFVZr
         V2rg==
X-Gm-Message-State: AOAM532T4AQ+itq5S3tEdJoY6fVIJTn19KLi81DXgYsqYAs2nx2kK3kj
        plnw9jZlxMKOKHQmw9jkMVQ=
X-Google-Smtp-Source: ABdhPJzM1OjuSXGjo2x5zmcICdAszhjqGkZ+2UO1QW+gsRz6L8kueWHNdiqT14Bo2mZm9l9KFmjQNQ==
X-Received: by 2002:a5d:4892:0:b0:1ed:beaa:778a with SMTP id g18-20020a5d4892000000b001edbeaa778amr17881962wrq.35.1647861008212;
        Mon, 21 Mar 2022 04:10:08 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id u11-20020a05600c19cb00b00389efe9c512sm18672875wmq.23.2022.03.21.04.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:10:07 -0700 (PDT)
Date:   Mon, 21 Mar 2022 12:10:05 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xiantao Hu <xt.hu@cqplus1.com>
Cc:     wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, qinjian@cqplus1.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: watchdog: Add watchdog yaml file for
 Sunplus SP7021
Message-ID: <20220321111005.w27blherwnon6kwk@krzk-bin>
References: <20220304081209.672-1-xt.hu@cqplus1.com>
 <20220304081209.672-2-xt.hu@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220304081209.672-2-xt.hu@cqplus1.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:12:08PM +0800, Xiantao Hu wrote:
> This adds the documentation for the devicetree bindings of the Sunplus
> SP7021 watchdog driver, found from SP7021 SoCs and newer.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>
> ---
>  .../bindings/watchdog/sunplus,sp7021-wdt.yaml | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml

Please use scripts/get_maintainer.pl on recent kernel (newest mainline or
recent linux-next) to get the list of people to CC.

> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> new file mode 100644
> index 000000000..9a9bfe150
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/sunplus,sp7021-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SoCs Watchdog Device Tree Bindings

s/Device Tree Bindings//

> +
> +maintainers:
> +  - XianTao Hu <xt.hu@cqplus1.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-wdt
> +
> +  reg:
> +    items:
> +      - description: watchdog registers regions
> +      - description: miscellaneous control registers regions
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    watchdog: watchdog@9c000630 {
> +        compatible = "sunplus,sp7021-wdt";
> +        reg = <0x9c000630 0x08>, <0x9C000274 0x04>;

lowercase hex (Second reg)

Can be fixed while applying, so in such case:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
