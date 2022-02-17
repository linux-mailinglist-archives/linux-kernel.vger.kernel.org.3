Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0804B975F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiBQD7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:59:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiBQD7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:59:45 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E82A22AD;
        Wed, 16 Feb 2022 19:59:31 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id y20so2251743iod.1;
        Wed, 16 Feb 2022 19:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1201U7jGf6mRbtKM7KoY721y/IYFIenAUJfm8rUu4Iw=;
        b=3iNXcI6W6EdebXvaqbZ7Gz5QD+PQxMy4DPi3C0H7a43MSCJYZXAl4d4wqKafeC/xwR
         t1m90Cy4HAdrp24lTo+kuaYFkxSG9DIWMGOLxxYaR/KoRhKDgXMLJy37zIQJcX+MPSD4
         d2lPBG67zr9NMwg23F/w3i27+WH/N/v1O0EIFRYzHcJSyl3Lbw+GPC9MCKpdAI86FcBa
         xaQJs+F9+JlqcDrlPLot1B2DyqFoaJj6Nm1E09XkiX9qqBNpSJQqEvqVQceBBU/ym79O
         g3YlKeklWdq9zaHxIas6lUXXiB+0uRVHkVWXEgfynW0p/rjXDHbt5iZ00/MIwwPdLkc1
         G3Ng==
X-Gm-Message-State: AOAM532rktNqH7Ofw7hTXwIrB8e1azk4CDqd3qpH8FDPXl1q7VSygCm1
        SKhvKMhj2E1wjU0vweunNw==
X-Google-Smtp-Source: ABdhPJztY01Htp3b7plSnLgVtXAE6/wMQ4BJc/inz7k+du/IoSn9hsGPbi3AVGmacTEQ3CbYasqFqg==
X-Received: by 2002:a5d:85c6:0:b0:63a:c12b:e0f4 with SMTP id e6-20020a5d85c6000000b0063ac12be0f4mr668858ios.18.1645070370850;
        Wed, 16 Feb 2022 19:59:30 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t15sm358729ilu.74.2022.02.16.19.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:59:29 -0800 (PST)
Received: (nullmailer pid 2266022 invoked by uid 1000);
        Thu, 17 Feb 2022 03:59:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
In-Reply-To: <20220216132830.32490-3-shawn.guo@linaro.org>
References: <20220216132830.32490-1-shawn.guo@linaro.org> <20220216132830.32490-3-shawn.guo@linaro.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: interrupt-controller: Add Qualcomm MPM support
Date:   Wed, 16 Feb 2022 21:59:23 -0600
Message-Id: <1645070363.942246.2266021.nullmailer@robh.at.kernel.org>
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

On Wed, 16 Feb 2022 21:28:29 +0800, Shawn Guo wrote:
> It adds DT binding support for Qualcomm MPM interrupt controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../interrupt-controller/qcom,mpm.yaml        | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml: properties:qcom,mpm-pin-count: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml: properties:qcom,mpm-pin-count: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml: properties:qcom,mpm-pin-count: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml: properties:qcom,mpm-pin-map: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	'description' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('$ref', 'items' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml: properties:qcom,mpm-pin-map: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'/schemas/types.yaml#/definitions/uint32-matrix' does not match '^#/(definitions|$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml: ignoring, error in schema: properties: qcom,mpm-pin-count
Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dt.yaml:0:0: /example-0/interrupt-controller@45f01b8: failed to match any schema with compatible: ['qcom,qcm2290-mpm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1593741

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

