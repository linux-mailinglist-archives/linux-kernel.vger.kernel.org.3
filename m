Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034F6487BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348676AbiAGSCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbiAGSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:02:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2784FC06173E;
        Fri,  7 Jan 2022 10:02:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w20so12522510wra.9;
        Fri, 07 Jan 2022 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YAopufrfMZ51IGtrg3jTbLpMge5spZgYt27uOrZnXBA=;
        b=TraUtI5RVcXWtWTIjSiw3vhiP+xVKrVen0TTg3S6WOZZadQeV/I9gKp0ErVnV5X7NB
         udlB60AKz5HaagNq/WOQYUbNk5E1wvbXIYXRyK9+8mFwKFqRVy3KXioQEBkpxvm3vap1
         6lg+OnWERGHE+B96SI0B31iPMdFj+zCY5oGnGbmw0jXqssKsydD5rkAvv0IJWxLFuXTJ
         P44hgMKJu8zsnwjSeB7EbgXMWzcPjoZn9w6Aoib0tyZOtrCAQhjBHl3HhfxrEnAQGApZ
         0FFDY4fsn/p0J7m5D0gONllJjyzeYKQ3qBZXVERzjbrxL8/hRuyQm7+wgKe0DSVwuyCl
         XHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YAopufrfMZ51IGtrg3jTbLpMge5spZgYt27uOrZnXBA=;
        b=7OEf619EgHtH45bEaKg7XwLVQ2q2/RV3JuX+seh4PKLTld4FBpcItaJ2RL/p5KtvWm
         sa7UeoYjpZ/Znrxwqqfil6IxAorJ53pf4U7wMzzJ48kPMhTnGkObL7ULj0DLI/B+VI+o
         MtDJlVMR1H6zJmN83SqSMeLDkfTB87fg/xt/EQmhisJwJZBRZTeB66F/7DDmyII23PFP
         RjpmL7+ha1XgVdU/9Ab+xBznyuxOUEM1yPHIo0NhynwFokSrnO3YY0sPsd6nDI2ENOLL
         dQXT4rYhEC3t11nVdtmCo1gkMCxlyd7g0vdb9w0625whC+UHsOY4h+RYQlafMIuKS9vl
         V82w==
X-Gm-Message-State: AOAM532re63l7iId37B+cvaV7vtNFTQqyRvMEOLdwn/5Mtcnjq6EeA9+
        kvLZjvQoGZLeMAng/r0ysY4=
X-Google-Smtp-Source: ABdhPJzertBGoCCYZjM0BZgTRmAr5XsP7j92armg0TkxwVJ3M5CFmVwZ8SawLXy6vxtw2ghzKLh1Og==
X-Received: by 2002:a05:6000:1e15:: with SMTP id bj21mr10622402wrb.118.1641578559742;
        Fri, 07 Jan 2022 10:02:39 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id c11sm10131449wmq.48.2022.01.07.10.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:02:39 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RESEND] drm/doc: Fix TTM acronym
Date:   Fri,  7 Jan 2022 19:02:30 +0100
Message-Id: <20220107180230.132666-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TTM acronym is defined for the first time in the documentation as
"Translation Table Maps". Afterwards, "Translation Table Manager" is
used as definition.

Fix the first definition to avoid confusion.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/drm-mm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index e0538083a2c0..198bcc1affa1 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -8,7 +8,7 @@ the very dynamic nature of many of that data, managing graphics memory
 efficiently is thus crucial for the graphics stack and plays a central
 role in the DRM infrastructure.
 
-The DRM core includes two memory managers, namely Translation Table Maps
+The DRM core includes two memory managers, namely Translation Table Manager
 (TTM) and Graphics Execution Manager (GEM). TTM was the first DRM memory
 manager to be developed and tried to be a one-size-fits-them all
 solution. It provides a single userspace API to accommodate the need of
-- 
2.25.1

