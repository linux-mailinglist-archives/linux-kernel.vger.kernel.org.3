Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0EE5A133D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbiHYORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbiHYORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:17:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8CFA6C30;
        Thu, 25 Aug 2022 07:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5810B82958;
        Thu, 25 Aug 2022 14:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7BAC433C1;
        Thu, 25 Aug 2022 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661437025;
        bh=RGbu5Vn25p9iZKa8664W6/TF1O6hzGjkkQucuvSbfLo=;
        h=From:To:Cc:Subject:Date:From;
        b=aDXxAMAE8v/tgx5BG+irGyQCIdwGo01vX0Ui6jzDhqxQ8HRDJirP25bn0CtVHbAmz
         Wz0kwLC2mkMymod31AYmjvD1XEcuapkQV71cII5j80kUhFmrQsRHwa+eQlDirUVvsq
         MJ6fbnFEWolvpM9tudSjR4xeWupvtq8hw7ON+Z6hhM6/qtovmidTwP/rVq1XMdvtkQ
         b8KguTh9DMu3bOjTb4R/Mzkt/1Ag7fpzpIrEDmcZ3x7w4YhPFPA0nmuE1Keumztb5w
         9FuGj/EwyOHr2XzPjM0/BwUsNN51sf9WRNB/MHMZlKLRF06Jc5B3+0vkSqHOgYlLoS
         Hka9PfLlV+imA==
From:   matthias.bgg@kernel.org
To:     lee@kernel.org, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mandyjh.liu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] dt-bindings: mfd: Rename mediatek,mt8195-scpsys.yaml
Date:   Thu, 25 Aug 2022 16:16:56 +0200
Message-Id: <20220825141656.15747-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The file describes the scpsys node for all SoCs and not only the mt8195.
Rename it to reflect this fact.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 .../mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml}     | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
rename to Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
-- 
2.37.2

