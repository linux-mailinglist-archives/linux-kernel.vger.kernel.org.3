Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C48646B354
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhLGHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhLGHGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:06:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E739C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:03:23 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id l5so379480ilv.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Pr8P3RG5fy/v/v5/oxEglTrLEfbK/m2I7KoCjfpq8Sg=;
        b=bcm4x1SYp7OA0me7wGyefPOmvKEs3VLA2i1vAPf/ObhzRN37X1c/yx2Gq3IohXb7I9
         geTAvdhJAIAYIbmrGTPNA4M/46h7V3yVqH7h1M+60NOuuvei7K+FXAMJ3ju5K+h6h+di
         QG+jcRHt56C4v6lZ/H4MRuEnfPBkHPV1hg8Ga+TO5YbSWPXKiWvYZGDD/2VZAVIpWc4Z
         9Q/zepS48qAeswXA9k86HnmSjElm+XkYFhmRIiEhL/G0bktc5qu3R3m3xyUlWpkdmqTj
         j9L+yxN+ejOrgk9Tt45KJ5uWwL8FfC2oONMCrgqfUtTuEwxd2vgP9jvJA1JmPg4WagOb
         4nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Pr8P3RG5fy/v/v5/oxEglTrLEfbK/m2I7KoCjfpq8Sg=;
        b=1zQZ0zOrGOGNJ0XVqAXOE2JcfOZZCJEE4kSvwTX8gndn68NsnHxMPcIzyaWP+z9Uws
         yAoGx8X4dvK6uE0Z26yr6R1dbw6TBD9j8N0ZWbpzN93blbBAJ6pNZwXm2yCXMllFd4rf
         SBR38Kz7JUFQR4NnmxGkaDN4QD62XJPATVbtsK0+F6IF23xDG6rh/WzdfwubqJlazWHt
         T5pB1StrM0cIiwhwQQbsSf2x2SfLm/dOOKfVrUR/aWy+Q1vACsDIXA8lkjjzeOCwYCHc
         tOscr3JHzjY6XCZ2sbfy4h+TozNNIc2OQEOrBWYGhH+ZTPdzcoklaYeTlHAaDzoDvRKT
         YBFg==
X-Gm-Message-State: AOAM533Y8m/s8WDJm9i/nwgSPQVl0EllEl1OCXIUoS4A5dmBOuIiuzMH
        fKe3nEM1xeaJVMdRB9vUiNb5qgWbi6o//wEOleQ3lF2XVRU=
X-Google-Smtp-Source: ABdhPJzlgFVVCs5hbC35Skm/1P/e2tQeYTO+oFh9NJolh/i19q5pPu3gSE4ipSzrdwfcNj6vX9tlNjOEE3W2xk0Y2BU=
X-Received: by 2002:a92:3013:: with SMTP id x19mr15771289ile.113.1638860598774;
 Mon, 06 Dec 2021 23:03:18 -0800 (PST)
MIME-Version: 1.0
From:   Jangwoong Kim <6812skiii@gmail.com>
Date:   Tue, 7 Dec 2021 16:03:11 +0900
Message-ID: <CAF=mnpiEGXemtEEo_fbJ1pkfwZaaZNo9HPGKG5EZ1voaPqRaWA@mail.gmail.com>
Subject: [PATCH v3] futex: Fix a faulty comment.
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jangwoong Kim <6812skiii@gmail.com>

Clarify that "woken" saves the last index of futex awoken.

v2 patch had a typo (awaken -> awoken).

Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
---
 kernel/futex/waitwake.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 4ce0923f1ce3..45d634dacfcb 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -454,9 +454,9 @@ static int futex_wait_multiple_setup(struct
futex_vector *vs, int count, int *wo
                __set_current_state(TASK_RUNNING);

                /*
-                * Even if something went wrong, if we find out that a futex
-                * was woken, we don't return error and return this index to
-                * userspace
+                * Even if something went wrong, if we find out that any futex
+                * was woken, we don't return error and return the last index
+                * of futex awoken to userspace
                 */
                *woken = unqueue_multiple(vs, i);
                if (*woken >= 0)
--
2.25.1
