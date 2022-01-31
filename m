Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3167C4A4DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbiAaSMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbiAaSMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:12:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA66CC061714;
        Mon, 31 Jan 2022 10:12:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f10so2109499lfu.8;
        Mon, 31 Jan 2022 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bd+246oU+gwCv1nTiFB/RtbYTLmhU4AaWG3IceBBM38=;
        b=Lamq6uWIgelv9qkCDQ8Fxjbyz+TGxImKWUwjek1dFwxef0QGmUFIfSodcw5R+1/xzl
         qYfbAiQM1F4XVTghjKn6wB3M1tGus9cjegtwg+e392dY3noy4yC33fdGIrrmVmmxY1o0
         qdBuFeTmgvdIbs28SmaSdRkLR08io1gvRmtA5AJrl6VBVa50bO4nyPToBLolWgE6bRkd
         Jo+M/UbWXE2cTM6pT+S7YNIFyRYQwwUnIBABEoNX616sstZPkwH1bvoJNLcwyzYRq87G
         qTr+Zgb13uCETf/c2xzxgW3k0oxgAJP7QYAZjbm99F6m1tTQKJy8CVGPjdXP2LMEQwYq
         RmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bd+246oU+gwCv1nTiFB/RtbYTLmhU4AaWG3IceBBM38=;
        b=OS1/HlZ/iMNj3rvPqppcDV+CFHaYq9f8YSErmmJPLGNaDrMHjqNR0g+3xlfzEcFPvS
         ITu6N1uS+VOPxnZimKdj3p6ydJDjgg3E11dxlcL673WRz4xwFu71qGvQTFuvMtK56lrN
         4sJ6ZdTZXPNWHVhuerBSqZOt5/ptVfO3ZvI1Kc+kFFyI+SKuKJ+Y97Fl7NzqoCxptWog
         YUu9PuUxLnE3KuW1qXudZnhAmLbSFB9Ao5+Nc1EqNGK3uRITpO/CWfj4VN36yjMfAaJT
         UtLoe/fouBcDMfS4TOv3Qfh+kXzLIK1iNj+UGU1fPFj/II+PlcSunOa3g6GKlaJsrbAZ
         Scpg==
X-Gm-Message-State: AOAM532OrhY5v+SDQ8ktfNRmlGKBiaiMjfHkWIvF+Bpk0rKXlv/eqjd3
        IrZHaRUxkLzIJrS6E8cKfE8=
X-Google-Smtp-Source: ABdhPJzVP/p95YssgrO9NCctzmif+jzuxLg6etXClVolBI8lU6fa0AfJxeNVcPK2YreboUkw7EZi5Q==
X-Received: by 2002:ac2:539b:: with SMTP id g27mr16548516lfh.612.1643652751169;
        Mon, 31 Jan 2022 10:12:31 -0800 (PST)
Received: from localhost.localdomain (109-252-138-136.dynamic.spd-mgts.ru. [109.252.138.136])
        by smtp.gmail.com with ESMTPSA id r17sm3391297lfg.237.2022.01.31.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:12:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03
Date:   Mon, 31 Jan 2022 21:12:06 +0300
Message-Id: <20220131181208.27101-2-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131181208.27101-1-digetx@gmail.com>
References: <20220131181208.27101-1-digetx@gmail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
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

