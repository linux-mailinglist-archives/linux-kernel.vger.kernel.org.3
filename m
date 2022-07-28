Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB91583C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiG1Ksd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiG1KsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:48:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65BE6558F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:46:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a23so2221463lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1xkCeFRSOl7osvDg152zQFoduvixlLuMF0R3jqBMPtE=;
        b=opnSnGfLr5+oJ+3vqZT/hLOk1V8U8yEK0wPTxIM93IkaXqWYk1Ld0S3aN49DFqsrKC
         brCoucMHeboD2rObwXhUTmc0hq6oe1xpJ1YkrSOajMAfXhJqhpkzknHC2A4hIzgtssT2
         XkIqu9rpMR5exL6AXXtdKpUf+ss8912IzWib+X9vG7A4XrFuLReRgkPBErryYVKW6KuL
         7dlCMH2FVPCQGH6rpijwMmqo+DhJ8xZA40ZH9N/QJTr7BNYLWOtDJe11Lk2l7kDgj77L
         NbPDgAfxSvEEggNhCyLFZOKLrtWkfsnv60jalk2c/Bk79YM/hDuu41Lr5tfxjiPFP1Mv
         tlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1xkCeFRSOl7osvDg152zQFoduvixlLuMF0R3jqBMPtE=;
        b=ZN0LpVr5p+TDP5RxiOYX9PoTh/w8Bf+Tf7uYFhfgh0l0ZYwdIz8yQAPJU3pJqlz6ef
         SP+46RsQb1lyO7oHEp2/NFjJipouUpca6E2at4cFhNvEVeUocJVnTn0VvL3cYOiAdF63
         ceXP2SueUFWFK2ZSydcTLTKDScIDNXzj3fLJCqmEdXp3htQ3o41q+SRqf2bSg3FKbH7J
         LF1gAhWvS41bw0OTul5zh1j3nb1UPCGQU9PqdMvJ3CBY/yq1NVYotQiIVRFj7m7hcOgP
         rgGvJ78FBT1lRlnPKndNb7NWWVpC0IhbekvkS6HResrIz+b0F7m6VzGIaZ2QZlPztBMh
         4X1A==
X-Gm-Message-State: AJIora91iN+vEUBg8wBfAgf2qqrwS+Mq3X2UtbLXOSXV3JspGLI1Aigo
        bTgUdiUfDsMWakPhm8VPZGmZ8w==
X-Google-Smtp-Source: AGRyM1sIey0VRJ4CLEdBZqZgjh+1viX6/kj9l5GJluthddRwxzsUiTTrYmH22z2/zIS4RpaHW4SqaA==
X-Received: by 2002:a05:6512:318b:b0:48a:ce50:3271 with SMTP id i11-20020a056512318b00b0048ace503271mr180700lfe.182.1659005213778;
        Thu, 28 Jul 2022 03:46:53 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id i20-20020a056512341400b0048a7901903esm141668lfr.144.2022.07.28.03.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 03:46:53 -0700 (PDT)
Message-ID: <03a13ed4-e7cd-6f7d-f8f7-9b1e6193e202@linaro.org>
Date:   Thu, 28 Jul 2022 12:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] pmic: add mt6366 regulator document
Content-Language: en-US
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        zhiyong tao <zhiyong.tao@mediatk.com>
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
 <20220728062749.18701-2-zhiyong.tao@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728062749.18701-2-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 08:27, Zhiyong Tao wrote:
> From: zhiyong tao <zhiyong.tao@mediatek.com>
> 
> Add mt6366 regulator document

As usual with Mediatek your emails fail to properly pass modern SMTP
checks and you end up in spam.

I reported it months ago to folks in Mediatek. No improvements since
that time.

I stopped checking my spam folder for Mediatek stuff and all will be
ignored. I will also stop complaining about it - just ignore Mediatek.

Fix your systems, instead of putting additional effort on community and
on reviewers.


> 
> Signed-off-by: zhiyong tao <zhiyong.tao@mediatk.com>
> ---
>  .../regulator/mediatek,mt6366-regulator.yaml  | 375 ++++++++++++++++++
>  1 file changed, 375 insertions(+)

Subject does not match subsystem.


>  create mode 100755 Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> new file mode 100755
> index 000000000000..eb72c64757cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> @@ -0,0 +1,375 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6366 Regulator from MediaTek Integrated
> +
> +maintainers:
> +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> +
> +description: |
> +  List of regulators provided by this controller. It is named
> +  according to its regulator type, buck_<name> and ldo_<name>.
> +  MT6366 regulators node should be sub node of the MT6397 MFD node.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6366-regulator
> +
> +  regulators:
> +    type: object
> +    description: List of regulators and its properties
> +
> +    patternProperties:
> +      "^buck-v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
> +        type: object
> +        $ref: "regulator.yaml#"

No need for quotes.

> +        unevaluatedProperties: false
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$"

Why do you enforce specific regulator-name? Remove.

> +
> +      "^ldo-v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$"
> +
> +      "^ldo-v(xo22|efuse|mch|vcama1|emc|a12|vcama2|mc)$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^v(xo22|efuse|mch|vcama1|emc|a12|vcama2|mc)$"
> +
> +      "^buck-(vcore)-sshub$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +        unevaluatedProperties: false
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^vcore-sshub$"
> +
> +      "^ldo-vcn(28|33)-bt$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +        unevaluatedProperties: false
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^vcn(28|33)-bt$"
> +
> +      "^ldo-vcn(33)-wifi$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +        unevaluatedProperties: false
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^vcn33-wifi$"
> +
> +      "^ldo-vsram-(others)-sshub$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +        unevaluatedProperties: false
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^vsram-others-sshub$"
> +
> +      "^ldo-vsram-(proc11|others|gpu|proc12)$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +        unevaluatedProperties: false
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^vsram-(proc11|others|gpu|proc12)$"
> +
> +      "^ldo-v(aud|bif|io|ldo)28$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^v(aud|bif|io|ldo)28$"
> +
> +      "^ldo-v(io|aux|rf)18$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^v(io|aux|rf)18$"
> +
> +      "^ldo-vsim[2]$":
> +        type: object
> +        $ref: "regulator.yaml#"
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^vsim2$"
> +
> +        required:
> +          - regulator-name
> +
> +required:
> +  - compatible
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      compatible = "mediatek,mt6366-regulator";
> +
> +      regulators {
> +        mt6366_vdram1_reg: buck-vdram1 {
> +            regulator-name = "vdram1";

Messed up indentation. Use only one, so 4 space for DTS example.



Best regards,
Krzysztof
