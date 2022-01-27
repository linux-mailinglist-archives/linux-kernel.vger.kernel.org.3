Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C183049DB47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiA0HPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:15:25 -0500
Received: from smtpbgau2.qq.com ([54.206.34.216]:36747 "EHLO smtpbgau2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237140AbiA0HPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:15:24 -0500
X-Greylist: delayed 1375 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 02:15:24 EST
X-QQ-mid: bizesmtp31t1643267717t0galw1u
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jan 2022 15:15:11 +0800 (CST)
X-QQ-SSF: 0140000000000090E000B00A0000000
X-QQ-FEAT: Fpktsi7R1dhY1NyAAeWPzQsxlI1nEI+qRQXG2DzvXzuALq9JofTf4jTB/6h4M
        uO0TWFPJA699nTnoOORDQtjX8F7UaAksn2fWAcedRFh0KtQlz3In0UvW0QYwjP/1XGnYsHw
        mVj+fPp4QNWMvzNGBVD8P9UTUqQxqVOX5G0QetKIPm2LwXti924vLj6hPbx/YTlmR3MhpB9
        NmeC+PWrA7VYTb1QLjlO+PywsdkjLILghn1RUWFxy/nSh+H8b/YN2Qi1V/hgrXrsnnaATQ0
        xe0kb7G1aArmoq5/wGwtVQmO7OuOftDRz+jlsySzBpL7FADdfT9mlmcECY52WBcELIuZdie
        MQL94nMi37xhDo8qIPZITM3MGqS86DuiMQkGxEt
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] drivers/pcmcia: Fix typo in comment
Date:   Thu, 27 Jan 2022 15:15:09 +0800
Message-Id: <20220127071509.31365-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unavaibale with unavailable.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 drivers/pcmcia/rsrc_nonstatic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 6b6c578b5f92..ad1141fddb4c 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -394,7 +394,7 @@ static int do_validate_mem(struct pcmcia_socket *s,
  * do_mem_probe() checks a memory region for use by the PCMCIA subsystem.
  * To do so, the area is split up into sensible parts, and then passed
  * into the @validate() function. Only if @validate() and @fallback() fail,
- * the area is marked as unavaibale for use by the PCMCIA subsystem. The
+ * the area is marked as unavailable for use by the PCMCIA subsystem. The
  * function returns the size of the usable memory area.
  */
 static int do_mem_probe(struct pcmcia_socket *s, u_long base, u_long num,
-- 
2.20.1



