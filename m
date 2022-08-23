Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF659E684
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbiHWQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244436AbiHWQA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:00:57 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213B15C371;
        Tue, 23 Aug 2022 05:12:58 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661255468tk4a19c0
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 19:51:06 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: DQ0OCu3gog2DpWggEOov9LWZw/zsVocqtlNvD3/KPuL43CWfdojDzP43r+azY
        659Ez1TAChQGnyVD++OW24EVOzEWGIJp6tASNFv8EEEKeUHttUShZ2mSUukTsoHgaG+8AZp
        Cjf9KmdwVlHszv++e1tND9fg0/RQwXpw2ij0jcMbMLMK59EuC8Do82B1GxYCJkDUCE1k8C9
        AxfTDnsPYpAXayeFVcCcClgmkqjZ8d40Jt8qRJ1QDtlcpMwtlayWkuJRhJArjo9UNP41llW
        MsSFTTiM8o1v/aRUZLDZVFTik44kEOScVNswQMdODH6agwdPZ5KyTVD8RHEYliHBsqIlFw2
        z38dkGbdjWtXW8VCGo05O2ldU3YFVOgVt9W97gdz1HNS1R4NHA=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] disp/dpu1: fix repeated words in comments
Date:   Tue, 23 Aug 2022 19:51:00 +0800
Message-Id: <20220823115100.44060-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'is'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index bce47647d891..59ca7d70a652 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1169,7 +1169,7 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
 
 	/*
 	 * max crtc width is equal to the max mixer width * 2 and max height is
-	 * is 4K
+	 * 4K
 	 */
 	dev->mode_config.max_width =
 			dpu_kms->catalog->caps->max_mixer_width * 2;
-- 
2.36.1

