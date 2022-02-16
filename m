Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361094B7F18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbiBPEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:06:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiBPEGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:06:36 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D3326;
        Tue, 15 Feb 2022 20:06:24 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id x13so901138iop.4;
        Tue, 15 Feb 2022 20:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+FhN6H4sJdFIwAxrGa45xsxIVEXRnp64Rx9ILQ4TAu4=;
        b=z5hoQlzp9CmZl/p5Kmt40zWi8Wy5lwbj89y/I6oaGs1ioqxBfedzW7HrFdcxB3dT1M
         L5T7hbwA2eWl+EiL0AyorUFnsbBLZklZoqAE+108pk8rVCq8/eGH4BBlJw+DpKS2Rjt6
         JA8NJQuE2Ykui7BcXzBIAbeLOUWpG2861lpt74drquML6Bd03xG7YezWDhC7ASWAUiPC
         UW1YRf9Ev7Y8wLuuaQedJFjD/3E4L/vWOdX6Ta4qQUQceNeQOSs+gs3h4h8EJesJK67+
         FHEfKhBgncJ2LDcp9XOKdhD9NdXStFy5lESvSmOAAqwVbmLHwPr4JTxNUX1Rv0ykJ3+E
         9g0g==
X-Gm-Message-State: AOAM5312c6a5LIZf1KUZoeeDWyf1M4eAzjl6UKvpTFEYfh9PmTkVh/Tu
        Gdb039joiMfSowsTIrrPwA==
X-Google-Smtp-Source: ABdhPJyJENO8J9J/BgMWhhP/uor8Gq356mJ2fVFAnZn6K8d9RLQjrlR5CKBvS9G6tzeoxnb0cijV7w==
X-Received: by 2002:a05:6638:1409:b0:30f:843:f953 with SMTP id k9-20020a056638140900b0030f0843f953mr586132jad.22.1644984383486;
        Tue, 15 Feb 2022 20:06:23 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g19sm3023031iox.39.2022.02.15.20.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:06:22 -0800 (PST)
Received: (nullmailer pid 298289 invoked by uid 1000);
        Wed, 16 Feb 2022 04:06:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     xinlei.lee@mediatek.com
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com
In-Reply-To: <1644847276-27622-2-git-send-email-xinlei.lee@mediatek.com>
References: <1644847276-27622-1-git-send-email-xinlei.lee@mediatek.com> <1644847276-27622-2-git-send-email-xinlei.lee@mediatek.com>
Subject: Re: [1/1] dt-bindings: pwm:Convert pwm-mtk-disp.txt format file to pwm-mtk-disp.yaml format file
Date:   Tue, 15 Feb 2022 22:06:20 -0600
Message-Id: <1644984380.781456.298288.nullmailer@robh.at.kernel.org>
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

On Mon, 14 Feb 2022 22:01:16 +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.yaml      | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml:60:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pwm/pwm-mtk-disp.example.dts:20:18: fatal error: dt-bindings/clock/mt8186-clk.h: No such file or directory
   20 |         #include <dt-bindings/clock/mt8186-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/pwm/pwm-mtk-disp.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1592602

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

