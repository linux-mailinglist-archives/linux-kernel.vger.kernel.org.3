Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41515501B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiDNTCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbiDNTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:02:14 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B363915C;
        Thu, 14 Apr 2022 11:59:48 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e2fa360f6dso6198226fac.2;
        Thu, 14 Apr 2022 11:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lZfkYDeAjm+6YQ8+2GjY/45c8G+URa8JyKyRL4TBTWg=;
        b=eDnHQ9UBfY1agg27rgPGLcXvAQnk4WLl9MH+wUcuURBBPODgoe1MpkzBT0BpAQA1Av
         AZrzm1jtkLBBgcXOAGREiL5j4kVxXHXIukXGeI5UXRPvqKRQbwW90FOh/u3Ozfkk9YDL
         X0S0GT7Vvr55JxMx0iilGz8EnloP4FsONzLxjrNOrNX2sJgKgf41mw7OIybTuN5VZrSF
         ZiMTXsY2YsZJZ9aQzkx9qfXQXJi36obY1EHSkCeQydpsbLgxkigcPJwInRhTwLxGVsOJ
         0KQPtS6DSaDIGtqN4IHRDpKiXjbUYZWsAEnwqifGWOe8FXvQrF66HlQkOsQHyp69oW9U
         4eyg==
X-Gm-Message-State: AOAM531mfrNjTMsbQ+mG9ONe+7oz1GeXC2A42fjx40G9sAl+B+lcgkQ1
        HpavUWw9bnA5R898jOm9fINdfDXiWA==
X-Google-Smtp-Source: ABdhPJzX7pRO8egJ5JEFd1QYqY3meBNkQfkQAz4MY34/Zz8sNPdgaQK2ZYpFC5e/5IA9h/iYF7Yf0Q==
X-Received: by 2002:a05:6870:a546:b0:e2:ddbe:bdd6 with SMTP id p6-20020a056870a54600b000e2ddbebdd6mr6811oal.77.1649962787668;
        Thu, 14 Apr 2022 11:59:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e22-20020a056870239600b000e2f0c69849sm995484oap.11.2022.04.14.11.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:59:47 -0700 (PDT)
Received: (nullmailer pid 2441856 invoked by uid 1000);
        Thu, 14 Apr 2022 18:59:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com
In-Reply-To: <20220414122657.526406-2-gengcixi@gmail.com>
References: <20220414122657.526406-1-gengcixi@gmail.com> <20220414122657.526406-2-gengcixi@gmail.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Thu, 14 Apr 2022 13:59:45 -0500
Message-Id: <1649962785.225391.2441855.nullmailer@robh.at.kernel.org>
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

On Thu, 14 Apr 2022 20:26:55 +0800, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Add a new bindings to describe ums512 clock compatible string.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml:22:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml: properties:clock-names: {'minItems': 1, 'maxItems': 4, 'items': [{'const': 'ext-26m'}, {'const': 'ext-32k'}, {'const': 'ext-4m'}, {'const': 'rco-100m'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml: ignoring, error in schema: properties: clock-names
Documentation/devicetree/bindings/clock/sprd,ums512-clk.example.dtb:0:0: /example-0/soc/clock-controller@20200000: failed to match any schema with compatible: ['sprd,ums512-ap-clk']
Documentation/devicetree/bindings/clock/sprd,ums512-clk.example.dtb:0:0: /example-0/soc/syscon@20100000: failed to match any schema with compatible: ['sprd,ums512-glbregs', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

