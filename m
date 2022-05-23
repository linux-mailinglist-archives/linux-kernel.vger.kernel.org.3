Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C727530F21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiEWMdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiEWMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:33:35 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9342EDA;
        Mon, 23 May 2022 05:33:33 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso3069056oto.10;
        Mon, 23 May 2022 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dwplQogufcM/dnnYWbT96twlhQ0Bm+4bOAAUZPHPafc=;
        b=S2iu8LAwk8AjNRz1QIZc9g2YZSYbTiwx1AvqJN4rYfzxqZ2K8qO31G01YGo6UL8GbA
         vDE13GbPIgfxCp8NAUzrdVrlyj27q4fcB65GSh5zleYON+zcxDBHbpJ8AWGQKUdyWneq
         r+QkxaC4lxPFYMd6PQnxxSdRzNlc+vXRaEMVAZOG+ZbI9ftIvocGmxfHJJEu+qC4f/YM
         Vj3WZ9JCg89TTv7rc0bikGBplYQ7S7Ox2PoXV8d+kt2MAz/irZnvIbDH+rSSCDf32zlj
         /IiVBkvVBF+YQE9iDi+rtko7xrx9I1vXZgxYsrX8+3f7iPfUZM0xlOQ/e1t2+nxo4+wm
         FnMw==
X-Gm-Message-State: AOAM531phNhEzby07u4+pB7SQPnQOoEwfzoRtoMqLuko0cVaw+nBnvXo
        UTlbYCtGyRFXhgS5VZ5Zdxa4NEJJZw==
X-Google-Smtp-Source: ABdhPJzOzSqNJr1zdhtsACskzJXsKeaw//EGjnzfH3hQzqBN9/ua9XgE+VlORI2w/MC1vWk22fnwNA==
X-Received: by 2002:a9d:768e:0:b0:60a:ed4f:2403 with SMTP id j14-20020a9d768e000000b0060aed4f2403mr5811132otl.237.1653309212748;
        Mon, 23 May 2022 05:33:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v132-20020aca618a000000b00325cda1ffabsm3894886oib.42.2022.05.23.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:33:32 -0700 (PDT)
Received: (nullmailer pid 1378075 invoked by uid 1000);
        Mon, 23 May 2022 12:33:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220523084958.2723943-2-jjhiblot@traphandler.com>
References: <20220523084958.2723943-1-jjhiblot@traphandler.com> <20220523084958.2723943-2-jjhiblot@traphandler.com>
Subject: Re: [PATCH 1/3] dt-bindings: leds: Add bindings for the TLC5925 controller
Date:   Mon, 23 May 2022 07:33:31 -0500
Message-Id: <1653309211.132000.1378074.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 10:49:55 +0200, Jean-Jacques Hiblot wrote:
> Add bindings documentation for the TLC5925 LED controller.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
> devicetree@vger.kernel.org
>  .../bindings/leds/leds-tlc5925.yaml           | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/leds/leds-tlc5925.yaml:52:15: [error] empty value in block mapping (empty-values)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml: patternProperties:@[a-f0-9]+$:properties:reg:items: 'anyOf' conditional failed, one must be fixed:
	None is not of type 'object', 'boolean'
	None is not of type 'array'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml: patternProperties:@[a-f0-9]+$:properties:reg:items: 'oneOf' conditional failed, one must be fixed:
	None is not of type 'object'
	None is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml: patternProperties:@[a-f0-9]+$:properties:reg: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml: patternProperties:@[a-f0-9]+$:properties:reg:items: 'oneOf' conditional failed, one must be fixed:
		None is not of type 'object'
		None is not of type 'array'
		hint: "items" can be a list defining each entry or a schema applying to all items. A list has an implicit size. A schema requires minItems/maxItems to define the size.
		from schema $id: http://devicetree.org/meta-schemas/core.yaml#
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml: ignoring, error in schema: patternProperties: @[a-f0-9]+$: properties: reg: items
Error: Documentation/devicetree/bindings/leds/leds-tlc5925.example.dts:18.9-14 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/leds/leds-tlc5925.example.dtb] Error 1
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

