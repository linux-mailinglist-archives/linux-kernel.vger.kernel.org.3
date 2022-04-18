Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07480505D57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiDRRPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiDRRPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1542A715
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 12so12824344pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dTfclv02OOzOcblj7XsN4Ih/CQalStRiqrtD05ZRe5s=;
        b=gSYHgZsHWwk2aKf0awq92l919SNMPCc9mEUPi3Jt7IHtTT9437FEJIF0N9Q5Uh9LP9
         r4y0iVYWEn5oh+o+1so4N6hnjxuY/QrWEQfacIOhvjWPxnbeEY3lCEbbkUpyKRp/3ql4
         VyoMeFjcQ9pO3dLoM2S2nBFkwnirK/Yj6MX8iP9nGvI2lhxk0EjCIqHs0vQQM1pY5/My
         8/0Mg+9A7hnVLGQdt4U1r4VwzBRoE5h9vXc+qxQKRXeU14I/qKZhoCPqixtPRsdBGIqC
         OJ1eUhmG/vLxzP5OJHBZBGdZtr5LBtfJqvSdOfyPKIzgVV+b0ixe5KZKrNW96Fg91rq2
         Eeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dTfclv02OOzOcblj7XsN4Ih/CQalStRiqrtD05ZRe5s=;
        b=iaEM9RP6YTfMunF/LpXXe+VYimnNvEqnstDjM/tMG41Xb2oSkebd5SxzBndSfx56Ee
         JBYnJaRX9DSY/hXwfDjnh63Hxuz0vm4T/UGmN6FLS0QGuznbyrY3zRkVuo4s6DWq90w5
         Y69TSOIY5gaIFRr4b+I7EMB1zcWpHIACvGz6FH0eMnk77oBYwxJ9Xg2yof7RiPP+VSWb
         4+AajRPNq7kXzDCxwK27CfUtWKabOe6vBIolBq5xFgPfWSK1dCV8sWEUXSX1xcR6rnrH
         eXb6iWm51KzuD6bsgk+bQhd8Ve0DZYABiGcaGtI6tU04YmSYmT9Pt89BxqAAeGGzdJRn
         hk7Q==
X-Gm-Message-State: AOAM531QZ6UHJ3vccrAoUqMQ9TxcKlBqrEpyT+mo9ea+hTB9N622xDsj
        lm1pCciJ3jJH32OtrPgPLWgeMkdacPgAJg==
X-Google-Smtp-Source: ABdhPJz4DC4B6xU9TuyvStBcxOz4sQXJ6bzv+81lnpHQ9IuZsVmEg2TRquLbZXyBq9GzaDDLEPHvyQ==
X-Received: by 2002:a17:903:11c7:b0:154:b936:d1d4 with SMTP id q7-20020a17090311c700b00154b936d1d4mr12090065plh.78.1650301977627;
        Mon, 18 Apr 2022 10:12:57 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id t63-20020a625f42000000b0050a7eaff8c9sm3636063pfb.189.2022.04.18.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:12:57 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH] staging: media: av7110: remove redundant space after cast
Date:   Mon, 18 Apr 2022 22:39:02 +0530
Message-Id: <20220418170900.16725-1-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary space immediately after a cast. Identified by
checkpatch: CHECK: No space is necessary after a cast.

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
---
 drivers/staging/media/av7110/av7110_av.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 91f4866c7e59..df41d2ce1ed7 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -93,7 +93,7 @@ int av7110_record_cb(struct dvb_filter_pes2ts *p2t, u8 *buf, size_t len)
 
 static int dvb_filter_pes2ts_cb(void *priv, unsigned char *data)
 {
-	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) priv;
+	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)priv;
 
 	dvbdmxfeed->cb.ts(data, 188, NULL, 0,
 			  &dvbdmxfeed->feed.ts, NULL);
-- 
2.25.1

