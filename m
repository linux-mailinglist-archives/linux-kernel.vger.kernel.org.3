Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC0459E7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbiHWQtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245381AbiHWQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:48:35 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF8A3D12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:21:11 -0700 (PDT)
X-QQ-mid: bizesmtp81t1661264458tp8bojah
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:20:56 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: Wp4pj0u9TId1/p9vqY4ReYjQFRg3a8LWVD+xyr4nV9JKXGLknbcBEXjK7esi3
        69862IWWlVSEL8Z/h69e2eL20A0F30L1Fxxl2sLyu04RtfnN8Y63IUeOskf3B0OpQiS4Q6d
        /GDJ1OKDZ2v/BUWko3ED5ndKp2RlCy4S0VYEzECdouqdvlop0Cj6tj8ryy+CwtpSrOPoazn
        Pwsiy3mlMOI+xJAT8bSFYpNm21oV5S+OVdb9YuGkiXNpKQ03Xp7ifWT9pjHk7L/zDqNF07A
        dtN/ythjPRhbCxjqZ1HbKCNb7APHX6bcBfXRWfb1TKG9fogl7k0hnejmmPRAI7gISzJbxEW
        koz1Li6Ez/PVte7ssJQo34tLKXsTSJ3vJf7xB3ZdKd/p2bI+bu3Ix1lHA3d7AdBPWIN/+rv
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     hdegoede@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] vboxvideo: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:20:50 +0800
Message-Id: <20220823142050.15519-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/vboxvideo/vboxvideo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo.h b/drivers/gpu/drm/vboxvideo/vboxvideo.h
index a5de40fe1a76..f60d82504da0 100644
--- a/drivers/gpu/drm/vboxvideo/vboxvideo.h
+++ b/drivers/gpu/drm/vboxvideo/vboxvideo.h
@@ -43,7 +43,7 @@
  * VBE_DISPI_INDEX_VBOX_VIDEO is used to read the configuration information
  * from the host and issue commands to the host.
  *
- * The guest writes the VBE_DISPI_INDEX_VBOX_VIDEO index register, the the
+ * The guest writes the VBE_DISPI_INDEX_VBOX_VIDEO index register, the
  * following operations with the VBE data register can be performed:
  *
  * Operation            Result
-- 
2.36.1

