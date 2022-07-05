Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83F0567904
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiGEU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiGEU5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:57:43 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748513FBB;
        Tue,  5 Jul 2022 13:57:42 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id p128so12326835iof.1;
        Tue, 05 Jul 2022 13:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VII4+LSw9T/gxl5+FohiuIGzGMIZ9dqiusLT8ztuOfQ=;
        b=zxdHZhgiGHTN/xRdaNi3ku2UoDwol4iWHnlztu+yoW4yutkJVAdan7TSgDrplRrOPj
         TzHgdVOtXbUvNQknNCAhSaJgUQQQ7Sg7suWUCR71MpYLWeQ7ro+PoexU16anzyw9SYBA
         /Ml912ZpE7ska04lwBNxay6t3+jrHe4mSz0fotEwLrTojTykfvA/OzifK5WNfNDMOX2a
         28QKs0llsKKJylaPlpoHUeo98M/o3LHgnP1MbPU5Zf2YJNFIFkIMavjH0xjM8cA787MT
         HM9mLvAytEZJmuwRoDP6/EVmptTAeTSAJx1Uohc47U7t0LWBliZ+cval9t4Oahk6OFhB
         cbbw==
X-Gm-Message-State: AJIora9QuBMFw28Gk2NyPywdUV6WIQ3ZUwo/0lNwdsQnNfvow2IjHMT4
        EyeBSGmQJqt3VzSkhT+CZg==
X-Google-Smtp-Source: AGRyM1vfLcm6IZw7/86NYDIFZB44UKjPVyEO4I8oJE/Oz0DoqL8OE1ZY84lQlcCK/TDePXwnFj4m9w==
X-Received: by 2002:a05:6602:1355:b0:669:40a5:9c26 with SMTP id i21-20020a056602135500b0066940a59c26mr20818102iov.105.1657054661830;
        Tue, 05 Jul 2022 13:57:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bo22-20020a056638439600b0033c8edf022bsm12230492jab.144.2022.07.05.13.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:57:41 -0700 (PDT)
Received: (nullmailer pid 2609976 invoked by uid 1000);
        Tue, 05 Jul 2022 20:57:39 -0000
Date:   Tue, 5 Jul 2022 14:57:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 03/16] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Message-ID: <20220705205739.GA2599256-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-4-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704100028.19932-4-tinghan.shen@mediatek.com>
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

On Mon, Jul 04, 2022 at 06:00:15PM +0800, Tinghan Shen wrote:
> Extract duplicated properties and support more levels of power
> domain nodes.
> 
> This change fix following error when do dtbs_check,
>     arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 132 ++----------------
>  1 file changed, 12 insertions(+), 120 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 135c6f722091..09a537a802b8 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -39,8 +39,17 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
>  patternProperties:
>    "^power-domain@[0-9a-f]+$":
> +    $ref: "#/$defs/power-domain-node"
> +
> +$defs:
> +  power-domain-node:
>      type: object
>      description: |
>        Represents the power domains within the power controller node as documented
> @@ -98,127 +107,10 @@ patternProperties:
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
> +      required:
> +        - reg
>  
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
> -    required:
> -      - reg
> -
> -    additionalProperties: false
> -
> -required:
> -  - compatible
> -
> -additionalProperties: false
> +      additionalProperties: false

You now aren't checking more than 1 level because you have defined 
'additionalProperties' to be a DT property. Check the indentation.

You need this in $defs/power-domain-node to recurse:

    additionalProperties:
      $ref: #/$defs/power-domain-node

>  
>  examples:
>    - |
> -- 
> 2.18.0
> 
> 
