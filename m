Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DCB4F0171
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiDBMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241811AbiDBMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:30:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01293F1E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 05:28:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d7so7715567wrb.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eliJjdk7jbLJE3kqta2u7nx7t+Z1Xrdbg0dQj0W2hGE=;
        b=cZ2s0lHLNcNHE4xg7ogaJ48AtEiu2LY2/w15h11/MGF5PZo3TVaOHE6+htxhO7jgrL
         y4WV+hRXWUSzTFYxdiJOw1UaRWHXnxLSMxF8rZ9ri4ogr5SjVwWdHbArAm57EhcrsQBQ
         Ac0YCZjR8IDxzFpa0NxvsG1pfX56zmgc2lh89zSzYWCxE3lpfFGk6DCL1GZQ3sBzq6oO
         YCPx3XojEJbr8QLtkWQv0F/LfimIcAPp8GvI2v0lW8q9o6VvCKNqrWcnSZaivJ0wNOkL
         K8GOCH5TJZs5x7j+jXr9Dvb8kfRU3zhDb2r9/a8muaIO71TyKxd4zzWqZbWJhpHeLbGe
         U6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eliJjdk7jbLJE3kqta2u7nx7t+Z1Xrdbg0dQj0W2hGE=;
        b=vBY4dVR6sXlWGqSFR9aJzw7Q/4KdEuA886L6fH/yn0NQ9At1KL6JxCJigNMqq8J7yl
         jM5T1Z9URLTxvBkjjOwK8z9CypyBSuzrqzg92hTEM5cMghWtKuP8X9WedEu01+vi2AlR
         EaYUwEl3baE+NfPVRKgn5BC5AWyUVGLsQXdow1u9g/A1BJ0WirrhO51NY2wBnr8vxwKO
         m/lrTWFgJqshodlQN+nWx+h5+dx/HqxV70BDMWesGgYO+RF+kWHf8TTD7gxXxNRhV8FN
         Xqg9w8yQ6s7LDmmVaUV3kZLYnxQ+zhJFsyA+eFJ3WY4EHrCeWv5+ibTOQ+q6IeKnuRPO
         v6Jg==
X-Gm-Message-State: AOAM531b8GBK+TQwirLhL6wJBijDwEd1oOjVS1Hu39e28QHJTiw7Yqwd
        M5Xf63GUjrO7yp1cgMMs4Ck=
X-Google-Smtp-Source: ABdhPJyeY53jJcGpZMdRQa/ArzO6Aq8e57wXvpxza7nODaW6Kfifkdn2BFA3A/I2zuFNIJYt6jKe9w==
X-Received: by 2002:adf:e10e:0:b0:206:2d7:b4de with SMTP id t14-20020adfe10e000000b0020602d7b4demr2163900wrz.497.1648902506773;
        Sat, 02 Apr 2022 05:28:26 -0700 (PDT)
Received: from alaa-emad ([197.57.138.121])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm4401473wrt.115.2022.04.02.05.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 05:28:26 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH 2/2] staging: rtl8712: Fix Lines shouldn't end with '('
Date:   Sat,  2 Apr 2022 14:28:17 +0200
Message-Id: <9bb14ea276fd3274900f7aec455174c53ed3a3e9.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <8c88829f625f9847a1db18fe467399594dacb064.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
References: <8c88829f625f9847a1db18fe467399594dacb064.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix " CHECK: Lines should not end with a '(' "
Reported by checkpatch

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 05ba0ca7d627..d43c097f30c3 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -638,16 +638,12 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		if (p2ndxmitframe) {
 			u16 total_length;
 
-			total_length = r8712_xmitframe_aggr_next(
-				pxmitbuf, p2ndxmitframe);
+			total_length = r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
 			do {
-				p2ndxmitframe = dequeue_xframe_ex(
-					pxmitpriv, phwxmits, hwentry);
+				p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
 				if (p2ndxmitframe)
 					total_length =
-						r8712_xmitframe_aggr_next(
-							pxmitbuf,
-							p2ndxmitframe);
+						r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
 				else
 					break;
 			} while (total_length <= 0x1800 &&
-- 
2.35.1

