Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FB5B1E79
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiIHNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiIHNRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:17:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215EDDFF52
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:17:33 -0700 (PDT)
X-QQ-mid: bizesmtp84t1662643039t07ra0ze
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:17:18 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: +bXiSo2NuBcBlRYOxHLzXBtArwwG6UHyCDKxp/s0RZ6EVpfj/h3Vkndm6DbmK
        WRueeLfffZ5YPRqwhoIQBQzq+tHY0bTZvPklKVKSmJ84Q6gqG9ibDy5v5o3IJ/nMKJcPean
        XqxdTAw6Evc/DT9nHy2+QIczXwutQmBqUEaKJ4fFTgmOS7pqogIy6Rtzm2L5jbuOIIXmm+N
        KnCUmqaQIHSYsopDhJBwCgQq/XFPTAUB2nB2zAt64jxMCAZD8s1YiF/yDPc81ibQIPduGWd
        qB8gt5DhWRqHlHBUeLvJXQHv6mmOZbD8mMa4fL7S8W0kdhzXr12LDcFLFuxvn/rYTFMixOK
        RlkEKFm/qkW6kvt1pwqkx9VT586HLKrNO9ZNYzZowrfLEN+YH+zjmrY+34jNg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch, Xinhui.Pan@amd.com,
        christian.koenig@amd.com, alexander.deucher@amd.com,
        Felix.Kuehling@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] amd/amdkfd: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:17:12 +0800
Message-Id: <20220908131712.40442-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 24b414cff3ec..cd5f8b219bf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2284,7 +2284,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 
 	/* Fill in Subtype: IO_LINKS
 	 *  Only direct links are added here which is Link from GPU to
-	 *  to its NUMA node. Indirect links are added by userspace.
+	 *  its NUMA node. Indirect links are added by userspace.
 	 */
 	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
 		cache_mem_filled);
-- 
2.36.1

