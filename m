Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121555912C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiHLPOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiHLPOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:14:00 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA79DA599C;
        Fri, 12 Aug 2022 08:13:59 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id o14so622665ilt.2;
        Fri, 12 Aug 2022 08:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=iLtu9hJNizm2ENvwqp87YzdTn+996PrzRE54oAzKcMM=;
        b=GK25sJZgzdZSpheohy0ovVVatGqHrfSJ1IhoqeM/qxZmLkocrji78He8ewcFTYk/Oj
         AQcjHTDTqRAY3SH12LiNyDkaW4dxJQqgVtQ4u1ChvlkAsORPEun3gyK3X8C4h73o0AzE
         UTWsR89IQmGlAzT1wMeV3W347/bM7nuosYbITmBeEIriwcDqY4dVQDMUP+y8J7LnMhts
         uUXLnGACGMtWvfZM3OJ9sH64pXvcJ/+OCwZQkktzZapZdwunUU7Gy6cby8LFdpuAqQqD
         I4Ljhz+LpsRLijLJSJCB7tVC8/M4y3BM0N4s6Bd6Ll0f20QHBb1TXkbc5H2hNbIRHVOy
         i1pQ==
X-Gm-Message-State: ACgBeo2v/qGBDhdEgaUecovajs3gE3r0nATSVX7FHBMXCCOO+3bnVyrj
        Bs313/zwOfDtuZEN+xbIMg==
X-Google-Smtp-Source: AA6agR7KRpnUyFMI150wo+Sdnq1BIvRsT6BExj1A3Xi3z6PcCcJJtet+x4xVVJ+NmoSp4yKkpTJ+hQ==
X-Received: by 2002:a92:cda6:0:b0:2df:a33b:202b with SMTP id g6-20020a92cda6000000b002dfa33b202bmr2085796ild.161.1660317238913;
        Fri, 12 Aug 2022 08:13:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o4-20020a927304000000b002e4c8200225sm70611ilc.39.2022.08.12.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:13:58 -0700 (PDT)
Received: (nullmailer pid 168982 invoked by uid 1000);
        Fri, 12 Aug 2022 15:13:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220812075603.59375-2-samuel@sholland.org>
References: <20220812075603.59375-1-samuel@sholland.org> <20220812075603.59375-2-samuel@sholland.org>
Subject: Re: [PATCH 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts property
Date:   Fri, 12 Aug 2022 09:13:53 -0600
Message-Id: <1660317233.444952.168981.nullmailer@robh.at.kernel.org>
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

On Fri, 12 Aug 2022 02:55:56 -0500, Samuel Holland wrote:
> The sun6i DPHY can generate several interrupts, mostly for reporting
> error conditions, but also for detecting BTA and UPLS sequences.
> Document this capability in order to accurately describe the hardware.
> 
> The DPHY has no interrupt number provided in the vendor documentation
> because its interrupt line is shared with the DSI controller.
> 
> Fixes: c25b84c00826 ("dt-bindings: display: Convert Allwinner DSI to a schema")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml           | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.example.dtb: d-phy@1ca1000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

