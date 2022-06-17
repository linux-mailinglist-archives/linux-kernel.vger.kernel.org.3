Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98A54FDC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiFQTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiFQTlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:41:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A570459BB9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:41:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m4so1788620pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iNNdP2LZxmKm58FrjwtrJAFY7fk75EuWhvCmR2iKGoc=;
        b=Z1nVp7zktPau5BC/OAGGnsRMLucenJWjin1G9LC6L4gnzmFv+obGjgdUH78HuIoixb
         Nv+5XRYOwuLmUY6vBCB/wdROzlwVYnd4SCJphZre3QfibX/Hiul33O79tus/8yo0IJUg
         ucezWFh94rljovqr1b1v97luXqzR2Gn5chKih9bSHpE0y2JCa9J5EOuy2/0aQ+0NOEZ+
         hSrMMCL5ds2QjkY1YrG3aAHY2N36X5u0aKf5plVnIN+jJa8JNt4r4qSkZZGXy9azj975
         AWnrYZdshsHKKqhaX4rB5Rb5ApD+Xd0Vd1pXehA3wZ+p7W1fYeMvrXQ3S468mkHQAHnD
         D9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iNNdP2LZxmKm58FrjwtrJAFY7fk75EuWhvCmR2iKGoc=;
        b=6EBy2nncXKJS+UC4MevgCohJaE2DDOXW5kHCpDK0jo2lJhJCHk6lTrJNAsldVgzHKO
         +nq6Oo8NyJNMygKA8TLp19yfLRbIN07MonY3r2yeDEB9ivU9MmbD392qMe8kWRXZb7c9
         P6SXcKfVDxzJoAYZcyYh0hDUwDPHQ3I+3HpJcUfZqPn45roAyyydzvxmiDzeKxlK2R2J
         Mh9YE/m9YY6cVlLPjbEhNC/b2PVkorx/IRzIbSO8ePPOdl0CUeLwXVHg2dqAnhiZl5eF
         U6MLKXIUnBg6Zo2ExIK2wvXspoPUmjpwYw6GL1KhTMus9HUJijmoVU6IrO+/U+JxxLDF
         e4Yw==
X-Gm-Message-State: AJIora8xI9UvkbnSCLqG/mcw6thWp78FSp9ecWunPVXOykuesmT1qP21
        XCEU7exQiR/VFPkPFMJb8f/5sg==
X-Google-Smtp-Source: AGRyM1vNWiaAHppJnHGdj2jmXr1y/42d4G8MNghgBWOVZJq0sHQra1yo+ss7Yv2WiLNUQSH80DxW0w==
X-Received: by 2002:a17:90b:1d8c:b0:1e6:8032:a8dc with SMTP id pf12-20020a17090b1d8c00b001e68032a8dcmr12388262pjb.99.1655494870110;
        Fri, 17 Jun 2022 12:41:10 -0700 (PDT)
Received: from [172.31.214.180] ([216.9.110.13])
        by smtp.googlemail.com with ESMTPSA id x126-20020a626384000000b0051835ccc008sm4073250pfb.115.2022.06.17.12.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:41:08 -0700 (PDT)
Message-ID: <46ec62eb-00da-defb-219f-92121fd35d7e@linaro.org>
Date:   Fri, 17 Jun 2022 12:41:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/4] dt-bindings: nvmem: convert mtk-efuse.txt to YAML
 schema
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20220617093132.22578-1-chunfeng.yun@mediatek.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220617093132.22578-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/06/2022 02:31, Chunfeng Yun wrote:
> Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---

Applied 1/4 and 2/4, dts patches need to go via SoC maintainer.


thanks,
-srini


