Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F340755E437
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbiF1NPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbiF1NPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:15:31 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE33135C;
        Tue, 28 Jun 2022 06:15:28 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id u20so12765660iob.8;
        Tue, 28 Jun 2022 06:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=eoO/x7bu4aRqXGjs88nzeRONL3YMYzeWgMsbV8yMbpY=;
        b=GqnlDCteBaxHcmNyqFKO4yDJRQ7CFaXvj6C56+crQit8n8o1bnesLY6XQM0o3tx4zP
         sg52qHkT0infg/vWhL3TWXQZmqHTikespCPh1YkkNmiEhtRcP7KSvnNik1skvYi5od0w
         ctJ0o9ZhYk6n9bohAas3P/LAzeYJWukv1bQKyJjQ1AeABmXH5w6TnpYAZudCcVCInNsR
         Y+pkJd8ZomHss5OfsjCY8vX+IpMJ72XQeyMhNGOx8vVJ+sA8N4yDZxlYRMetPpu5UujG
         LHWTl7VX3lHhnMNTcyTmrWAUFxYbDh/6GkNwQ6sFMhWMvrtsWGfOyFR0r40E78LVd3Uu
         06Yg==
X-Gm-Message-State: AJIora8lNdb+rDGn/geC6qdY4fSqH2GzikO5BFT94woGNbFBrwj1GeQY
        l8Yng8NZoyo3Xd6V8FrmG1yo1UVXAA==
X-Google-Smtp-Source: AGRyM1uLRQIsoQb/m55If6Pna11BMZb9W0F/Ss94rf+Kxx2UN5mK1VltXoovNGgZqa3DJA5DrrhtYQ==
X-Received: by 2002:a6b:3f8a:0:b0:672:77f8:c000 with SMTP id m132-20020a6b3f8a000000b0067277f8c000mr9507935ioa.11.1656422128117;
        Tue, 28 Jun 2022 06:15:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b15-20020a056602218f00b00669b2ffad32sm6640154iob.54.2022.06.28.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:15:27 -0700 (PDT)
Received: (nullmailer pid 313748 invoked by uid 1000);
        Tue, 28 Jun 2022 13:15:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, tlanger@maxlinear.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        vigneshr@ti.com, linux-kernel@vger.kernel.org,
        rtanwar@maxlinear.com
In-Reply-To: <20220628112731.2041976-2-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com> <20220628112731.2041976-2-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH RFC v1 1/8] dt-bindings: mtd: intel: lgm-nand: Fix compatible string
Date:   Tue, 28 Jun 2022 07:15:23 -0600
Message-Id: <1656422123.522235.313747.nullmailer@robh.at.kernel.org>
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

On Tue, 28 Jun 2022 13:27:24 +0200, Martin Blumenstingl wrote:
> The driver which was added at the same time as the dt-bindings uses the
> compatible string "intel,lgm-ebunand". Use the same compatible string
> also in the dt-bindings.
> 
> Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/mtd/intel,lgm-nand.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

