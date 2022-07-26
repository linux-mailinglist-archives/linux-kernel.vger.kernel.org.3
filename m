Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22AD5812CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiGZMGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiGZMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7B22B194;
        Tue, 26 Jul 2022 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658837157; x=1690373157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/y17cHBQ5iVwv3J6QidD4ZeKYLL1WEzsEMjhIU10dI=;
  b=JLe7BCjsLJ4nmxe9Tu9sMJAj2TtEsZIOgHRmyu5S3I+dOLBohxiSCUSC
   lOUn3pDy4E5vLfmynYOmhWZARdePZYuo6WstxODesBzyJWjNCPWM4I00M
   i7IesY6lH4/tZaoNOx1NTgf5J7Lt3Z9Rn4JAkBX//IgViVEZmfmvSy+bw
   TX/NdA0E0nXzbVQCSflusJyWAc3INtvi/tUQ33X3YUTfW/5NBTbsqu3vt
   4gtI2co6KZ9OQ2joS+r95/YSqGZC2J06p50ss0ACXxCyy5ZQagPPl+q0n
   bUNDtyrB4uD5dKq8v+Aun7cD4xErtrqSg+HhfuFXOTBzsakZxWFpg5hif
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="289125412"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="289125412"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="726514858"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2022 05:05:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8414C1DF; Tue, 26 Jul 2022 15:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 7/8] media: ov2740: Add missed \n to the end of the messages
Date:   Tue, 26 Jul 2022 15:05:55 +0300
Message-Id: <20220726120556.2881-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed \n to the end of the messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ov2740.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index 7271e3d011c9..c4c511f90257 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -451,7 +451,7 @@ static int ov2740_write_reg_list(struct ov2740 *ov2740,
 				       r_list->regs[i].val);
 		if (ret) {
 			dev_err_ratelimited(&client->dev,
-					    "write reg 0x%4.4x return err = %d",
+					    "write reg 0x%4.4x return err = %d\n",
 					    r_list->regs[i].address, ret);
 			return ret;
 		}
@@ -474,7 +474,7 @@ static int ov2740_identify_module(struct ov2740 *ov2740)
 		return ret;
 
 	if (val != OV2740_CHIP_ID) {
-		dev_err(&client->dev, "chip id mismatch: %x!=%x",
+		dev_err(&client->dev, "chip id mismatch: %x != %x\n",
 			OV2740_CHIP_ID, val);
 		return -ENXIO;
 	}
@@ -772,14 +772,14 @@ static int ov2740_start_streaming(struct ov2740 *ov2740)
 	reg_list = &link_freq_configs[link_freq_index].reg_list;
 	ret = ov2740_write_reg_list(ov2740, reg_list);
 	if (ret) {
-		dev_err(&client->dev, "failed to set plls");
+		dev_err(&client->dev, "failed to set plls\n");
 		return ret;
 	}
 
 	reg_list = &ov2740->cur_mode->reg_list;
 	ret = ov2740_write_reg_list(ov2740, reg_list);
 	if (ret) {
-		dev_err(&client->dev, "failed to set mode");
+		dev_err(&client->dev, "failed to set mode\n");
 		return ret;
 	}
 
@@ -790,7 +790,7 @@ static int ov2740_start_streaming(struct ov2740 *ov2740)
 	ret = ov2740_write_reg(ov2740, OV2740_REG_MODE_SELECT, 1,
 			       OV2740_MODE_STREAMING);
 	if (ret)
-		dev_err(&client->dev, "failed to start streaming");
+		dev_err(&client->dev, "failed to start streaming\n");
 
 	return ret;
 }
@@ -801,7 +801,7 @@ static void ov2740_stop_streaming(struct ov2740 *ov2740)
 
 	if (ov2740_write_reg(ov2740, OV2740_REG_MODE_SELECT, 1,
 			     OV2740_MODE_STANDBY))
-		dev_err(&client->dev, "failed to stop streaming");
+		dev_err(&client->dev, "failed to stop streaming\n");
 }
 
 static int ov2740_set_stream(struct v4l2_subdev *sd, int enable)
-- 
2.35.1

