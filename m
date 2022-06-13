Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21489549A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiFMRvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbiFMRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:50:35 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D46EB3E;
        Mon, 13 Jun 2022 06:33:20 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id p69so6111002iod.0;
        Mon, 13 Jun 2022 06:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vyoJ85txEp3wcFTSeMW6nKhdwOlY3JedEaCIumOgJX0=;
        b=otzJfOUwHCkOtcKoB+GqdbhFFpPSSm1AmwqloLzwx32osBGOFYzUbLkEpWK6Oa5V0q
         retP9HK66JWnNhLtdaquDt3d9M5Q7CjwxfDh7Q0zVjBJJRkV4DAa6rjuWbxQXeaXKIis
         HG4asCk5ZBT6cb8K2A/XGoc4LCHKKNtrTXme/PiVShYUiu4AiifGzWalPz4N0MS7cKt4
         jbrRaRKC8BJRRFmGHAJ3cu1mvepMq/iZOUKYVi/WAgdZhvegzW3igb6ZwHhP4g8bfVV/
         Bz1/2vjbcnU2+5JESO/uCAfaTqtRcF+YGC/MHg8CqU9DSd/jkWfLhNE4deQ+4YVCyCrx
         ne4Q==
X-Gm-Message-State: AOAM533gaA8O0s4lMVijjQ5n9gYXBdQ0wkdSxpfHDXVWpPCiQ8z5WvJA
        Y+PbIlr7kNYfw4mOpRitXw==
X-Google-Smtp-Source: ABdhPJwOoiPPMXAQ3HpzpzSM0BQ0OOEN1wDLDCLjfQX27FZnwuzSrw5lgyXQOpUCBVuEPG4qAKKUYw==
X-Received: by 2002:a05:6602:2cd1:b0:66a:6f0:5867 with SMTP id j17-20020a0566022cd100b0066a06f05867mr540059iow.143.1655127199851;
        Mon, 13 Jun 2022 06:33:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b14-20020a92c84e000000b002d1df239846sm3901175ilq.79.2022.06.13.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:33:19 -0700 (PDT)
Received: (nullmailer pid 3564130 invoked by uid 1000);
        Mon, 13 Jun 2022 13:33:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, maoguang.meng@mediatek.com,
        xia.jiang@mediatek.com, srv_heupstream@mediatek.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        kyrie wu <kyrie.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        nicolas.dufresne@collabora.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org
In-Reply-To: <20220613032232.23187-2-irui.wang@mediatek.com>
References: <20220613032232.23187-1-irui.wang@mediatek.com> <20220613032232.23187-2-irui.wang@mediatek.com>
Subject: Re: [V3,1/8] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
Date:   Mon, 13 Jun 2022 07:33:17 -0600
Message-Id: <1655127197.543108.3564129.nullmailer@robh.at.kernel.org>
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

On Mon, 13 Jun 2022 11:22:25 +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgdec compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  .../media/mediatek,mt8195-jpegdec.yaml        | 177 ++++++++++++++++++
>  1 file changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml: patternProperties:^jpgdec@[0-9a-f]+$:properties:mediatek,hw-id:minItems: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml: patternProperties:^jpgdec@[0-9a-f]+$:properties:mediatek,hw-id: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems', 'minItems' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml: patternProperties:^jpgdec@[0-9a-f]+$:properties:mediatek,hw-id: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml: patternProperties:^jpgdec@[0-9a-f]+$:properties:mediatek,hw-id: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml: ignoring, error in schema: patternProperties: ^jpgdec@[0-9a-f]+$: properties: mediatek,hw-id: minItems
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.example.dtb:0:0: /example-0/soc/jpgdec_master: failed to match any schema with compatible: ['mediatek,mt8195-jpgdec']
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.example.dtb:0:0: /example-0/soc/jpgdec_master/jpgdec@1a040000: failed to match any schema with compatible: ['mediatek,mt8195-jpgdec-hw']
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.example.dtb:0:0: /example-0/soc/jpgdec_master/jpgdec@1a050000: failed to match any schema with compatible: ['mediatek,mt8195-jpgdec-hw']
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.example.dtb:0:0: /example-0/soc/jpgdec_master/jpgdec@1b040000: failed to match any schema with compatible: ['mediatek,mt8195-jpgdec-hw']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

