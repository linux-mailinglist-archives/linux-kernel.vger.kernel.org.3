Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239FE4C5B04
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiB0MWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiB0MWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:22:33 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B385AEFD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 04:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645964517; x=1677500517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R07GPCy1jIy1JXE9hr4EI4ZYmUfucWZTqLwFYuHqxVo=;
  b=bwqh3fjM2GOiYhrdZn4rh0EWfZ0zVMKR4BiUjzuiuOLozYlnskCmjQkA
   XCCZF0MHnvythWrst0RqdJeB6oVUhC9hwz+t1RQfa9y7kEJcvTCXr6dbN
   azy/cmPY7LinxBnFjMdeS2zer9+LeyneHRwKQrswFC7fkhj4xJAwnjdRg
   UQfwYHwzNo/J4rJrz9IQE8O4d6AmlkPwHKFPYQkZy2zEL26vqoCKBxGb5
   drKDYnEzDrZWucWVXQhPRvfDWKFGqItrElHoMA/C3vJBm37WuaFdjIDzo
   dwM3InHEV2eR44Dw1PH00CAPNA1JuHU4LtlAnp1hj/IyHiop4m5REqiIw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="313448179"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="313448179"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 04:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="777824681"
Received: from pglc00012.png.intel.com ([10.221.207.32])
  by fmsmga006.fm.intel.com with ESMTP; 27 Feb 2022 04:21:52 -0800
From:   niravkumar.l.rabara@intel.com
To:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        krzk@kernel.org, biju.das.jz@bp.renesas.com,
        enric.balletbo@collabora.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        aford173@gmail.com, alexander.stein@ew.tq-group.com,
        spujar@nvidia.com, yuzenghui@huawei.com, festevam@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        niravkumar.l.rabara@intel.com, dinh.nguyen@intel.com
Subject: [PATCH] arm64: defconfig: enable the CVP driver
Date:   Sun, 27 Feb 2022 20:21:27 +0800
Message-Id: <20220227122127.35093-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@intel.com>

Build the CVP driver in the standard arm64 defconfig.

Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..b2efafb15de6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1172,6 +1172,7 @@ CONFIG_UNIPHIER_EFUSE=y
 CONFIG_MESON_EFUSE=m
 CONFIG_NVMEM_RMEM=m
 CONFIG_FPGA=y
+CONFIG_FPGA_MGR_ALTERA_CVP=m
 CONFIG_FPGA_MGR_STRATIX10_SOC=m
 CONFIG_FPGA_BRIDGE=m
 CONFIG_ALTERA_FREEZE_BRIDGE=m
-- 
2.19.0

