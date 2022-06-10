Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A90546E94
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350510AbiFJUll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347415AbiFJUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:41:37 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31311369E4;
        Fri, 10 Jun 2022 13:41:37 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id p1so174765ilj.9;
        Fri, 10 Jun 2022 13:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ay9qEjaKzTwJySEiYdo7I7NMgl95SkInDvkrEPDZkNc=;
        b=ghK/R9PhX2SlpwIItXVqaZd7OXB7VaqNxDjmBp0w591QXnUINrZnrxCXxDj6/Pv8y8
         s+WMLaUvhoNq5DjJaEw8bYpq1nf1pOYkQM3UJZCFqY5pr339Cwfs195TI2g8oEZKeZ3A
         udjoPnCgfrOfZgaFgC3TuGx/tIzrOebXiqQQ/zitycJs/ISxPulz0IgJfKByiQstWStq
         U4D7aQ/n7TDBdw5ZtOqObsO10eG3usOnbxyjHYGLeY2TxwHAwF7qTuGWnkGKMVYtyEuQ
         suV3oFZjbHODNy93W+rwoQ4wNRh0+dRfGhC+WOqTWHzswADjX/Pe5Tx9c6cGXUzLzsgW
         2njQ==
X-Gm-Message-State: AOAM532VHBVR8fdkqGhoMrGdgZRg3uIOtSc2YHXJGi6D9DX5Z+6lNjbY
        6f4tPgAl4FU2NfffRxBG25f0Po4bvQ==
X-Google-Smtp-Source: ABdhPJzdFryVQmT1X0CHlty7rZltQ9RCroq52q6f9tq/ufbZHEISZjrOKH764lm3npH/yNWPE4hUGw==
X-Received: by 2002:a05:6e02:1a42:b0:2d3:afa3:bd with SMTP id u2-20020a056e021a4200b002d3afa300bdmr26593907ilv.142.1654893696438;
        Fri, 10 Jun 2022 13:41:36 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id z8-20020a92bf08000000b002d77734e157sm1996200ilh.56.2022.06.10.13.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:41:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: arm/fvp-base-revc: Remove 'panel-dpi' compatible
Date:   Fri, 10 Jun 2022 14:40:57 -0600
Message-Id: <20220610204057.2203419-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The rtsm-display panel timing node was removed in commit 928faf5e3e8d
("arm64: dts: fvp: Remove panel timings"). Without the node, 'panel-dpi'
is not needed either.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/arm/fvp-base-revc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index a496e39e6204..5f6f30c801a7 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -186,7 +186,7 @@ smmu: iommu@2b400000 {
 	};
 
 	panel {
-		compatible = "arm,rtsm-display", "panel-dpi";
+		compatible = "arm,rtsm-display";
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&clcd_pads>;
-- 
2.34.1

