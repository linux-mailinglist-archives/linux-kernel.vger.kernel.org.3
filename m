Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C654EB283
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbiC2RPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiC2RPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:15:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F2D12ACE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:13:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso3549362pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3zC5IcKvUaDkpsn3lT4kTobWRQFTfTbuR/nGXChYGU=;
        b=R678Bg5FTHfY7McAdvtbX/XHHI3aoxyWhMQua1z2OXt/275slX+CHv6z/FtEyliJ7E
         hDVmlo2b1SLmGyvhfFSOoBTtgbtLWUCIzzlz1UAheKKOXXOXdeMCKkCla0lnrXyWWie8
         mEjB/JpvADVvZ26Nz/Ddp/Fq5Wn98iwRHLoiWSTeVUQN91uJMUJJeOcv/CBQdNzEN+qe
         SDeEggbo+eqivk5abJE1hyvAL+ydVvrgq9Zx2VaDGwZxUd53/+HaeXL74p2oklBzFAVr
         t7jYT24CTaY7HF8y31SLPilETeXrSVBOh8vIONoIT0Wy0o/ZdUN2RNR5h3SyfiB/0OCW
         BTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3zC5IcKvUaDkpsn3lT4kTobWRQFTfTbuR/nGXChYGU=;
        b=ql8gfbHWB54m0pns1X1hcoMf8pv7bai2Roj20ga5UeYAdl7dXq3RBZxkxIlvdNKOlx
         l+rctBnFBrgnEZ6N3/hCAVbXiufRbrQBYHOYkuWuQsi8+mh9wIynRds0UrwqmU/KNO5P
         r5NID+MmpEZUga047X/+RPm8ELL7B3G+6dj2U54CIx1Wb0l5C+5w97vDvQKXENggaicW
         rEDNeWI+4rRq5l7+DlNaBjseNePGD8h+aobaUoxFTxzzAg380AlAnB1t200EcKa7KczT
         mSTiaVC8Eo7ipoAKVGO1Dw34+rlhvdRj12h1Rd7vloW3M5QWMKYz+9uCGYTAHuSbLsdI
         DZVA==
X-Gm-Message-State: AOAM533JPgH9xnZ9lMh44+enELmn76vmtUPBJeAwIrkJ9rEwb+sNosKU
        9OH+u4rwV0zdKm8w81L+VdbOiw==
X-Google-Smtp-Source: ABdhPJzZK2VNETv8cU1z0g2xhCr/i2ujQOA5cvQXfC5a24/jAuD6J2boUfJhjoZ5YmRtn8yrC+KbfQ==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr32036112plo.113.1648573994369;
        Tue, 29 Mar 2022 10:13:14 -0700 (PDT)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id bt15-20020a056a00438f00b004fb6a6af05dsm6102633pfb.187.2022.03.29.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 10:13:13 -0700 (PDT)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Gustavo Silva <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        linux-kernel@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: [PATCH] uapi/linux/stddef.h: add include guards
Date:   Tue, 29 Mar 2022 10:12:52 -0700
Message-Id: <20220329171252.57279-1-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iclude guarde to uapi/linux/stddef.h to prevent
redefining macros.

Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 include/uapi/linux/stddef.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 3021ea25a284..7837ba4fe728 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_STDDEF_H
+#define _UAPI_LINUX_STDDEF_H
+
 #include <linux/compiler_types.h>
 
 #ifndef __always_inline
@@ -41,3 +44,4 @@
 		struct { } __empty_ ## NAME; \
 		TYPE NAME[]; \
 	}
+#endif
-- 
2.35.1

