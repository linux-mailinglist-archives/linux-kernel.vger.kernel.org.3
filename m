Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6644855315A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350075AbiFULuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiFULuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:50:22 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B3A2AC53
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:50:16 -0700 (PDT)
X-QQ-mid: bizesmtp81t1655812210temdbd6r
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 19:50:04 +0800 (CST)
X-QQ-SSF: 0100000000700040B000B00A0000000
X-QQ-FEAT: AYaL7CbwjQ2sEKDCa6vt0Ix3H/2K/Ne/IH775FDwsozEWiO8G/issmoslDUNU
        duunK7+6E3Stl2WDvp8+3fAeYyAKmYXEjZNrEPboHgI1R2w8tqIawlToe1GvNfBd1HWcCDx
        jcbg8wgqubbbUGZEWpdG7d9QILIAG59TUksPkuGmRjY8Tkrdz8S3j+cvV7iZdl/I2/jVI0q
        0H78IgMNbS+b5Xg+eJtVsTGo0GhEbhzAhZ2B6a3E0RsVUV+DcTbKPygpmsWLCXj7s3Ea3lh
        3JDBbgAa6yhoxmsyrInJgLtlFgspDoP8O9HJgEElzLAyajkf28/0dWsFRnV3Z47XUeJm0P8
        cQ55WTut6UsnyRbdBPxs8sdkw05wg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] extcon: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 19:50:03 +0800
Message-Id: <20220621115003.109395-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: ./drivers/extcon/extcon.c
line: 250

/* Find the the index of extcon cable in edev->supported_cable */
changed to
/* Find the index of extcon cable in edev->supported_cable */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/extcon/extcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index d3a32b806499..0e40418ad287 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -247,7 +247,7 @@ static int find_cable_index_by_id(struct extcon_dev *edev, const unsigned int id
 {
 	int i;
 
-	/* Find the the index of extcon cable in edev->supported_cable */
+	/* Find the index of extcon cable in edev->supported_cable */
 	for (i = 0; i < edev->max_supported; i++) {
 		if (edev->supported_cable[i] == id)
 			return i;
-- 
2.17.1

