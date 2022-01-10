Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320C94898D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbiAJMru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245684AbiAJMq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:46:58 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F6C061757
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:46:58 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6u4c-0007Td-JI; Mon, 10 Jan 2022 13:46:54 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 8/9] staging: r8188eu: remove unused cck, ofdm and mcs rate defines
Date:   Mon, 10 Jan 2022 13:46:37 +0100
Message-Id: <20220110124638.6909-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110124638.6909-1-martin@kaiser.cx>
References: <20220110124638.6909-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused defines for cck, ofdm and mcs rates.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/include/odm_HWConfig.h    | 29 -------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
index 3a8c041dbb66..1bd6f254bf53 100644
--- a/drivers/staging/r8188eu/include/odm_HWConfig.h
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -4,42 +4,13 @@
 #ifndef	__HALHWOUTSRC_H__
 #define __HALHWOUTSRC_H__
 
-/*  Definition */
 /*  CCK Rates, TxHT = 0 */
 #define DESC92C_RATE1M				0x00
-#define DESC92C_RATE2M				0x01
-#define DESC92C_RATE5_5M			0x02
 #define DESC92C_RATE11M				0x03
 
-/*  OFDM Rates, TxHT = 0 */
-#define DESC92C_RATE6M				0x04
-#define DESC92C_RATE9M				0x05
-#define DESC92C_RATE12M				0x06
-#define DESC92C_RATE18M				0x07
-#define DESC92C_RATE24M				0x08
-#define DESC92C_RATE36M				0x09
-#define DESC92C_RATE48M				0x0a
-#define DESC92C_RATE54M				0x0b
-
 /*  MCS Rates, TxHT = 1 */
-#define DESC92C_RATEMCS0			0x0c
-#define DESC92C_RATEMCS1			0x0d
-#define DESC92C_RATEMCS2			0x0e
-#define DESC92C_RATEMCS3			0x0f
-#define DESC92C_RATEMCS4			0x10
-#define DESC92C_RATEMCS5			0x11
-#define DESC92C_RATEMCS6			0x12
-#define DESC92C_RATEMCS7			0x13
 #define DESC92C_RATEMCS8			0x14
-#define DESC92C_RATEMCS9			0x15
-#define DESC92C_RATEMCS10			0x16
-#define DESC92C_RATEMCS11			0x17
-#define DESC92C_RATEMCS12			0x18
-#define DESC92C_RATEMCS13			0x19
-#define DESC92C_RATEMCS14			0x1a
 #define DESC92C_RATEMCS15			0x1b
-#define DESC92C_RATEMCS15_SG			0x1c
-#define DESC92C_RATEMCS32			0x20
 
 /*  structure and define */
 
-- 
2.30.2

