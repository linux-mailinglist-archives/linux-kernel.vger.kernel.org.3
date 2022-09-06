Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FE35AF727
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiIFVlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIFVlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:41:17 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A28A6EE;
        Tue,  6 Sep 2022 14:41:10 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-127f5411b9cso148174fac.4;
        Tue, 06 Sep 2022 14:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FbKPQXfgOSHzOYW0WiEuQn3YF7xR5w7WxlOeboF7hFg=;
        b=G4TLyzu5Y/BxI9LIuFEsYvS51xSa1mzUR2TALMF8RQnWuwPf5nV7qRNjVwZw11Ysiq
         aCQLetA1k6euY/RtboBxGops/LaHIb4HCvk0j2ww5bvxbJLbWlJIqqyhPjU6BRJBqjCl
         42CSIlzJuVtsMpS0SR0oHVewpNh8cT50reHrm7MAYt663G1j2vBMPMdLEaP0qHkktx/O
         CnrkoUvKP5BO4UU46nGrW6skxxcTAE8zzxIYMSGo+Dpxzl9AWb7lK/x7J8bVtI2AzGp9
         ZwmRXwG1Ec4Z6YpPqO3NRHiCP43p6aP+5MrgjCD1qRtmPn7DHnDcuKaHkbYrdZmRza1P
         s6hA==
X-Gm-Message-State: ACgBeo21zb5jO80LJ/OI1VdoWwL3VxEWrU0sdV6G6q2+4sLZ8/SiXYZQ
        wo7bH6bS6Qkj1JX4NUcC+Q==
X-Google-Smtp-Source: AA6agR6frPS+sWwOl68vgFD6HQuEoYRcMk19NM5wPt3pojgx36cNn0sP9Jv9fT72zxeJwTOBOou6zg==
X-Received: by 2002:a05:6870:a188:b0:126:444d:743d with SMTP id a8-20020a056870a18800b00126444d743dmr149386oaf.111.1662500469213;
        Tue, 06 Sep 2022 14:41:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm7649013oab.3.2022.09.06.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:41:08 -0700 (PDT)
Received: (nullmailer pid 1224963 invoked by uid 1000);
        Tue, 06 Sep 2022 21:41:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, johan@kernel.org,
        lgirdwood@gmail.com, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, broonie@kernel.org
In-Reply-To: <20220906201959.69920-1-ahalaney@redhat.com>
References: <20220906201959.69920-1-ahalaney@redhat.com>
Subject: Re: [PATCH v2] regulator: dt-bindings: qcom,rpmh: Indicate regulator-allow-set-load dependencies
Date:   Tue, 06 Sep 2022 16:41:00 -0500
Message-Id: <1662500460.139898.1224962.nullmailer@robh.at.kernel.org>
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

On Tue, 06 Sep 2022 15:19:59 -0500, Andrew Halaney wrote:
> For RPMH regulators it doesn't make sense to indicate
> regulator-allow-set-load without saying what modes you can switch to,
> so be sure to indicate a dependency on regulator-allowed-modes.
> 
> With this in place devicetree validation can catch issues like this:
> 
>     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
>             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> v1: https://lore.kernel.org/linux-arm-msm/20220902185148.635292-1-ahalaney@redhat.com/
> Changes since v1:
>   - Dropped first two patches in the series as they were user error
>     (thanks Krzysztof for highlighting this!)
>   - No change in the remaining patch
> 
> Krzysztof also asked if this patch in particular should apply to other
> regulators, which I think it should for those regulator's who implement
> set_mode(). Unfortunately I don't know of a good way to get that
> information in order to apply it at a broader scope for devicetree
> regulator validation. At least with this in place RPMH users can get
> better coverage... if someone has suggestions for how to broaden the
> scope I'm all ears!
> 
> Thanks,
> Andrew
> 
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pm8150l-rpmh-regulators: ldo6: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dtb
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

pm8150l-rpmh-regulators: ldo9: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dtb
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sm8350-hdk.dtb

pm8350-rpmh-regulators: ldo6: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sm8350-hdk.dtb

pm8350-rpmh-regulators: ldo7: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sm8350-hdk.dtb

pm8350-rpmh-regulators: ldo9: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sm8350-hdk.dtb

pmc8280-1-rpmh-regulators: ldo3: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280-1-rpmh-regulators: ldo4: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280-1-rpmh-regulators: ldo6: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280-2-rpmh-regulators: ldo3: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280-2-rpmh-regulators: ldo4: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280-2-rpmh-regulators: ldo6: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb

pmc8280-2-rpmh-regulators: ldo7: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280-2-rpmh-regulators: ldo9: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280c-rpmh-regulators: ldo12: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280c-rpmh-regulators: ldo13: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280c-rpmh-regulators: ldo1: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb
	arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb

pmc8280c-rpmh-regulators: ldo7: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sc8280xp-crd.dtb

pmm8155au-1-rpmh-regulators: ldo10: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8155p-adp.dtb

pmm8155au-1-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8155p-adp.dtb

pmm8155au-2-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8155p-adp.dtb

pmm8155au-2-rpmh-regulators: ldo8: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8155p-adp.dtb

pmm8540-a-regulators: ldo13: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-a-regulators: ldo3: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-a-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-a-regulators: ldo7: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-c-regulators: ldo10: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-c-regulators: ldo17: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-c-regulators: ldo1: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-c-regulators: ldo2: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-c-regulators: ldo3: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-c-regulators: ldo4: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-c-regulators: ldo6: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-c-regulators: ldo7: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-g-regulators: ldo3: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-g-regulators: ldo7: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-g-regulators: ldo8: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-g-regulators: qcom,pmic-id:0: 'g' is not one of ['a', 'b', 'c', 'd', 'e', 'f', 'h', 'k']
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

pmm8540-g-regulators: Unevaluated properties are not allowed ('qcom,pmic-id' was unexpected)
	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb

