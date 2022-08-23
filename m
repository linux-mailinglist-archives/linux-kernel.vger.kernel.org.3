Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8F59E691
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiHWQEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiHWQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:04:04 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF3160D39;
        Tue, 23 Aug 2022 05:16:07 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661255657thh0jeh9
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 19:54:15 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: QityeSR92A2vaqJieZ/C2jnDkFbth8pjx3vQqtP3jMyy0sZWScZTMt10dIAvc
        coxdEzrmw4eC0mba6f9Lyze/fe7WzGcnv9+djNypt7nBnhYE2gAfCzvFj2qEOKmMgr47gH0
        VT3ZJPyrAvJ4IxuF4FwLuzG5l7sMPVeSjQRa12mzDewrUg9tnV6ijeQKaa3VrYx9dMiG9ai
        cRbqb745UVlw7yt5SBOhvTK2sQDL4Ot9mJ3SqHWOZUbpTzUm3rTxpO/85/2q+g7WcfWAGWd
        bAPk+xNZ6YN9O7fPNiKrCp8np5rxQFv0SorgMJnj4hgcfQzyfkEU/wuc1jTjzemU2uQTnfB
        uzk+bcOWk6htSdSKrzDeTI4eqKvcqeiouWuTMeZXVeEZBW/Hav3/c1RFlDogg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/msm: fix repeated words in comments
Date:   Tue, 23 Aug 2022 19:54:09 +0800
Message-Id: <20220823115409.46653-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'one'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/msm/msm_gem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index c75d3b879a53..e300c70e8904 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -118,7 +118,7 @@ struct msm_gem_object {
 	 * An object is either:
 	 *  inactive - on priv->inactive_dontneed or priv->inactive_willneed
 	 *     (depending on purgeability status)
-	 *  active   - on one one of the gpu's active_list..  well, at
+	 *  active   - on one of the gpu's active_list..  well, at
 	 *     least for now we don't have (I don't think) hw sync between
 	 *     2d and 3d one devices which have both, meaning we need to
 	 *     block on submit if a bo is already on other ring
-- 
2.36.1


