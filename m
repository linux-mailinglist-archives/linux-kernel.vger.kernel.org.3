Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18635670CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGEOS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiGEOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:18:42 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826C222A7;
        Tue,  5 Jul 2022 07:14:12 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id p128so11232297iof.1;
        Tue, 05 Jul 2022 07:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=u3B52s9BVjfLE00xH/w1pvHP0oYdlCBCswFBMFKCN8E=;
        b=l/86pVHRaLUp9Y9Sk7Wi99OycLbkwo/MqN1grV8pR54chBReyWyAPPGDWS39jYBSmF
         5G0dsLI8WQ7xa2NSlR9zeFGqWKx+YV/l9kdper7Pv+iUaGdeKluanWh6zvShNNuJd45G
         Orte0iff2fkkpq7sVVxPr0subbleMU75EHlggjxOn4u8hKku052wbADC8QBa4lNrq29h
         uupbPRNNnO0wtqSUHjikZVwXxCRxYt4fDyAhPBm5/gRAvLTvx8au/MUhuzlwNnpbrM9q
         JVMfRo3Uu4159Y0ID3C7g8OBGrNUbSRvyR5kgXVEBjLIKtoPf09U/qnyDLO+PQqex6vg
         gNqw==
X-Gm-Message-State: AJIora/a2xg4vUPYZD2a2mOy1ZkXKbVYvJhdgiO6HqHezuBJ5R5dWbDS
        XsM1yPDUYiovn50cWoTU0w==
X-Google-Smtp-Source: AGRyM1vGWd92SH01YtAp8IRPCxtyzYzM+kpesmmk5aJTp2tiuL15Lk6/prD5mFHrx1PIjHm6qkpuSA==
X-Received: by 2002:a05:6638:f95:b0:314:58f9:5896 with SMTP id h21-20020a0566380f9500b0031458f95896mr21218247jal.228.1657030451057;
        Tue, 05 Jul 2022 07:14:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o4-20020a92d384000000b002dc0ccc4cafsm2777795ilo.49.2022.07.05.07.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:14:10 -0700 (PDT)
Received: (nullmailer pid 2035858 invoked by uid 1000);
        Tue, 05 Jul 2022 14:14:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220705094239.17174-18-johan+linaro@kernel.org>
References: <20220705094239.17174-1-johan+linaro@kernel.org> <20220705094239.17174-18-johan+linaro@kernel.org>
Subject: Re: [PATCH 17/43] dt-bindings: phy: qcom,qmp-pcie: add missing child node schema
Date:   Tue, 05 Jul 2022 08:14:09 -0600
Message-Id: <1657030449.193663.2035856.nullmailer@robh.at.kernel.org>
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

On Tue, 05 Jul 2022 11:42:13 +0200, Johan Hovold wrote:
> Add the missing the description of the PHY-provider child node which was
> ignored when converting to DT schema.
> 
> Also fix up the incorrect description that claimed that one child node
> per lane was required.
> 
> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 88 ++++++++++++++++++-
>  1 file changed, 85 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml: allOf:3:else:patternProperties:^phy@[0-9a-f]+$:properties:reg: {'minItems': 3, 'maxItems': 4, 'items': [{'description': 'TX'}, {'description': 'RX'}, {'description': 'PCS'}, {'description': 'PCS_MISC'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml: ignoring, error in schema: allOf: 3: else: patternProperties: ^phy@[0-9a-f]+$: properties: reg

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

