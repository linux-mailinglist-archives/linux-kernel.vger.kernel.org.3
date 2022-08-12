Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12C95912C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbiHLPOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiHLPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:13:59 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D4A7A80;
        Fri, 12 Aug 2022 08:13:57 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id r5so1029106iod.10;
        Fri, 12 Aug 2022 08:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=+gnS23mSZkFSRCfkxdCiT8D1lZEPwBiVeiXPhatZCZ4=;
        b=d52qyPc31Wa84oGVIzvGheJQeI+dksihim5QOh10Rip8fI+fRUqRtsT/Je4oLYMRpt
         ruPZ3Wd/a+HVC3v4PKFGqgOPIZAuLrP/IhT9Hq3K117vmFgB2DtZrXrzye2ttdmsiJ/W
         UIjfGMIvQwFo8mcaXKD7/61dKX/a8yOS0BwJOjxUZVhOrn0mmesOoxlxcepNH3sky0ho
         wZ4ngmCyZKyplW0VlBB84s6SeRERg+Y2axE8HJW5WhXbVO6z8C4W1DHKjpxNZFhbagEr
         8jwrR6jkXA5HXR5XzzEBzbEUynHjmxtTKdXj37jQYZD6U2I3ealOlvmiNu73xR3wblNF
         MojQ==
X-Gm-Message-State: ACgBeo3vYKirGIT2nLEEJRlmoA6sGlkowDT6jV+7zniA6tJe4EzvNeJY
        XvLaphDKtfgBrrxdamvDDg==
X-Google-Smtp-Source: AA6agR6d9iIReWiEm6VWqwmm0FzN4hPDYtj7eb+Orodkp8VoIY0qJFoUq8spBIFr2C6pFlessr3vyw==
X-Received: by 2002:a05:6638:1386:b0:342:8d69:71c2 with SMTP id w6-20020a056638138600b003428d6971c2mr2041161jad.315.1660317236960;
        Fri, 12 Aug 2022 08:13:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q13-20020a0566022f0d00b00681b6e20a82sm1041171iow.46.2022.08.12.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:13:56 -0700 (PDT)
Received: (nullmailer pid 168978 invoked by uid 1000);
        Fri, 12 Aug 2022 15:13:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        alina_yu@richtek.com, sre@kernel.org, devicetree@vger.kernel.org,
        alinayu829@gmail.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        cy_huang@richtek.com
In-Reply-To: <1660225318-4063-2-git-send-email-u0084500@gmail.com>
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com> <1660225318-4063-2-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471 battery charger
Date:   Fri, 12 Aug 2022 09:13:53 -0600
Message-Id: <1660317233.429908.168977.nullmailer@robh.at.kernel.org>
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

On Thu, 11 Aug 2022 21:41:57 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for the Richtek RT9471 I2C controlled battery charger.
> 
> Co-developed-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/power/supply/richtek,rt9471.yaml      | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/richtek,rt9471.example.dtb: charger@53: usb-otg-vbus-regulator: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

