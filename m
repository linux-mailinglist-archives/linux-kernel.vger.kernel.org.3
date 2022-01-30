Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7CD4A3BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbiAaAAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiAaAAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:00:02 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A438C06173B;
        Sun, 30 Jan 2022 16:00:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u14so23316838lfo.11;
        Sun, 30 Jan 2022 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSRXr5ZF0nstHXuLDJqj0kP/ADj336Vx1akoatH/1f4=;
        b=QCaUpwAprGHXP3AkP+bziM+wqojb7xFEfUeDy/40PxRMK3ropDDtOFSrg4W2lpY1T4
         bkPat1SCKo4lpe/LlE9AzrraVql9QcJiHNjbijwxvT++r5B88TlqpjT04DbqNKKkHB1m
         CFaGZe6/9O1ahyR4fFvQ7TRtm8TLE6uotDhrplk+tFqbtLURgXjM4guWBtH56J1MCVDt
         JOL6N8q3lvdX3j6SLap+6QOeMR/coq2y/+FyUOHhdZkVft5xaNM1uxou6nSxU9EqvM8J
         KhGBd7ZAcvzqc01Nfd4h6LTARxZu//yXHzBxLtVs2tUgqZuD56vMWGy1g8ny5/+trtx5
         Hb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSRXr5ZF0nstHXuLDJqj0kP/ADj336Vx1akoatH/1f4=;
        b=5FZ/XDlTXovsXILxqoZJ29NzwqtCmBzT8VzuDgqj+tmlScFIFx3NLJ3cdc2j9GJNMQ
         1z4fr4PTLxmdZUTynauDlnWnKBUjP1KIHZB7lfpSwrQz0Nh/urw+JwcOvNS5tq/+R8Wl
         OR5QzopIYfxLAqtvLwBSTo7OoXKmD5eHoW278mhIUv2zOeAlc+p56al7kAMQ69UEOUYc
         rFlfIDUhhHLzxqWgZP7fdofwKUhS9EZOnlfvtv45MWiEk7beC41rY/dFFOMSF9R0Z2oV
         ylLKy6DCxC3nw7+ydbP6yQcADijlXlp7oB/4TnB2l418N8DNprwbfh1E0Xt5OM1h90T8
         TGMw==
X-Gm-Message-State: AOAM530ffgOk4KXo1JEYXeQu2IjKmici3x2UocCPbKwai8J1gqMegHS6
        ISe0h0xZ7nQ0OU4BDt/VkK4=
X-Google-Smtp-Source: ABdhPJxYEuAYHQSlw/+GIa/vwm5WXcLSmoc7ThaeQRELpG3jBxBX9v+KGy5wC/15zu6eB4EbBnVjJQ==
X-Received: by 2002:ac2:490b:: with SMTP id n11mr13663286lfi.134.1643587200667;
        Sun, 30 Jan 2022 16:00:00 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id e7sm3443193lfb.17.2022.01.30.16.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 16:00:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03
Date:   Mon, 31 Jan 2022 02:59:43 +0300
Message-Id: <20220130235945.22746-2-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130235945.22746-1-digetx@gmail.com>
References: <20220130235945.22746-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

LQ101R1SX03 is compatible with LQ101R1SX01 from software perspective,
document it. The LQ101R1SX03 is a newer revision of LQ101R1SX01, it has
minor differences in hardware pins in comparison to the older version.
The newer version of the panel can be found on Android tablets, like
ASUS TF701T.

Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/display/panel/sharp,lq101r1sx01.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
index a679d3647dbd..9ec0e8aae4c6 100644
--- a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
@@ -30,7 +30,12 @@ allOf:
 
 properties:
   compatible:
-    const: sharp,lq101r1sx01
+    oneOf:
+      - items:
+          - const: sharp,lq101r1sx03
+          - const: sharp,lq101r1sx01
+      - items:
+          - const: sharp,lq101r1sx01
 
   reg: true
   power-supply: true
-- 
2.34.1

