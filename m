Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4155A00A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiFXR1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiFXR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:57 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358FEE33;
        Fri, 24 Jun 2022 10:26:56 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id s17so3379510iob.7;
        Fri, 24 Jun 2022 10:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=f/f/wxl/bFty+5iBK1OwUM+39GiNxLXhVThB2jedR6c=;
        b=Jojdlag4e+QpNJC/V3YDooxNBMdb9zmULnQdLRudOCPnpUjbGdy7NRdLpo38XAjG/A
         dPgWwT8MHIuGGws9IJiPPn212fiQzk4Eru0aYkgWoagSlxN3HTGwRBag6217Ph+RgGDI
         Lv0UKlj8GNjM+P824BI/wy45sqhRbr2yIr6jEIbGRUMApf+yJ8Mod/bsszPz8NI1lKIB
         pLv13NL8aR5sg+pmD7t/nPR9afmeN3/i2qJy02IQ0aIl+HUiyrfVm6Z8++iT3IFa6Y6p
         Lto3t1noeviCHl+OA4Fy5os4uMacIGIjNZ0ir3bDfZXBcEM+EjQXoJVdvZQ8w6GAiqwQ
         blmw==
X-Gm-Message-State: AJIora+bE+qofxDb8mNUI2azShG6eNKQefs4CK0BmmN/I1GlO3YwnoXK
        QjkSQRwWgtmh98isAbewCw==
X-Google-Smtp-Source: AGRyM1vcSlSWL1sgowZx/3+XTz8PV774nht015v17RE+GXDieDsLBz3KrAnzO9PGOXvDejvBdCXeqg==
X-Received: by 2002:a5d:9342:0:b0:654:9336:81d7 with SMTP id i2-20020a5d9342000000b00654933681d7mr43080ioo.136.1656091615761;
        Fri, 24 Jun 2022 10:26:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s12-20020a92d90c000000b002d92c91da91sm1344661iln.77.2022.06.24.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:55 -0700 (PDT)
Received: (nullmailer pid 146352 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20220623094614.1410180-3-stephan.gerhold@kernkonzept.com>
References: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com> <20220623094614.1410180-3-stephan.gerhold@kernkonzept.com>
Subject: Re: [PATCH 2/3] regulator: dt-bindings: qcom,smd-rpm: Add PM8909
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.427255.146351.nullmailer@robh.at.kernel.org>
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

On Thu, 23 Jun 2022 11:46:13 +0200, Stephan Gerhold wrote:
> Document the "qcom,rpm-pm8909-regulators" compatible for describing
> the regulators available in the PM8909 PMIC (controlled via the RPM
> firmware).
> 
> PM8909 is very similar to the existing PM8916 but lacks 3 of the
> regulators (s3, s4 and l16).
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pm8994-regulators: 'vdd_lvs1_2' does not match any of the regexes: '.*-supply$', '^((s|l|lvs|5vs)[0-9]*)|(boost-bypass)|(bob)$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
	arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
	arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb

