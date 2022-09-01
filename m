Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2285A8A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiIABM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiIABMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:12:22 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4912E4D1;
        Wed, 31 Aug 2022 18:12:12 -0700 (PDT)
X-QQ-mid: bizesmtp75t1661994719tda0256c
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 09:11:57 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: jTyhoG5kVjFLWRWK93gDvXvG8QTGYCgaUqD9nlGavCoKztyBzbcF6c3ERsswh
        g7zLk+rndnPNWZYElQEU1VRMVgioPBOaE4OqY557OPjU8rIMqYbd9N3ZAhhmAE1jv5dlc5p
        OqM8qXfcEadDHXS46FOGN759i+XdKREwCKAPtJkaIhrYEqGUQfQPU/GKsLG/V92Bak82S6X
        p/MOd8/ZcNCqMxbh0it/7RnUuePevDIusNF9DHghxtM5jYDE322sECytVgnZKUZ1ayu1FNF
        S7OGbx8dipmvIrv7DSNjQa/Uqvb2XK9l2fx9AZlv43zG1VVkuoePQR7SjDQJHAPZQoP/T5S
        HwcZiwDxnXrgaMJMpmL51DAmKNnhg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, jacopo@jmondi.org,
        laurent.pinchart@ideasonboard.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media: v4l2-tpg: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu,  1 Sep 2022 09:11:51 +0800
Message-Id: <20220901011151.22735-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' should be clearer than 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
index 9b7bcdce6e44..10ed9e65eecc 100644
--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -86,7 +86,7 @@ void tpg_set_font(const u8 *f)
 }
 EXPORT_SYMBOL_GPL(tpg_set_font);
 
-void tpg_init(struct tpg_data *tpg, unsigned w, unsigned h)
+void tpg_init(struct tpg_data *tpg, unsigned int w, unsigned int h)
 {
 	memset(tpg, 0, sizeof(*tpg));
 	tpg->scaled_width = tpg->src_width = w;
@@ -109,15 +109,15 @@ void tpg_init(struct tpg_data *tpg, unsigned w, unsigned h)
 }
 EXPORT_SYMBOL_GPL(tpg_init);
 
-int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
+int tpg_alloc(struct tpg_data *tpg, unsigned int max_w)
 {
-	unsigned pat;
-	unsigned plane;
+	unsigned int pat;
+	unsigned int plane;
 
 	tpg->max_line_width = max_w;
 	for (pat = 0; pat < TPG_MAX_PAT_LINES; pat++) {
 		for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
-			unsigned pixelsz = plane ? 2 : 4;
+			unsigned int pixelsz = plane ? 2 : 4;
 
 			tpg->lines[pat][plane] =
 				vzalloc(array3_size(max_w, 2, pixelsz));
@@ -132,7 +132,7 @@ int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
 		}
 	}
 	for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
-		unsigned pixelsz = plane ? 2 : 4;
+		unsigned int pixelsz = plane ? 2 : 4;
 
 		tpg->contrast_line[plane] =
 			vzalloc(array_size(pixelsz, max_w));
@@ -153,8 +153,8 @@ EXPORT_SYMBOL_GPL(tpg_alloc);
 
 void tpg_free(struct tpg_data *tpg)
 {
-	unsigned pat;
-	unsigned plane;
+	unsigned int pat;
+	unsigned int plane;
 
 	for (pat = 0; pat < TPG_MAX_PAT_LINES; pat++)
 		for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
-- 
2.36.1

