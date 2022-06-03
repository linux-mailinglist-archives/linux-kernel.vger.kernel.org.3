Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5318353D2DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 22:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348237AbiFCUed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiFCUeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 16:34:31 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D12CC9B;
        Fri,  3 Jun 2022 13:34:30 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e656032735so12121980fac.0;
        Fri, 03 Jun 2022 13:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJw0B5tn4BmXSGtMVrepajRG0uVNOV/u4Rk3XgkDC7A=;
        b=XkWLs8ARyhlzkHBRIlXf2NrQQtC03JNDpjRt0/1Uhs2OTCmcbPo8M7S28iCUAy+tVa
         RTCUhdvh4DlaifmfI7mZDs867CfSPyIYFYHg7yHxyuDsYA8I/hZcxt4nfoQzgT1gUdmP
         IdHQHQQ8WIBPPNOPM0zHTDVwZHuH4Vox0IeFoojni+lM6j7wWd+caVMojS2bROIRFXnm
         co/cADVKxQl8xWJmtjl0iwJj8mja/J5zuPxE1Ee8nsW5nqMYKgYNN7Ojah1K/1g08NSU
         /lyte9Hdnbu1P9FLKYiKFf9ZMs5BVf3gZ9RTRnMzW5JV1uubc98loCSrI513iVpDzm6E
         UjYg==
X-Gm-Message-State: AOAM5313jntNM6iWebTrEySHoh9ZpxHUaXSl8QyN9IRbIPe15TDn0gze
        25ooBJK/Fx/OztSaUqbyqA==
X-Google-Smtp-Source: ABdhPJxxdyoxC3Rw40umBO2Z+JkgH098pk9/seLSsYxGasFWZIAMt9BGhGwEeRHvr/JdlzCpsyu7dQ==
X-Received: by 2002:a05:6870:c88a:b0:f2:8d92:318a with SMTP id er10-20020a056870c88a00b000f28d92318amr6954189oab.281.1654288469986;
        Fri, 03 Jun 2022 13:34:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f7-20020a056830264700b0060b1e040014sm3982071otu.51.2022.06.03.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 13:34:29 -0700 (PDT)
Received: (nullmailer pid 861878 invoked by uid 1000);
        Fri, 03 Jun 2022 20:34:29 -0000
Date:   Fri, 3 Jun 2022 15:34:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Message-ID: <20220603203429.GA858060-robh@kernel.org>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-2-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603121802.30320-2-kavyasree.kotagiri@microchip.com>
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

On Fri, Jun 03, 2022 at 05:48:00PM +0530, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../bindings/mfd/atmel,flexcom.yaml           | 97 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ------------
>  2 files changed, 97 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

Doesn't apply for me. If there's some 5.19-rc1 dependency, then resend 
after the merge window. Otherwise, at least document the dependency.

Rob
