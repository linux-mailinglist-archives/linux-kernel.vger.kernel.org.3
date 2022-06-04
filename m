Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6728453D745
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiFDOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiFDOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:39:22 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E123BEC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:39:16 -0700 (PDT)
X-QQ-mid: bizesmtp75t1654353546tmw8q82q
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 22:38:59 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: kMnkUN8kF5Aw1fdYl8bO2SctWGVn3lAaViFNbKb4L1kEM8augPuNjK7fE8FmL
        KEBU8+NmQvvK4+Q5yxLqa8qO5lyvdK5MdU4knqfwVV0PL/1AcAOv9VFu5Q9b6D+i6gOt0S4
        rfKXM02c+qymhaRQnV4qVaVDTGn1BG1jEEc59sSp4ZOMneJh4q+MaDwuY5w+Rje526HV1tb
        Pg3VCVR0Y3Y3fZmotq8S9itxEeCXFVEfftSP82GqBGwuYyo0+QIjlYqip0KHvAJ0YkqPHw5
        3zGAiamm6naeUQ8+PA8B7D7jMDj2kp09bIFrE35NAWxjdoLmjZQ6Xi+vAh6y/2wEPBOEY78
        7D1xg9Q0QHaaQGECHs=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] vdpa/mlx5: Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 22:38:58 +0800
Message-Id: <20220604143858.16073-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'is'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index dcca782c698e..3569c782c8a0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -105,7 +105,7 @@ struct mlx5_vdpa_virtqueue {
 
 	/* Resources for implementing the notification channel from the device
 	 * to the driver. fwqp is the firmware end of an RC connection; the
-	 * other end is vqqp used by the driver. cq is is where completions are
+	 * other end is vqqp used by the driver. cq is where completions are
 	 * reported.
 	 */
 	struct mlx5_vdpa_cq cq;
-- 
2.36.1

