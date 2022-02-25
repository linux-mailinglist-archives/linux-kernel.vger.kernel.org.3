Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F84C49CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242464AbiBYP5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiBYP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:57:02 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0201D8A82;
        Fri, 25 Feb 2022 07:56:30 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z15so5031417pfe.7;
        Fri, 25 Feb 2022 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+8G7tfQjV4ABkTw2q7bkb0w4qL2HQLeYpElCFm5+0A=;
        b=VCZCpTm8gU7mIFzNDCQAeyjVWNwhmu1TRcK5A69m8/XMTsoIWllTmkIupPLKk5z2+l
         uVvCna5KOSqGga2gVYdk/N7NnwPg8voVsGltJ6wo7DRp0w8Vmfyi05mVDiIHVEqAQ4U8
         TMUJUZAM907TANUSba0fmcdyC7zBOGZ47wmMs702JQDToRIv+uKjO+RZFthTuWaUMZum
         HilTGn3V760r0bJaqVpZ25uVKEZdYTstTyu2JyaKs+Vd3eHj6w+CDockKOg14xBvWrBC
         9FFkvCZz9hvsz3NNg0+pFmGlfiAokYd6qL7AUIpWy3hNm6wtW8TndKaNpH5Vi827m6Qb
         08/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+8G7tfQjV4ABkTw2q7bkb0w4qL2HQLeYpElCFm5+0A=;
        b=2AjJgzgVkhF1OpI93d9RWfTv88NPnP2LJD4uVq2dyFkl8Ashj3Lc8j5A2ffI4xj/ia
         0P4CxESNW4QBqFJTDYWx+OgDU+Cjb6WyfFA+be1R6/Ry5PLZoBhQQm0CsthXd2iY1nUE
         wCm1m6QMVa2a0ly8Et/aUlgQpNXI0fOqXJWFMCec3VZipVMyFmlnIrD0sNxQpknx2GL5
         8ZsTcNYs2NegaNPfMFAH0B5dSi5QREOx6vAY7eVzLhOH8ms7w6na7aHbUXdturc9YStv
         BL8Wh5HxsjmeFnX45eL/bNEHrxln7EbEk0hqT11gxIgVMTAT5b+KGPpZEl+XaZpLXNHw
         Fexw==
X-Gm-Message-State: AOAM532uydTFjZXP0RaPHWFzXz0v/ohC/LHChub+XaWjniWS1UoInWhp
        M72JT/6SyFLivbXYIQKMGgJ0cdZ1NFImtY1O
X-Google-Smtp-Source: ABdhPJyKZMHrRt1ODKefYe6udSponfLE0sQv56Y0NLeGtURzbrTz0pYERo9eU71Qk3xSTEv8v+8+Ng==
X-Received: by 2002:a63:c22:0:b0:373:3d5b:ee98 with SMTP id b34-20020a630c22000000b003733d5bee98mr6515812pgl.252.1645804589451;
        Fri, 25 Feb 2022 07:56:29 -0800 (PST)
Received: from localhost.localdomain ([2402:4000:2281:554f:f1f7:ced3:4a51:c107])
        by smtp.gmail.com with ESMTPSA id m6-20020a056a00080600b004e1bb196743sm4150254pfk.5.2022.02.25.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 07:56:29 -0800 (PST)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: av7110: av7110_av: Fix Switch and Case Same Indent Style Error
Date:   Fri, 25 Feb 2022 21:26:22 +0530
Message-Id: <20220225155622.585621-1-ahamedhusni73@gmail.com>
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

This patch fixes "switch and case should be at the same indent"
checkpatch error.

Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
---
 drivers/staging/media/av7110/av7110_av.c | 30 ++++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 91f4866c7e59..1d42862e9669 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -770,22 +770,22 @@ static void p_to_t(u8 const *buf, long int length, u16 pid, u8 *counter,
 	if (length > 3 &&
 	     buf[0] == 0x00 && buf[1] == 0x00 && buf[2] == 0x01)
 		switch (buf[3]) {
-			case PROG_STREAM_MAP:
-			case PRIVATE_STREAM2:
-			case PROG_STREAM_DIR:
-			case ECM_STREAM     :
-			case EMM_STREAM     :
-			case PADDING_STREAM :
-			case DSM_CC_STREAM  :
-			case ISO13522_STREAM:
-			case PRIVATE_STREAM1:
-			case AUDIO_STREAM_S ... AUDIO_STREAM_E:
-			case VIDEO_STREAM_S ... VIDEO_STREAM_E:
-				pes_start = 1;
-				break;
+		case PROG_STREAM_MAP:
+		case PRIVATE_STREAM2:
+		case PROG_STREAM_DIR:
+		case ECM_STREAM     :
+		case EMM_STREAM     :
+		case PADDING_STREAM :
+		case DSM_CC_STREAM  :
+		case ISO13522_STREAM:
+		case PRIVATE_STREAM1:
+		case AUDIO_STREAM_S ... AUDIO_STREAM_E:
+		case VIDEO_STREAM_S ... VIDEO_STREAM_E:
+			pes_start = 1;
+			break;
 
-			default:
-				break;
+		default:
+			break;
 		}
 
 	while (c < length) {
-- 
2.25.1

