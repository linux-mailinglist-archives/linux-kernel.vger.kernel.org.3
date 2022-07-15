Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3525F575D08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiGOIHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGOIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:07:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194AE7E03D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:07:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so6622227lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HMDnLfBMBpAnvkfwUu1kUcciuPfA0gd/jLIRz34KC2Q=;
        b=QR/A/hgSlUZte4asSWtLqDuxQmnKzibCYCIbMKxSECKlou7MyhHtzssTjq2Cn4Xbal
         aD3L8t39u6mc9+oPXUQSfvD+PP4nSMb2LQA2W0rbI71cLc+BTwovvZFmt0zHNDDrUu5I
         2L8aIGMmQVLjQmxt5hnkkFaZdbD71unxxwBocmt7CEAySVuMrF39pMUamvqvVkbdJD0g
         ebFs9dF2iV6izMqIB4odycxP6QsuQrsrQycsSmcJgyP+vvZ/TFAK5/NjcJQacmoKqPeq
         ZK4ktXuFyA89spS1KOG/mNPTzuzSt2IVJ5KBHfKjlmHrHoB7kJT1XqSXF0ou668qyMGi
         j9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HMDnLfBMBpAnvkfwUu1kUcciuPfA0gd/jLIRz34KC2Q=;
        b=YePfLuaQP0Piz/UR26vjITUmpu704Pk95kyXr0BIrXILx2zA6cPFq38zEoEMbTJD9D
         WGun/Z0599zsBg77OM+2u6tsRN/JxUp2bTN+wGYA3PrmWDTbSoZNHpCyvxcofb9IJcLO
         Eup072PaZ6ixCCsDYtozLeDcAymUdtUPNpFO8VNIoqwsoAr1dxJJdh854hhu6G0LIw2T
         02pzWCIsuVq4mHQbNjumlZ220ZEQ+0/Km1FV/WKrQAuKHF4ta2fgP7BPXwsdaVVLWpR7
         gfjw8qH6Syj0lzE44/WSnC5vFflJkpHU3edX/cGYyAAooFBK1LVeFR1Rgbiqyiv/D4At
         3mPg==
X-Gm-Message-State: AJIora+qni8y+SPJYAvqCMa+Nr9Y8EzhLZatcxeMBvejoO/prGZbP4lL
        Zv01IrDTsYBQMi7ExABJOBYFeA==
X-Google-Smtp-Source: AGRyM1seZOIBtoRiwdKNcrQKrAEd4sfpxeEoh9duO4f8VVv0gWScXXeRrwqk1ZeqbkII0kyUy0tv8g==
X-Received: by 2002:a05:6512:acd:b0:489:f4ce:70a2 with SMTP id n13-20020a0565120acd00b00489f4ce70a2mr7571532lfu.322.1657872463261;
        Fri, 15 Jul 2022 01:07:43 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id c36-20020a05651223a400b0047f79487758sm777934lfv.133.2022.07.15.01.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 01:07:42 -0700 (PDT)
