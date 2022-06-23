Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE7557787
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiFWKK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiFWKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:10:10 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4587C49F16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:10:06 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655978798t8sle0bp
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:06:34 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8eUD0dPq5rRcARw3pLgA6H09Lxnt1o2JBg/eohDc8FS3FblIESZR
        qS8NiowP/Lmo8sxgVOHBKFAiKqahVpcbmQb12cB+A6xMB3DhP55L+uGwcKo25/sbKK907Bc
        zQYsYSIrdrffT6uX3Bw5EipEEfkSkbUfjn4Q7scKlf214gGAerW053TITGK7nhIGhZdaCzk
        kfe1XsJ518N5tjtis4k3dq/l4bxzo4SSjMsuRk2df6e6kK9ctEBtbNsqyno9K3aQT4PvKSv
        Rlkb3+mCyx8zB1ZXcAmtUfB7U5xeoiu6ol8n5Xq/y9dmE0HPqt7mDiE9ujVta3KrbfXeYWw
        IeywhgjrwmTO30twNhTcWAiztvlRg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     lyude@redhat.com, javierm@redhat.com, alexander.deucher@amd.com,
        jose.exposito89@gmail.com, jiangjian@cdjrlc.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: drm: selftests: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:06:32 +0800
Message-Id: <20220623100632.27056-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - ./drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
line - 3

* Test cases for for the DRM DP MST helpers

changed to:

* Test cases for the DRM DP MST helpers

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 967c52150b67..4caa9be900ac 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Test cases for for the DRM DP MST helpers
+ * Test cases for the DRM DP MST helpers
  */
 
 #define PREFIX_STR "[drm_dp_mst_helper]"
-- 
2.17.1

