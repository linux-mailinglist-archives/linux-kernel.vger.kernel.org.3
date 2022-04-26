Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50BB510705
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351554AbiDZSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbiDZSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:34:30 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426AF1CFE9;
        Tue, 26 Apr 2022 11:31:21 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id q129so21652408oif.4;
        Tue, 26 Apr 2022 11:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qgmDW0PWpCTN6QAQccW/HQMdlWsW6QW4exSJtmSe5+o=;
        b=KKNUIBt/8wiFdOADyn6aZUavslE75mX5FeoLxox+VwwLvFITe3sZ1ffux/ndFx6jWg
         Umjkw33pIBnu42qOPHwEcVhccRN886hjJu9QECXfydHWS2MBrEIKbwRAvJ7VCh0rVMwS
         35hQob783Czak+1bqFHelUtoFegMDS6aT8seGT5dFO/SHk5vKfOc6HNI6DR6qXjJYbjW
         VnrohWp7RMKk5puuBeI01ZH+wFrmNrPfgh530c4GmpS8356IHoMvLirMkKca8d0uKjkh
         aHzvyRdVkBcby6DoWfjPqTy3bjFcuEiY4/kFr3HV0qFtEu9jFHGIqmEWf+CEbVo/tDD9
         hx9Q==
X-Gm-Message-State: AOAM531bGC1OG+RPAVw3Vxu2NnC6lzo3zElSXO2koZ9Ili5b62FA6daP
        RNjEb62wsP7O22LmfPSBsWHAugqxIA==
X-Google-Smtp-Source: ABdhPJzIL1Yhrx2OPNJPgILC3RYcFne6c582YL6nl/ypM4+HqTvmQMy38qg7I2jfWGPUHp/r+AUExA==
X-Received: by 2002:aca:c46:0:b0:323:1b2b:77de with SMTP id i6-20020aca0c46000000b003231b2b77demr12069221oiy.113.1650997880448;
        Tue, 26 Apr 2022 11:31:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s2-20020a05687087c200b000e686d1386asm1079738oam.4.2022.04.26.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:31:20 -0700 (PDT)
Received: (nullmailer pid 2314030 invoked by uid 1000);
        Tue, 26 Apr 2022 18:31:18 -0000
Date:   Tue, 26 Apr 2022 13:31:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/5] dt-bindings: arm: mediatek: mmsys: add power and gce
 properties
Message-ID: <Ymg6dn3PotTeWbqF@robh.at.kernel.org>
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
 <20220419033237.23405-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419033237.23405-2-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:32:33AM +0800, Rex-BC Chen wrote:
> From: "jason-jh.lin" <jason-jh.lin@mediatek.com>
> 
> Power:
> 1. Add description for power-domains property.
> 
> GCE:
> 1. Add description for mboxes property.
> 2. Add description for mediatek,gce-client-reg property.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index b31d90dc9eb4..6c2c3edcd443 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -41,6 +41,30 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  power-domains:

How many and what are they.

> +    description:
> +      A phandle and PM domain specifier as defined by bindings
> +      of the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for details.

Drop. Don't need generic descriptions of common properties.

> +
> +  mboxes:

How many?

> +    description:
> +      Using mailbox to communicate with GCE, it should have this

If using?

> +      property and list of phandle, mailbox specifiers. See
> +      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for details.

Drop

> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Already has a type.

> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of client driver can be configured by gce with 4 arguments
> +      defined in this property, such as phandle of gce, subsys id,
> +      register offset and size.
> +      Each subsys id is mapping to a base address of display function blocks
> +      register which is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1

This needs to define exact sizes.

items:
  - items:
      - description: phandle to GCE
      - description: subsy id
      - description: register offset
      - description: register size

> +
>    "#clock-cells":
>      const: 1
>  
> @@ -56,9 +80,16 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/power/mt8173-power.h>
> +    #include <dt-bindings/gce/mt8173-gce.h>
> +
>      mmsys: syscon@14000000 {
>          compatible = "mediatek,mt8173-mmsys", "syscon";
>          reg = <0x14000000 0x1000>;
> +        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
>          #clock-cells = <1>;
>          #reset-cells = <1>;
> +        mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +                 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +        mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>      };
> -- 
> 2.18.0
> 
> 
