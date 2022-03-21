Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212DE4E2D91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243071AbiCUQPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350888AbiCUQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:14:06 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F327A74DD6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=jEz2JWGFyUlDzW
        pfIqps0dXpIbCRQKaLSS5PMn2F+2E=; b=FLZH/45CYwgJsS+RdBouMD3gfVgMPJ
        FazvroCNq3fvPRCocLvcZLkK0ABFtem4TUW8wqUyGBi4CI71tWVOycgHO8uypnEC
        nKEBP9YHMf9DnudZXgKtNsedhRs9jww2Nurv+61T70dmoD7ajPfJaRGVLLqtsIMi
        wwY+iI6i4fw3o=
Received: (qmail 958078 invoked from network); 21 Mar 2022 17:12:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:36 +0100
X-UD-Smtp-Session: l3s3148p1@u9y4w7zaONkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 15/15] delay: remove the fallback for fsleep
Date:   Mon, 21 Mar 2022 17:12:23 +0100
Message-Id: <20220321161223.2837-16-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
References: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users are converted to usleep_autoyield now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
RFC, please do not apply yet

 include/linux/delay.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index d0919f52fec8..f1bf8d4103c0 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -88,6 +88,4 @@ static inline void usleep_autoyield(unsigned long usecs)
 		msleep(DIV_ROUND_UP(usecs, 1000));
 }
 
-#define fsleep usleep_autoyield
-
 #endif /* defined(_LINUX_DELAY_H) */
-- 
2.34.1

