Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CED5536BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiE1JOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiE1JOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 05:14:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084365FB0;
        Sat, 28 May 2022 02:14:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y1so6306188pfr.6;
        Sat, 28 May 2022 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2cmreXVkKeTuS3iLda3uDJCEUdvooYyM7QNARThfArQ=;
        b=VTRt1uLhMTgIvoICyNK1K4DvISkrJto6QUdz42wHaQhFckzhegvbpDenZo1DkDOsuP
         lECoEOynKmg/Ze93ddslExgRDFXN9ZEbbT1sN8I3ZE3dxVWd4hlEJojzEDtVC5S2ybDx
         O3M+kDI7BSFLOBRuRtDow343Wthn0enWane8a0D/6JK/s/DByaq1I/aGT/qZjQ7apeCh
         Ha8lnoT/XUfmfTN1KsCGh6lhI7O9pEP+07R/QL6uVc0mJWjbA7+kJsDHxnynuIKyVGN2
         THFWA0HQz1gfwdpeePJEmsooJz2NNv2A39aBeDwiGXjIAuwoq8++Fuw5S7FjQsgxaBM2
         fLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cmreXVkKeTuS3iLda3uDJCEUdvooYyM7QNARThfArQ=;
        b=I3zhliva6ngHBRPLd07FeJIx0YSD5BNEHZYkg16Y0IVNthuQlXrckA40YGWDy21CtI
         tGJ0UCAXkvsj1r1BHsMSEn54QPjdarr7makFXtI6Z5ZbokxIOWSIAYVxmT/0Ss2vX10X
         gzLo6l60K7YDramKWhGu9wQOCZyKjzCwRu9XGKiodYfmO2YpKqY0AMFy7w+5NH832gjH
         PxNxWGuW9oXFZSQ7taKN/JlGG1I/hKiPevA2LEkyC/LoWoGBCJgppYiTIYd6ipxe8AkC
         oR0JhxwWcI3ILk34XAVbN/q+WPFxQfd5Ux0fTXCOvOsUcCvy9US7vzMNsefHKJoOEbM5
         bdZg==
X-Gm-Message-State: AOAM533F6jXlcsiJZjCRJ8x5XB0nI9TyxkfC1xwQqIgltKwM2m3aDz8X
        UY9L3QHegzQYMvGNNeVUTtykz0iu+OzkSjbh
X-Google-Smtp-Source: ABdhPJxTZ3//L0+n/S1b5h79f4IEubXD+U1hWPngiQJyYJKXN7Cu3aGrFpYqFoZGccOa0dTRsa6SPA==
X-Received: by 2002:a05:6a00:15c5:b0:518:9848:4915 with SMTP id o5-20020a056a0015c500b0051898484915mr30768636pfu.62.1653729280076;
        Sat, 28 May 2022 02:14:40 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-83.three.co.id. [180.214.232.83])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b0016198062800sm5320179plg.161.2022.05.28.02.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 02:14:39 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        llvm@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: uclogic: add missing function name in uclogic_params_hid_dbg() kernel-doc comment
Date:   Sat, 28 May 2022 16:14:03 +0700
Message-Id: <20220528091403.160169-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220528091403.160169-1-bagasdotme@gmail.com>
References: <20220528091403.160169-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

uclogic_params_hid_dbg() is public void function. The comment for
kernel-doc, however, lack its function name on short description, thus
triggers "missing initial short description" warning.

Add the function name to fix the warning.

Fixes: a228809fa6f39c ("HID: uclogic: Move param printing to a function")
Cc: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "José Expósito" <jose.exposito89@gmail.com>
Cc: llvm@lists.linux.dev
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 71501453de12e4..0319e3f1527f1d 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -102,7 +102,7 @@ static void uclogic_params_frame_hid_dbg(
 }
 
 /**
- * Dump tablet interface parameters with hid_dbg().
+ * uclogic_params_hid_dbg - Dump tablet interface parameters with hid_dbg().
  *
  * @hdev:	The HID device the parameters describe.
  * @params:	The parameters to dump.
-- 
An old man doll... just what I always wanted! - Clara

