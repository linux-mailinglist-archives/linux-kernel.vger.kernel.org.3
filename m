Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09925526F5D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiENC6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiENC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:57:29 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B37A3312607
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1652492926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4drBsrduYyDq5E9ctWf2Hiho5x1IUZsixAHhbApmnLM=;
        b=o848X1A8X1BMnR2/sDbvCQYjOrl65v2jlY5bk98oJ8V4T3JOjDLNWw/SOQ6gFReo7wGWzu
        QMofnl53SsltcnK+G4xiLRaUqcAuK7IlgWScHKusvThDyUbz3YgMivVjYP4zZrIkPAPzaQ
        iozf+nOpKqXY8lCabjjKwlqTyR5fTdKzlK8NHjY0/Y31U6MkI/SMvRHUCxf6CeDcnNPbnf
        Yifb2otanzyMztyosNa0wwxjXOWZHIwYvqnI55Kw3LxQFDu4D+zXLusg7xWAjguARiBY4a
        AIG/ckoY/8SnjDdTjvDXO1UZ90p1HHy+IizCTMbwacohOHI1gTUOaLPKs0GaZdN4SE10iB
        iNDt5qFpesl5tOBLm6Y1wfzc4/xTmsI2F8LOMV3iEbpwzQZqk/wArcRTC7LyyZs2Qfq4Tl
        HeZjeQMOk+rzfRNbwPSq1TwbEwAMy+MoDGkYwkDjKx6sz1zCJPEdm3KolkdXnEsPGVwsmD
        pIgov2hsaTooQp/uwrPJHKMik/QNBFWoAFyC1pTZvx7qo9HLwRnRq2wgqZAIzT8+rwJ0Ih
        n6HyjeDfbPiFIIP5VigSmZmfC5IIp1ZNDXBlbiCNkKKI9lCzqSg+BHl6QEfiMBcDu/SkWc
        fhew4NXZoB5TaIZIz4J5kUB83Mv3D4LOltP2o/1aGkAq8KwenHRxA=
Received: from paul-debian-hp (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 4351477a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 14 May 2022 01:48:46 +0000 (UTC)
Date:   Fri, 13 May 2022 20:48:44 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        notify@kernel.org
Subject: [PATCH] sound: sound_core: changed spaces to tabs
Message-ID: <Yn8KfFXUfWlGw+Bw@paul-debian-hp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changed spaces to tabs in sound_core.c according to kernel styling
guidelines. found using checkpatch.pl.

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 sound/sound_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 3332fe321..28bc038dc 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -290,7 +290,7 @@ static int sound_insert_unit(struct sound_unit **list, const struct file_operati
  *	completed the removal before their file operations become
  *	invalid.
  */
- 	
+
 static void sound_remove_unit(struct sound_unit **list, int unit)
 {
 	struct sound_unit *p;
@@ -395,12 +395,12 @@ int register_sound_special_device(const struct file_operations *fops, int unit,
 		name = "admmidi";
 		break;
 	    default:
-	    	{
+		{
 		    __unknown:
 			sprintf(_name, "unknown%d", chain);
-		    	if (unit >= SOUND_STEP)
-		    		strcat(_name, "-");
-		    	name = _name;
+			if (unit >= SOUND_STEP)
+				strcat(_name, "-");
+			name = _name;
 		}
 		break;
 	}
-- 
2.35.1

