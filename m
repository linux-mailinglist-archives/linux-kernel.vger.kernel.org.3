Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E1C487CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiAGTMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAGTMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:12:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B52C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00AE461F63
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 19:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35ADC36AE0;
        Fri,  7 Jan 2022 19:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641582721;
        bh=EUVUzy5Iorg9B+v2x/jejthbo+RJh83a7jVU3+fqPSU=;
        h=From:To:Cc:Subject:Date:From;
        b=PPocm1aiO0SAPwQ2EVAcb5tZeMUQW1U4lAWfPFoQrEy6/Kk6R3WPkvk3LlGvxxRru
         AoOFmuZPMbyLbOuFbkTkxeXTaA7EJ+ZDtoDQr5mJGkXElREEGQMxfomBAF5n7oNjLb
         zrOwolN3bFBxXMOt5jGTWcSvx1/IIRImCrqPaznET21vzomU8uuZNs+xVP9RfpLf0T
         0qckVZA3h8TaiFD93q8SrMUCeM5L3UUPiBIUwMiNRnvrexXyJwjfPz/xUbUufUxBwz
         3tvOUYDTEaiZKl4zNox85bFXvVA1cbp3W2eG+xMOaNu/TXvHljtLqbSS8GzCXRZ/8e
         kGrLPeJarRG2w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH] regmap: debugfs: Fix indentation
Date:   Fri,  7 Jan 2022 19:11:45 +0000
Message-Id: <20220107191145.813876-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=635; h=from:subject; bh=EUVUzy5Iorg9B+v2x/jejthbo+RJh83a7jVU3+fqPSU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh2JBkmisznMbu96swQchkxTDb2cK2RJQ3+jil58P/ Kl0IRmiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYdiQZAAKCRAk1otyXVSH0AOoB/ 42DJ4L/D8L1umqahpXyJcxGgqFM4KIIBdj+gmD/D+YUFBF0CWenCzfkpp5un07LtTux5AJ2hxgOHQ6 nBpDH8EVv8w5mPybBkbtQngLLlKK9pmZZ/kPp1nimLRRGDIKWJ7xp6DJ0MMcf3dImNqag1yHv6hyqN eZ5DKfzJwGPaEHyAduDM97OSq1e5Ra4Pd76CkpDwA3ONEn2ewWHMhynRKfysPxrQbEbb+rqv+mGwiP qF1OFmBihPvaiKLB14Eaj820iHPt7wUy2VwDGK7rm2mv3lL3REd+Cy+CZgA0EdXEeVbrpZ7633J2rw F4zc6MoeVWWpu0jPDmi3Gtte5ocUvF
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index ad684d37c2da..817eda2075aa 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -598,7 +598,7 @@ void regmap_debugfs_init(struct regmap *map)
 		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
 						dummy_index);
 		if (!map->debugfs_name)
-				return;
+			return;
 		name = map->debugfs_name;
 		dummy_index++;
 	}
-- 
2.30.2

