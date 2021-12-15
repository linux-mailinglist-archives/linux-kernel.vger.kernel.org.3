Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A3475256
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbhLOF7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhLOF7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:59:22 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2717CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:59:22 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id f20so20796954qtb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGyV/tEc1kQ5qnhdjJ7JGN2JxWPU/d/MVobn7v35k8s=;
        b=Q4xlGDAf2TvJf+yvytF7/9ML42IWMY81J+skLMcQzSeoIEClNOqOIEEzjyV/vTQKuD
         hz+g6KSDXgLQy/Rzzi0kvy9lK4wa+dZe/SR+PKbG3DDsE4dVjGrPU6D5r4dtdYfT8jY9
         CDSVKAh7UNbKbsclItAJDQ7870ERcqdPDvFHPlRmI8QJaZAvFEu8CzfSm0V5Tz98gzgM
         q3qZ22pB4L+KWdfeR8Y7anmm488cN994XTbXnsZ7rU1vKJdb2NqLXTdgUbOvKtAuxfnc
         Jbq+mirJIlGoRcWGXwOSkow1gpLRPPF9irU9CTlTtyiji6WOismbrkandiKm25KgM/a+
         gPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGyV/tEc1kQ5qnhdjJ7JGN2JxWPU/d/MVobn7v35k8s=;
        b=SHNVz494uOeU81KgBy8zm+Edrr4mRODW1sy0kA7piuON6ihfqoYVH0G1bA4yn9xgUP
         WHcPQqnP3JQ+QwlCxG8nbHibGicGeD9dheaXMnuBdTkr745en/7+b2ScEF2tD1ow3Dap
         f8TUZDHqh9fZRPEOIVoGzk1r5DJd5V02emCfeEYMhl9Kwcj9lid86ZzJPyJ2JC39N9F9
         PhWn19oU0tY+/jNFlu14gMxXIbyV5vyqxj++3D/9Iu253kqqfmhMhlbnGYqPJiO0jIyD
         wXjiNMc8QQ4+J+BaxrLtzULMnOwo7zKBUQtZtG5zCK1vqimn4ykvBdsKoLZ91IjNwyTI
         ePJQ==
X-Gm-Message-State: AOAM532DQRdvHisvJRfQB7hSMv7x4xBEydunQ94OQCHIChLlQgwcOiFd
        xUgFhfn5qHyGzXvtJaIIgWI=
X-Google-Smtp-Source: ABdhPJx+PZvh0lBMTq0uazX7/lKZ7eA7azta6hIdvCT+HD3KGyT7aE5Yn/31lcyE0BPaS37xLG5bqA==
X-Received: by 2002:a05:622a:188c:: with SMTP id v12mr10296793qtc.618.1639547961365;
        Tue, 14 Dec 2021 21:59:21 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e20sm800934qty.14.2021.12.14.21.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 21:59:21 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     ebiederm@xmission.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH kernel-next] kernel: remove redundant result variable
Date:   Wed, 15 Dec 2021 05:59:13 +0000
Message-Id: <20211215055913.441464-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from kimage_add_entry() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 kernel/kexec_core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5a5d192a89ac..574391de1f83 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -561,23 +561,17 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
 static int kimage_set_destination(struct kimage *image,
 				   unsigned long destination)
 {
-	int result;
-
 	destination &= PAGE_MASK;
-	result = kimage_add_entry(image, destination | IND_DESTINATION);
 
-	return result;
+	return kimage_add_entry(image, destination | IND_DESTINATION);
 }
 
 
 static int kimage_add_page(struct kimage *image, unsigned long page)
 {
-	int result;
-
 	page &= PAGE_MASK;
-	result = kimage_add_entry(image, page | IND_SOURCE);
 
-	return result;
+	return kimage_add_entry(image, page | IND_SOURCE);
 }
 
 
-- 
2.25.1

