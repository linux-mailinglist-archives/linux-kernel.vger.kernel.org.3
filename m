Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818458AC38
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbiHEOPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbiHEOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:15:00 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B08C17E2F;
        Fri,  5 Aug 2022 07:14:59 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id v185so1968856ioe.11;
        Fri, 05 Aug 2022 07:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=GStP1mWtH05yFhEkyFXX7j8mnan7IGcniVkf2QQYi5Y=;
        b=3OIrcIN2MS/6Y00TyUghgbw96YcIG8n5jHm3vHbo/+Wbzs7WonWl2LK51duOT0eiEH
         WzIUuDNH31r7HsyEFphSnNs+7KVKD1IINet+ghu5gP4qK85MPhdNw/w6v6vPITFGHaiY
         LQHnvIMh6I74uEYunDzfS5mTrCdoQ6L8WE28pa4pPUfkz1hrQOs+ub/IhIP3QyDCVBoK
         caK3bEOW9nfmeS9Y8pzNS+yQNoMeten2ZdCiVB0QnZ7EyGqojEdebPsDMfZsU+R1zooS
         F2ytZsfHK3jfy67yqpKekYvu1VNXc0utVILtXie81QRlTaSeOfTQFynOMp+UkJpACbWE
         SabQ==
X-Gm-Message-State: ACgBeo3Z3HICDEZYhIJahxHcBQudNNYY+K6bys4n0D0Xn1fJXCp0cTHc
        iO4YZapDE5wPF2fh0ZtWsWTOnNv8gw==
X-Google-Smtp-Source: AA6agR6lC6UYJeG5WuaFwW9AeuSAogmFk+tf/UzDHbotiYOTSh/sLrt1NAzasR3dTIyB0jtffRTkvA==
X-Received: by 2002:a02:ac91:0:b0:342:77df:129a with SMTP id x17-20020a02ac91000000b0034277df129amr3159812jan.115.1659708898718;
        Fri, 05 Aug 2022 07:14:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a16-20020a92d590000000b002dab4765893sm1706342iln.66.2022.08.05.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:14:58 -0700 (PDT)
Received: (nullmailer pid 1809603 invoked by uid 1000);
        Fri, 05 Aug 2022 14:14:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lee@kernel.org, nm@ti.com,
        linux-rtc@vger.kernel.org
In-Reply-To: <20220805064352.793918-2-mranostay@ti.com>
References: <20220805064352.793918-1-mranostay@ti.com> <20220805064352.793918-2-mranostay@ti.com>
Subject: Re: [PATCH 1/4] Documentation: tps6594x: Add DT bindings for the TPS6594x PMIC
Date:   Fri, 05 Aug 2022 08:14:55 -0600
Message-Id: <1659708895.345431.1809602.nullmailer@robh.at.kernel.org>
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

On Thu, 04 Aug 2022 23:43:49 -0700, Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti,tps6594x.yaml  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml: properties:ti,system-power-controller: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml: properties:ti,system-power-controller: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml: properties:ti,system-power-controller: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
./Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/mfd/ti,tps6594x.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml: ignoring, error in schema: properties: ti,system-power-controller
Documentation/devicetree/bindings/mfd/ti,tps6594x.example.dtb:0:0: /example-0/i2c0/pmic@48: failed to match any schema with compatible: ['ti,tps6594x']
Documentation/devicetree/bindings/mfd/ti,tps6594x.example.dtb:0:0: /example-0/i2c0/pmic@48/rtc: failed to match any schema with compatible: ['ti,tps6594x-rtc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

