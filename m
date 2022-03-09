Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEE34D25B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiCIBIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiCIBIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:08:14 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000031451EB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:49:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V6gIl0e_1646786970;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V6gIl0e_1646786970)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Mar 2022 08:49:35 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] ASoC: SOF: amd: Remove unneeded semicolon
Date:   Wed,  9 Mar 2022 08:49:28 +0800
Message-Id: <20220309004929.125558-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./sound/soc/sof/amd/acp-ipc.c:74:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/sof/amd/acp-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 9fcd2535fd3b..e1842f037083 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -71,7 +71,7 @@ int acp_sof_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 			dev_err(sdev->dev, "%s: Failed to acquire HW lock\n", __func__);
 			return -EINVAL;
 		}
-	};
+	}
 
 	acp_mailbox_write(sdev, offset, msg->msg_data, msg->msg_size);
 	acp_ipc_host_msg_set(sdev);
-- 
2.20.1.7.g153144c

