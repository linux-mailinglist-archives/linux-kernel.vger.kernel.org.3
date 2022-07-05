Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE30567044
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiGEOGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiGEOGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:06:20 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A7F237DA;
        Tue,  5 Jul 2022 06:54:34 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id h5so7286295ili.3;
        Tue, 05 Jul 2022 06:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=buPhKKKW8Xayy8T9aHzdMFGzDZRwQ4d9cvNmyEA517Q=;
        b=6OPYwWjvpClcFEgRDlrd3slFsIL153UN8Hw4V7WA43IiPEQ8va3EVfwQbjjUMYymmN
         cRSbZC8yvW/PNAIXCOmNCqdC3lWi1p3Vx++rg8AFMqXRXM3xQFJ1+NUxX5KC8A1CTj9A
         ZQdTsdTWCBqC0t68q7VKCAHbq/J+CoGtgh34noTD1s0NfZoJ2syVeuPd2xXXkL8FldEw
         XRHygK6MLgCKywTJwsmXI0NuUq5wvux06CWd/K237QWjoewbClMCYBGelkAm5k2EhUFp
         JpZcSbMJpYhLTSU1edqARqpQIcHqoR5vWKNU3VaAb80gEbYemznHiikkDymF/MDvVNIr
         Iukg==
X-Gm-Message-State: AJIora/Jgpf0ahFIWrXvnlCaULz09CQ3aAG4WZDuyNAA9P+EuqVjidKq
        59omW/Lw4axI6D+nMW+QQxZa6W/3EQ==
X-Google-Smtp-Source: AGRyM1s+sSt2C+3zdM8x8HXBUZqMpoqENUNuNJ3ltpsCbA+QPeSFS+w1g92ETH9uvwjhbZ3cmkWH5Q==
X-Received: by 2002:a05:6e02:20c5:b0:2d9:3368:3db1 with SMTP id 5-20020a056e0220c500b002d933683db1mr20137991ilq.112.1657029273087;
        Tue, 05 Jul 2022 06:54:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p4-20020a056638190400b0033ea1d9858bsm5308602jal.36.2022.07.05.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:54:32 -0700 (PDT)
Received: (nullmailer pid 1999979 invoked by uid 1000);
        Tue, 05 Jul 2022 13:54:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
In-Reply-To: <20220705000448.14337-1-pali@kernel.org>
References: <20220705000448.14337-1-pali@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add cznic,turris1x-leds.yaml binding
Date:   Tue, 05 Jul 2022 07:54:31 -0600
Message-Id: <1657029271.142997.1999977.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2022 02:04:47 +0200, Pali Rohár wrote:
> Add device-tree bindings documentation for Turris 1.x RGB LEDs.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../bindings/leds/cznic,turris1x-leds.yaml    | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/leds/cznic,turris1x-leds.example.dts:21.18-84.11: Warning (unit_address_vs_reg): /example-0/cpld@3,0: node has a unit name, but no reg or ranges property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.example.dtb: led-controller@13: reg: [[19, 29]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

