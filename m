Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3EA58B6C9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiHFQZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHFQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:25:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2570411457
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:25:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f28so4737837pfk.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Tlr/PaqbxkpfKuux+ZeYdthv16cbtlg5RBXZEsNXtGw=;
        b=Mn+5qAQtoswA528bAeJwnZfGXmUf3wXZiCtGaiNazI8Xqczs3yY10dq/W7sMOYjAfJ
         NO7KYhT2nYfV0xByuSTfyCHOWsPeMjUleWaHlDX8JYMi6ZRwtMMVJDHrowG04BxfNKEi
         O+pymlw5q6lrPn8TzpvkGnH4iQEJQjEVN8q1NL++Bu05CmaN59TN/2QrUnmUsWJUuY7l
         SvbQ1mkGfIqQ7K4oNQ2YQzF8Gr44HI5GrcKe7ZqJOLVd3FQ2BRoMMWkMBTreo41gMXrz
         Q2x1BLZcWXZJftwR0dKlDGDRtTtQrr+y5o+QXj2uRJtcffd1CV02PAFVDmLjSn6bF+T7
         3rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Tlr/PaqbxkpfKuux+ZeYdthv16cbtlg5RBXZEsNXtGw=;
        b=PwOER3YuA4qL3ZpM8Mmjki629Li9NldJgU0+MxBxachasOCeH0r97Z+De+4vDcuucS
         lXdtCaa9iroJSNKfttBJ7dxjZqwnGCB0Tf6ZxLFbalhOk5/yFfdJyXG712wGQ2CX5PyT
         McFnLGBIfgrswTXSimDObR2DAZDojuzRnrZ+Z44Ig69nXtUIx9McPhf3qvTORCHgbI0t
         PtoBEGEOklBJXvoQbGIkGAkNsQmmVD90Xatmo5z/SvLVrUSVLgHI2Q8p6YSyuNnwRoGC
         IcHfWGeJyd2EcAaPlrcnvwmMfACmSnRF00jY21epaasFt7wO92sxv8tdRziC+PiR9qRw
         niqg==
X-Gm-Message-State: ACgBeo1WI02BZtz+MaVDsFpkNc3cSHqrkK8/xvPZF7m9nJV8eC782iOL
        Ak7YGmEnJUGPup09O4hewOM=
X-Google-Smtp-Source: AA6agR6scjUmAyGOnOVRExK9PxzftY+DxlzyKN/lR+WECWZVYdxE6FD4KvF6yE9ORQT5sqbN5DnFCQ==
X-Received: by 2002:a05:6a00:2392:b0:52e:b4fb:848 with SMTP id f18-20020a056a00239200b0052eb4fb0848mr8705112pfc.8.1659803131495;
        Sat, 06 Aug 2022 09:25:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b001f04479017fsm4990927pjd.29.2022.08.06.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:25:31 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH RESEND V3 3/6] rslib: Fix obvious documentation mistakes
Date:   Sun,  7 Aug 2022 00:25:07 +0800
Message-Id: <20220806162510.157196-4-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806162510.157196-1-zhangboyang.id@gmail.com>
References: <20220806162510.157196-1-zhangboyang.id@gmail.com>
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

