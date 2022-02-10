Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7224B0608
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiBJGFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:05:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiBJGFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:05:34 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC071D9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:05:36 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id c14so3929158qvl.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 22:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=libE9Yn1tWBYKLkyjSY/ju5fNvytYicqcfgJwizlZcE=;
        b=dLKYw75qu4bpXdwIh3rv48k15nRreYPToUXnAHn/slr1zvyL8DqWHxmixuR93gw4M/
         bl/4oFr9hfl7mJEKZCMyx40iWCZt47TgKsAmz8HPsDddE0OQEZ9XOJ1w+5YorWITCBZF
         12sEovbYFwSkEoXtBUV6cFGloa1ocqMLIORVaB1Wsbrvo/LfNRN9gpcGdvV4uu3DIXUU
         2Tt2u4JahD2Rubi12QtPNP2cqjMEyHII+HqeU7PUIcKvnh4xU2olUyaO19hjOYuIu/X4
         c23BPIS/SyCkCMzMpdYIdclcuagKi40wKsmbnMu37uYpK9HR/CoOxnxj4UarpC0Ca1SU
         7f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=libE9Yn1tWBYKLkyjSY/ju5fNvytYicqcfgJwizlZcE=;
        b=xLBZ1z53zJ5IYCoO06/qSNY/9L6bKyEaB+DH9vpTRHZ6QH56rre7PvhYX927gTo1x+
         hCWmpJvDFAXXhqkRvye2cdFOa12rU3kvKRe4p1p4Eb48ioiDVfVUKHPGpjW8cGilU9Xq
         EdG+t4Nqkt93p9BWHrPjUr8lPPoc5U8nSjDu/XtuP0xtbXX9iX5Bq1zsWw7vfYVIQuOv
         71NJFwVtF5dOBzpR6IJUgPUOyMiYNvzAq+gYntzXRKakGU6UbfmSyO3EcnPMGP7QOBg8
         CauJYGJ66MIu0XF3XxXaurpNls2fBVUWWUYUAt5SbE8dVgSMrQPeEh4aqj2VH9buH0P2
         78EA==
X-Gm-Message-State: AOAM531E07JtR3jm5esSDrreWedWep/XvzSyVCBNb/EXiKQdWUYr2FL6
        vlJVbTIyZPNLnJ/g877fPcGWRzjmKbs=
X-Google-Smtp-Source: ABdhPJwPEeBaJnQZEpGh/G4E2EiYfU9a5wjU9luZd+NapvxeRAesLQVAOTyq3zmZ8C+PR6Xyefuvtg==
X-Received: by 2002:a05:6214:62b:: with SMTP id a11mr3968947qvx.99.1644473135358;
        Wed, 09 Feb 2022 22:05:35 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d6sm10331723qtb.55.2022.02.09.22.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 22:05:35 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     kishon@ti.com
Cc:     vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers/phy: remove unneeded ret variable
Date:   Thu, 10 Feb 2022 06:05:29 +0000
Message-Id: <20220210060529.1608027-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Return value from regmap_update_bits() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/phy/ti/phy-ti-pipe3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 2cbc91e535d4..060b68c69ab8 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -318,7 +318,6 @@ static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy);
 
 static int ti_pipe3_power_off(struct phy *x)
 {
-	int ret;
 	struct ti_pipe3 *phy = phy_get_drvdata(x);
 
 	if (!phy->phy_power_syscon) {
@@ -326,9 +325,8 @@ static int ti_pipe3_power_off(struct phy *x)
 		return 0;
 	}
 
-	ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
+	return regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
 				 PIPE3_PHY_PWRCTL_CLK_CMD_MASK, 0);
-	return ret;
 }
 
 static void ti_pipe3_calibrate(struct ti_pipe3 *phy);
-- 
2.25.1

