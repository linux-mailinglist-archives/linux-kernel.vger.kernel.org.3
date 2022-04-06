Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A063B4F69DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiDFTaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiDFT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:28:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE1196D62
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:22:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x20so3443546edi.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+W0ovMUi1rIKA0H93ONQhbPqTAcvMIJLIIKO5SgqwQ=;
        b=IzSY30tgeyKhJuKVSko7726mC81nlvAkiLdzsHO/ZwKLkKoHDRbmlJjHKuYL1Epend
         rs/Aqq7xdrjRZLwegY34CwXuxl2+zVh61xNV32DA/KHraAHU9EAzvpcnemAEyZFKOzWA
         Ofi4K2bGrWCXUsD4ztxL/uwDCjD/DrVAxhzbkXA4JHVsnDmjdR+5jbxUBD2y+6qOlH1T
         Ak+gDSxY//HWNaSnUOcVu/DYS2XZu5ZzwqJtdDXYTZ43H/kYjRFFjb4Duhx51/zG6i5c
         48IZillBqMKk3h4fth3Szwm86RUPZjYhsT3ITtKe7NaleefGYdmauqxXrUrPBBswSsDN
         jLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+W0ovMUi1rIKA0H93ONQhbPqTAcvMIJLIIKO5SgqwQ=;
        b=t/7RAcYsog0A0xgM8HvD8k7bJP0s5NsyBtqreI0Fjl2/c8Aiw2LfFsOJsKwl8/CcaW
         UrUmRGFQp9lnAiXNzPRlJv9c7kjOsYILhCAG7QCEDV5BIvlpMnG8mlJJtr4BIkOY1kEc
         kiCG41fXfMcAqBUCGU+f5GiqlJEay+YF6sf4QQ2fjbD1hCR2qAxQy8u6f4jJntzb3M2i
         9LQobleyoRwD53zBKHLDMYKqZ7Fp6h5JwkarRdp8AIzvkWs+fIrD5gmaVOYLoeq92w9J
         1PPB5HBzvBd59SAmI1X9F08iDfS/Cbw3UHqktjXo5zE0Xsn5ED5GQ1LyBgKyq5WrJLBt
         xG8A==
X-Gm-Message-State: AOAM531yRL0bMIaxXWvUvyD2ZSFbBVdl23LIRJii+PfR4InnSz6k70Ak
        9w8PJ4CTJX1H6lOazUj4JS8=
X-Google-Smtp-Source: ABdhPJyV9ip0vEfW8t15CaHBNwMXTEUy7+OTeQqIbWiHb4nBZQ9DWREueTCro87PMdTdruq9R4xykg==
X-Received: by 2002:a05:6402:10d5:b0:408:f881:f0f3 with SMTP id p21-20020a05640210d500b00408f881f0f3mr9857798edu.112.1649265759220;
        Wed, 06 Apr 2022 10:22:39 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm7912730edb.14.2022.04.06.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:22:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/5] staging: r8188eu: remove unused _RND* from osdep_service.h
Date:   Wed,  6 Apr 2022 19:22:19 +0200
Message-Id: <20220406172219.15565-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406172219.15565-1-straube.linux@gmail.com>
References: <20220406172219.15565-1-straube.linux@gmail.com>
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

Remove the unused macro _RND() and the unused functions _RND256(),
_RND512() from osdep_service.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 .../staging/r8188eu/include/osdep_service.h    | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index f6c55f6c9e1a..f1f3e3ba5377 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -94,24 +94,6 @@ static inline void flush_signals_thread(void)
 		flush_signals(current);
 }
 
-#define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
-
-static inline u32 _RND256(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 8) + ((sz & 255) ? 1: 0)) << 8;
-	return val;
-}
-
-static inline u32 _RND512(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 9) + ((sz & 511) ? 1: 0)) << 9;
-	return val;
-}
-
 struct rtw_netdev_priv_indicator {
 	void *priv;
 	u32 sizeof_priv;
-- 
2.35.1

