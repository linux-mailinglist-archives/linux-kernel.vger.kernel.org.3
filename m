Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0E4717F5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhLLDRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:17:22 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:65056 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhLLDRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:17:21 -0500
X-QQ-mid: bizesmtp32t1639279022tmw5fopp
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:17:00 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000000A0000000
X-QQ-FEAT: uDpExrHON0d7iXJvqpAYExe5gs9VnCju9yn6/zYw3YYlok3aJhXzZSpu4dGnH
        6rbQeK1ep0s1DJkgzvKSN9GtxrOwH1BHIGVbJLql/iqnRUSzhBr2+zO50c5kVvBSH1Xzi8F
        fU9daPweHY2CjIeEU0zWFmrj67XhJxu/K0kGdq80xthvRXgd2GcSOgeh86YCNB9kxeQQ1zL
        rOdbSajbQTJbjtMar38xbgvCQ7XKxwIYAvaUNHhtjgtJuenY6YsBzDq/VrS/MguRHI5OJda
        SpBeBdXde/paMeDL3Qop4RoCur6ObIJUU4vXjL47XI3ue8Sho2bmdmnfCVCpYbq2CdxFfaQ
        hfQM8Gy4jSiXkWKBDh3D2PWz1Y4JUpBSgBTgiAe
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     elder@kernel.org
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] greybus: es2: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:16:57 +0800
Message-Id: <20211212031657.41169-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `for' in the comment in line 81 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/greybus/es2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 15661c7f3633..e89cca015095 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -78,7 +78,7 @@ struct es2_cport_in {
  * @hd: pointer to our gb_host_device structure
  *
  * @cport_in: endpoint, urbs and buffer for cport in messages
- * @cport_out_endpoint: endpoint for for cport out messages
+ * @cport_out_endpoint: endpoint for cport out messages
  * @cport_out_urb: array of urbs for the CPort out messages
  * @cport_out_urb_busy: array of flags to see if the @cport_out_urb is busy or
  *			not.
-- 
2.34.1

