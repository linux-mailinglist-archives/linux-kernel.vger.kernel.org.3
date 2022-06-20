Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23B5551035
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiFTGVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiFTGUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:20:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D05DEE7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 31so9387429pgv.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tlr/PaqbxkpfKuux+ZeYdthv16cbtlg5RBXZEsNXtGw=;
        b=IHfZuuDVETy6Ag+hUo9D+k3Shi+pcMR0kS+Q567spHTPV76lvWUyPiMZGAyMTv+Hg6
         OAAvOz2iFm04zf92/577Mw66zuMqgArXojSHK6BznkTOLs6d+eFse7YAK6YCiz2xwLXz
         qUq4e8l+Ka30SZJa8GOGHd5PU2j2eSQoqF0867bJPQqW4E7w1L6dWDzZcHL1OC39aVZs
         m4LV6iIIM1qv3aP2dIyryu+ydo8uWUY0fz1ld2UVdrLjIUHhFR7g27CD46lnTr16dPPt
         6LmT+sSCxPfzAHuynFLrugXtTlOTttguSMt8vNV5LFgJ65KtrlUGhXqsBGcNWynzTLjH
         Cjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tlr/PaqbxkpfKuux+ZeYdthv16cbtlg5RBXZEsNXtGw=;
        b=Bs1wTN/PCdWyfsDEwKU06WaG2Bsjd5qrFtIwCdfmFHXmDwGs84kNbMz/uDdc4vzw8s
         yNep4xddPkZ4QnGmQCYlZTFaMA5ftp81T73DmFWbDzSvdXrhCrKx+SKXuOk7mh2CdeEg
         8KPIXj8FH5A3Vxr/+0Y7QX1GjcerM8cnzEHsJfnWFp9BagycldM3VgQNTIbsP3FZFYFo
         7RZpyst2HnTVht7nIFIpgSR6Sq3Titg8uHGcmeDjPS+IEDHC5os3FCM8/Eyf1rmfB7Wc
         fGPZdzy9IRdNVAaJO3cWReMHtcahzq2heNxdK4xR4jaC6zMCZW9+oqp+8MyTxvrfuYVT
         6yIQ==
X-Gm-Message-State: AJIora+5CFktL+NJlapxUen+heZFAR0WbxHqexRcKuNbBK/1d7sK8hZe
        WxgSvMK7RG6f0EVncpMdvyRvcKuJ1Lg=
X-Google-Smtp-Source: AGRyM1sEsRRT5ZgBMC4CZisjm5oHwdKnCArcqQdZad9i4XN0S9ijvAbMW9tc446fm1gKjHzx8OGM8Q==
X-Received: by 2002:a63:724b:0:b0:40c:c398:fae6 with SMTP id c11-20020a63724b000000b0040cc398fae6mr2645377pgn.551.1655706047116;
        Sun, 19 Jun 2022 23:20:47 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b003fd9e4911f9sm8010469pgd.31.2022.06.19.23.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 23:20:46 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v3 3/6] rslib: Fix obvious documentation mistakes
Date:   Mon, 20 Jun 2022 14:20:12 +0800
Message-Id: <20220620062015.15612-4-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620062015.15612-1-zhangboyang.id@gmail.com>
References: <20220620062015.15612-1-zhangboyang.id@gmail.com>
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

This patch fixes some obvious documentation mistakes.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h           | 4 ++--
 lib/reed_solomon/reed_solomon.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 507fa14c03b2..cd0b5a7a5698 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -19,8 +19,8 @@
  *
  * @mm:		Bits per symbol
  * @nn:		Symbols per block (= (1<<mm)-1)
- * @alpha_to:	log lookup table
- * @index_of:	Antilog lookup table
+ * @alpha_to:	exp() lookup table
+ * @index_of:	log() lookup table
  * @genpoly:	Generator polynomial
  * @nroots:	Number of generator roots = number of parity symbols
  * @fcr:	First consecutive root, index form
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index bb4f44c8edba..da46026a60b8 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -56,7 +56,7 @@ static DEFINE_MUTEX(rslistlock);
 
 /**
  * codec_init - Initialize a Reed-Solomon codec
- * @symsize:	symbol size, bits (1-8)
+ * @symsize:	the symbol size (number of bits)
  * @gfpoly:	Field generator polynomial coefficients
  * @gffunc:	Field generator function
  * @fcr:	first root of RS code generator polynomial, index form
-- 
2.30.2

