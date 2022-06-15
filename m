Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2009454D00B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355195AbiFORdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357384AbiFORcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:32:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9FB46
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:32:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u18so11008522plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W1PQYZC14YMjHxT30YEBNlrtmJ3QC4MXeKQysGRg+Yw=;
        b=LLceS4Bvp4DhcnnLuCIwqgbqNp6J/l72nMXqhgIjd8/hq1DDLIwDn05fkERjkMyyfz
         ZB7DSoL5I8hjYPDY+mdw4AXi0E6y7pp62jvbB/EgWuzpZ86hIbhHRp79/DhlHcEyYKsu
         wpHlwcu8gv9SvSy+A/1bRM4T9CHWtJBuvH4CM9m6g7MhOWK5zN93QKIyMgHeHFGktwGu
         9gLqJYdlY6dUpcrsC41tPFsu1FljJ0SBFOUn5gbdTXEOwHhJTLE/uqDmbWsGBwwvQkDS
         90Au78Z+x+AILhvwS9iOa7uK/JiFTYrFOXBQVyDJwDclT0jsah+pifj6C1UnXtvGlgvv
         ighA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W1PQYZC14YMjHxT30YEBNlrtmJ3QC4MXeKQysGRg+Yw=;
        b=z0TUtG+hPm0ZzJozNmrQ2Zki+jR14gJBMIlHKG0By2Rk5u8+qsVmUR0tW57LblqmZI
         Gvwrwiz+2SGvS+GrSukOzyQUh0NpusqcZGV2CuyZKNPCvsNXUjCby3HF2NGIZnwrFhta
         YCQpU1mT+YnNAkPurqre5vh7m3SC4TlRLEy/jn74UXkhtG3wVuXHpq9kRdFJRU0/TRWJ
         mUkTaENTB1BXP4ILORlYRqdCa3SEXpDnYYwJk2Lw+xCQ/yyLpJxDA/GIFmUe8UHegMd8
         1ugDNJl6i8NnoFZGWkheBKQ8f+JSmWdGxxUWcmLFpm6e5nGgtazdwpik6MZdp+2nEWXq
         XUTw==
X-Gm-Message-State: AJIora+SZXOl8nqMNgSbCM/pjtuuoFh64JuP4rpLiL0o1VukXw8nGNRx
        RM8q+7DQn5FkWH7MyQSaLAltquxL6LNL2Q==
X-Google-Smtp-Source: AGRyM1t5Bb3byzNK2GCgYIJSoyJJv6PdLq49qYzDb+iYtiJqiqZHZMSFKTIH6YqdgfcSUyPXOQ4snQ==
X-Received: by 2002:a17:903:408c:b0:163:e526:4397 with SMTP id z12-20020a170903408c00b00163e5264397mr829378plc.80.1655314364597;
        Wed, 15 Jun 2022 10:32:44 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id cd6-20020a056a00420600b0050dc7628162sm10075365pfb.60.2022.06.15.10.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:32:44 -0700 (PDT)
Message-ID: <acac2ec1-759a-dee0-8f08-df83b63b96f5@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/3] dt-bindings: dsp: mediatek: add mt8186 dsp
 document
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220609083101.24195-1-tinghan.shen@mediatek.com>
 <20220609083101.24195-4-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609083101.24195-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 01:31, Tinghan Shen wrote:
> This patch adds mt8186 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers, clocks, memory regions,
> and mailbox for dsp.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> new file mode 100644
> index 000000000000..33c78f89d296
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dsp/mediatek,mt8186-dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek mt8186 DSP core
> +
> +maintainers:
> +  - Tinghan Shen <tinghan.shen@mediatek.com>
> +
> +description: |
> +  MediaTek mt8186 SoC contains a DSP core used for
> +  advanced pre- and post- audio processing.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8186-dsp
> +
> +  reg:
> +    items:
> +      - description: Address and size of the DSP config registers
> +      - description: Address and size of the DSP SRAM
> +      - description: Address and size of the DSP secure registers
> +      - description: Address and size of the DSP bus registers
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: sram
> +      - const: sec
> +      - const: bus
> +
> +  clocks:
> +    items:
> +      - description: mux for audio dsp clock
> +      - description: mux for audio dsp local bus
> +
> +  clock-names:
> +    items:
> +      - const: audiodsp
> +      - const: adsp_bus
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mboxes:
> +    items:
> +      - description: ipc reply between host and audio DSP.
> +      - description: ipc request between host and audio DSP.

"IPC request between" does not specify who sends the request. Host or DSP?

See existing bindings for some better examples, e.g.:
Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.yaml
which clearly states who receives from who.

> +
> +  mbox-names:
> +    items:
> +      - const: rep
> +      - const: req

tx/rx




Best regards,
Krzysztof
