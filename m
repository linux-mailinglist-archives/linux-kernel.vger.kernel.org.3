Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61551572CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiGMFAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiGMFAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:00:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FCE313B6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:00:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r18so12628707edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7zvWAkBTi/beWqRFaw5lDcuuxOrGcwkbEW6Pb2PXE4Y=;
        b=VyHGbrpP1vLssXF9qkHIPGZI1MV57KbSlgYwNEDzaRG0iV3mA7d/SdLRqa99Z6qzZk
         zZWcG0SgFMmJ0numAmylMJKXq7UH+14wXu6mu3E8XC6z74M59seYohKXz1Ininskig0E
         BxDG2H2X1slGxy8CE/eBZVygHn/2disnbdIFW5M2by6QyR7QJhOKByPfirE0IXzowwU8
         LR84L2Yyg6HujggtV0UpLaZpOBt0/+VvwUNpb5kJaHdKwtPR6xt/fL7wEH2a5E67S1CN
         WxpinUjxZ+wynT6SRxxMZ80oMNH910Biw3uRRaGs9yfDKmrW+LetF/WeCPTjlwHEWsjs
         0uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7zvWAkBTi/beWqRFaw5lDcuuxOrGcwkbEW6Pb2PXE4Y=;
        b=alB8vS1rQAmptfAtXiczEyCXes8XhFaIJ+fxd+D1KXkYEI6NPOd50DQ8IOhcUPTqIQ
         SEmieJKxEY/E7HIjyh2V6xYkPUHjfgdLm26v0Of/HavXbrgTUwqGwiyQspdZ8k5pss2m
         yi8BIh4d1Yq8ZpY8WXlQbUc8EPGl6Qpbr6YF1C35Xaw2jXgVN3IwQ1lyVSbHwL4oBb7N
         t9Va62TBrvzpUvqyIMRmRta+N+L+/rTNPw53nIeH2tCvYUgqHaErLyXp0FB4KUNc55m4
         qqGgtWq6oCI9NQUyJjEn5s40Ne90fErnlIOg8qDQ4Ia+FiFi/DqopV4+kXRI6UbyS29q
         SeFg==
X-Gm-Message-State: AJIora8IcuyUHavxCrwjHk6szRl8xUTQgzUPGFNj8NdzVwM6cHsJZXKn
        OzzUz447iTsd+emmeEkQJ9U=
X-Google-Smtp-Source: AGRyM1vKo0fAIwILvK8iK/IJuJWaQ3vQFDqXmOJpkpJaX/bjETJTmd1uG0fxp++RWGMnNUqyvonttw==
X-Received: by 2002:a05:6402:42cb:b0:43a:5df2:bb5d with SMTP id i11-20020a05640242cb00b0043a5df2bb5dmr2292773edc.36.1657688400175;
        Tue, 12 Jul 2022 22:00:00 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id x17-20020aa7d6d1000000b0043a71775903sm7194112edr.39.2022.07.12.21.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:59:59 -0700 (PDT)
Date:   Wed, 13 Jul 2022 06:59:58 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] staging: vt6655: Rename byData to reg_value in two
 macros
Message-ID: <159014866cce40913d360a0692fb3c426d4cb840.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a variable in two macros that use CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b8f543aef716..16c18a1ed22e 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -539,9 +539,9 @@
 
 #define MACvRegBitsOn(iobase, reg_offset, bit_mask)			\
 do {									\
-	unsigned char byData;						\
-	byData = ioread8(iobase + reg_offset);				\
-	iowrite8(byData | (bit_mask), iobase + reg_offset);		\
+	unsigned char reg_value;					\
+	reg_value = ioread8(iobase + reg_offset);			\
+	iowrite8(reg_value | (bit_mask), iobase + reg_offset);		\
 } while (0)
 
 #define MACvWordRegBitsOn(iobase, reg_offset, bit_mask)		\
@@ -553,9 +553,9 @@ do {									\
 
 #define MACvRegBitsOff(iobase, reg_offset, bit_mask)			\
 do {									\
-	unsigned char byData;						\
-	byData = ioread8(iobase + reg_offset);				\
-	iowrite8(byData & ~(bit_mask), iobase + reg_offset);		\
+	unsigned char reg_value;					\
+	reg_value = ioread8(iobase + reg_offset);			\
+	iowrite8(reg_value & ~(bit_mask), iobase + reg_offset);		\
 } while (0)
 
 #define MACvWordRegBitsOff(iobase, reg_offset, bit_mask)		\
-- 
2.37.0

