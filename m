Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD17C5677AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiGETTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiGETTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:19:05 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294371EC47;
        Tue,  5 Jul 2022 12:19:05 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id y18so12061590iof.2;
        Tue, 05 Jul 2022 12:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WPIEwkVrmxig66ialqAqq2owXYX1dmoA0wLUgk0+Jp8=;
        b=lY5AA5tvC3H/ahvP8oWme5Q6YeaftNZPnDExCzAULgzVhvNikAWGQeqlmGWuGHxAtt
         hsMyz+N2U+HsNiPNX3xuvxPlv8ThGOMKeMkq3Wjb7darkbKNcFVVbm89NPNPytCFBu9b
         jiq6tfI1XhMb3cSTeds23PwBq90p4c7q+wUmGSOac4zBwYY4EF+IweMycz/r2tW2MRoR
         EuuPyzTgB5Y8gSi30CLTbWNfmuUIFQ3Yu/1xsIFPhNDVsM9BSeid+ubzZ9e7okcQHLsK
         Ga/PSF926VHbI3gACUZYNGmceepxeUtL1GQQ7Q/lLLbTxY/MuMNWpJA1zNI9e83Ccm8V
         c6iQ==
X-Gm-Message-State: AJIora8iFRqOZmauryWCb/8cAn8e0o9Gnk6vFi0jt6jLYLmZezCMvY1f
        ln9xr+rRwIhS1lU7I4aaI9B+3m44bQ==
X-Google-Smtp-Source: AGRyM1ukQp/CEyzQERolQoD4vyxGMs9HeuxGET5TIc4m7jyTwHuQfQWJXFF3lpftEUav3q1LgeVswg==
X-Received: by 2002:a05:6602:164f:b0:678:9c7c:6701 with SMTP id y15-20020a056602164f00b006789c7c6701mr4168774iow.107.1657048744386;
        Tue, 05 Jul 2022 12:19:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f9-20020a02a109000000b00339e3a22dbbsm15216707jag.21.2022.07.05.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:19:04 -0700 (PDT)
Received: (nullmailer pid 2471231 invoked by uid 1000);
        Tue, 05 Jul 2022 19:18:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220705155929.25565-1-pali@kernel.org>
References: <20220705000448.14337-1-pali@kernel.org> <20220705155929.25565-1-pali@kernel.org>
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add cznic,turris1x-leds.yaml binding
Date:   Tue, 05 Jul 2022 13:18:57 -0600
Message-Id: <1657048737.399210.2471230.nullmailer@robh.at.kernel.org>
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

On Tue, 05 Jul 2022 17:59:28 +0200, Pali Rohár wrote:
> Add device-tree bindings documentation for Turris 1.x RGB LEDs.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v2:
> * Fix schema errors
> ---
>  .../bindings/leds/cznic,turris1x-leds.yaml    | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/leds/cznic,turris1x-leds.example.dts:23.13-47: Warning (ranges_format): /example-0/cpld@3,0:ranges: "ranges" property has invalid length (16 bytes) (parent #address-cells == 1, child #address-cells == 1, #size-cells == 1)

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

