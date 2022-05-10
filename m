Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EAE5211EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiEJKSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiEJKS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:18:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73212AC0D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:14:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l18so31896000ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dbb/ygIPwle8pAxWJvLtaKiiriFkDuqy8P36ttqmEG8=;
        b=yycP2wQZ9HF/b/5FrlR8y2OYTYX3t/FNxIguneIPCWzzxuMa0ywg/+isW+/xZ0N47N
         ftjZJcdDRDFJt1uCggycsLqPYeBjkUN247gzZUe+mmvza6I/+tCsx32K2B9ZCr3V9yF6
         RKrYdcQT01qPTOa5mRH+Po281aWca4Ubd245sIIXjuRV7GQt03eS85g1ST1oyMq9hc8O
         fDegD87KKu4LBgM39oiCem643VRaY9frJPO784Rv7P/OOIklEqi9CCoMsaGLPvvAIAwK
         Si7cnMCsNwVQqMN4rRFLobj8ZoLw1qSoG04rGJKd4aktEiJJNk5jvixFdKG+0fFl6ZpQ
         lDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dbb/ygIPwle8pAxWJvLtaKiiriFkDuqy8P36ttqmEG8=;
        b=7cGf+pv445rKewlKFsZfMfyTJeL/dVmme5SsMcIzGz0t4G5ofpEbfw22StkBsNTlcf
         u7cXeqJiG/p+581C9IMHdZXLKtbVImJGWGIqAYxJWSWsWlp0t27O3Fhz+zZA/9voPchS
         V7W6mJu88Hlr1EZalrEP7+9IkSKedGFJ01VBiR9YnCMrL8XpjoMfMwoB/qIEsy7+vubJ
         DD6lpPJBo1uxynHHv3Q8XzAx+A6qm4BUgHd00cbIOhI4yiWuEKSEImg1YLuwQ4Dlwu94
         GIar2ajOTYdWNEqxkAuuZC0n32IUK03x1m+Bf8eXfuHYD2d4hzL4RBUQPrYbvFJXoAIL
         iV5A==
X-Gm-Message-State: AOAM533mt76DMW2hTMlieJ2sb4ZnihQwvRFr05Uuh6ia/gvsmz0vZEfm
        SENDlu/FCJB++2jZMkf0BPDB+g==
X-Google-Smtp-Source: ABdhPJydVj8m9S+WzagJO2lkw35EdeHC09Xmn2fKUVMjIUdi8GsSf/3KkrMZdALGKxBPh4z0+VaMZw==
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id nb10-20020a1709071c8a00b006e92a0dd7b7mr18248840ejc.572.1652177669239;
        Tue, 10 May 2022 03:14:29 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709064a0100b006f3ef214db4sm5972354eju.26.2022.05.10.03.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 03:14:28 -0700 (PDT)
Message-ID: <ece7675a-a386-0a16-a087-2469758917f7@linaro.org>
Date:   Tue, 10 May 2022 12:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: pmic: mt6366: add binding document
Content-Language: en-US
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        tinghan.shen@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220510064603.15920-1-zhiyong.tao@mediatek.com>
 <20220510064603.15920-2-zhiyong.tao@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510064603.15920-2-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 08:46, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 
> The commit adds mt6366 binding document.

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> ---
>  .../bindings/regulator/mt6366-regulator.yaml  | 405 ++++++++++++++++++
>  1 file changed, 405 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6366-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6366-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6366-regulator.yaml
> new file mode 100644
> index 000000000000..1f125f5ba860
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6366-regulator.yaml

Filename with vendor, so "mediatek,mt6366-regulator.yaml"

> @@ -0,0 +1,405 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mt6366-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6366 Regulator from MediaTek Integrated
> +
> +maintainers:
> +  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> +
> +description: |
> +  List of regulators provided by this controller. It is named
> +  according to its regulator type, buck_<name> and ldo_<name>.
> +  MT6366 regulators node should be sub node of the MT6397 MFD node.
> +

Missing properties node, missing compatible. How is it supposed to
match? If you plan to use it as part of other binding, please send
entire patchset (including the binding which uses this one).

In current form this looks untestable, unusable.

> +patternProperties:
> +  "^buck_v(dram1|core|pa|proc11|proc12|gpu|s2|modem|s1)$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^v(dram1|core|pa|proc11|proc12|gpu|s2|modem|s1)$"
> +
> +    unevaluatedProperties: false

Put this one after $ref (other places as well). Makes it more readable.

> +
> +  "^ldo_v(ibr|rf12|usb|camio|efuse|xo22)$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^v(ibr|rf12|usb|camio|efuse|xo22)$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_v(rfck|emc|a12|a09|ufs|bbck)$":
> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^v(rfck|emc|a12|a09|ufs|bbck)$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_vcn(18|13|33_1_bt|13_1_wifi|33_2_bt|33_2_wifi)$":

No underscores in node names.

> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^vcn(18|13|33_1_bt|13_1_wifi|33_2_bt|33_2_wifi)$"
> +
> +    unevaluatedProperties: false
> +
> +  "^ldo_vsram_(proc2|others|md|proc1|others_sshub)$":

No underscores in node names, in all places.

> +    type: object
> +    $ref: "regulator.yaml#"
> +
> +    properties:
> +      regulator-name:
> +        pattern: "^vsram_(proc2|others|md|proc1|others_sshub)$"
> +
> +    unevaluatedProperties: false
> +

Best regards,
Krzysztof
