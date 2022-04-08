Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8727B4F99C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiDHPpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbiDHPpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:45:31 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99E43337A;
        Fri,  8 Apr 2022 08:43:27 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id j83so9209026oih.6;
        Fri, 08 Apr 2022 08:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tIVvsMOQ7cFWwkCGVqCfLl1FwEek3DzuImDRvFkxMno=;
        b=otdtA3evqNnPCFlWoejcb0C49T0X0vayeQvRW5uAmWhpoPMRl64VD5qSJxgE48Lsw8
         tw+jU3RLpHCal1fD+2n4pXd7RD4E3jVZrXNzyK+qqN/Fpl8hXpvmEL7M9FL+dyczK4Tl
         +9zmlupHysU+VJOobr7wAJcyoJIsOcR22BrvXG5TamexbHgc//PnafVAuYObVOVMaFnC
         KfyE6+cRUa3BQnV0Kvmwt8VAQzQCLHNEb9p8OyJLuTAGIUDrJLsXTaTvUrKS+Ktxi6HC
         KrYeaVF+uTb/Vss8LLywG2MZDLeFJCLzfgQRWpo5Q+H8OvgtqWHhMKPs2TJpA6Ab5Vl+
         l3ag==
X-Gm-Message-State: AOAM5324q+cgGjkfpeK9NjAHyQy6tWJ7343c+9zV7P4zAUjNeolEbcYR
        kdwkpFUkIRjw3SdY5EABZg==
X-Google-Smtp-Source: ABdhPJx1waDvsdQQrqMQlc4BXnVbrJPfC+HVNMchAgDg3A24WVu+5+6z2d1B32mk2M4DBzW1QdA2Yg==
X-Received: by 2002:a05:6808:5c5:b0:2da:5bec:e1ff with SMTP id d5-20020a05680805c500b002da5bece1ffmr108506oij.189.1649432607264;
        Fri, 08 Apr 2022 08:43:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r19-20020acaa813000000b002ed02ca6a3fsm8769618oie.1.2022.04.08.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:43:26 -0700 (PDT)
Received: (nullmailer pid 3538560 invoked by uid 1000);
        Fri, 08 Apr 2022 15:43:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20220407154338.4190674-9-p.zabel@pengutronix.de>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de> <20220407154338.4190674-9-p.zabel@pengutronix.de>
Subject: Re: [PATCH 09/14] dt-bindings: reset: snps,dw-reset: Convert to yaml
Date:   Fri, 08 Apr 2022 10:43:25 -0500
Message-Id: <1649432605.563844.3538559.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2022 17:43:33 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Synopsys DesignWare reset
> controller to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>
> ---
>  .../bindings/reset/snps,dw-reset.txt          | 30 -------------
>  .../bindings/reset/snps,dw-reset.yaml         | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reset/snps,dw-reset.example.dts:20.41-24.11: Warning (unit_address_format): /example-0/reset-controller@0000: unit name should not have leading 0s

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt
MAINTAINERS: Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

