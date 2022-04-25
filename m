Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1B50E1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiDYNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiDYNe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:34:27 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE2F2B1;
        Mon, 25 Apr 2022 06:31:23 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 12so17038166oix.12;
        Mon, 25 Apr 2022 06:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Axyt9xLWwnpfr+htuIM2/g7D3vysIvMnk+0DJEac8Rg=;
        b=0/n53HuI1/ClFQlYtQ6E8FngtWdd27krB/6K5hHNae9wsWHaszIT+7vffsh7tOxktL
         b84KMHfb1jMhx5NP1CfmFbRiKUVC1W/TSarDz0IN7FFH4vDyt/Kjbhwb9SESJl/QmZA8
         UOWoRjX3QlrTBtTEOXrs+nj9iJ9BkWSPKds6E9OvcH2TIPZe41Sb0jcqldsKOar3mts/
         ySApG0qcv6wYKYWgA4HoQxQNkRn1mVTCjXixby6n1d79m6ccJd2V1xzQdcVkzbdfRBLz
         BKizikU4JLWtf2VVCoKjCOKyYlU+PSg52OgitWCA8PTvYCt28syf62MUVQyP7DIw/UnL
         VIow==
X-Gm-Message-State: AOAM531NSuABgjp6Seoe7sJmcckl1k/cGP6oqwa9jeelwk09X5qUTsHr
        eEqm/EUJouTaR7coZY68fg==
X-Google-Smtp-Source: ABdhPJyVjn+HTDw2xumFtgvqDomRgaw07jqy9n+QJpvWG9J0fVtbmDg5NYHNy4qZ3JPmObwI1qJBVQ==
X-Received: by 2002:a05:6808:f06:b0:324:f7bd:c3a with SMTP id m6-20020a0568080f0600b00324f7bd0c3amr6214113oiw.25.1650893482373;
        Mon, 25 Apr 2022 06:31:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j126-20020acab984000000b002da77222b7dsm3717265oif.22.2022.04.25.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:31:21 -0700 (PDT)
Received: (nullmailer pid 3715965 invoked by uid 1000);
        Mon, 25 Apr 2022 13:31:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        vdumpa@nvidia.com, Snikam@nvidia.com, thierry.reding@gmail.com,
        dmitry.osipenko@collabora.com, digetx@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jonathanh@nvidia.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220425075036.30098-4-amhetre@nvidia.com>
References: <20220425075036.30098-1-amhetre@nvidia.com> <20220425075036.30098-4-amhetre@nvidia.com>
Subject: Re: [Patch v8 3/4] dt-bindings: memory: tegra: Update validation for reg and reg-names
Date:   Mon, 25 Apr 2022 08:31:19 -0500
Message-Id: <1650893479.258020.3715964.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 13:20:35 +0530, Ashish Mhetre wrote:
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


memory-controller@2c00000: reg: [[0, 46137344, 0, 720896]] is too short
	arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dtb
	arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dtb

memory-controller@2c00000: reg: [[46137344, 1048576], [45613056, 262144], [24117248, 1048576]] is too short
	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dtb
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dtb
	arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb
	arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb

memory-controller@2c00000: 'reg-names' is a required property
	arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dtb
	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dtb
	arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dtb
	arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dtb

