Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7944733B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbhLMSLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbhLMSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:43 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so12151118wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anky/pj7/rcmax3ozqQQ2mqz0Ex4H2mV+LKwnahctPA=;
        b=C6Ksw4ZmqTccE99SjXGbEk3og3sAvMwKdQENu5l4qeq7vt6NrZtM6kQqobQj3FClPk
         eqg8aPYhegvZ2AsO/kk9ZcV21cX4u4pXU3Os7anXkoFvbMpLzkcIiM15QX6ynmQxs+mX
         vNHTXSgz2G7rNm2L/tnwB9qI4k7MPYLHBG7J+ay5J6+i7LuXAV1T/Z6pkbHYdW8xQace
         +kX1SxObYd1bmM7Oo1ikya0GqneMIquWMPoVvDCC6NnMZwfaIAfHVg37jwrJC+GfED89
         PXQKql2/LqJs2Sp/kGnZq3aY8MVyCLPRM7H/AtEjAHtSZlYay/EgwpY2umLjCSpuXRcz
         uHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anky/pj7/rcmax3ozqQQ2mqz0Ex4H2mV+LKwnahctPA=;
        b=bBp6HuD8Yq/vo7+gt+e8WQbYRDt6BzQt/K4vPnoFSizRTKhERV24T1ERdVr/4wOpFX
         +hMJC4cANCbKi3uADQ+t8r09HXPjiGyfHp1CQCHx4C5Irx3/kXej4qbW6sMi6eLYGk74
         kBtBy3jpmaBOFxZDBKN0cBGO8/tSM4zYypOoLq1jkH58++4JOzueeMABITElwmP+DzGy
         jf6PYSvr9/vLiqcec/r1bQjEHU71YSmmyjvgYh950Y/4CGQDbarGdwqG5nFkMYOP+/9Q
         CzXR5UdbFr8k+iGcEcApOzZFUfDHoGF/LS5DtCnNLjVHSlIoST/11NXvubHlN9KXcE0w
         K9qg==
X-Gm-Message-State: AOAM531+/i32/oplLn2/bsozsnNgmrkWtNmd/tkmUCpYwTNY03BXCwMB
        Weples2rImXUqRjG6JM6WNw=
X-Google-Smtp-Source: ABdhPJyoyFlW4lEPr6DsCtti6saUfqve3Q+d0k+LKKOlrYyVg9C0Nr+BYqJy0BUwrdTzoJLvxrMYxA==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr321247wme.72.1639419101745;
        Mon, 13 Dec 2021 10:11:41 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id t127sm8750956wma.9.2021.12.13.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:11:41 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     rodrigosiqueiramelo@gmail.com
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/3] drm/vkms: drop "Multiple overlay planes" TODO
Date:   Mon, 13 Dec 2021 19:11:31 +0100
Message-Id: <20211213181131.17223-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213181131.17223-1-jose.exposito89@gmail.com>
References: <20211213181131.17223-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

