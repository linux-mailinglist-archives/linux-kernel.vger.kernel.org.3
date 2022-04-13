Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10D4FF6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiDMM2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiDMM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:28:32 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434745D66F;
        Wed, 13 Apr 2022 05:26:11 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so1030921otq.13;
        Wed, 13 Apr 2022 05:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1dqPCxWjCSCf7mIDEYW2fcPrVISdU4rxrKI4YSiKcVE=;
        b=QPWD8w+aOu046kP5QL1fjqryzkfNI3OEWAmADqXB/La7VQbv042SM2FSg0FnkJxEoB
         Fp1fp4OtG7zu8LNfp6A9a1+ahRL8C6E7sVV21bKei+08wazA7EEcrkz06ftCzQqvGDaY
         tSXng3v4V570UCy/K9Ki1D3IR0yC/4IajnJi6LTcd9ZVzoUvJzEj3whoiaV0DIUEuj+M
         SifhhhS7L3/gHvSFDoKKn1TgvgCoRctISs1dz0pQBiAzRCmfKkhbPSlqGIkZZ5u4n2OR
         DmWza3iX6MWiUE5BA1IpBRwua2+lDrUIY5BIbV8JGFKf3xxOr1A2jz5O/xlt4fersdUb
         duHQ==
X-Gm-Message-State: AOAM532nxExlcU9TLCnbmGfWdnxaxrPENhYavEMxWa0xs/8DHTvtWNK4
        PcvsrWNDno5MTx09CZOmeA==
X-Google-Smtp-Source: ABdhPJzEFsbH95qUqpxqG9001AF8MB5wGgK10fURpb/sMRsYZjupsRufyJVjqe+tH507Ko2NEaQt1A==
X-Received: by 2002:a9d:1702:0:b0:5e8:c77f:513 with SMTP id i2-20020a9d1702000000b005e8c77f0513mr1768522ota.140.1649852770439;
        Wed, 13 Apr 2022 05:26:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u14-20020a4aae8e000000b003332a47de0bsm221931oon.20.2022.04.13.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 05:26:10 -0700 (PDT)
Received: (nullmailer pid 2930034 invoked by uid 1000);
        Wed, 13 Apr 2022 12:26:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     dmitry.osipenko@collabora.com, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Snikam@nvidia.com,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com,
        krzysztof.kozlowski@linaro.org, vdumpa@nvidia.com
In-Reply-To: <20220413094012.13589-4-amhetre@nvidia.com>
References: <20220413094012.13589-1-amhetre@nvidia.com> <20220413094012.13589-4-amhetre@nvidia.com>
Subject: Re: [Patch v7 3/4] dt-bindings: memory: Update reg/reg-names validation
Date:   Wed, 13 Apr 2022 07:26:08 -0500
Message-Id: <1649852768.330323.2930033.nullmailer@robh.at.kernel.org>
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

On Wed, 13 Apr 2022 15:10:11 +0530, Ashish Mhetre wrote:
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

