Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF13958ED38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiHJN2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiHJN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:28:23 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C780F2FFF9;
        Wed, 10 Aug 2022 06:28:18 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id o14so8276767ilt.2;
        Wed, 10 Aug 2022 06:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=NzrQIGZCwIus9r1JyqSwJ+/rNe7ZRlaMYtJkznnEWLg=;
        b=kkiI0jXtB8RIBseTVXcnJJz61eJO5Y056gWHp7gTwj+xOV3S6Epe9hm8t2Omx7nFVo
         QPLhEazs3RDnjZNW8fsE3nlpTYUsQPv4zELqAnxDVw+mMdGLjas3q4Kue5H29qGCpTxd
         AcDutLnXiRp6Smhps2a9VORPnPARFf8OUYqf43jBtsZy1c3wRIKje4aPTw2quAK97lH5
         oys9TYVNArBSHBkgaWod2E0FtgQCgN2Ec6625TIhOPPnyHauTCm5kpKROUhK3RxmCpTG
         G11OLudjq3yS81rcIvNqXvnnVh6MgY9RoDn4TL6bw4hea2/D6Bi/Lg9Il+yDJ72wYNHD
         U2qQ==
X-Gm-Message-State: ACgBeo0wzBqXXlS4Pu+7GAsDzqmW+Me4v/NCsfnHmAsCVV6wm8I8pr6O
        ob6ldl10A+aedBNMspPmbw==
X-Google-Smtp-Source: AA6agR5or8CrY7N1/B4wmO+I53M/6xlIzZiBbAgz6RffPqaplg84PR1rPJzhLCT3ceYrBI6TH4xkTA==
X-Received: by 2002:a92:b00f:0:b0:2d6:5628:6865 with SMTP id x15-20020a92b00f000000b002d656286865mr12008908ilh.230.1660138098027;
        Wed, 10 Aug 2022 06:28:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t5-20020a92c0c5000000b002dd0bfd2467sm2189282ilf.11.2022.08.10.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:28:17 -0700 (PDT)
Received: (nullmailer pid 3991541 invoked by uid 1000);
        Wed, 10 Aug 2022 13:28:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        lgirdwood@gmail.com, linux-remoteproc@vger.kernel.org,
        agross@kernel.org, bgoswami@quicinc.com, swboyd@chromium.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        quic_rohkumar@quicinc.com, robh+dt@kernel.org,
        quic_plai@quicinc.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org
In-Reply-To: <1660117558-21829-3-git-send-email-quic_srivasam@quicinc.com>
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com> <1660117558-21829-3-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: remoteproc: qcom: adsp: Add required bindings for SC7280
Date:   Wed, 10 Aug 2022 07:28:15 -0600
Message-Id: <1660138095.893744.3991540.nullmailer@robh.at.kernel.org>
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

On Wed, 10 Aug 2022 13:15:52 +0530, Srinivasa Rao Mandadapu wrote:
> Add compatible name, clocks and update max reg items for SC7280
> based platforms.
> Add adsp-memory-regions property, required for memory sandboxing.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since V2:
> 	-- Add clock property.
> 	-- Add qcom,adsp-memory-regions property.
> Changes since V1:
> 	-- Change reg property maxItems to minItems and update description.
> 
>  .../bindings/remoteproc/qcom,lpass-adsp-pil.yaml          | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml: properties:qcom,adsp-memory-regions: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'List of memory regions accessed by ADSP firmware.'}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml: properties:qcom,adsp-memory-regions: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	'description' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('items', 'minItems' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml: properties:qcom,adsp-memory-regions: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml: properties:qcom,adsp-memory-regions: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml: ignoring, error in schema: properties: qcom,adsp-memory-regions
Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.example.dtb:0:0: /example-0/remoteproc@17300000: failed to match any schema with compatible: ['qcom,sdm845-adsp-pil']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

