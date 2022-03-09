Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4104D2E12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiCILch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiCILcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:32:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC07170D42
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:31:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so1298752wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SbpJdgeFl8FPUDGJdHtMj/2irciJ6OreFRE7fGfvGh8=;
        b=knd2Ao1yAGdUdzAOg0aNuSFZLz5tp1fWJsxGz/FL3uAqmiGEVawxvgCd4gPa2t6EIY
         IAmnXEiPZus4tz6eF/M/AIOFcIL0tm1Ep+crwpf7uHxuwTGCw4ObaFLPTAUtEesTOd0F
         ZGQisoC/1vxLDr8ajvL+Jsnbat9bB4pCvdODlXf9QvheeQH3z+5zwtEh04K5/nDdaE5X
         mXNWM1SiVBXn6UbTF8Oj2HA8t6DIkNJcxComGV509Sd/S4jEEafpANiCKHwBMgi+R0tj
         dr8NoUiuM1u0GxFnIelh4qNV59JV5w3twbV1U4qqUamC7oRLksBCs5igkZTqEQMBzUNV
         mDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SbpJdgeFl8FPUDGJdHtMj/2irciJ6OreFRE7fGfvGh8=;
        b=B0RaPLFEyUM7sF4kHSfw40IQUjTCV3f/o8DXan7BmEDwqMy+UTkHT7SNRP5EPwR8jG
         7Jfca5nz0rBAnMglnWh6Ejp5yZcJa9snNXNuiAULuTVnQJOiK4gLdny8jX17BHUh6S3T
         6NSg69iH7AKTmnvcF5JEJoAfbVGJUgSd2zJkFNYoXzytSv1IK5yZ3DsfyBsfuvT/gbVp
         +hETz0eYlNdcWQsLo7AdJ7YnLPuzVgZIweRn+IgCKx7WmXQq/QkORLYniPRbqcEctSTH
         Hm3mj8Yu+1tfbvf+Uqe/by9qgfAoE7i0+w3182pma+QrqaDrah503xaLLhK9M6ZrCw8n
         PKNw==
X-Gm-Message-State: AOAM533ZRVwyiOByHwhAH/dxmhHpbqHsgWa/fzQQh82uAx++KVSIwLj6
        lzDP1vivwkfTUAdC2rXJiiP8ug==
X-Google-Smtp-Source: ABdhPJyZMDAfCZtX12MryC40zWqN64VWMATbqd7xW1WXC0cNO9FpW0f13MvAv7X9CzF9oa3X10xxGQ==
X-Received: by 2002:a05:600c:1c87:b0:389:9dda:af17 with SMTP id k7-20020a05600c1c8700b003899ddaaf17mr7191864wms.27.1646825483099;
        Wed, 09 Mar 2022 03:31:23 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id o11-20020adf9d4b000000b001f0077ea337sm1503812wre.22.2022.03.09.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:31:22 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        robh+dt@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH RESEND 0/1] arm64: dts: Juno CTI device tree additions
Date:   Wed,  9 Mar 2022 11:31:16 +0000
Message-Id: <20220309113117.1126-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of a patch from some time ago (04/2020)[1] which seems to have fallen through
the cracks - most likely as last time I mistakenly tagged it as dt-bindings: rather than dts:

I am planning a release of additional CTI configuration examples, which include some for
Juno - so this is now needed upstream to support that work.

Patch unchanged, other than a correction to the subject.

[1] https://lore.kernel.org/linux-arm-kernel/20200415201330.15894-1-mike.leach@linaro.org/


Mike Leach (1):
  arm64: dts: arm:  Juno - add CTI entries to device tree

 arch/arm64/boot/dts/arm/juno-base.dtsi    | 162 +++++++++++++++++++++-
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  37 ++++-
 arch/arm64/boot/dts/arm/juno-r1.dts       |  25 ++++
 arch/arm64/boot/dts/arm/juno-r2.dts       |  25 ++++
 arch/arm64/boot/dts/arm/juno.dts          |  25 ++++
 5 files changed, 269 insertions(+), 5 deletions(-)

-- 
2.17.1

