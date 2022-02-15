Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB44B7078
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiBOPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:23:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiBOPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:23:13 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DBA8A6C3;
        Tue, 15 Feb 2022 07:23:02 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id m185so24208560iof.10;
        Tue, 15 Feb 2022 07:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vrGCEqs3ZcHD11nZgMvaC4OA4F7Yf6g0iO/URyWvAjM=;
        b=Xlb4gf0fz1h7XjfDsVRsZZG48arWGnk7YaXA5XoTdMQh8Q3IOG4ggHP6Z3+jWGJD3z
         tX8GEzyyjtpEZ3e8ONaOIcuVCF7cOamSHDyujocipDMMdGTsUXAAM71+/0cJx7ixT0p7
         foPq3t8bTH0PNvXzjojpakYY1+cKPMsYsEraakx/D7FMvDlJzTLkzHQDWSiaxMBVEMaD
         UzPbS2imnV7L4BU18DlyhfDKLaMUpBnhGb9TevxHAwtVvj3A/uonSZzYsuMi8jemiqIk
         CJVSBQECf9Uw2SNowaF/1h+Dn3SlOxllTesjmYcsu0FbhURWt5yb3I1P3dkqkI7AaZxL
         epkA==
X-Gm-Message-State: AOAM531taKHI0DhfDtsC3vFo8ecLyNuTv/o2I79bxuHuBGnrOegucJsH
        gYrZ+BCwDf6Ry10yjkoOSQ==
X-Google-Smtp-Source: ABdhPJx3ciMARLUvsLLdfn081t+WvmIB7RaM+GlMGeydTUKsgDMINbDqr63hWtB6jJAjkcYmFzHV1A==
X-Received: by 2002:a05:6638:160c:: with SMTP id x12mr3002235jas.151.1644938581797;
        Tue, 15 Feb 2022 07:23:01 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g19sm1767007iox.39.2022.02.15.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:22:59 -0800 (PST)
Received: (nullmailer pid 3450858 invoked by uid 1000);
        Tue, 15 Feb 2022 15:22:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     linux-input@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org
In-Reply-To: <20220211233137.99624-2-danilokrummrich@dk-develop.de>
References: <20220211233137.99624-1-danilokrummrich@dk-develop.de> <20220211233137.99624-2-danilokrummrich@dk-develop.de>
Subject: Re: [PATCH 1/2] dt-bindings: ps2-gpio: convert binding to json-schema
Date:   Tue, 15 Feb 2022 09:22:45 -0600
Message-Id: <1644938565.051109.3450857.nullmailer@robh.at.kernel.org>
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

On Sat, 12 Feb 2022 00:31:36 +0100, Danilo Krummrich wrote:
> Convert the ps2-gpio dt-binding documentation to DT schema format using
> the json-schema.
> 
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  .../devicetree/bindings/serio/ps2-gpio.txt    | 23 --------
>  .../devicetree/bindings/serio/ps2-gpio.yaml   | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/ps2-gpio.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/ps2-gpio.yaml: ignoring, error in schema: 
Error: Documentation/devicetree/bindings/serio/ps2-gpio.example.dts:22.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/serio/ps2-gpio.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1591901

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

