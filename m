Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8975587172
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiHATbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiHATay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:30:54 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC31117E;
        Mon,  1 Aug 2022 12:30:50 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id p10so840590ile.5;
        Mon, 01 Aug 2022 12:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=68X4qWbGtTFIeTpRkrQqYh3V9U2RdglpeJ/XvuTio2M=;
        b=6K3kDAMEuG4O2yYT3bEXRUXz0QgV0ftzshhkzXRUDcwEdJclsJRLd748yCfjnGaKmt
         Cp2RLQfv4S5RFaKhDPcCI2AOYpUmvtFI7QqkQOu/dkmngz1RDNCxMtqKZ6FWoLm9Cv1p
         +W2V87+F+7H+B/WlJpfrONtwlJXC94ZNzKxOT2ciSYYxoRSSYA0Lt3w1qo0etjXzidF2
         hShgNFkg0OBvJ4/jXyuRr3ejFuqtqtzImzCANdF+60ELEKNRqfir2lMJTUeOQ2l1ekwE
         ztlCj3ZJnbaYNY6/hl49VIyxgatH+1IwErv1VpB+XAbRl5cYo3yLCsJ7xTRLjtIVzWX9
         L6IA==
X-Gm-Message-State: AJIora/wUAzq0Zayy6ieO4pO3dOUv0z1iYa+XQ4HmbfZPDeKeUFMcfO5
        /85ZUhP+QyNjQDr9q5bFGg==
X-Google-Smtp-Source: AGRyM1tQNi5twR+ViPskLi6NNiVfaZlNIANTIuqKhF5Nl5YIUD1ubx9Pi6G6HuZVS9nvyPZ5GIuC1g==
X-Received: by 2002:a92:d752:0:b0:2dd:d885:82f2 with SMTP id e18-20020a92d752000000b002ddd88582f2mr6615271ilq.50.1659382249905;
        Mon, 01 Aug 2022 12:30:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o8-20020a92c688000000b002dcf9e17a29sm5021974ilg.76.2022.08.01.12.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 12:30:49 -0700 (PDT)
Received: (nullmailer pid 1380282 invoked by uid 1000);
        Mon, 01 Aug 2022 19:30:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, perex@perex.cz,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, robh+dt@kernel.org, tiwai@suse.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1659370052-18966-2-git-send-email-spujar@nvidia.com>
References: <1659370052-18966-1-git-send-email-spujar@nvidia.com> <1659370052-18966-2-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: Add schema for common DAI params
Date:   Mon, 01 Aug 2022 13:30:47 -0600
Message-Id: <1659382247.124005.1380281.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022 21:37:30 +0530, Sameer Pujar wrote:
> The "convert-channels" and "convert-rate" bindings are provided for both
> simple-card and audio-graph-card. However these are separately defined in
> their respective schemas. For any new binding addition, which is common to
> both, there will be duplication.
> 
> Introduce a new schema to have common DAI params properties and these can
> be re-used in other schemas wherever applicable.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/audio-graph-port.yaml           | 13 ++++------
>  .../devicetree/bindings/sound/audio-graph.yaml     |  7 +++---
>  .../devicetree/bindings/sound/dai-params.yaml      | 28 ++++++++++++++++++++++
>  .../devicetree/bindings/sound/simple-card.yaml     | 16 ++++---------
>  4 files changed, 40 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/dai-params.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.yaml: properties:simple-audio-card,convert-rate: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	'description' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('$ref' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.yaml: properties:simple-audio-card,convert-rate: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'/schemas/sound/dai-params.yaml#/properties/dai-sample-rate' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	'/schemas/sound/dai-params.yaml#/properties/dai-sample-rate' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.yaml: properties:simple-audio-card,convert-channels: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	'description' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('$ref' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.yaml: properties:simple-audio-card,convert-channels: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'/schemas/sound/dai-params.yaml#/properties/dai-channels' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	'/schemas/sound/dai-params.yaml#/properties/dai-channels' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
./Documentation/devicetree/bindings/sound/simple-card.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/sound/simple-card.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.yaml: ignoring, error in schema: properties: simple-audio-card,convert-channels
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound: simple-audio-card,widgets: b'Microphone\x00Microphone Jack\x00Headphone\x00Headphone Jack\x00Speaker\x00External Speaker\x00' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound: simple-audio-card,routing: b'MIC_IN\x00Microphone Jack\x00Headphone Jack\x00HP_OUT\x00External Speaker\x00LINE_OUT\x00' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb:0:0: /example-0/sound: failed to match any schema with compatible: ['simple-audio-card']
Documentation/devicetree/bindings/sound/simple-card.example.dtb:0:0: /example-1/sound: failed to match any schema with compatible: ['simple-audio-card']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound: simple-audio-card,widgets: b'Headphone\x00Headphone Jack\x00' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb:0:0: /example-2/sound: failed to match any schema with compatible: ['simple-audio-card']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound: simple-audio-card,routing: b'ak4642 Playback\x00DAI0 Playback\x00DAI0 Capture\x00ak4642 Capture\x00' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb:0:0: /example-3/sound: failed to match any schema with compatible: ['simple-audio-card']
Documentation/devicetree/bindings/sound/simple-card.example.dtb:0:0: /example-4/sound: failed to match any schema with compatible: ['simple-audio-card']
Documentation/devicetree/bindings/sound/simple-card.example.dtb:0:0: /example-5/sound: failed to match any schema with compatible: ['simple-audio-card']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

