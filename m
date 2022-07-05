Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F04567055
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiGEOHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiGEOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:06:26 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B959E5585;
        Tue,  5 Jul 2022 06:54:41 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id r133so11161107iod.3;
        Tue, 05 Jul 2022 06:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wSbi+Yapsg0IfPzaUY/hIFJoyEdtAo+MMIudhobPdvQ=;
        b=b2Gh5MbgB8EXzM4Ih/qrGlxcLcd4vYyRUvtC4Cti+xqAL7O3hZ+SwtE8HGihglKFKa
         Y7Zk4ESYC+eSpkuFCjMVx7rBNP+gx8Cm8HBAbViy5W/4T1WSZFldz7wZHjqKwiY5GKN1
         B2dz96q6/fEAFySMuH50TbAe37Fd35nOgo5eezyI2mSAX5+bLXPiHg2dLmNlglNoJia/
         BiMf82KqcV9bEqg8KrZewYV65MfI8PZ0X1J2ULn1zCbgzyuB4fgEnI6S35OW7ZVZOQes
         OcwhI8siJtPB/Hq1voBRplBPISVXHzrJJfqPTb3pBbXKn/R52TFP6Z4CTP1XHuF/npCR
         5jNA==
X-Gm-Message-State: AJIora83Pswjo3ILGOKy00EDKTfOqWT3Z/3eZr/ZcN3paQxY7ZhdSFbB
        5rfOMjttIK4207htc+2Q6w==
X-Google-Smtp-Source: AGRyM1ul79hg6w7JBKvpSn59jpa12141EBVpo5YfxCgbhC8ntMWQRS2E7XSrs3NNh6bgwEFvvPBCRQ==
X-Received: by 2002:a05:6638:160f:b0:33c:ad8e:bcc0 with SMTP id x15-20020a056638160f00b0033cad8ebcc0mr21840034jas.299.1657029280958;
        Tue, 05 Jul 2022 06:54:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r14-20020a92cd8e000000b002d11397f4f9sm13195229ilb.74.2022.07.05.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:54:40 -0700 (PDT)
Received: (nullmailer pid 1999986 invoked by uid 1000);
        Tue, 05 Jul 2022 13:54:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jli@analogixsemi.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        qwen@analogixsemi.com, bliang@analogixsemi.com
In-Reply-To: <20220705053657.2340274-2-xji@analogixsemi.com>
References: <20220705053657.2340274-1-xji@analogixsemi.com> <20220705053657.2340274-2-xji@analogixsemi.com>
Subject: Re: [PATCH v13 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Date:   Tue, 05 Jul 2022 07:54:31 -0600
Message-Id: <1657029271.166880.1999984.nullmailer@robh.at.kernel.org>
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

On Tue, 05 Jul 2022 13:36:55 +0800, Xin Ji wrote:
> Add analogix PD chip anx7411 device binding
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> 
> ---
> v12 -> v13 :
>     1. Drop the quotes for "$id" and "$schema"
>     2. Remove "allOf" label
>     3. Change node name from "i2c1" to "i2c"
>     4. Change node name from "typec" to "usb-typec"
> ---
>  .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/usb/analogix,anx7411.example.dts:26.22-23 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/usb/analogix,anx7411.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

