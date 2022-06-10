Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9010546FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348401AbiFJXTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbiFJXTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:19:12 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC8659D;
        Fri, 10 Jun 2022 16:19:10 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id s23so516630iog.13;
        Fri, 10 Jun 2022 16:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=I85nzJQvpanBbnKRqJtMLn+dRbMroiljIODt3AC3sUA=;
        b=d1V9VTvOTdB5PSzJQEQAfX0wnk/OEf5LT+s+vwUFh5DhoAToEtec3va884DEiaUnAN
         hy4sCgVbGOslJKfdlcMCN29/vYWGZXh0X79zANDDJbtpu+mCW1qoyhUHvvo2FnQYcRFc
         cV58KrDg6r93skqeLnaDRqOXbB/dNIqMu6d/+6wCW+k3Pl4CdH77hzeUPu3VO2W6XVqn
         hxJSizLZ9YBOr/+NWQKw3jj9B6rER7gJYxLDlGKR5ye7zqr4hKPwmljcVQ04MFtPMpXM
         lxR7GcO5kxP9R+RRhdtBZQUwKgvSDcCgzVl6XrRP2knDofjU50BAtNaZGyXGOi6depc6
         RyJQ==
X-Gm-Message-State: AOAM531MaITuOvpt25T/qzmMZf7C7XduXpdR0F0MhNwtFOO8ReNj4CwK
        KvZJ2T72RlGr6r5exkwTXw==
X-Google-Smtp-Source: ABdhPJyek+/IffazigJpKri07/SwvYOlBtivddM8UGvJatPh3EPESw3a8N+6KkBOSBAS1qj4+6zFxg==
X-Received: by 2002:a6b:2c87:0:b0:669:c37b:342b with SMTP id s129-20020a6b2c87000000b00669c37b342bmr1736787ios.158.1654903149861;
        Fri, 10 Jun 2022 16:19:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y21-20020a027315000000b00331c06bf620sm176633jab.154.2022.06.10.16.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 16:19:09 -0700 (PDT)
Received: (nullmailer pid 2450359 invoked by uid 1000);
        Fri, 10 Jun 2022 23:19:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
In-Reply-To: <20220610203746.2191518-1-robh@kernel.org>
References: <20220610203746.2191518-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mtd/partitions: Convert arm-firmware-suite to DT schema
Date:   Fri, 10 Jun 2022 17:19:06 -0600
Message-Id: <1654903146.326838.2450358.nullmailer@robh.at.kernel.org>
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

On Fri, 10 Jun 2022 14:37:44 -0600, Rob Herring wrote:
> Convert the arm,arm-firmware-suite partition binding to DT schema
> format. Simple conversion as there's only a compatible property.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../mtd/partitions/arm,arm-firmware-suite.txt | 17 -----------
>  .../partitions/arm,arm-firmware-suite.yaml    | 30 +++++++++++++++++++
>  2 files changed, 30 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.example.dts:18.17-22.11: Warning (unit_address_vs_reg): /example-0/flash@0: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

