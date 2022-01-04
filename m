Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27723483A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiADCAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiADCAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:14 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E3BC0617A1;
        Mon,  3 Jan 2022 18:00:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j18so73041146wrd.2;
        Mon, 03 Jan 2022 18:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuzntP1U4quOJkZ2JAisD9olh8sECglpZxZHObJrdk4=;
        b=CoyAtFh/CfpNkb/WGr+Cz7UFFKBs3s7vP+gw9aFnHOHfnN4/M4ikIz4DxRvVTiE6Qz
         +baMdqreWcnunMqIyD2qZZ+UpgbOWvBEn77kcJk3UWrJj4mpoRy/D+rn5kW/lu51dDrY
         4bYFCtW90IWDuMQf7sMb5orIlw82t1/q8JqKViBirKEg7+Isu30dIA2JTZ4lsI50NxtM
         WdWmva7+64PHy800Pd7xRtoRPKN5MBKBMbzCx4kRpIvoV1UEm0Sz4/uUgNaDGDuAoJe0
         WMMFHL9BcBjoEAg1qrtpNFyHBVvbNf5ZY8wG9Jf1zJTfF44TzZ0TxQ3PUQeX4xgszN1o
         MVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuzntP1U4quOJkZ2JAisD9olh8sECglpZxZHObJrdk4=;
        b=au6AEajUqIZS7PpZTbKbN+eqd8TMm9AVS9WgVW5KtgYbJr0tNd40OAw9pz3gpNk0vO
         dEl6nTwG/kSXu3IdQWDMFYeKqu2a8ij39bE75i8hUaNSIVXt6Iq6Yj/Zh8sOm3gFKeCI
         kxdZIyttUxGjzyzDjMMfECwYpVw+x3D0EbBUpGVnopmYAFYPQ1ujRFFtQ3KgpSfDWSnX
         dQVyzDY3QAjhE2RkSLjX26UaiWwVlr0UkQCrXWJ7CsZRkpFqtBXZ6DI2Q0KQ5x14jVXF
         B02Zb2lAizsZehK94z21E6vRjBidtp2VYIT/pe3YMYZ5Y53VAJfNmSM3MLo2SaAecjFT
         deJw==
X-Gm-Message-State: AOAM532pcaYTP4IwP0GGNLO90XGGAgxZr4MJvm6cI7XIY+KKdO+4+qrR
        ojMH7ImxXQ4i5XjHv37NJ8g=
X-Google-Smtp-Source: ABdhPJzHkgYYeXEL3k+bw6r/5h/pLBwAw7ryZHVIgaHqjgAozpXHYqt4eDy3SVoqLzTGwkOKSjsBiA==
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr39642223wri.704.1641261612494;
        Mon, 03 Jan 2022 18:00:12 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:12 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] scripts: kernel-doc: Move the TODOs
Date:   Tue,  4 Jan 2022 02:59:46 +0100
Message-Id: <20220104015946.529524-16-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier I thought I could take "add perldoc documentation" off
of this list. Now I think it also means a self-documentation.
And this is not even started.

I'm putting this block by the end, where it can quietly evolve.

* Transform documentation into POD (15/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index dd5801cad519..b9f381f0fc1b 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -53,10 +53,6 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 
 # more perldoc at the end of the file
 
-# Still to do:
-# 	- add perldoc documentation
-# 	- Look more closely at some of the scarier bits :)
-
 ## init lots of data
 
 my $errors = 0;
@@ -2497,6 +2493,11 @@ Treat warnings as errors.
 
 =cut
 
+TODO
+
+- add perldoc documentation
+- Look more closely at some of the scarier bits :)
+
 PRE-GIT MUSEUM
 
 Original formatting preserved for its historical value.
-- 
2.30.2

