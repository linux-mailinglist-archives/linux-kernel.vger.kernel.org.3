Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17F158934D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbiHCUe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiHCUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:34:24 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715715B7B8;
        Wed,  3 Aug 2022 13:34:23 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id o2so13756969iof.8;
        Wed, 03 Aug 2022 13:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=sy0PwHGMpgR2DJVISTy8eXI/nlvufmA5Ye3PE/bOB+Q=;
        b=z6BqM+VUvgkigkQCZ+HCBlqkT/duAG+bCHo9NmhhXyL1M9f8E05YjIPy2cSwmxN4xN
         UNWaOvMN9gx5uk1muENlAUa8ljjbflJ0/J0lKPDQEGIkiVddlK0dG1A7JsmiIerMP+pD
         TB6nt4vSOOwJQ+Eg3FKUb7hUHX+mhcziB2xwHLzju0UAqRp2AKKmfo2TcAAxPMtnachD
         ++P2Wmx55nyz0T33tvgQjhiRy/8vfllundR1MO7XMbQTSEOZMcIrMriATs8ALz/whczs
         zteyAnKp+sKkjMPfW6gGPS9FqhKSZ+q1o1UUz0rFoqPYL0a3sgX8+P3DsfT6m3782Pni
         edZQ==
X-Gm-Message-State: ACgBeo10IZQrflPMK6Y52mzvO7mCnavhaaCbUhzj2eoGrjNV5efTN1I3
        uD9Cso80GJO1K6Vu0OJO5A==
X-Google-Smtp-Source: AA6agR7LLSQANxQxTu6rbbHddUerm1lOHrVSd3soiL2HV9IzRJfpkFHye/9Vr6sjUkfF/OiI9TlfRQ==
X-Received: by 2002:a6b:916:0:b0:67f:a5e7:68af with SMTP id t22-20020a6b0916000000b0067fa5e768afmr5081861ioi.89.1659558862764;
        Wed, 03 Aug 2022 13:34:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e5-20020a056602158500b006814fd71117sm70746iow.12.2022.08.03.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 13:34:22 -0700 (PDT)
Received: (nullmailer pid 2576748 invoked by uid 1000);
        Wed, 03 Aug 2022 20:34:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jai Luthra <j-luthra@ti.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20220803151726.31628-1-j-luthra@ti.com>
References: <20220803151726.31628-1-j-luthra@ti.com>
Subject: Re: [PATCH v2] dt-bindings: sound: tlv320aic3x: Convert to dtschema
Date:   Wed, 03 Aug 2022 14:34:18 -0600
Message-Id: <1659558858.566275.2576747.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 10:17:26 -0500, Jai Luthra wrote:
> Convert bindings for TI's TLV320AIC3x audio codecs to dtschema.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  .../bindings/sound/ti,tlv320aic3x.yaml        | 158 ++++++++++++++++++
>  .../devicetree/bindings/sound/tlv320aic3x.txt |  97 -----------
>  2 files changed, 158 insertions(+), 97 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/tlv320aic3x.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


aic33@18: 'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/omap2420-n810.dtb

codec@18: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/imx6dl-gw5903.dtb
	arch/arm/boot/dts/imx6q-gw5903.dtb

tlv320aic3104@18: 'adc-settle-ms', 'assigned-clock-parents', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am57xx-beagle-x15.dtb
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dtb
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dtb

tlv320aic3106@18: 'adc-settle-ms' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/da850-lcdk.dtb

tlv320aic3106@19: 'adc-settle-ms' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/dra71-evm.dtb
	arch/arm/boot/dts/dra72-evm.dtb
	arch/arm/boot/dts/dra72-evm-revc.dtb
	arch/arm/boot/dts/dra76-evm.dtb
	arch/arm/boot/dts/dra7-evm.dtb

tlv320aic3106@1b: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-sl50.dtb

