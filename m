Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A434786BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhLQJI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbhLQJI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:08:58 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1117C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:08:57 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d13f:527c:5504:a743])
        by michel.telenet-ops.be with bizsmtp
        id XM8u2600k250X3006M8ukg; Fri, 17 Dec 2021 10:08:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1my9EU-005XGF-EM; Fri, 17 Dec 2021 10:08:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1my9ET-00A9zO-8h; Fri, 17 Dec 2021 10:08:53 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] media: dvb_ringbuffer: Fix typo in dvb_ringbuffer_pkt_write() kerneldoc
Date:   Fri, 17 Dec 2021 10:08:52 +0100
Message-Id: <270f5b7f79a24dc1a3e81d94f6f54fc0f08daf56.1639732105.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no such error code EVINAL.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/media/dvb_ringbuffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/dvb_ringbuffer.h b/include/media/dvb_ringbuffer.h
index 8ed6bcc3a56e5ffd..029c8b615e490fae 100644
--- a/include/media/dvb_ringbuffer.h
+++ b/include/media/dvb_ringbuffer.h
@@ -214,7 +214,7 @@ extern ssize_t dvb_ringbuffer_write_user(struct dvb_ringbuffer *rbuf,
  * @buf: Buffer to write.
  * @len: Length of buffer (currently limited to 65535 bytes max).
  *
- * Return: Number of bytes written, or -EFAULT, -ENOMEM, -EVINAL.
+ * Return: Number of bytes written, or -EFAULT, -ENOMEM, -EINVAL.
  */
 extern ssize_t dvb_ringbuffer_pkt_write(struct dvb_ringbuffer *rbuf, u8 *buf,
 					size_t len);
-- 
2.25.1

