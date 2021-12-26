Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24C547F672
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhLZKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 05:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhLZKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 05:41:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE82C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 02:41:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j18so26375243wrd.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 02:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urda7dukOjrduEUTaGt81lKPi62bFg/eZfAHEnqnCIg=;
        b=IVgjJdfFI9JqBDqtDgFrsG6mMMuXOo5LT4CXf8uYQJMP+1UJEIkW+KtT7i23EW/Q1Q
         wksPThVgIYPfVRKc3etd1TntgDQ/HqR+LfkMVuDnuU79OIRUCEiWw22TT91cvY86HVFv
         0D19oVPZZfNxQWWWow5EOYqb1NnRhhUGCufvlyO9iNrmQ4jvsEZDUsu3A6yeT0n2CjZX
         mE0cAQsKXVljzX0/+zKj9n06NR2JIGQQ+ESM3dFfFQeFi1Ue/9JgpFhFtUXTF4xjUiXd
         vQsuXEK/dXWZd94Yd8uI0k8ridXIgutOqUGjCFCL7KczAnsXe1gsUo+bwYNc7cz7HzUN
         1CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urda7dukOjrduEUTaGt81lKPi62bFg/eZfAHEnqnCIg=;
        b=PeQD5twfyUZhkira8cFMOVMxcFlHU9zL482e/LVaH1w5wdgnRZWj5DPhsbVX2OYL+S
         6CILSzSWDGX7F4ITvbxR+lI1sBc4Q7BC/midBZgt7hetqSmfCtLz+41v6usGUEZ1DmA4
         ZLRCxeEBfXfp1okm100oRNQdB2v+CNHL5pIswSuILh0sKVG0clA74ih4hIPORUl2MtVH
         aOCS2ahTh5z/Djycqnp/OIuLEz3536ajwycVlfR/R7fmFluz4ye5G5NZFE2fbpEqq9zC
         l6jak9MYIYUOc9yPY0q8G8Cwitoq+YnLeEDxytMGL5Ob+L6V/8kfyiS0TOwe+Vpa5t9A
         jIrA==
X-Gm-Message-State: AOAM531LkfP812UlhFQ1FP7bMqAjScd4ZDNGHNMvr/1fOQMn0vcYjJIg
        bzN2nMKgKceqESt+SgXmnaw=
X-Google-Smtp-Source: ABdhPJxMy8Ln4GlG/YF/pknetTJtI5gnctb6Y9F66+nXLcd6KQuxdSnO6R2xu8qF87P9acttOBLUeA==
X-Received: by 2002:a05:6000:1845:: with SMTP id c5mr9396461wri.499.1640515272517;
        Sun, 26 Dec 2021 02:41:12 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g9sm12592729wmq.22.2021.12.26.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 02:41:12 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     melissa.srw@gmail.com
Cc:     mwen@igalia.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 3/3] drm/vkms: drop "Multiple overlay planes" TODO
Date:   Sun, 26 Dec 2021 11:40:59 +0100
Message-Id: <20211226104059.11265-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211226104059.11265-1-jose.exposito89@gmail.com>
References: <20211226104059.11265-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the task from the TODO list.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 941f0e7e5eef..9c873c3912cc 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -124,8 +124,6 @@ Add Plane Features
 
 There's lots of plane features we could add support for:
 
-- Multiple overlay planes. [Good to get started]
-
 - Clearing primary plane: clear primary plane before plane composition (at the
   start) for correctness of pixel blend ops. It also guarantees alpha channel
   is cleared in the target buffer for stable crc. [Good to get started]
-- 
2.25.1