Message-ID: <c2e9f890-98c2-8f09-952d-495f2b57a254@linaro.org>
Date:   Fri, 15 Jul 2022 10:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/19] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-6-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714122837.20094-6-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 14:28, Tinghan Shen wrote:
> Extract duplicated properties and support more levels of power
> domain nodes.
> 
> This change fix following error when do dtbs_check,
>     arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 119 +-----------------
>  1 file changed, 6 insertions(+), 113 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index be81cd97afa4..e5494a330716 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -42,6 +42,10 @@ properties:
>  
>  patternProperties:
>    "^power-domain@[0-9a-f]+$":
> +    $ref: "#/$defs/power-domain-node"
> +
> +$defs:
> +  power-domain-node:
>      type: object
>      description: |
>        Represents the power domains within the power controller node as documented
> @@ -100,122 +104,11 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/phandle
>          description: phandle to the device containing the SMI register range.
>  
> -    patternProperties:
> -      "^power-domain@[0-9a-f]+$":
> -        type: object
> -        description: |
> -          Represents a power domain child within a power domain parent node.
> -
> -        properties:
> -
> -          '#power-domain-cells':
> -            description:
> -              Must be 0 for nodes representing a single PM domain and 1 for nodes
> -              providing multiple PM domains.
> -
> -          '#address-cells':
> -            const: 1
> -
> -          '#size-cells':
> -            const: 0
> -
> -          reg:
> -            maxItems: 1
> -
> -          clocks:
> -            description: |
> -              A number of phandles to clocks that need to be enabled during domain
> -              power-up sequencing.
> -
> -          clock-names:
> -            description: |
> -              List of names of clocks, in order to match the power-up sequencing
> -              for each power domain we need to group the clocks by name. BASIC
> -              clocks need to be enabled before enabling the corresponding power
> -              domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> -              SUSBYS clocks need to be enabled before releasing the bus protection,
> -              and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> -
> -              In order to follow properly the power-up sequencing, the clocks must
> -              be specified by order, adding first the BASIC clocks followed by the
> -              SUSBSYS clocks.
> -
> -          domain-supply:
> -            description: domain regulator supply.
> -
> -          mediatek,infracfg:
> -            $ref: /schemas/types.yaml#/definitions/phandle
> -            description: phandle to the device containing the INFRACFG register range.
> -
> -          mediatek,smi:
> -            $ref: /schemas/types.yaml#/definitions/phandle
> -            description: phandle to the device containing the SMI register range.
> -
> -        patternProperties:
> -          "^power-domain@[0-9a-f]+$":
> -            type: object
> -            description: |
> -              Represents a power domain child within a power domain parent node.
> -
> -            properties:
> -
> -              '#power-domain-cells':
> -                description:
> -                  Must be 0 for nodes representing a single PM domain and 1 for nodes
> -                  providing multiple PM domains.
> -
> -              '#address-cells':
> -                const: 1
> -
> -              '#size-cells':
> -                const: 0
> -
> -              reg:
> -                maxItems: 1
> -
> -              clocks:
> -                description: |
> -                  A number of phandles to clocks that need to be enabled during domain
> -                  power-up sequencing.
> -
> -              clock-names:
> -                description: |
> -                  List of names of clocks, in order to match the power-up sequencing
> -                  for each power domain we need to group the clocks by name. BASIC
> -                  clocks need to be enabled before enabling the corresponding power
> -                  domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> -                  SUSBYS clocks need to be enabled before releasing the bus protection,
> -                  and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> -
> -                  In order to follow properly the power-up sequencing, the clocks must
> -                  be specified by order, adding first the BASIC clocks followed by the
> -                  SUSBSYS clocks.
> -
> -              domain-supply:
> -                description: domain regulator supply.
> -
> -              mediatek,infracfg:
> -                $ref: /schemas/types.yaml#/definitions/phandle
> -                description: phandle to the device containing the INFRACFG register range.
> -
> -              mediatek,smi:
> -                $ref: /schemas/types.yaml#/definitions/phandle
> -                description: phandle to the device containing the SMI register range.
> -
> -            required:
> -              - reg
> -
> -            additionalProperties: false
> -
> -        required:
> -          - reg
> -
> -        additionalProperties: false
> -
>      required:
>        - reg
>  
> -    additionalProperties: false
> +    additionalProperties:
> +      $ref: "#/$defs/power-domain-node"

That's an interesting construction - endless recurrence. I did not know
it works like that... How about making it a bit more specific? Defining
defs "power-domain-node" for just one child (without
additionalProperties piece) and (maybe with just one more level):

@@ -43,6 +43,12 @@ patternProperties:

   "^power-domain@[0-9a-f]+$":

     $ref: "#/$defs/power-domain-node"



+    patternProperties:

+      "^power-domain@[0-9a-f]+$":

+        $ref: "#/$defs/power-domain-node"

+        unevaluatedProperties: false

+    unevaluatedProperties: false

+

 $defs:

   power-domain-node:

     type: object

@@ -105,9 +111,6 @@ $defs:

     required:

       - reg



-    additionalProperties:

-      $ref: "#/$defs/power-domain-node"

-

 required:

   - compatible




Best regards,
Krzysztof
