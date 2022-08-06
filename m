Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D48A58B6A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiHFPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiHFPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:55:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B79E0C0
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 08:55:06 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KM8moHKN0iBgAKM8morpDC; Sat, 06 Aug 2022 17:55:04 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 17:55:04 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: ths7303: Fix the include guard
Date:   Sat,  6 Aug 2022 17:54:59 +0200
Message-Id: <ece3a3a009fb7dbc21d41f7702765dd6cc073932.1659801283.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything is about THS7303, so let the include guard reflect it as well
to avoid potential future conflict.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/media/i2c/ths7303.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/media/i2c/ths7303.h b/include/media/i2c/ths7303.h
index 95492d12786d..fee2818c558d 100644
--- a/include/media/i2c/ths7303.h
+++ b/include/media/i2c/ths7303.h
@@ -10,8 +10,8 @@
  *     Martin Bugge <marbugge@cisco.com>
  */
 
-#ifndef THS7353_H
-#define THS7353_H
+#ifndef THS7303_H
+#define THS7303_H
 
 /**
  * struct ths7303_platform_data - Platform dependent data
-- 
2.34.1

