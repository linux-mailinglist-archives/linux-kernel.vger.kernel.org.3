Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D436483A62
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiADCA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiADCAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF79C061784;
        Mon,  3 Jan 2022 18:00:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v6so11318073wra.8;
        Mon, 03 Jan 2022 18:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYqakpFR2YauOJIseMjLHG8gpVRgifkK6MPT98zhKg4=;
        b=nUgQ4cgVwAjw5HfFzkBijX4vncjn5xrjqFg+K5Udz32kFb9ql43Z3+diu0OHwxX7hn
         4Ybvbpg4RwTJ9tXk1hIpVJ/n+HhyV/uS5PXUjbEp3nu8sdFIbsq74z0x4JV1egMFMxiD
         wLSAYaCutM3hTKsWCTLC+ETEFlvHoC8aqkBsWc4D7zhxIi3qTMBS55WfWoVJmGFR/1+y
         etRZbo2aGMNxUSMgOa0OfQhFVlx6xwLJUIj3zudutI8PWhzPf+l1zM/9JB3+wz4FEpPB
         jkMwiOMNcj0P/UZcl68QD4RHOFFt7C2XUVSAVUYy+qaxN2C5WnoxHlxuvkAP1Dwb/W35
         5ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYqakpFR2YauOJIseMjLHG8gpVRgifkK6MPT98zhKg4=;
        b=lsKVgCoU+MgZvy1Z+5Xf4pIFLPcOv9efj+zOL9VidajEfuatmPAdMwj9nMLCFDOQrm
         UuWEWu9t6EkkEaDtYyYqlmqKofqL1Rrh9esTnlZzXc7sZLzUaurVDuMoMdjWghrbUizS
         owlr21+GB/JACHceHnJivkup85H4ONtLHKXJlMN0fIjH/dgJFX02dnsiA6whMKNUVMZY
         AzxSCEUYP9UceNT8QYpUFijwQxrKivlpWHcIX+6j24j0lZY+eCAu93oU9e1xmEmk4MAR
         v6AVF2LcKf0fv2QK/AAsgGnAJkZWebv94ErKM8aarwNimg4oFbNYnYUOwpBTW4U5AvwK
         KScw==
X-Gm-Message-State: AOAM531lvaZ7jlbRWkN1t9zCiF5+9DhVCFXTTiFiSnJYBjG0gWazO1Vr
        XYcaDFO9DArW24RusXB5NsqNGqWVXJg2Lw==
X-Google-Smtp-Source: ABdhPJwUWPWWgg4yTYGvLqw7NqKyUcpgRKvf81FPw+MFhcbYcWS9tHxYqHvWVFoYo+UsUS5x04dWDQ==
X-Received: by 2002:adf:ee47:: with SMTP id w7mr40099223wro.368.1641261607245;
        Mon, 03 Jan 2022 18:00:07 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:06 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] scripts: kernel-doc: Translate the "Other parameters" subsection of OPTIONS
Date:   Tue,  4 Jan 2022 02:59:40 +0100
Message-Id: <20220104015946.529524-10-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notes:
- The -help token is added.
- The entries are sorted alphbetically.

* Transform documentation into POD (9/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c46d4b9afef2..33e7923683a0 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,11 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Other parameters:
-  -v			Verbose output, more warnings and other information.
-  -h			Print this help.
-  -Werror		Treat warnings as errors.
-
 EOF
     print $message;
     exit 1;
@@ -2628,4 +2623,22 @@ Enable output of #define LINENO lines.
 
 =back
 
+=head2 Other parameters:
+
+=over 8
+
+=item -h, -help
+
+Print this help.
+
+=item -v
+
+Verbose output, more warnings and other information.
+
+=item -Werror
+
+Treat warnings as errors.
+
+=back
+
 =cut
-- 
2.30.2

