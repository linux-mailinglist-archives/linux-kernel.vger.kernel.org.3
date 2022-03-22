Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976104E3634
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiCVBwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiCVBwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:52:20 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC43BA5B;
        Mon, 21 Mar 2022 18:50:54 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id j83so18170157oih.6;
        Mon, 21 Mar 2022 18:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=6wGO95480o++3hkVke2KCQeABv0JOzxQ2AVcywF5mS8=;
        b=neFfjZUMragKNmD3hjaep8XtQScupTwKAPLsIuiRX09q3gMrUUiFyKEKM5IkExPBRd
         QOIN093DhF/veq8EV3Mj5HyPxqVPS3hwhrVGewDdt9Lmc/DSQL2y4HOFF/PZRLuBSgjk
         CqRyjNboEcqKQfa8w30F9AxTCjTc32dCcnkuGv9GAXLD4Gyay3NOwYUlN9Sj63w9OSsu
         K/O54/U332hVNy1DlusXzXT1essdjEh8JxBsi3rvvmBt3YCBYMWUlIKs40zZgi5H72Fj
         it9QEivFcSuqVTM8U/qkf66OFLrGL9Qz6qIQM8ebscq1Yp/hJ+LyQqDMG3eeF8Ke9Ue0
         NNlg==
X-Gm-Message-State: AOAM533W/hya12U6eaEYX+w4KYceja0DOaM3M1GgxW+uXsK1AiRU/MAa
        7YKADIsCcwD0FZsmxOSU7w==
X-Google-Smtp-Source: ABdhPJwj36RCG58UmGKrtvgw5QXEfOwvQc1Y4lLzuT9Y/w9iAv4/yO6DZ834We37179XQTFVsEmSEg==
X-Received: by 2002:a54:4f89:0:b0:2ef:7561:d35d with SMTP id g9-20020a544f89000000b002ef7561d35dmr1055708oiy.261.1647913853228;
        Mon, 21 Mar 2022 18:50:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p8-20020a4aac08000000b00324907b406fsm1857479oon.21.2022.03.21.18.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 18:50:52 -0700 (PDT)
Received: (nullmailer pid 941033 invoked by uid 1000);
        Tue, 22 Mar 2022 01:50:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-crypto@vger.kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        herbert@gondor.apana.org.au, linux-clk@vger.kernel.org
In-Reply-To: <20220321200739.3572792-22-clabbe@baylibre.com>
References: <20220321200739.3572792-1-clabbe@baylibre.com> <20220321200739.3572792-22-clabbe@baylibre.com>
Subject: Re: [PATCH v3 21/26] dt-bindings: crypto: convert rockchip-crypto to yaml
Date:   Mon, 21 Mar 2022 20:50:51 -0500
Message-Id: <1647913851.207213.941032.nullmailer@robh.at.kernel.org>
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

On Mon, 21 Mar 2022 20:07:34 +0000, Corentin Labbe wrote:
> Convert rockchip-crypto to yaml
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 84 +++++++++++++++++++
>  .../bindings/crypto/rockchip-crypto.txt       | 28 -------
>  2 files changed, 84 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1607887


cypto-controller@ff8a0000: 'reset-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml
	arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml
	arch/arm/boot/dts/rk3288-firefly-beta.dt.yaml
	arch/arm/boot/dts/rk3288-firefly.dt.yaml
	arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml
	arch/arm/boot/dts/rk3288-miqi.dt.yaml
	arch/arm/boot/dts/rk3288-phycore-rdk.dt.yaml
	arch/arm/boot/dts/rk3288-popmetal.dt.yaml
	arch/arm/boot/dts/rk3288-r89.dt.yaml
	arch/arm/boot/dts/rk3288-rock2-square.dt.yaml
	arch/arm/boot/dts/rk3288-rock-pi-n8.dt.yaml
	arch/arm/boot/dts/rk3288-tinker.dt.yaml
	arch/arm/boot/dts/rk3288-tinker-s.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-brain.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-fievel.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-jaq.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-jerry.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-mickey.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-mighty.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-minnie.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-pinky.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-speedy.dt.yaml
	arch/arm/boot/dts/rk3288-veyron-tiger.dt.yaml
	arch/arm/boot/dts/rk3288-vyasa.dt.yaml

