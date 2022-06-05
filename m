Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3439353DE59
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347609AbiFEVWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbiFEVWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:22:05 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39929D63;
        Sun,  5 Jun 2022 14:22:04 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id x16so5985563qtw.12;
        Sun, 05 Jun 2022 14:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nef1Ozun/+sIAQcPo6GXHDjM+cslc5L3dWpOX/Hb0jk=;
        b=obMrBJhpBWkztEnk6dzBjCvUFfWnp9a5HuaKWMTOCNlbMqnJWPir6AREUWGYyuMEM7
         ZVW9x5MwyCV+wsH61KBAfimXVJLeBeNbbTFyWU6buFlBKABTnrI0dbvO2XAplS3c02sP
         0YvFBRUDzKw19Xmvy4dILVlV7YM4W8vgaYhHlwcFy8mmniVQSa0Z0lhqxKtkHNHqtqRf
         k7ST4hz8noCkw5fe8o0Fx6rLSqxutKwx6p2OPraQ99hlNVzM1m6KB4cJINECoRKHsh4w
         W/TdZUfwkma3CgK+o9Epb61/S9iEYh3K5+Q/PN+b0gl7PlHQtSwaSfdnUazM/gSdiFgt
         J2tg==
X-Gm-Message-State: AOAM533YyXnSkJOo/SQDtJ1NLjVGxJzuBXRIceO9/z9ZayC04rZ65/NS
        lgrKB1zntXJpjfxncg+jcA==
X-Google-Smtp-Source: ABdhPJyyhAPumG/SLys5NhI3H6wf7GTwYLJHiQCyC3p9H5iHOwhSEbNiPoiqL01xXencWPz3nSHjrw==
X-Received: by 2002:a05:622a:40b:b0:304:e4be:65a with SMTP id n11-20020a05622a040b00b00304e4be065amr7023694qtx.309.1654464123277;
        Sun, 05 Jun 2022 14:22:03 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006a693e46d5csm7278738qkl.11.2022.06.05.14.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:22:02 -0700 (PDT)
Received: (nullmailer pid 3539659 invoked by uid 1000);
        Sun, 05 Jun 2022 21:22:00 -0000
Date:   Sun, 5 Jun 2022 16:22:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: power: Add MT8365 power domains
Message-ID: <20220605212200.GA3539140-robh@kernel.org>
References: <20220530204214.913251-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530204214.913251-1-fparent@baylibre.com>
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

On Mon, May 30, 2022 at 10:42:11PM +0200, Fabien Parent wrote:
> Add power domains dt-bindings for MT8365.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  2 ++
>  include/dt-bindings/power/mt8365-power.h      | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8365-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 135c6f722091..2c6d3e4246b2 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -29,6 +29,7 @@ properties:
>        - mediatek,mt8186-power-controller
>        - mediatek,mt8192-power-controller
>        - mediatek,mt8195-power-controller
> +      - mediatek,mt8365-power-controller
>  
>    '#power-domain-cells':
>      const: 1
> @@ -67,6 +68,7 @@ patternProperties:
>                "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
>                "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
>                "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
> +              "include/dt-bindings/power/mt8365-power.h" - for MT8365 type power domain.
>          maxItems: 1
>  
>        clocks:
> diff --git a/include/dt-bindings/power/mt8365-power.h b/include/dt-bindings/power/mt8365-power.h
> new file mode 100644
> index 000000000000..4f50997a13b4
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8365-power.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license please.

Rob
