Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC5585A72
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiG3MdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3MdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:33:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B98B49B;
        Sat, 30 Jul 2022 05:33:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p10so4575500wru.8;
        Sat, 30 Jul 2022 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1+pa1kvGNZpNFzAbS1R4fdQJbOyeCHM1HfJ0LUvp6M=;
        b=ApNvXXP4M9DGFzc9cfZvYe9lPKH9uSuVVC/hw3XxiF+6xwWP0eanjqlkVmRY8sirXV
         epx3DvtBdqBLDWwL+2NTIBLWqbMOWDMPzFTwidILNQh2242bu/dN3SmWgXkEJnL9EagY
         l03cM9UOFC/T/t+lkSTIUnuClZQII0uK+jYivfDPVTu3m5tpEe1mzInc6TJuegGcqWDW
         p097uOOKafA2gBuSP43CeKjWi2czUJbvoAIauXAP8Hn5Ry7uGuHMjOP4ajPvuAbEQeuk
         uIO0o9XM+o+IacXEEhWb61Sgmg/gFZzD0EmjgRuGsG1WKZvEIaaBHoIjkf6t7BPQgot1
         DKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1+pa1kvGNZpNFzAbS1R4fdQJbOyeCHM1HfJ0LUvp6M=;
        b=5ifWMaTsEdtx2eBdse8t3AQbA7ijeSJWiIxq8gjRDC9mVJBHWpek41jby57VKSn921
         PFIcP1FTZxHjIx90f5bfH7r8WXMQJStdONkp4BaJ1CO//epxAB7WAl2HxDZpnByv7/oq
         IHgFStOu2u10LbIx6HABqrLsmqT528NmyrQRcXxm1MQQMQxNjQGPM83UJl5BV54QC3yZ
         KR/QcmTv1NVYynHzj+GfHirAdtC+eLJUNC33aF9aJYuMDWDR2Bfk1W8e2mTjoA6O03e/
         ls0ij3xn6WlrOB7vO6t5XezbBoGo481agqlcFAdsffgIM1AIEqebQhVc+XY0qDGIWjuA
         fe+A==
X-Gm-Message-State: ACgBeo3vARxvbyZQyzH52tP35WUjtaUzW9vM/R5i64fpPscG8bOk6CKW
        rh0tKrXcOXMiz+2yspcpJ63839mxWDLOog==
X-Google-Smtp-Source: AA6agR4uzRDw0YGcSy4u9Z5xNDV8zScaww/uV3GRdlsfYWFdkMBeoeb5I5a6MizUouW45IFIKTO5mQ==
X-Received: by 2002:adf:e881:0:b0:21f:abb:fc0a with SMTP id d1-20020adfe881000000b0021f0abbfc0amr4789208wrm.103.1659184390305;
        Sat, 30 Jul 2022 05:33:10 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d6546000000b0021f13097d6csm3947687wrv.16.2022.07.30.05.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 05:33:09 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/rapidio/rio-scan.c: remove redundant variable tmp
Date:   Sat, 30 Jul 2022 13:33:09 +0100
Message-Id: <20220730123309.147307-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable tmp is assigned a value but it is never read. The
variable and the assignment are redundant and can be removed.

Cleans up clang scan build warning:
drivers/rapidio/rio-scan.c:561:10: warning: Although the value
stored to 'tmp' is used in the enclosing expression, the value
is never actually read from 'tmp' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/rapidio/rio-scan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 19b0c33f4a62..5256e76ab29c 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -524,7 +524,6 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 {
 	struct rio_dev *rdev;
 	u32 regval;
-	int tmp;
 
 	if (rio_mport_chk_dev_access(port,
 			RIO_ANY_DESTID(port->sys_size), hopcount)) {
@@ -558,8 +557,7 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 	rio_mport_write_config_32(port, RIO_ANY_DESTID(port->sys_size),
 				  hopcount,
 				  RIO_HOST_DID_LOCK_CSR, port->host_deviceid);
-	while ((tmp = rio_get_host_deviceid_lock(port, hopcount))
-	       < port->host_deviceid) {
+	while (rio_get_host_deviceid_lock(port, hopcount) < port->host_deviceid) {
 		/* Delay a bit */
 		mdelay(1);
 		/* Attempt to acquire device lock again */
-- 
2.35.3

