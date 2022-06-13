Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3518549A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbiFMRud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbiFMRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:50:09 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D436EC59;
        Mon, 13 Jun 2022 06:33:25 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id p1so4235291ilj.9;
        Mon, 13 Jun 2022 06:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=11tFqD3m8Y4XwFlrhzVilQYpi5rnvNYwyh/colXebbQ=;
        b=iR/qIqgwc6Z0a5diEE12yCsRbME3f5s0u9DluK0GgkFKuQ7G71QI6NCI4vzqAwxeoN
         DEGpUFzczlfCGMfQHBf6MvsWvy2nqGfpPbg8YDH4vVYfCydPdzulzSM25qIifnCNg828
         sSP+fhEbN79tv3LxlFjxCPSgFZ9JQAlr9ctlXADook/QkOZP+CdbnNq/gj8/Btkmlm+3
         4m2MXN57sF1wvtfI/3K5OhrT+PJoTijnry8qgg8QwYCS7DR6U5mTHGy4yiikG/kDdkeV
         MFeB7Z29LVYATCvwXHmmobvyrBTH5HeSn1ewbM4/EsCCuE3A/qntV1+7manXdPSJ9Myn
         U3YQ==
X-Gm-Message-State: AOAM533hyaICgtJmTE88BKm5rgZtVfVhnBAzV/R4+zk22iJL4FhXtaO6
        ydjEfeJGPf8KopBRuzTWwQ==
X-Google-Smtp-Source: ABdhPJzmK2cQV83DMuVJPdr/ZvzCb4HSLLb6Uq1aIv7PF7+f2zyEtUCDw+8RtX1G2m0ocrPThjCEww==
X-Received: by 2002:a92:d5cf:0:b0:2d1:d9b0:d5b1 with SMTP id d15-20020a92d5cf000000b002d1d9b0d5b1mr30500068ilq.252.1655127204260;
        Mon, 13 Jun 2022 06:33:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s18-20020a92cb12000000b002d392d98afdsm3947121ilo.9.2022.06.13.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:33:23 -0700 (PDT)
Received: (nullmailer pid 3564133 invoked by uid 1000);
        Mon, 13 Jun 2022 13:33:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        kyrie wu <kyrie.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        nicolas.dufresne@collabora.com, maoguang.meng@mediatek.com,
        linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        xia.jiang@mediatek.com, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, wenst@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
In-Reply-To: <20220613032306.23237-2-irui.wang@mediatek.com>
References: <20220613032306.23237-1-irui.wang@mediatek.com> <20220613032306.23237-2-irui.wang@mediatek.com>
Subject: Re: [V9,1/7] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
Date:   Mon, 13 Jun 2022 07:33:17 -0600
Message-Id: <1655127197.551988.3564132.nullmailer@robh.at.kernel.org>
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

On Mon, 13 Jun 2022 11:23:00 +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgenc compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  .../media/mediatek,mt8195-jpegenc.yaml        | 155 ++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml: patternProperties:^jpgenc@[0-9a-f]+$:properties:mediatek,hw-id:minItems: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml: patternProperties:^jpgenc@[0-9a-f]+$:properties:mediatek,hw-id: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems', 'minItems' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml: patternProperties:^jpgenc@[0-9a-f]+$:properties:mediatek,hw-id: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml: patternProperties:^jpgenc@[0-9a-f]+$:properties:mediatek,hw-id: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml: ignoring, error in schema: patternProperties: ^jpgenc@[0-9a-f]+$: properties: mediatek,hw-id: minItems
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.example.dtb:0:0: /example-0/soc/jpgenc_master: failed to match any schema with compatible: ['mediatek,mt8195-jpgenc']
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.example.dtb:0:0: /example-0/soc/jpgenc_master/jpgenc@1a030000: failed to match any schema with compatible: ['mediatek,mt8195-jpgenc-hw']
Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.example.dtb:0:0: /example-0/soc/jpgenc_master/jpgenc@1b030000: failed to match any schema with compatible: ['mediatek,mt8195-jpgenc-hw']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

