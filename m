Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0AA5B02CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIGLWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIGLWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:22:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA56287690
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:22:29 -0700 (PDT)
X-QQ-mid: bizesmtp75t1662549737tb47k330
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Sep 2022 19:22:15 +0800 (CST)
X-QQ-SSF: 01000000002000D0F000B00A0000000
X-QQ-FEAT: KdN0SWBFoH7UMzyW8EPeWYXI1PlM16NaqZ033qT+4v1Jdp8YqqCiqA3S37Erx
        AxZ2ilvPBERPpuKozNZ1XlnVLL8CQQasmmgGUhWxj4iuoe7S2PlO3l9isDwSszp0nsCYW5s
        qlnpciI3oGhFuLOcWUNDk68XFHSGDsXzoVyALFEHkuiK27SpxYD0/2Ro9nbab+50szLecvT
        7e/wt/6cdRIp24Mgb3Nd/+N344/J1Nyw+NICUQDf0MmHRxFmWFPuX/epI9K/pimdsxx7VIB
        0wu//vt2d+2Ngi/ORDpYjTyvArHrMoGj+FL0QvlKE4AlJ8+dQebNyQk8Ej8fbFNlZlQY8aO
        evQcySOMceBeKalikhEx6Azr1n5a/aumj9YZZrJlx7/NTMV7urnjESzs4tlXg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/amdkfd: fix repeated words in comments
Date:   Wed,  7 Sep 2022 19:22:09 +0800
Message-Id: <20220907112209.22879-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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

