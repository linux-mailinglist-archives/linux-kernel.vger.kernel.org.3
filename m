Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175AE59ECAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiHWTpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiHWTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:44:59 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88E46D9FE;
        Tue, 23 Aug 2022 11:47:09 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id g5-20020a4ac4c5000000b0044af7c8c4b3so2484049ooq.1;
        Tue, 23 Aug 2022 11:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=tHYjnzkUc2Gvy/va2RI2R+NsJzI7m0zroWi8SmJXJGE=;
        b=8PqnGfPX1fQcmkrlGSTVL/fy6bUmd0/964r9vxqy3TDjwifCUL5FWjTFPubGuhHR6X
         MWsZgAlH52uwhK3RoSkRqfGtufp7rH/4MbTf5oBT1+yaPIEkRVvM3aBtKEFccj/ccBoR
         m4HTNHzf4nWbS6RiZ25gZG3SgP0aA1q5+zvgYp1w0gDlMrAEnj/n3K1QQxvis7l2y61r
         M2ZQfUoFZgEp5t8EQeh2pJ02YqBdKEWVSAPCcY9NC7eOPZRggMaimFv9Zcdo38Ybpclu
         gMx35ZUU135cNUK3XkJzhp225cBlxvIrPaEYEazftoVRhrgOAMkp//khH7DAbLdBDiEB
         /ndQ==
X-Gm-Message-State: ACgBeo0aQvUs+WHR+sVFPLPOcYjmj2zJkfVZrDvAR/Z4greLEXGCDSSV
        kIimXRArvD30KDcSXWDERP9OOI6YnA==
X-Google-Smtp-Source: AA6agR7MkfBFGnMVdJ7ZdvTTyviNRzCXNrqYz7IHn6hyMrk7BM/gV7icm1f6LC3vQCNiknGqYTbZwg==
X-Received: by 2002:a4a:abcf:0:b0:428:47bc:4bc0 with SMTP id o15-20020a4aabcf000000b0042847bc4bc0mr8511436oon.15.1661280428885;
        Tue, 23 Aug 2022 11:47:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u15-20020a056870d58f00b0010e046491f8sm3980600oao.57.2022.08.23.11.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:47:08 -0700 (PDT)
Received: (nullmailer pid 3761037 invoked by uid 1000);
        Tue, 23 Aug 2022 18:47:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, UNGLinuxDriver@microchip.com,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220823060052.3921849-2-colin.foster@in-advantage.com>
References: <20220823060052.3921849-1-colin.foster@in-advantage.com> <20220823060052.3921849-2-colin.foster@in-advantage.com>
Subject: Re: [PATCH v1 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Date:   Tue, 23 Aug 2022 13:47:07 -0500
Message-Id: <1661280427.824099.3761036.nullmailer@robh.at.kernel.org>
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

On Mon, 22 Aug 2022 23:00:52 -0700, Colin Foster wrote:
> Convert the phy-ocelot-serdes device tree binding to the new YAML format.
> 
> Additionally, add the file to MAINTAINERS since the original file didn't
> exist.
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
>  .../bindings/phy/phy-ocelot-serdes.txt        | 43 -------------
>  .../bindings/phy/phy-ocelot-serdes.yaml       | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 62 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml: 'examlpes' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml: ignoring, error in schema: 

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

