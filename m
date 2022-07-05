Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87A5677AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiGETTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiGETTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:19:03 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3793721E1D;
        Tue,  5 Jul 2022 12:19:02 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id h5so7883832ili.3;
        Tue, 05 Jul 2022 12:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=H2/JFG0hb41g8ahIOdqUXPABcdIND6KlxCLKCofk1Tk=;
        b=5TwsDD1oL5fi2YGAEgh1wRtJclAISG3LW2bXlwEmAYkiceRtbMDe5d6oN34h0Y8vDT
         iMH3UMDntgvb6RBGzP7p1iUorYH80FdFcvJLNjcnBuuNZbGkgogEjk3pIPpt+aq1MheI
         Qf3h39wz5aaHGd4/g0eAnx3RI4CmSjZi7PfwSstlrWXh3jkQhcHcTsn9NWybMcFkZ+K2
         mtZnWf4KH6oy1WGXAZ4auLFabUVx4rhTywVGkV/UL1pG4hl4a5q6Xs10iKK4PifSYdOG
         he1QZI1D5SMpzsC20rVKKiE1pjGyJUSAnyRDIyz77jBYjKk5uYXlH2ySk6ODt/HaV8hW
         6orw==
X-Gm-Message-State: AJIora9JjpNOORiB6qUhcWft6mhK+aVVCWedmcMBddDZ9qc9vwpdQwHX
        jCpGJXryRzwOyI0JvGRI5A==
X-Google-Smtp-Source: AGRyM1slveEYm+aObYhSURKqgQkyndiEbdFCPWNudhuY/5PhoCwMVhuWlaclmf8rHLFT3yCK0IZ15A==
X-Received: by 2002:a05:6e02:1b81:b0:2da:d56b:1587 with SMTP id h1-20020a056e021b8100b002dad56b1587mr18264556ili.74.1657048741398;
        Tue, 05 Jul 2022 12:19:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k14-20020a0566022a4e00b0067821726c8csm5923139iov.53.2022.07.05.12.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:19:01 -0700 (PDT)
Received: (nullmailer pid 2471235 invoked by uid 1000);
        Tue, 05 Jul 2022 19:18:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ryan.Wanner@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alexandre.berna@microchip.com, nicolas.ferre@microchip.com,
        Claudiu.Beznea@microchip.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220705163046.18409-1-Ryan.Wanner@microchip.com>
References: <20220705163046.18409-1-Ryan.Wanner@microchip.com>
Subject: Re: [PATCH] dt-bindings: sound: Convert atmel CLASSD to json-schema
Date:   Tue, 05 Jul 2022 13:18:57 -0600
Message-Id: <1657048737.414926.2471234.nullmailer@robh.at.kernel.org>
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

On Tue, 05 Jul 2022 09:30:46 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert atmel CLASSD devicetree binding to json-schema.
> Change file name to match json-scheme naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../bindings/sound/atmel,sama5d2-classd.yaml  | 111 ++++++++++++++++++
>  .../bindings/sound/atmel-classd.txt           |  55 ---------
>  2 files changed, 111 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/atmel-classd.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/sound/atmel,sama5d2-classd.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

