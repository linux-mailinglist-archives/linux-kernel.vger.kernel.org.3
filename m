Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8118A4E7CF8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiCYTt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiCYTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:48:03 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640ABE00;
        Fri, 25 Mar 2022 12:36:46 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id g20so10357724edw.6;
        Fri, 25 Mar 2022 12:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+IQOL/i3pOvSW6gL8acHIjGAB8zIBWe2pJauIvLBYZw=;
        b=Jpg3SFWpcGh+acolcJXQrC8Vd1srCmtpuOfqxFA3X06ggAkJ/Jtj/Tjzkx1LTb2yq0
         WW7ytd0qzqXhnOu8ykX7dAoqOvu3kV2xTXoxfzhMCjO9gu32FpxU1wTKrbuxsl5NlK2C
         4B7NBRJZ5XGXhnTJZL/mIhlcM38zAwYtwAZ+hs3aMH3DMzrYKesUOHOE1+a0RXWrKqQ/
         SCP8nc3Eo8lmOB3vVepsvMMFcBFBLZs39ey9nafL6Pnj2t0dpNiW6fZKASniAcIW9gBi
         MNnJsI8JaakB/jJR3G7buEKrVCpi+f02ToiE0widEIR7lPuvmsIkTaq9667x++yj+Z8z
         c/iA==
X-Gm-Message-State: AOAM5327RPpM6kyHVTS2ut1hC2CH45AKirwbrbIKNIgWBDsk6DLaw1f8
        r8UpHECdif+cijYUqC4c5Q4z4ncPQNALRg==
X-Google-Smtp-Source: ABdhPJxMwXvlpL+4JyEmyf1bVymPZHtcHyRrXsWs0hxmehdLZOEYA6fVeuX2XFBlMV/UWRok9ezgvg==
X-Received: by 2002:a50:9fad:0:b0:419:f22:46db with SMTP id c42-20020a509fad000000b004190f2246dbmr14492584edf.354.1648229797742;
        Fri, 25 Mar 2022 10:36:37 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id g4-20020a170906520400b006e0b798a0b8sm490009ejm.94.2022.03.25.10.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:36:37 -0700 (PDT)
Message-ID: <da463ecb-e4ac-6e9c-c3a6-775d5c853807@kernel.org>
Date:   Fri, 25 Mar 2022 18:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 03/22] dt-bindings: mediatek,dp_phy: Add Display Port PHY
 binding
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        angelogioacchino.delregno@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        markyacoub@google.com
References: <20220325171511.23493-1-granquet@baylibre.com>
 <20220325171511.23493-4-granquet@baylibre.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325171511.23493-4-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 18:14, Guillaume Ranquet wrote:
> This phy controller is embedded in the Display Port Controller on mt8195 SoCs.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../bindings/phy/mediatek,dp-phy.yaml         | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
> new file mode 100644
> index 000000000000..4180d40f4fa7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2022 MediaTek
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Display Port PHY binding

Skip "binding"

> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  Device tree bindings for the Mediatek (embedded) Display Port PHY
> +  present on some Mediatek SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-dp-phy
> +
> +  regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the Display Port node.

Need a vendor prefix and descriptive suffix (e.g. mediatek,dp-syscon).

> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - regmap
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dp_phy: dp_phy {

Generic node name: just phy. Also underscores shoulk not be in node name.

> +      compatible = "mediatek,mt8195-dp-phy";
> +      regmap = <&dp_tx>;
> +      #phy-cells = <0>;
> +    };


Best regards,
Krzysztof
