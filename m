Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B91B5B0838
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiIGPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiIGPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:13:30 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DC057E05;
        Wed,  7 Sep 2022 08:13:28 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127d10b4f19so11002054fac.9;
        Wed, 07 Sep 2022 08:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dgmGxDNFvXOm4yqWSsGec1/H6R6opGE/962d6kVCRow=;
        b=tEU5wsa6dXCkrQCj0yC/8LcfEPqrOwOa8FpHSXKuwHIUEbLzhRF2ZBvP2eKTFsqYc9
         w35a+7PLoaz148QCzxvsqdOjlop88p/OpaQvZigfQBzDWmYLcCv3TDpoyXtzd1I6uMS+
         krYkZqUIKFEJZl8URpbqRGq08KocrGiGKotw2faidhiM3WgGZfU5iXmSANbRTaBjrnaR
         46eRETU1UO/xmt/ObyjKLkiKheh8uB+bDdRtksmAUyaMSE1wsba26dqAuOg1kLMCJRsk
         Nj5zPH+ccotNL+UDk7fFNyuLDcNW02SQJJQTHRT1s2Z5pvEeKCPLcBOzmowqjLcfHpzK
         T3Mg==
X-Gm-Message-State: ACgBeo3xMynkH0KPE60mb6adpK3vJONep3aqKLqOEwF6kdYKpggIgOac
        Vnu+x2PK2yDi+dq9NbR/lQ==
X-Google-Smtp-Source: AA6agR7x9v7wP2nBGNjRo3wjG7lFeYRzAJmOxl1KTPvxbC/LQ9wJFFOFFpzdFX8XGRS3VTiScqNXEQ==
X-Received: by 2002:a05:6808:1487:b0:344:8cb8:da49 with SMTP id e7-20020a056808148700b003448cb8da49mr12198907oiw.90.1662563608187;
        Wed, 07 Sep 2022 08:13:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q6-20020a0568080ec600b00342ece494ffsm6606976oiv.46.2022.09.07.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:13:27 -0700 (PDT)
Received: (nullmailer pid 3457341 invoked by uid 1000);
        Wed, 07 Sep 2022 15:13:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Smitha T Murthy <smitha.t@samsung.com>
Cc:     linux-kernel@vger.kernel.org, aakarsh.jain@samsung.com,
        andi@etezian.org, david.plowman@raspberrypi.com,
        dillon.minfei@gmail.com, stanimir.varbanov@linaro.org,
        jernej.skrabec@gmail.com, andrzej.hajda@intel.com,
        hverkuil-cisco@xs4all.nl, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        aswani.reddy@samsung.com, benjamin.gaignard@collabora.com,
        m.szyprowski@samsung.com, ezequiel@vanguardiasur.com.ar,
        pankaj.dubey@samsung.com, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, linux-fsd@tesla.com, alim.akhtar@samsung.com
In-Reply-To: <20220907064715.55778-2-smitha.t@samsung.com>
References: <20220907064715.55778-1-smitha.t@samsung.com>        <CGME20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7@epcas5p1.samsung.com> <20220907064715.55778-2-smitha.t@samsung.com>
Subject: Re: [Patch v2 01/15] dt-bindings: media: s5p-mfc: Add new DT schema for MFC
Date:   Wed, 07 Sep 2022 10:13:26 -0500
Message-Id: <1662563606.630951.3457340.nullmailer@robh.at.kernel.org>
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

On Wed, 07 Sep 2022 12:17:01 +0530, Smitha T Murthy wrote:
> Adds DT schema for s5p-mfc in yaml format
> 
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  .../devicetree/bindings/media/s5p-mfc.txt     |  77 +------------
>  .../bindings/media/samsung,s5p-mfc.yaml       | 109 ++++++++++++++++++
>  2 files changed, 110 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/media/samsung,s5p-mfc.example.dts:21.11-12 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/media/samsung,s5p-mfc.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