> v6: no changes, based on kernel 5.19-rc1
> 
> v5:
> sync with the series:
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=640196
>     1. change title suggested by Krzysztof;
>     2. No need drop 'reviewed-by Rob' suggested by Krzysztof
>     3. add maintainer Lala who maintain efuse driver now;
> 
> v4: fix duplicated unit-address in example;
>      drop reviewed-by Rob, due to changes;
> 
> v3: add reviewed-by Rob
> 
> v2:
>     1. remove description of subnodes which is covered by nvmem.yaml
> suggested by Rob
>     2. change the example which is commoner than mt8173's
> ---
>   .../bindings/nvmem/mediatek,efuse.yaml        | 87 +++++++++++++++++++
>   .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ---------
>   2 files changed, 87 insertions(+), 43 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>   delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> new file mode 100644
> index 000000000000..f6e01ddb7499
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/mediatek,efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek efuse
> +
> +description: |
> +  MediaTek's efuse is used for storing calibration data, it can be accessed
> +  on ARM devices usiong I/O mapped memory.
> +
> +maintainers:
> +  - Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> +  - Lala Lin <lala.lin@mediatek.com>
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  $nodename:
> +    pattern: "^efuse@[0-9a-f]+$"
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt7622-efuse
> +              - mediatek,mt7623-efuse
> +              - mediatek,mt8173-efuse
> +              - mediatek,mt8192-efuse
> +              - mediatek,mt8195-efuse
> +              - mediatek,mt8516-efuse
> +          - const: mediatek,efuse
> +      - const: mediatek,mt8173-efuse
> +        deprecated: true
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    efuse@11c10000 {
> +        compatible = "mediatek,mt8195-efuse", "mediatek,efuse";
> +        reg = <0x11c10000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        u3_tx_imp_p0: usb3-tx-imp@184,1 {
> +            reg = <0x184 0x1>;
> +            bits = <0 5>;
> +        };
> +        u3_rx_imp_p0: usb3-rx-imp@184,2 {
> +            reg = <0x184 0x2>;
> +            bits = <5 5>;
> +        };
> +        u3_intr_p0: usb3-intr@185 {
> +            reg = <0x185 0x1>;
> +            bits = <2 6>;
> +        };
> +        comb_tx_imp_p1: usb3-tx-imp@186,1 {
> +            reg = <0x186 0x1>;
> +            bits = <0 5>;
> +        };
> +        comb_rx_imp_p1: usb3-rx-imp@186,2 {
> +            reg = <0x186 0x2>;
> +            bits = <5 5>;
> +        };
> +        comb_intr_p1: usb3-intr@187 {
> +            reg = <0x187 0x1>;
> +            bits = <2 6>;
> +        };
> +        u2_intr_p0: usb2-intr-p0@188,1 {
> +            reg = <0x188 0x1>;
> +            bits = <0 5>;
> +        };
> +        u2_intr_p1: usb2-intr-p1@188,2 {
> +            reg = <0x188 0x2>;
> +            bits = <5 5>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> deleted file mode 100644
> index 39d529599444..000000000000
> --- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -= Mediatek MTK-EFUSE device tree bindings =
> -
> -This binding is intended to represent MTK-EFUSE which is found in most Mediatek SOCs.
> -
> -Required properties:
> -- compatible: should be
> -	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
> -	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
> -	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
> -	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
> -	      "mediatek,mt8195-efuse", "mediatek,efuse": for MT8195
> -	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
> -- reg: Should contain registers location and length
> -- bits: contain the bits range by offset and size
> -
> -= Data cells =
> -Are child nodes of MTK-EFUSE, bindings of which as described in
> -bindings/nvmem/nvmem.txt
> -
> -Example:
> -
> -	efuse: efuse@10206000 {
> -		compatible = "mediatek,mt8173-efuse";
> -		reg	   = <0 0x10206000 0 0x1000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		/* Data cells */
> -		thermal_calibration: calib@528 {
> -			reg = <0x528 0xc>;
> -		};
> -	};
> -
> -= Data consumers =
> -Are device nodes which consume nvmem data cells.
> -
> -For example:
> -
> -	thermal {
> -		...
> -		nvmem-cells = <&thermal_calibration>;
> -		nvmem-cell-names = "calibration";
> -	};
