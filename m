Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4010471903
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhLLHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:10:08 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:50672 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhLLHKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:10:05 -0500
X-QQ-mid: bizesmtp37t1639292961t1w89zs7
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 15:09:20 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: F3yR32iATbj57DaptpeFQ4FzHbrVAl8VVOYapPxMBhc2Ndb2XA/ZWJhfN0WSh
        UU6eBdyOxRKupU1xNB2jrAsbp03hqRd1HeKhKrOGfnc6zRrSGwGhTVzj/Kjul2cgfVg9u+E
        Tr1LX1V/GbRN75rfzo97FaPSC7pw2jHtfoSdnrPtm9ik4uY/kYn5viWalbwsmuSpGrrtNMY
        iKYVbSGajYuDEANWoniIqJufMiMTgPw9K2AuvtanwnwcJPAGfNex8ZsQFm1Alp/5r5P9UzA
        lPjSleBmzfgm/Y9UiNmhXCbBVKGts8iof2+/TIbe2XEW/FVuhCu7/za1hU4Ns6544vkeyLK
        omEmMIt74lgPAzM6STSe/RpFFu2AQjfvAWcbTDCp52Sf0e+388=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     awalls@md.metrocast.net, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: ivtv: no need to initialise statics to 0
Date:   Sun, 12 Dec 2021 15:09:18 +0800
Message-Id: <20211212070918.289617-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0, because compiler
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initializations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/pci/ivtv/ivtvfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 2c43ebf83966..00ac94d4ab19 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -42,7 +42,7 @@
 
 /* card parameters */
 static int ivtvfb_card_id = -1;
-static int ivtvfb_debug = 0;
+static int ivtvfb_debug;
 static bool ivtvfb_force_pat = IS_ENABLED(CONFIG_VIDEO_FB_IVTV_FORCE_PAT);
 static bool osd_laced;
 static int osd_depth;
-- 
2.34.1

