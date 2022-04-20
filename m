Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B224508C13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380029AbiDTP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355816AbiDTP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC35044A0C;
        Wed, 20 Apr 2022 08:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70EF26183D;
        Wed, 20 Apr 2022 15:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C0FC385BA;
        Wed, 20 Apr 2022 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650468346;
        bh=7VdTIarpj4DEF1wLyRFzg7wcUOlSAfbGXkDpuT6RetU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1NRMR3/m9DLsPxBIm0jRRISt84pI7JBs2syxvNZgLznv0OtIaBNziXlMfGtw6sTf
         DEIIEfSyPJQiMOGbbIq0ouT3OAOyQQR2/O5FxbSqWDMfX9u3TMC0263NA7GIpKHvyk
         8RnNm5adjLpkr+tb9jCxzc9yhI6IfWPYyKYfPF5aPXCE6ki5AS0eYU3yNoFGtlgJKr
         nQuE8pQCdnh9SHchipBav8bIxZTp6FpOkK0eWtwfNdFqQGyV5+IQYVYhoX1Uc2Fz40
         qBV5ilyTXJIDf4tbdSnza3Zx0O4gk10BqcTfwwPnL1ySmc4s1YX4pDUbxZdFU1uruL
         dpy4KqM9soJiQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nhCD5-0001Sa-Uo; Wed, 20 Apr 2022 17:25:39 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] phy: qcom-qmp: fix phy-descriptor kernel-doc typo
Date:   Wed, 20 Apr 2022 17:23:30 +0200
Message-Id: <20220420152331.5527-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420152331.5527-1-johan+linaro@kernel.org>
References: <20220420152331.5527-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelled "clock" in the description of the pipe_clk field in the
PHY-descriptor kernel-doc comment.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 972f27c0e0a2..8c2300bfe489 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3291,7 +3291,7 @@ struct qmp_phy_combo_cfg {
  * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
  * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
  * @pcs_misc: iomapped memory space for lane's pcs_misc
- * @pipe_clk: pipe lock
+ * @pipe_clk: pipe clock
  * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  * @lane_rst: lane's reset controller
-- 
2.35.1

