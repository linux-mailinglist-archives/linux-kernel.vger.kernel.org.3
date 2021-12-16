Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6B476F30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhLPKw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhLPKwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:52:55 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E479C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:52:55 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r34-20020a17090a43a500b001b0f0837ce8so2202263pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VISxCt6uNVlSXPrOg0qtSxETrJeGne9ub26tyDD42ME=;
        b=jSRozYOCvi0no2PTPRdH1uAwBQ1bMEWSTfOcWWE193wMj9ECqkb2dHQ2I++Zdn+cMd
         BeEKWZE0Z2z3KlAz73W6Nb/ay0K7B0Rfmf/6ohuJoN8KOUPBWg4GHUwTdEhO+yzvUrtp
         zOHdAS9T9fJ2KuyQEtYLUsYxdOlPy9vKbzWT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VISxCt6uNVlSXPrOg0qtSxETrJeGne9ub26tyDD42ME=;
        b=IJfkh4ro05IqyiGhdIVH8zmGu7XcKS/gV6yeUIcPrsqx7Djiw1k+uVN0a+7KCMXszk
         6WanpRT9DWv10Nx/N3xoKkbTlnSo2S/+fdGw+t6UXpZiTpjdrGiFFRB43bC+KAxJ4xOB
         4NWCJyuDeDIHFjtBW7AK9EYA4SeOwN0qmrronDeWmv7TthcRqVtvoJ5q1wmfYhpc+Jjq
         AKcqR/6bTGQg8+zXWUWXfRgsnYtATAI5zUPqTq2L0t8BW86ZKZSsTJwI1UiCJM+X84cL
         BhGT5dcia2Wj2g7VMdrBQhkwStfUSHvCaxaeGW/9L70g5ZRu2hGAAV/0ONGC50l2qeBf
         pBYA==
X-Gm-Message-State: AOAM5331eCCmBqOXLXymHW1ZYYo+X1ZnMTH8ieYpDVWNrtE/jVIUl36W
        mX9DyfyLARRfFTNW2XzFYOOWjg==
X-Google-Smtp-Source: ABdhPJwMM6UUiGaZqGGwoI1XbPc1TId9Q5ruqmBSAwlCGK5WR0Dt3/tT3wiL5rzTFiuP6tKl6tQN/g==
X-Received: by 2002:a17:902:c78a:b0:142:1b7a:930 with SMTP id w10-20020a170902c78a00b001421b7a0930mr16197185pla.8.1639651974796;
        Thu, 16 Dec 2021 02:52:54 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id w19sm4986142pjh.10.2021.12.16.02.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 02:52:54 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add prefix for Miyoo
Date:   Thu, 16 Dec 2021 19:52:44 +0900
Message-Id: <20211216105246.3548133-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216105246.3548133-1-daniel@0x0f.com>
References: <20211216105246.3548133-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a prefix for "miyoo". The only details I can find about
the company is their aliexpress store "miyoo global store":
https://www.aliexpress.com/store/912663639

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..3fe6117eac42 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -757,6 +757,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^miyoo,.*":
+    description: Miyoo
   "^mntre,.*":
     description: MNT Research GmbH
   "^modtronix,.*":
-- 
2.34.1

