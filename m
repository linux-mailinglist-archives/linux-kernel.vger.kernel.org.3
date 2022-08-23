Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48C659E786
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiHWQiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245013AbiHWQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:37:24 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD337FE57;
        Tue, 23 Aug 2022 07:44:38 -0700 (PDT)
X-QQ-mid: bizesmtp91t1661265874to4mmkkx
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:44:33 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: 4rCmCcmdMHfKEpw7yFlENQd58M2UxApIy42DuiqmFWQ+q38XgX2UaChPLm5kR
        P9Rj6XX5BLOPQmZT2DA51sHiiidTzvMW2+FSzDRKatK7U5WcOlNSChWlZRTo9Vz1plpq7GZ
        qnZ4ga7pk4CsMj2nd4Nje9GGZoEg93VllTuRi8yja8cYBsxwOw0nVFdVnbVcfUc1OpWUp6F
        iUnEGchp2YYqqaBX8dlFXzmvVuwb8eF3s1FbtFupJFG6/BA55KRyrO7ph/Uh4CP5AWKnqwn
        Eylnc8oEFGxZp8b3jzFusFvGRLTDcKPl23nY5QUOmMKNJCUxAeTOlxtRIkKfoGZXDUCKIiW
        j09D9FDuIQopp3ZFhGqMnHjHB/XaPdWf0+m7ScKZv2lFrvUYP217NeDsb6bZjm84WcOzcb2
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] media/dvb-frontends: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:44:27 +0800
Message-Id: <20220823144427.33846-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/dvb-frontends/tda1002x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/tda1002x.h b/drivers/media/dvb-frontends/tda1002x.h
index 60a0952c1bca..00491bea9975 100644
--- a/drivers/media/dvb-frontends/tda1002x.h
+++ b/drivers/media/dvb-frontends/tda1002x.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
     TDA10021/TDA10023  - Single Chip Cable Channel Receiver driver module
-			 used on the the Siemens DVB-C cards
+			 used on the Siemens DVB-C cards
 
     Copyright (C) 1999 Convergence Integrated Media GmbH <ralph@convergence.de>
     Copyright (C) 2004 Markus Schulz <msc@antzsystem.de>
-- 
2.36.1

