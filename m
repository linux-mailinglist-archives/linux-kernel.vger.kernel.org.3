Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C9357F3C7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiGXHm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiGXHm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:42:26 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244D13F70
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:42:21 -0700 (PDT)
X-QQ-mid: bizesmtp83t1658648530tlaln5py
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:42:09 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: 83ShfzFP0oAUTgA4x7fia1N3iOs8FDZQk3RUK2OOVsdNMVcrH24z/8qAduNcj
        qMQSnETQt93LZ1f1Q367pIJuE1LZEJziQbwtI395RtiN/2iT74wmU0gMtK/LlUWCGoSVSpK
        qS2U47OWS9FCRTHyG/BH1LHE1HmO0M7i68y7oFxVbKFSPPS9hPI8mJw43emYIPRY6xmIgiM
        SyHmomb8PVVw1OZ5BitUgvfJDUkrZeLnXokZ6XK45B+dn+oNAGlpebBYECbEw5F3tcx/kLm
        SVLOcpX1fW4O+lEZWGI6WqgfKMHr28vb5ATH8vf+iL7eG2hsNi0L7IkI0lHYLTpMAKijy+s
        xMpMGxysYSA4xcU65NQ2ePvqmqQ73xwb0MXzMS5lB29NYC++0Q=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] dc/dce: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:41:50 +0800
Message-Id: <20220724074150.17869-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 70eaac017624..f0b585caa28f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -322,7 +322,7 @@ static void set_video_latency(
 		value);
 }
 
-/* set audio latency in in ms/2+1 */
+/* set audio latency in ms/2+1 */
 static void set_audio_latency(
 	struct audio *audio,
 	int latency_in_ms)
-- 
2.36.1

