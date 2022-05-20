Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6A52E718
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbiETIQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345055AbiETIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:16:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B72E0B9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:15:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq30so13069966lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3WMyBzBsRRCp6gbma/PbvD8+LxmLfC0Z+aWsUUO5v2Q=;
        b=r8VE/uCTjI1e7vSggfcD/lYcs0j1kTxOduTx3B/oYII5BDkRCTFH8oLlvB4Tof2u4D
         srS0Okq1V37kNOj+J0SbInhv+n24I+vkVDFIQ06wiyfkkAzCCe9TxOnztwm7TOy6OsRi
         r5uotICug85Fom3LRI5GHqRjAM8dyJmTIGZF9JAucv5bIUju3LizX2JH3cDTsYdCbpV+
         /dvm7USDxXWWjZiaqH9X3v9iH33NRi/011BF43EKMgU10d+u7pRuZbxa93+hEVU19CmH
         96GhWRfNlrjwi2H3D3shQ/vvJUvLQKZraiyEi3N6ReCkaB6uTsZR35TzIS1CiM6YfP1Q
         uSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3WMyBzBsRRCp6gbma/PbvD8+LxmLfC0Z+aWsUUO5v2Q=;
        b=EwV2BoBCcUYU2ZYuOZ5ELwgMY7a4fWv8dvuMN78w5eveMz0bdrzP0MB//8fw6XqJy1
         iB0yMHnMVACjJAFwJeacOd1OB3wD+unqnhM3/vWWZnuiZ0nJcFWdWIONfcuk98vhWyKn
         QmDxm0WHRwmjQGMK6egm3YFE9jmeiU/4e5Sgg0W5joRlNtWCZr2tREyo3dayhuGG1rf/
         SqgGOPuIQcFUq6A+H4UMd0e2BTDmCTdzsnEp6sxLw6CEtYpqWX1J6P7Iz/hNKZsGmjwY
         /XjWTBPG2ZTrPT3apmlOdr63mg2jH0FBeYkVlfrgXw0FTt8byaVYTRWs5i7rXmW5+87T
         q+ew==
X-Gm-Message-State: AOAM5306jx4aYQWg2zulyYO9ZQEyy/Vq+uv6XXjJWpDji4rFEtTC1l7d
        /54hTwyfvYiJ/oOVV+oobvt1aQ==
X-Google-Smtp-Source: ABdhPJwykLzONsSZWY9axC9eeMj14sgcODVg3yQ+6KyFmWtA4KaDq9yJKAlnTHB1z/K2FxU5uXKaeQ==
X-Received: by 2002:a05:6512:3d1a:b0:477:ae14:9778 with SMTP id d26-20020a0565123d1a00b00477ae149778mr6380088lfv.72.1653034556706;
        Fri, 20 May 2022 01:15:56 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x17-20020a05651c105100b0024f3d1dae9esm222920ljm.38.2022.05.20.01.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 01:15:56 -0700 (PDT)
Message-ID: <45e78390-5f91-7ac7-45d8-5796bc608234@linaro.org>
Date:   Fri, 20 May 2022 10:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: mailbox: mtk-gce: Convert txt to json-schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220519101806.18097-1-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519101806.18097-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 12:18, AngeloGioacchino Del Regno wrote:
> Convert the mtk-gce documentation from freeform text format to a
> json-schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mailbox/mediatek,gce-mbox.yaml   | 114 ++++++++++++++++++
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 -------------
>  2 files changed, 114 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
> new file mode 100644
> index 000000000000..750391b4038c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mbox.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mediatek,gce-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Global Command Engine (GCE) mailbox
> +
> +maintainers:
> +  - Houlong Wei <houlong.wei@mediatek.com>
> +
> +description: |
> +  The Global Command Engine (GCE) is used to help read/write registers
> +  with critical time limitation, such as updating display configuration
> +  during the vblank.
> +  The GCE can be used to implement the Command Queue (CMDQ) driver.

Mention the headers in description.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6779-gce
> +      - mediatek,mt8173-gce
> +      - mediatek,mt8183-gce
> +      - mediatek,mt8186-gce
> +      - mediatek,mt8192-gce
> +      - mediatek,mt8195-gce
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: gce
> +
> +  '#mbox-cells':
> +    description: |
> +      The first cell describes the mailbox channel, which is the GCE Thread ID;
> +      The second cell describes the priority of the GCE thread.
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - '#mbox-cells'
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8195-gce
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2

Are you sure this works on mt8195-gce?

> +
> +        clock-names:
> +          items:
> +            - const: gce0
> +            - const: gce1
> +

Best regards,
Krzysztof
