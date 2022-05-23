Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7587531E64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiEWWNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiEWWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:13:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288446D4FC;
        Mon, 23 May 2022 15:13:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so516247pjt.4;
        Mon, 23 May 2022 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qlf5oC7nbFp7JFcEvQgRc08GVWjJu27OOp/51PqPx9U=;
        b=mwQZVOyw5TYzABamKOu9R5KjnjBSoXV2pVjrPfGHz9tb3bt0ORFzDi9Eb/Aufjm0tH
         GUuoa+wt9SzJrXOSpUYGJiNAJAKGC8kqXX9INvJL3Jp7f2tqMgo6vkDlywBkGT25lZFC
         i77vNjbiiVt6EZgu8CcXtF/mJpm9Jd9vMzG6+Xjy8z8Zes8IYMG3H55YG52FZr6CB07P
         2OoM0sfd9St3+8GG58j4TXoI3jEBwV1aNsoRy5aVJkU9pX+jpoHQH0hN8rZikhfzdHyJ
         cOLChU33Gj74ETEARYHbUzDnau+7hp2kpr9cae5L1g0Q40XVgs5A8wGqOMR973EPULGm
         srIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qlf5oC7nbFp7JFcEvQgRc08GVWjJu27OOp/51PqPx9U=;
        b=69HtPJmr0oA+nrwl9/gZp5tyKlesvmN7f3PqEBAlCoVrmGUjc7esKJ0vfQuSKXX4Fs
         bCT7xlRY9XSO8RqvvUg5lI87c6BQsHysn0+vuHmYtFtwZmiwJ3CYPQL0P9+XY8S1dcFW
         NsCLH3fC95S0M+f5O7ODetwAS7giB7FzTHYd72vBHvfsdHhi1G4bN8GEhkhS+QF518Jz
         iG4QZV1y7zLGQkv6JwaVxiEaxtAkLC2PwfbXKgCTJ4emGz1TWMHpiT7vT8KDifuA1Y/c
         R2iQiXEG47X/1RDRwnnB0UxRcYeIEOGfkLIU6g86p9vpBYvzTD1O3xeEchOJQHxwxPaL
         Hzjw==
X-Gm-Message-State: AOAM532iFEo3TALa2QwJQdgPE1LYidrF+8sAw6M1ut2RZDYAWKWMv0U2
        W2gxq6xWbWoJOtiIvOVAgQskB582tWw=
X-Google-Smtp-Source: ABdhPJyqd18E8y7p3aVlXcJT6MwhP1zFwQOyM+vhqjcHvicb+ZVnvRptOubC0gPwmkqyivxOYcHYhg==
X-Received: by 2002:a17:902:b10f:b0:161:f196:b4e with SMTP id q15-20020a170902b10f00b00161f1960b4emr18689551plr.134.1653343983492;
        Mon, 23 May 2022 15:13:03 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ce25:f34f:c90d:61fa])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b0016194c1df58sm5621147plf.105.2022.05.23.15.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 15:13:02 -0700 (PDT)
Date:   Mon, 23 May 2022 15:13:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: mtk-pmic-keys - allow compiling with COMPILE_TEST
Message-ID: <YowG7BVsJTNd0ELi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no hard architecture dependencies in the driver, so to improve
compile test coverage let's enable the driver when COMPILE_TEST is
selected.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4ea79db8f134..a20ee693b22b 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -795,7 +795,7 @@ config KEYBOARD_MT6779
 
 config KEYBOARD_MTK_PMIC
 	tristate "MediaTek PMIC keys support"
-	depends on MFD_MT6397
+	depends on MFD_MT6397 || COMPILE_TEST
 	help
 	  Say Y here if you want to use the pmic keys (powerkey/homekey).
 
-- 
2.36.1.124.g0e6072fb45-goog


-- 
Dmitry
