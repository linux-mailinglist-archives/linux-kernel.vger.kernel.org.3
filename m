Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448BD59FACE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbiHXNDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbiHXNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:02:58 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2997EDB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:02:56 -0700 (PDT)
X-QQ-mid: bizesmtp66t1661346163t6mn2l4h
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:02:42 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: ILHsT53NKPjOlNPuqpWWqWg50EYn8tzNunygvysfeek+xEh1PNauTIxWspfom
        ZAxbXsjhibOXgqXUV5+K3n1XQcGlKqgWMOFzwvU4BO5syIv4D5DtN89Zi/ToQ6Y43tFrpuz
        6gOxl8EUvZYZ/DilLpfeU5vdiFOa+je+SXFUMGZm1ZvmgwDMayJEYQXRrEJ1+jVHDyxRH/U
        ucAl7D9hGSilQhQeq2cJdh7AqDCdPecVCGkdLEHvgnU6vx5H1wRmGzc2kKIup+vpJtbIDuA
        WSZWlabs6YKP1TUjYCB3YbsWbs3HX35nRdQIObC1Doe/ugy2VPuoze68eWxT9Mna2zIY3ee
        hPYK0My0YjltM4VLyrW1DPe5SYtTXGBYCy6Oi8oc3TA4fBrnGrnzeVfkc16qg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/vboxvideo: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:02:26 +0800
Message-Id: <20220824130226.33980-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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

