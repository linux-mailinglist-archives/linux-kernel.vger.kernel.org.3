Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00DD4EDF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiCaRIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiCaRIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:08:45 -0400
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D441EB81C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648746409;
        bh=FPMU8N2jQavOCacSfQdcJQJfNCrqNiTewNmJoSVKxMk=;
        h=From:To:Cc:Subject:Date;
        b=NBpC313Fi6fGyxJF0jy2X9oiO7udr+bTfG3DQDvHlF2a8Lg444dGjLQa7V6NOCySl
         40UBk6Xc9ZgaOaImGpML89aC95uvNHzFSv2s+n/UMBAgzu5/XZpVquyAuyUzrEXc/I
         a9gteeqlVilKsXNuV7d2zZPGQ5XvYeLwiC96ujZU=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 1AE356CF; Fri, 01 Apr 2022 01:06:46 +0800
X-QQ-mid: xmsmtpt1648746406ti3pg1fcb
Message-ID: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieiszZ2O+QJKwha6txJuLAmVUYRfy6rjfX0HXoCicoXIgn3AFLgw
         juzfSbzrFcKQyW1M60knK5U5CdA1izHfBG0WGSsbKqfKdxnHu7GcF7+wKfm8dzbgkxu/lFhNMp0l
         N1GKRA07TvWf+1gf/Vp8ikbVsYxZlMxEIAkWYzJk1KP94IOet7DFTJy0IgRnAcNVw8CcFslE28in
         9pfTGfPRCC4DQMHrsoHvilFikfrmtvgSttgbCDE45UsxlpozgF7HBp3tuu5PBOjZbwwNTPuxnzmA
         IbDmfxUGSZ4tJQ0Z0WcuL/4N7vktv+g74d1IMHWSj1Gek842zpvkzvFWZMyOgUjf5GlM4w09heex
         qptic1W6nVOui6e1slC4JbDjd8SuoM1KGjOKFazp7Zh0mENIj94rljkXKFOmiT5TkT59VZidq2yS
         KIIvqhCaW+ekieciLoBl6laB1ZkloT5tg0xQ1NOHcz0o0ugi8QR7XeTv0u42yiQCFrQq2G0gGzj8
         x30UBcfxn9ay7ggwSwWpmiMqW6pCpC/o5lP9LqDoFinWDiGRNzdpbr5zPuaUHYtrzPgHu7C1LSUd
         6HNv2QyqPAQNTAQhcVEy+VfUdhgL8CbpYhHGUA1VbUOvB2b3JGWtg7ZyfjuyvJgxfqEORYgErDAr
         NSTeVzlycJmBESQbp/F6x6MdPX49c+okDiKU2t8sCTVtphOi7AqigJMwkBHyatbiW3YaYuBo94+7
         ORBUmfF6WVLPXfFM6Ja0LeoJ7Qt1h+aI/Jt9jHc87BPuTTQBSKGgNvUGHcNCXlveGU8l8/mT07+2
         lJxfKGaby2O1PGtqs85ArHDdS5ofLrrZWGLN4jBBOEB+YrgJouTbPgu/hns8/IiCg8JHmMtCsHTk
         blO/SjzZu3V33FLhoiXdQy3i8qXilFPl3g1hxA3XuPluTNgyp0ktnx2IPIyzbz0Q==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 1/3] staging: rtl8712: change the type of _r8712_init_recv_priv()
Date:   Fri,  1 Apr 2022 01:06:35 +0800
X-OQ-MSGID: <20220331170635.9555-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

There is a memory allocation in _r8712_init_recv_priv(). Since the
original type of this function is void, now it is changed to int to
make the error of allocation failures propagate to its caller easily.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/rtl8712/recv_osdep.h   | 2 +-
 drivers/staging/rtl8712/rtl871x_recv.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/recv_osdep.h b/drivers/staging/rtl8712/recv_osdep.h
index d8c1fa7..f5b97c5 100644
--- a/drivers/staging/rtl8712/recv_osdep.h
+++ b/drivers/staging/rtl8712/recv_osdep.h
@@ -18,7 +18,7 @@
 #include "drv_types.h"
 #include <linux/skbuff.h>
 
-void _r8712_init_recv_priv(struct recv_priv *precvpriv,
+int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 			   struct _adapter *padapter);
 void _r8712_free_recv_priv(struct recv_priv *precvpriv);
 void r8712_recv_entry(union recv_frame *precv_frame);
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index c23f6b3..dd8cb07 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -44,7 +44,7 @@ void _r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 	_init_queue(&psta_recvpriv->defrag_q);
 }
 
-void _r8712_init_recv_priv(struct recv_priv *precvpriv,
+int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 			   struct _adapter *padapter)
 {
 	sint i;
@@ -60,7 +60,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 				sizeof(union recv_frame) + RXFRAME_ALIGN_SZ,
 				GFP_ATOMIC);
 	if (!precvpriv->pallocated_frame_buf)
-		return;
+		return -ENOMEM;
 	kmemleak_not_leak(precvpriv->pallocated_frame_buf);
 	precvpriv->precv_frame_buf = precvpriv->pallocated_frame_buf +
 				    RXFRAME_ALIGN_SZ -
@@ -77,6 +77,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 	}
 	precvpriv->rx_pending_cnt = 1;
 	r8712_init_recv_priv(precvpriv, padapter);
+	return 0;
 }
 
 void _r8712_free_recv_priv(struct recv_priv *precvpriv)
-- 
