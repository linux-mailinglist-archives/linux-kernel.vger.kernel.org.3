Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE354AF6E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiBIQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiBIQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:35 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C77C05CB96
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:38 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i186so5321793pfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mG3qP+QrOSaboEBGdq6nQWobBpgHojm9ly6BViVKhnI=;
        b=iGmaY8/LbHXSahcXRwibEhuKkjW3drpXi2oD9PnOA1sTwJIq0H3HyYB9SQkBujf34I
         DjvD0PtveUK2q0S2uwwc2NbvRmZTdHdEeH6Wugelfd1pjVDxjZdQK8NPnGFtbrS46aXH
         V754YgJ/3MP1GMhidVa9nFdEAezjpbIdqC4SucMqI3v0/ptAfng5bpf2zf9cj8Nw0agS
         GMDxdS0PmfV5i1DCxmFBOjcTKrHkQJca10HyDQDnK9dQ6rFnWme4lMtdcPChbFemwmxf
         n8l2w51Bps+9CEKZtIf/JvhmKtMt/hPBcTaqM1KyoRpb0FQlraLyBz7nOdYRLyEFiXAv
         hj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mG3qP+QrOSaboEBGdq6nQWobBpgHojm9ly6BViVKhnI=;
        b=oKR7okNE+ggDOQU0fKJNdkkUDUksQ5Y+cyZjVEzIKIfxE08SYRBW4F/+qEwvgdRl60
         sLBsOawbzKZQ3BlvAYhV8GqOSlBFAS1tup4pRFLLENHY57CfpbIjs877eb+CDTIlhB2X
         WgR0lzlu+1Z7WVpMd1AGbxEzhXLBR68SupQ7HKwXv5qRG2Q98o6JqWq9bY6IuG9TcAKE
         FG0jOAGtOnXLI8SC14w9V1H88LiCgqw7gaeuF2JkhyJCfo9XS8Y6QHK5f91nI8stmNrb
         Icx19QqYDtZdHGVROv7Bw2kbeSkJ6V4o/WnztILDjGTLZEbRIBcw4lV0ef70ZXlEOtc+
         M39A==
X-Gm-Message-State: AOAM533GNcCUxSFM5VakKE32tDtmFZW2JBHhwqZWodwbxEmrTsbMNIcc
        ONVC2F7HkqZdkWm94rLTLak=
X-Google-Smtp-Source: ABdhPJxC2Lph/4BCmF1vTLO7c0xSu3cjJFT78SsazSwJuS6z7T6gYsvRk0BbPcls5rNtFb1swvQKOA==
X-Received: by 2002:a05:6a00:88e:: with SMTP id q14mr3094913pfj.47.1644424658229;
        Wed, 09 Feb 2022 08:37:38 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:37 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 4/9] staging: r8188eu: remove empty function _InitOperationMode
Date:   Wed,  9 Feb 2022 22:06:02 +0530
Message-Id: <07083cbb8b09957d2fcf9e5b70e0fd832ce53f35.1644422181.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644422181.git.abdun.nihaal@gmail.com>
References: <cover.1644422181.git.abdun.nihaal@gmail.com>
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

The definition of function _InitOperationMode is empty. Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 659e0f26db29..66e90c6928ca 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -449,10 +449,6 @@ static void InitUsbAggregationSetting(struct adapter *Adapter)
 	usb_AggSettingRxUpdate(Adapter);
 }
 
-static void _InitOperationMode(struct adapter *Adapter)
-{
-}
-
 static void _InitBeaconParameters(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
@@ -635,7 +631,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	_InitEDCA(Adapter);
 	_InitRetryFunction(Adapter);
 	InitUsbAggregationSetting(Adapter);
-	_InitOperationMode(Adapter);/* todo */
 	_InitBeaconParameters(Adapter);
 
 	/*  */
-- 
2.34.1

