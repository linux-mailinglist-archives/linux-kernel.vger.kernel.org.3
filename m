Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF2749081F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiAQMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbiAQMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:03:20 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ACCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:03:19 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id q14so18878798qtx.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RpBYlGXPbFap4L5TKbbvLbdLjwtLkqOYr6EFFOxVE/Y=;
        b=pHwL9CRahjNqVfc0BFZjlpoHk+89UbT1NZklYv6ILJXL4yMZ8Y18ZzIbhZ7e/5rG28
         Cva/2bk/t+FAWTGnHgJdUoR2SAMpvncd2wPwhwgL7etUY53CLrY6O53WW1yhuS++je+Z
         3G1QU5JcYTy5hTiIbVPaNvX6S5OUHSFe/rRjMWKhu2HY9QkTDYnIotx+DQG5lI5ZS2wL
         2c6AyPmJzOzeobLpuUTUbhFHgZPS1X+hKAenebO5dD/MHbIl4YAAF/9HA290aR8opW3U
         Wy1EMShzG1kdMdBSWvlJyf46T79YrCP+PzHgw6LLyFWqVQ8tgUL5s+R3bHrsF3KvkFnM
         qWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RpBYlGXPbFap4L5TKbbvLbdLjwtLkqOYr6EFFOxVE/Y=;
        b=hUIExxaxeXdGllzygOA055GuFGHv14qbkroYcBtp3IXd+lNoPYQNpunPpAEN1g2Gcq
         46Ei74FyeXCV9LKSWtajzKHmFiDtbN2gj1JvN1GUwJrBubqpXCz2SA+iov3QyhZcfN4G
         uuasqvdivGZ/SByNPKK+sZnObMNWS7cnDu6csFZzxZ2akWh0OSAhL3zC/Qf0MhVyiSmd
         HamQ4hpvHawitHbwgM0+I6e9F0xs0PEeVjG11hSAG+tWiWPySBErGuF3ilP2xSc9alXZ
         T293mGHLXPvlqPD0KBC1s/BS8kVR9SGqp0f9k+OKTjNU6eYTinCHeFz9gZN7CXi81OFJ
         v/uw==
X-Gm-Message-State: AOAM531X1WPRamccGjptekw43fb4wI1NqPj42a/35Nh020LGQIElMUPu
        ugkw5PWfrNiNlStVRlPURpGqFg==
X-Google-Smtp-Source: ABdhPJyTMpcEPdjddJeMxLEqzrsSDwKgwcN/qO9pxpAeN7iKOaPQRaGXCNvN+pzLaqqULFDznJuE6A==
X-Received: by 2002:ac8:5cc9:: with SMTP id s9mr16803216qta.397.1642420998371;
        Mon, 17 Jan 2022 04:03:18 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id y17sm995746qtw.0.2022.01.17.04.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 04:03:17 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add Suren as psi co-maintainer
Date:   Mon, 17 Jan 2022 07:03:17 -0500
Message-Id: <20220117120317.1581315-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suren wrote the poll() interface, which is a significant part of the
psi code and represents a large user of psi itself (Android). It's a
good idea to have him look at psi patches as well, and it's good to
have two people following things in case one of us is traveling.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc4a1370ef1b..e2b548f00acf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15457,6 +15457,7 @@ F:	drivers/net/ppp/pptp.c
 
 PRESSURE STALL INFORMATION (PSI)
 M:	Johannes Weiner <hannes@cmpxchg.org>
+M:	Suren Baghdasaryan <surenb@google.com>
 S:	Maintained
 F:	include/linux/psi*
 F:	kernel/sched/psi.c
-- 
2.34.1

