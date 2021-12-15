Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A49476181
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344186AbhLOTSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbhLOTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:18:44 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D34C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:18:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k64so21527000pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VieVwmJcTaouBAsZhAsLWT8FWFzWmhNzhs/0LCf2Xx8=;
        b=KQaP77Z+T21lpkRzYHOY7GZ/71aDT9EktseQSiMaEH9b+P4R0mI2rGqJnngOMkV4LE
         reYdKLoKmY+elWRlEYuAsKwhmqlAWSpG8F//YwDK3SotHgql2TdIMryDryexH1gu6W8H
         mVRX2dwj9+pMUUFwXt2FB4euWVVJ7oupjoZ/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VieVwmJcTaouBAsZhAsLWT8FWFzWmhNzhs/0LCf2Xx8=;
        b=Sl2sK36lSHdqfKdG2hwg9So6yBf5u26IxhWy+WO7ulu0N8BiNiGuwOhLpjHzJlmE3s
         nzD68PQNJWu0Xiv0S3SdwB7s14evNCvRWgwJiauLqGX75CHBgjCiu17xgWKEHRUwH/02
         +WzFwrBGpn8jeqTA02hoMLW6NCGEdxtU0MlG7IJqaSqgBdBeGms1RS6hqaNVEakjTpt6
         SKwK+DAaYGWS4fI9ChwGwAZmvlVzE9ecIt0jgXBg1I6/5uHcsn2m/wdiO0ClDoHmqXMW
         WHAfC1plEpuSHywNbzGjmbDyj/ImjjG/Aoxb75RTwqBYEpu+kFG3hnqWHhS4YhkS4r15
         HgkQ==
X-Gm-Message-State: AOAM531f8H7wVZpjS0Xbk5kdYoi0kVW4yasXQ5Hgj6WM60m7vvfb+3s7
        Y08q95ptSL8ImnNV6st8w1QlHQ==
X-Google-Smtp-Source: ABdhPJyIK/MXWr+ArcoWEok+Ed+yI2nihs7NoVe0mWxmf0ySNM0hCdkshrKHX/ewdub/9B6BOpExkQ==
X-Received: by 2002:a63:c155:: with SMTP id p21mr8792730pgi.156.1639595924042;
        Wed, 15 Dec 2021 11:18:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g1sm2953110pgm.23.2021.12.15.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:18:43 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        James Morse <james.morse@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Fuad Tabba <tabba@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: Drop outdated links in comments
Date:   Wed, 15 Dec 2021 11:18:35 -0800
Message-Id: <20211215191835.1420010-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; h=from:subject; bh=DfZ3UnHsFmsw/4N8X7tFFfoiorSVEgqutHFHjXlqRJY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhuj+KVHSRvnQNmxzGq7Cmwjvi8uBXKualoCmCG7Ac MP2cEAmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbo/igAKCRCJcvTf3G3AJv2CD/ 44aCLWGwalwPUI9Jx/X4oqTA953MfMh2ACDgiXMyTKaavdqYutq4t3u9evp4kTyes2fWCViJNr1Ryk jkWtykGccTM6X7LYuoNrd0jpHmr3k1xS1x/WCbvSMLOgjOwaYnalVNxYeYiIMak8zWPliYc9fbMKcA 098B3X9xpr9m6tAVxWwrCabG5z59wgz5oVI38eSEBZOrfWqPbaU1q+4X2KUrQ7XOCi+YKomxzW2rIA eHLyBsAfTcHx+svY35yGVLKpseFzzXf38R4dKSm6Xfej6K2qEhM5jU3NQKKOS77PU89f7r0bWV3QRz iFitrhpqNVxdWGaH8WWRlBk+1iyZ0zZ+P4KUDIBBVObM9+ZS/GaNdUND/GA6xc/AG2e6RYBfbpbWVY Z9I+rmSsnZe2ND8BzibY5tDhxh6uh0Gnn2lcdwWBiSa+G95Oqz71Nsw64gRWYmZUXLqc1i3iZra6kP egFxvIrs9aKxO6SU6onpy/IMt037DRFJac+8Smct8Big7KM5gxta+aILrxjW898E7BP5bNRK3na/4p RBtXnajjSt2RoaT/WY0Judgkvqj0rYd54Jq9csl6R7zxhWPSf2yAH7elswm2XIxVp+yBoqG0P27eHS oCL2XwFdlH8WDxkY9hUXTzgupa+WdZ3BPBRIly8+OhGh9WRi3o8z1dcV3izw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org links
with lore"), an effort was made to replace lkml.org links with lore to
better use a single source that's more likely to stay available long-term.
However, it seems these links don't offer much value here, so just
remove them entirely.

Cc: Joe Perches <joe@perches.com>
Suggested-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/lkml/20210211100213.GA29813@willie-the-truck/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/hibernate.c   | 4 ----
 arch/arm64/kernel/hibernate.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
index 2373020af965..2c1f290342e4 100644
--- a/arch/arm/kernel/hibernate.c
+++ b/arch/arm/kernel/hibernate.c
@@ -7,10 +7,6 @@
  * Ubuntu project, hibernation support for mach-dove
  * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
  * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
- *  https://lkml.org/lkml/2010/6/18/4
- *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
- *  https://patchwork.kernel.org/patch/96442/
- *
  * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
  */
 
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 2758f75d6809..6328308be272 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -7,10 +7,6 @@
  * Ubuntu project, hibernation support for mach-dove
  * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
  * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
- *  https://lkml.org/lkml/2010/6/18/4
- *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
- *  https://patchwork.kernel.org/patch/96442/
- *
  * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
  */
 #define pr_fmt(x) "hibernate: " x
-- 
2.30.2

