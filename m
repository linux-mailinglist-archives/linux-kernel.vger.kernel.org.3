Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671B3508962
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379118AbiDTNdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379091AbiDTNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:32:44 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC12DF52;
        Wed, 20 Apr 2022 06:29:56 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id l9-20020a056830268900b006054381dd35so1095968otu.4;
        Wed, 20 Apr 2022 06:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=BG+0ozXvBLSOCY5he9k76u27evzUY5aBnxEBXuu4exA=;
        b=WIYRj8SIc2Rm2eCUDo1f+7I3VYMw0bEbP0lVJ5iDld21P69CEp/ecjlqH8ehwpnyEe
         WZUvaJxNWt8mukPgNK3/Tn797mnAp6c6kuFXyKJkEsvWk/Gfv8ENH3b9VqpeyN4/V8/7
         ahVZoOPjktJWMvo5O8d8mzAfQm/wvGGWOC1ExfLAvL7d47hdlct99qfKn2TP8avMBe7q
         nIcaPB9Q9yA5oGW5ApC5De+v9qYL7/IEBdMyMz4EJj0zwo0TSnfX0Oxzy0mkUPoFR9GC
         LDBMCZ7GF+aiSQ9j7KqnHM0jdNXskoosmI+i+TBVc0qCEEtp/jul831NVP9igeUqqBR0
         i+QQ==
X-Gm-Message-State: AOAM532xNM4dPC/+zP6Q7rs9WsNkfnWW48Uw+UKo8AoAuKSg7BkvUgEY
        7+a8mAPAIsXE90e18xgh+Q==
X-Google-Smtp-Source: ABdhPJwcecoaQxKd1d1Lc8VIkVNeCeomISZIs798r4fPHUG9GHAc/5YzUyxljMxV67Gwe/f1ZlfjmQ==
X-Received: by 2002:a9d:6d99:0:b0:605:67e2:229b with SMTP id x25-20020a9d6d99000000b0060567e2229bmr676848otp.13.1650461395681;
        Wed, 20 Apr 2022 06:29:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t83-20020aca5f56000000b00322b2a08b85sm2430637oib.19.2022.04.20.06.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:29:55 -0700 (PDT)
Received: (nullmailer pid 1168368 invoked by uid 1000);
        Wed, 20 Apr 2022 13:29:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Changming Huang <jerry.huang@nxp.com>
Cc:     leoyang.li@nxp.com, shawnguo@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, broonie@kernel.org
In-Reply-To: <20220420073146.38086-1-jerry.huang@nxp.com>
References: <20220420073146.38086-1-jerry.huang@nxp.com>
Subject: Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech sx1301
Date:   Wed, 20 Apr 2022 08:29:53 -0500
Message-Id: <1650461393.981975.1168367.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 15:31:45 +0800, Changming Huang wrote:
> Add DT Binding doc for semtech sx1301
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
> changes in v4:
>   - rename example node, adjust description
> changes in v3:
>   - add the dt-bindings
> 
>  .../bindings/spi/semtech,sx1301.yaml          | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml: properties:fsl,spi-sck-cs-delay: True is not of type 'object'
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml: properties:fsl,spi-sck-cs-delay: More than one condition true in oneOf schema:
	{'description': 'Vendor specific properties must have a type and '
	                'description unless they have a defined, common '
	                'suffix.',
	 'oneOf': [{'additionalProperties': False,
	            'description': 'A vendor boolean property can use "type: '
	                           'boolean"',
	            'properties': {'deprecated': True,
	                           'description': True,
	                           'type': {'const': 'boolean'}},
	            'required': ['type', 'description']},
	           {'additionalProperties': False,
	            'description': 'A vendor string property with exact values '
	                           'has an implicit type',
	            'oneOf': [{'required': ['enum']}, {'required': ['const']}],
	            'properties': {'const': {'type': 'string'},
	                           'deprecated': True,
	                           'description': True,
	                           'enum': {'items': {'type': 'string'}}},
	            'required': ['description']},
	           {'description': 'A vendor property needs a $ref to '
	                           'types.yaml',
	            'oneOf': [{'required': ['$ref']}, {'required': ['allOf']}],
	            'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'},
	                           'allOf': {'items': [{'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'}},
	                                                'required': ['$ref']}]}},
	            'required': ['description']},
	           {'description': 'A vendor property can have a $ref to a a '
	                           '$defs schema',
	            'properties': {'$ref': {'pattern': '^#/(definitions|$defs)/'}},
	            'required': ['$ref']}],
	 'type': 'object'}
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml: properties:fsl,spi-cs-sck-delay: True is not of type 'object'
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml: properties:fsl,spi-cs-sck-delay: More than one condition true in oneOf schema:
	{'description': 'Vendor specific properties must have a type and '
	                'description unless they have a defined, common '
	                'suffix.',
	 'oneOf': [{'additionalProperties': False,
	            'description': 'A vendor boolean property can use "type: '
	                           'boolean"',
	            'properties': {'deprecated': True,
	                           'description': True,
	                           'type': {'const': 'boolean'}},
	            'required': ['type', 'description']},
	           {'additionalProperties': False,
	            'description': 'A vendor string property with exact values '
	                           'has an implicit type',
	            'oneOf': [{'required': ['enum']}, {'required': ['const']}],
	            'properties': {'const': {'type': 'string'},
	                           'deprecated': True,
	                           'description': True,
	                           'enum': {'items': {'type': 'string'}}},
	            'required': ['description']},
	           {'description': 'A vendor property needs a $ref to '
	                           'types.yaml',
	            'oneOf': [{'required': ['$ref']}, {'required': ['allOf']}],
	            'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'},
	                           'allOf': {'items': [{'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'}},
	                                                'required': ['$ref']}]}},
	            'required': ['description']},
	           {'description': 'A vendor property can have a $ref to a a '
	                           '$defs schema',
	            'properties': {'$ref': {'pattern': '^#/(definitions|$defs)/'}},
	            'required': ['$ref']}],
	 'type': 'object'}
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml: ignoring, error in schema: properties: fsl,spi-cs-sck-delay
Documentation/devicetree/bindings/spi/semtech,sx1301.example.dts:22.11-21: Warning (reg_format): /example-0/spi@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/spi/semtech,sx1301.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/semtech,sx1301.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/semtech,sx1301.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/semtech,sx1301.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/semtech,sx1301.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/semtech,sx1301.example.dtb: example-0: spi@0:reg:0: [0] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/spi/semtech,sx1301.example.dtb:0:0: /example-0/spi@0: failed to match any schema with compatible: ['semtech,sx1301']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

