Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82477483A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiADCAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiADCAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEE4C061761;
        Mon,  3 Jan 2022 18:00:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so678215wme.4;
        Mon, 03 Jan 2022 18:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSfgUsvhrjJaj+G06o0Ido86WeZkW3i/4hxs0h3tr6E=;
        b=CCCgJTZN3rtxZIHNytt4bl8ONJ/DZs2q8wXMlQRKuNULK8O0fRiBzfEGgsHG7AizTL
         mDosvpqXEywar4Csc1yZ6s+wg/ELCy6bxLasavU2AK5oA7J33QxkslWQgHQpsoKb9LLU
         nBu5KZ2EBET7TrN7fwJAn0Ca+u557ksK519umuCMM/EDjRd4zbDs7hQ4gd6B/TmzCzsC
         WD8S4HWmCp51uk6UaUtvZNR7nA5PqtDsp+hkNpyS4d3UQfQ+/HARtezz3swrs35hPgXQ
         Yr2ZEp00hnp5mDd4oRxQ+mSBYguKHBsbjGQDA9ZQWrKAft07xmoFE+qL/d3rwP7pe/F6
         CDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSfgUsvhrjJaj+G06o0Ido86WeZkW3i/4hxs0h3tr6E=;
        b=zmxQr8eKERyGjoVzI7SEiUGytIiDNO5PVLa/1AIDgXwR/7Vf/fTEJW5LSs0NrdYADD
         JS0PTxyde72xFZEnXXk7nY9Hw+MB2WJ5jlpYF8WIHix27nibEf8T8ANj1BBkQJHQ44Ni
         ZEr5/CXoxHHyxhn9hDqPnDn3PaVCM5kBG22iAtamK/X/NEl+xVoLcgVul/rINK9QVOY6
         MK6uuKtEMy+UvbYTR52HVd51cSiz68G04O+DCBgWN7N1xrpr8zuVYDLN8EHRUdCaDg+Y
         Ll1NhGFMK6yt4sV/u5unUFjRT9xMmQienXO/+k8Z6G1Ll2I0Y+DQeG1RCK+bW+nQhZY2
         RQKw==
X-Gm-Message-State: AOAM5305EcopFpPOYvJWXel/dFGRJbuF1PNpsom8NV82WMCDZWuIsUdg
        TH1yzhr5eaiD2yg2P3DejrW2u0vSGwpR/w==
X-Google-Smtp-Source: ABdhPJz5KcmJIUAqPsM4oWJNIuwJSHwY9vQhpRSr7WP7t+0hVLZ26QiK4awWz2AGcFcw7Rd4pwxibA==
X-Received: by 2002:a05:600c:4fcc:: with SMTP id o12mr39733215wmq.184.1641261604570;
        Mon, 03 Jan 2022 18:00:04 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:04 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/15] scripts: kernel-doc: Translate the "Output format selection modifier" subsection of OPTIONS
Date:   Tue,  4 Jan 2022 02:59:37 +0100
Message-Id: <20220104015946.529524-7-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This section is renamed to "Output format modifiers" to make it simple.

To make it even more simple, a subsection is added:
"reStructuredText only".

Other notes:
- paragraphing correction
- article correction

* Transform documentation into POD (6/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 8213399fd7ec..f26966dd8bde 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,13 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output format selection modifier (affects only ReST output):
-
-  -sphinx-version	Use the ReST C domain dialect compatible with an
-			specific Sphinx Version.
-			If not specified, kernel-doc will auto-detect using
-			the sphinx-build version found on PATH.
-
 Output selection (mutually exclusive):
   -export		Only output documentation for symbols that have been
 			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
@@ -2583,4 +2576,19 @@ Do not output documentation, only warnings.
 
 =back
 
+=head2 Output format modifiers
+
+=head3 reStructuredText only
+
+=over 8
+
+=item -sphinx-version VERSION
+
+Use the ReST C domain dialect compatible with a specific Sphinx Version.
+
+If not specified, kernel-doc will auto-detect using the sphinx-build version
+found on PATH.
+
+=back
+
 =cut
-- 
2.30.2

