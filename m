Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698EE59B476
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiHUObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHUObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:31:18 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94921CB06
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 07:31:14 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661092257tqxhds2p
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 22:30:55 +0800 (CST)
X-QQ-SSF: 0100000000200000B000B00A0000000
X-QQ-FEAT: Wyle2N1OIGk9/qf4RjOezsRwFlh5szDP0qWpg9ROsqG5sbiWbn0ZK8iUFuwsj
        r3CM24sDaCZXdJtyTH7UR/iKB5AGvqSXE0M2tE7adbPMbbOW+Eb5WCQZp7wOTqx1o8pRAsk
        CXe2/Vqov+MGzRUTOHniT+Dk/IsNPg5rWpg/ABfRk3rweBuwLR1l5ZvGGk1vhHqaf7fgbzn
        rMUljpC39odco41y9zm4P8FOqu1SK1SWgxRPJ2X3YqWxhYyZZqcr9X7TFSxgc/k4i8nnSlk
        vhsnjdGrKcNZ6kbDdTnQ1r25m708Qr5zkou5kvQxUoIQM5/2/L7OgA3/Tqk/w1Ay7uSWacG
        r0vR6qZ
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] subdev/clk: fix repeated words in comments
Date:   Sun, 21 Aug 2022 22:30:38 +0800
Message-Id: <20220821143038.46589-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'at'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
index a139dafffe06..7c33542f651b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
@@ -581,7 +581,7 @@ gm20b_clk_prog(struct nvkm_clk *base)
 
 	/*
 	 * Interim step for changing DVFS detection settings: low enough
-	 * frequency to be safe at at DVFS coeff = 0.
+	 * frequency to be safe at DVFS coeff = 0.
 	 *
 	 * 1. If voltage is increasing:
 	 * - safe frequency target matches the lowest - old - frequency
-- 
2.36.1

