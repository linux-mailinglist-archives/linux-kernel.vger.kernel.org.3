Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8B50FF46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351020AbiDZNnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiDZNnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:43:03 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AD866AEF;
        Tue, 26 Apr 2022 06:39:55 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-deb9295679so19374681fac.6;
        Tue, 26 Apr 2022 06:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QrQ9VqE2GYBUqLfXHq7kE29EKoA/X/hQON4fu6hD7zM=;
        b=Q6HmwT6x9gND+Fx5TSCy1XlVyzSFmryjgnfOPJHzyVx2T1YYqRqfhURUHELPeDd11F
         K6roCcGK/RVq4lOUi37RL+PWfipJzHaiKhHixM+brJ5xpcRAAHa+TQUdfLndniJUqfMr
         M53DNRkY+G5gmL0lvzv0FIUgiHHQR4OZ10BpIC+3L5goCnPXAPU+WoGyQ5BThR+KtNvP
         QRNN+ABEVg71JJMXJfeoRAi15wFFiadzviptb93DaRiNgIMWxHCakBRUZXN0wiuEmH3H
         wDNZgLm92IDHKJqSOrpCnFlWUgWBKAKHTT9Rk19v5cG49JfajBO/+UOygQjSpgSBpOMe
         225Q==
X-Gm-Message-State: AOAM5302EVwvfnaSQ9QeEYS3JszD3Dkz6o/E+jmntW6opz+4AzcwFQJX
        esU+Iq216pBsTaHLpZy6+mTNN5U1pw==
X-Google-Smtp-Source: ABdhPJy5hrZuALWcshnidC+ZyuM8Ji1w2mi/OyZokRnpLnmUn4Ia4cRlyuHR7vMBPaiesqxb5h9sLw==
X-Received: by 2002:a05:6870:f29a:b0:de:eaa4:233a with SMTP id u26-20020a056870f29a00b000deeaa4233amr9206354oap.137.1650980395073;
        Tue, 26 Apr 2022 06:39:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dv8-20020a056870d88800b000e92d5a54ffsm805426oab.26.2022.04.26.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:39:54 -0700 (PDT)
Received: (nullmailer pid 1856414 invoked by uid 1000);
        Tue, 26 Apr 2022 13:39:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Changming Huang <jerry.huang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-spi@vger.kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220426022413.885092-1-jerry.huang@nxp.com>
References: <20220426022413.885092-1-jerry.huang@nxp.com>
Subject: Re: [PATCH 1/3 v5] dt-bindings: dspi: added for MikcroBus socket
Date:   Tue, 26 Apr 2022 08:39:53 -0500
Message-Id: <1650980393.789726.1856413.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 10:24:11 +0800, Changming Huang wrote:
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
> changes in v5:
>   - rename compatible name to mikcroe,mikcroe-socket
> changes in v4:
>   - rename example node, adjust description
> changes in v3:
>   - add the dt-bindings
> 
>  .../bindings/spi/mikcroe,mikcroe-socket.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml: $id: 'http://devicetree.org/schemas/spi/mikcroe,mikcroe-spi#' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml: properties:fsl,spi-cs-sck-delay: True is not of type 'object'
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml: properties:fsl,spi-cs-sck-delay: More than one condition true in oneOf schema:
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
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml: properties:fsl,spi-sck-cs-delay: True is not of type 'object'
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml: properties:fsl,spi-sck-cs-delay: More than one condition true in oneOf schema:
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
./Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/spi/mikcroe,mikcroe-socket.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.yaml: ignoring, error in schema: $id
Error: Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.example.dts:20.9-15 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/spi/mikcroe,mikcroe-socket.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

