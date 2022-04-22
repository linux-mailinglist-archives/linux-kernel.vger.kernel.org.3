Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEE950BC19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449568AbiDVPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449567AbiDVPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:52:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF45DA24
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:49:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g18so17151943ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EbBrf90Se9JVfBrPUX5vB31Mi0cnNfK03HhVmontGZM=;
        b=p9urVnCyqPfWbAeTgSbUtdRfSxObUFNtR0D5eF2v15vU3h8ra7egnDpTofsF4zJKh0
         X22/Y5qYPAJRpQ98ETFprhKBhKvU0zd+geenSx+OqdONFFOEMFm/DETjBqA5zPJYG3E7
         3Lg8/RE2tyAnTpDpXHoPo6ItX60g3EhXtOeJGHEy+8b5wSLVz4ZbOMbCJAf8tWmtENho
         mOLA7uM8bUw5tZoJ0nkYku9LZz1GGHuHyA7elECdI/gtOAwKZMNV3hdtYnSTZkre6Q91
         6JSYJteZeSn4baDRnQZ5J2HyW3VHfsogrGAL8aYAmMtsFSFYn4KCrDxSCBNfcrE5ypDj
         7j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EbBrf90Se9JVfBrPUX5vB31Mi0cnNfK03HhVmontGZM=;
        b=cL+ImyXTYAMEbh4KopaxV6d+YNKJD4EcFe38olSSK9qoiJDprKMajSS03om1GiVo9r
         B3xmUlE4fpxNeiTC40PEUmZljq9nWcGIXFXlgtyDkMCvxkzZhhys95iv9cM8XJziPkvm
         h/HTgi4WMRXsO7t63T4HiEID+MdQmFLd+9y3EeKCOontioyKI8SmKJHbAKbym0HWon8L
         ZHBFhDK6sDo1GHWDItsPs/LMoWeRrU6Bkntd80LkeZ92pJTv0/tEWa197TEXckdAf1PL
         K+/WucVBu6PAnu9h1Bn7AlJSX1SSebB/Y/ffCEEO6KhzJTiDSNjxIxl8Gf2GBZ7A+Hel
         EiAg==
X-Gm-Message-State: AOAM533PsphJiMhd9xJWuR1rhbW5w1YgXU467xDvIp2vZ49YLVTiGoC1
        5XCxIyA9BEt3hoGvO0OCHi3Pvw==
X-Google-Smtp-Source: ABdhPJwOm7OVQF6vFjjh8qNr+uvEPPGlSIw610XQhQ2Tyyu1bh8vgEPXO+cVxey0E8SMmZLsiUzj1g==
X-Received: by 2002:a17:906:1ec3:b0:6cf:d118:59e2 with SMTP id m3-20020a1709061ec300b006cfd11859e2mr4726662ejj.767.1650642581658;
        Fri, 22 Apr 2022 08:49:41 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906700a00b006efdb748e8dsm864676ejj.88.2022.04.22.08.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:49:40 -0700 (PDT)
Message-ID: <c0a188e5-8a8c-d4a3-5a3d-9b9dd85d8f44@linaro.org>
Date:   Fri, 22 Apr 2022 17:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] dt-bindings: dsp: mediatek: add mt8186 dsp document
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422071534.15653-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 09:15, Tinghan Shen wrote:
> This patch adds mt8186 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers, clocks, memory regions,
> and mailbox for dsp.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
> 
> This patch depends on MT8186 clock bindings.
> https://lore.kernel.org/all/20220409132251.31725-2-chun-jie.chen@mediatek.com/
> 
> ---
>  .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> new file mode 100644
> index 000000000000..00a79e880895
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dsp/mediatek,mt8186-dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek mt8186 DSP core
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
> +      - const: audiodsp_sel
> +      - const: adsp_bus_sel

What does the "sel" stands for? Maybe just skip the "_sel" suffixes?

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mboxes:
> +    items:
> +      - description: ipc reply between host and audio DSP.
> +      - description: ipc request between host and audio DSP.
> +
> +  mbox-names:
> +    items:
> +      - const: mbox0
> +      - const: mbox1

These should be rather some meaningful names, e.g. "rx" and "tx".

> +
> +  memory-region:
> +    items:
> +      - description: dma buffer between host and DSP.
> +      - description: DSP system memory.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - mbox-names
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>

You do not use these headers.

> +    #include <dt-bindings/clock/mt8186-clk.h>
> +    dsp@10680000 {



Best regards,
Krzysztof
