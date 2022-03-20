Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7304E1CE0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbiCTQif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbiCTQic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:38:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF43EAB5;
        Sun, 20 Mar 2022 09:37:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s8so13574055pfk.12;
        Sun, 20 Mar 2022 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5y2O5eH0uz4RqUV+g+CVqKPa9GF0DiPMGgxFfF92Z4=;
        b=WfTrmjxf6qB8DHA3S1LUOhT3UuO407oKcxOU285vY5JhyTe5mLiJK1Z75xSrTY8CER
         JyjuInZj4nuM7Eaxw/BsXtyM11Vz02oZ2mtmWLC/g5rJNtAxxjJCpBx/J0V3yFnH8HbM
         MgmYsxWBylHhozkp8m8ilMWGB7Aimzc7hGoKxP0fDd8+0NWFx8ncEW7X0oJ8fjeAATlr
         jJB6BKc1HdLgEvFdvMSrGXGG/s6zxWJFAggqz4AmILV9pgNERgy8FqQtYkfkZt5JLmeD
         4sitkdPh9tLhNbBQDZjlwd/DuoaaGqZ5XR7hDxHEr8wCRLAp6/JrEeSHb+eqE2F6su40
         BxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5y2O5eH0uz4RqUV+g+CVqKPa9GF0DiPMGgxFfF92Z4=;
        b=RPWRVT0WCv1lAvAjxP0N8IdtMhHe2+vJFS9t0lniytHJ1ep74eEXyQWerAFFMfVUDe
         Ckgc0POYo5LsUnUhUHtPtQLKgz2hpqjLli8Ylx8gNTha4OqDK5mfnqiISfY+icIULx7H
         PmoauMGo7SXSWzQHD/7IOU/zewBT4hbSBC19ezEurijbIXHnpQuJ0yC/7fJ+cvCXttI9
         Mo7cj74Z42yCDlm29GNaJVQzTG4lyN/tKa7O8CeCJxy/u9UJNyDxK4JmQIVPPO3DSgBN
         v/bXJ3wLUdhISrQl92jqpuXY3wcup9ew1LDLGGcFs22l2U1w2vPOJSfuZhhWKX504sTz
         wRuw==
X-Gm-Message-State: AOAM532FUlN0i4HnlJR8S/RHpYjwvF24AubH5OtWMS8EbvdZPvcnMdh+
        pqiTYjdk2T27Y3djLwoXk38=
X-Google-Smtp-Source: ABdhPJzgb2p1evISFTPaTJWiw1LjEItmF2jn/t0+UOhObYSZsu+WojxuIlFa2+I93NUrw7R5XeAfHw==
X-Received: by 2002:a65:614e:0:b0:380:bfd9:d4ea with SMTP id o14-20020a65614e000000b00380bfd9d4eamr15080781pgv.92.1647794228474;
        Sun, 20 Mar 2022 09:37:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:4000:2381:95dc:514b:b97f:b05c:6ff1])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a8b8600b001c70c8e4040sm1485535pjn.27.2022.03.20.09.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:37:08 -0700 (PDT)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v2 2/2] media: av7110: fix prohibited spaces in switch statement
Date:   Sun, 20 Mar 2022 22:06:18 +0530
Message-Id: <20220320163618.41054-2-ahamedhusni73@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320163618.41054-1-ahamedhusni73@gmail.com>
References: <20220225155622.585621-1-ahamedhusni73@gmail.com>
 <20220320163618.41054-1-ahamedhusni73@gmail.com>
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

This patch fixes "space prohibited before that ':'" checkpatch error
in the switch statements.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
---
V1->V2: Prohibited space fix after patch review.

 drivers/staging/media/av7110/av7110_av.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 1d42862e9669..ab7cf496b454 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -595,10 +595,10 @@ static int find_pes_header(u8 const *buf, long int length, int *frags)
 			case PROG_STREAM_MAP:
 			case PRIVATE_STREAM2:
 			case PROG_STREAM_DIR:
-			case ECM_STREAM     :
-			case EMM_STREAM     :
-			case PADDING_STREAM :
-			case DSM_CC_STREAM  :
+			case ECM_STREAM:
+			case EMM_STREAM:
+			case PADDING_STREAM:
+			case DSM_CC_STREAM:
 			case ISO13522_STREAM:
 			case PRIVATE_STREAM1:
 			case AUDIO_STREAM_S ... AUDIO_STREAM_E:
@@ -659,10 +659,10 @@ void av7110_p2t_write(u8 const *buf, long int length, u16 pid, struct av7110_p2t
 			case PROG_STREAM_MAP:
 			case PRIVATE_STREAM2:
 			case PROG_STREAM_DIR:
-			case ECM_STREAM     :
-			case EMM_STREAM     :
-			case PADDING_STREAM :
-			case DSM_CC_STREAM  :
+			case ECM_STREAM:
+			case EMM_STREAM:
+			case PADDING_STREAM:
+			case DSM_CC_STREAM:
 			case ISO13522_STREAM:
 			case PRIVATE_STREAM1:
 			case AUDIO_STREAM_S ... AUDIO_STREAM_E:
@@ -773,10 +773,10 @@ static void p_to_t(u8 const *buf, long int length, u16 pid, u8 *counter,
 		case PROG_STREAM_MAP:
 		case PRIVATE_STREAM2:
 		case PROG_STREAM_DIR:
-		case ECM_STREAM     :
-		case EMM_STREAM     :
-		case PADDING_STREAM :
-		case DSM_CC_STREAM  :
+		case ECM_STREAM:
+		case EMM_STREAM:
+		case PADDING_STREAM:
+		case DSM_CC_STREAM:
 		case ISO13522_STREAM:
 		case PRIVATE_STREAM1:
 		case AUDIO_STREAM_S ... AUDIO_STREAM_E:
-- 
2.25.1

