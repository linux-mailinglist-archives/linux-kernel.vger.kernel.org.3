Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09643505A39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbiDROtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiDROsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:48:52 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4526580B;
        Mon, 18 Apr 2022 06:35:50 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso9868918otf.12;
        Mon, 18 Apr 2022 06:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nM2L+6+JapegEUukuEtNkUpnQ327ArTz1PQHCESkekc=;
        b=CexFq6HtRzwSWzsSvbqg4a32Aj7UI2EJsoMtsW6d+y7prBEsVvPdhjNcbusGspsfiJ
         fN83AbqHAYJmTA1fHps92Mo7I13lE1DOcnl5pdwIhMnwFRvLwLj9VZOmsTdsWBwXMeXc
         5JwA7XLhQrkjIMGEYjMt8OzTIYyVFWXQpz8vn6Yx0er9tbV2n/UuoqH2noxTnhXQse6/
         57+oXvmVVD2uamMObSYzxjWyim+BnewmGoCDycbSN+we9KXKgFHaM63zCTtKfO8bvYvd
         6+uN65N3C2U80wMW4pYoBLcT7NvYjd+qdILfoyz822vyq8d+eII9q5s12bSg9yir1XZn
         e8UQ==
X-Gm-Message-State: AOAM530lCj09BiTfVjlmpPnvw2mPGlLOMrilkPYvVk+oEhieENCLZ3IT
        zREw+m/jIZAp9O7Xx/LWXw==
X-Google-Smtp-Source: ABdhPJz752ki2JeGrma0W1R0R7N4ZOPRVgO5nDcQ0xNX/FR870hfxRKpCIQJR1irqpOLZhDrCrSUGg==
X-Received: by 2002:a9d:5d16:0:b0:5ce:127a:1c42 with SMTP id b22-20020a9d5d16000000b005ce127a1c42mr3876612oti.350.1650288949590;
        Mon, 18 Apr 2022 06:35:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g8-20020acab608000000b002ecf38fb699sm3990505oif.38.2022.04.18.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:35:49 -0700 (PDT)
Received: (nullmailer pid 3125296 invoked by uid 1000);
        Mon, 18 Apr 2022 13:35:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Jirman <x@xff.cz>, linux-input@vger.kernel.org
In-Reply-To: <20220417021633.56127-2-samuel@sholland.org>
References: <20220417021633.56127-1-samuel@sholland.org> <20220417021633.56127-2-samuel@sholland.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: input: Add the PinePhone keyboard binding
Date:   Mon, 18 Apr 2022 08:35:48 -0500
Message-Id: <1650288948.488026.3125295.nullmailer@robh.at.kernel.org>
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

On Sat, 16 Apr 2022 21:16:29 -0500, Samuel Holland wrote:
> Add devicetree support for the PinePhone keyboard case, which provides a
> matrix keyboard interface and a proxied I2C bus.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Drop keymap DT properties
>  - Add vbat-supply property
> 
>  .../input/pine64,pinephone-keyboard.yaml      | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml: ignoring, error in schema: 
Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.example.dtb:0:0: /example-0/i2c/keyboard@15: failed to match any schema with compatible: ['pine64,pinephone-keyboard']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

