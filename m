Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3D4EC6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbiC3OmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244124AbiC3OmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:42:15 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A453B7C;
        Wed, 30 Mar 2022 07:40:30 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so15035492otj.10;
        Wed, 30 Mar 2022 07:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WluG5A3Su9h6kButSakciwh97/HOUIf+fbIX970BGps=;
        b=5UTR25fk0eCnYZHCswINXb8g2foHBrXOVsMdSRzVUaORw2clQLqpLUgBG2LoeaCCzo
         EevNGFJJoBSjQB2pAuFldOplvxp4xr/gkkC7/kzaS548SLyJx6O0NHKXxswIkjFtLFyZ
         I+9SswivJELTcXkF1utwG/TuiAB+bwR1movajntxM8CJNemuoP8DBumnRbyB1WBpOGRE
         +fiaP54AnHFXJxyHOyfcOB93YTq0IJUh9lIJRuVaWAB28PHJWO8lRdsZyoQMzaRxevLZ
         QT4ncJVmBFglKkAV18ERMwPwG7KdYOQDoQ4JiJWiRfWyKGu9vDg6jYNUjOdaqTeqn1Qe
         JPeA==
X-Gm-Message-State: AOAM533aGvwqtlAnTrNU74BwhSrg6RtzwjzMRqRN5WR2cAFuusVDCGI+
        14o9Nj0mLz807tVeq1XNTw==
X-Google-Smtp-Source: ABdhPJwBBRjRl69m95mUWUdtBlAPdWiXCOSKHrQW8piO6H7rRiDBWu53Pcr1z0ZJDoY2oW17y4smCA==
X-Received: by 2002:a9d:74da:0:b0:5cd:b164:6daf with SMTP id a26-20020a9d74da000000b005cdb1646dafmr3414136otl.231.1648651229564;
        Wed, 30 Mar 2022 07:40:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c3-20020a056808138300b002f76b9a9ef6sm2137595oiw.10.2022.03.30.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:40:27 -0700 (PDT)
Received: (nullmailer pid 3015921 invoked by uid 1000);
        Wed, 30 Mar 2022 14:40:27 -0000
Date:   Wed, 30 Mar 2022 09:40:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "huziji@marvell.com" <huziji@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Message-ID: <YkRr22lQHKCZa5A2@robh.at.kernel.org>
References: <20220329000231.3544810-1-chris.packham@alliedtelesis.co.nz>
 <20220329000231.3544810-3-chris.packham@alliedtelesis.co.nz>
 <1648554629.870840.350362.nullmailer@robh.at.kernel.org>
 <d4c477b3-0cf2-e495-6a54-5fcd0301cc14@kernel.org>
 <6e118704-3c63-929e-ebf0-9a78fbed5daa@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e118704-3c63-929e-ebf0-9a78fbed5daa@alliedtelesis.co.nz>
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

On Tue, Mar 29, 2022 at 07:50:59PM +0000, Chris Packham wrote:
> 
> On 30/03/22 02:14, Krzysztof Kozlowski wrote:
> > On 29/03/2022 13:50, Rob Herring wrote:
> >> On Tue, 29 Mar 2022 13:02:31 +1300, Chris Packham wrote:
> >>> Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
> >>> in-tree dts files don't validate because they use sdhci@ instead of mmc@
> >>> as required by the generic mmc-controller schema.
> >>>
> >>> The compatible "marvell,sdhci-xenon" was not documented in the old
> >>> binding but it accompanies the of "marvell,armada-3700-sdhci" in the
> >>> armada-37xx SoC dtsi so this combination is added to the new binding
> >>> document.
> >>>
> >>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>> ---
> >>>
> >>> Notes:
> >>>      Changes in v4:
> >>>      - Add review from Krzysztof
> >>>      - Squash in addition of marvell,sdhci-xenon with an explanation in the
> >>>        commit message
> >>>      Changes in v3:
> >>>      - Don't accept ap807 without ap806
> >>>      - Add ref: string for pad-type
> >>>      Changes in v2:
> >>>      - Update MAINTAINERS entry
> >>>      - Incorporate feedback from Krzysztof
> >>>
> >>>   .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
> >>>   .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
> >>>   MAINTAINERS                                   |   2 +-
> >>>   3 files changed, 276 insertions(+), 174 deletions(-)
> >>>   delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> >>>   create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> >>>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.example.dt.yaml: mmc@aa0000: compatible: 'oneOf' conditional failed, one must be fixed:
> >> 	['marvell,armada-3700-sdhci'] is too short
> >> 	'marvell,armada-3700-sdhci' is not one of ['marvell,armada-cp110-sdhci', 'marvell,armada-ap806-sdhci']
> >> 	'marvell,armada-ap807-sdhci' was expected
> >> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> >> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.example.dt.yaml: mmc@ab0000: compatible: 'oneOf' conditional failed, one must be fixed:
> >> 	['marvell,armada-3700-sdhci'] is too short
> >> 	'marvell,armada-3700-sdhci' is not one of ['marvell,armada-cp110-sdhci', 'marvell,armada-ap806-sdhci']
> >> 	'marvell,armada-ap807-sdhci' was expected
> >> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> >>
> >> doc reference errors (make refcheckdocs):
> > Chris, your own dt binding does not pass it's check (example)...
> >
> > After updating the compatibles, you need to check the example. The
> > examples are anyway duplicating common stuff, so half of them could be
> > removed.
> 
> Yeah silly me. I started taking short cuts to run dt_binding_check 
> dtbs_check as one command but then the dt_bindings_check output scrolled 
> off the top of my terminal.
> 
> As for the examples themselves I want to leave what's there as a fairly 
> direct translation of the old binding. If we consider them unnecessary 
> removing them can be done as a follow-up.

The examples cannot have warnings/errors.

Rob
