Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D638468BDE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhLEPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbhLEPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:38:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E1C061751;
        Sun,  5 Dec 2021 07:34:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so32817679edu.4;
        Sun, 05 Dec 2021 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2BIJQ2SN/UnbP4L3hzifXWik0mr8gsruo3HJIkfXK0=;
        b=Cds7mT68wcmvDkbPqtbgGAUoIP1Qy5QrNsF00gNcM9SSRsCCsJdwyt3Tigzgi4iofn
         G/0THTMIFdE3Q7gE54kPIKC9jBkUBcSW9ktmy8mYDqgXQ7cUH1A+ZAmXGgx5NSrPisFD
         tw4eOSM7X3MWlvDm3NN9P3p9PeHCi3+hISDdPk1KV9o6L1AC0YnLXR/eilday16DCd1K
         L8lohSTiLzdiR1wbhrg5XNDkLAOhSht3Yur5jUcbloKCw5qbHAqBzn7kxtChUslOvgeG
         JihKUHj9lhf6IDY5hUchU0U6Xhzp6nfnQk98+YD6GGemDhVs+/ovBcxsKGvmJkrtJEsV
         xbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2BIJQ2SN/UnbP4L3hzifXWik0mr8gsruo3HJIkfXK0=;
        b=3vf9elyLtuPasbhsOb46et/sKsezfUq2v/vcvhghOKLYS87tdGJKCHBNgXqWV/81KR
         Rd3USdw+uda7pYUj6czYDAFXuIZBikNCziKA+/P0EaL9ZAwTGYx2Yy4w9Nbi1CB3GkvN
         kmufMMQZ2+cWXA7/asDOTKYN+VPwac5rR9RVJwcHhTeggNObJNx7saq6T+AwA2LuEobN
         kbNCJYXXJpyQdoYCNCtMAnzsul5euxWnyzZ9VQ4w7f1zDNsG+R46oEEI4eBt4rJbCNiN
         QwKTEcclQKB5W42NVtoAsVvfwrec++0+I53gypPJcpP4QDgr0No8FDpsWZOHjVq0AVpx
         HZrQ==
X-Gm-Message-State: AOAM533qGIQ0wyWwy30rkfrStITIWFsEBVKKgspfkOgLTx4kGEtn7HTj
        1xRlwqmqV40CV62vr+L2KSk=
X-Google-Smtp-Source: ABdhPJy2jHmlsezBVaGHCM6FXaitWGgpZtSbfQITteDMUF3jRpkixEbGP4ohkodmeHUWUuSyA/ubCw==
X-Received: by 2002:aa7:d510:: with SMTP id y16mr45737341edq.338.1638718497588;
        Sun, 05 Dec 2021 07:34:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id sa17sm5529941ejc.123.2021.12.05.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:34:57 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: arm: samsung: document jackpotlte board binding
Date:   Sun,  5 Dec 2021 16:32:59 +0100
Message-Id: <20211205153302.76418-6-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205153302.76418-1-virag.david003@gmail.com>
References: <20211205153302.76418-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the jackpotlte board (Samsung Galaxy A8 (2018)).

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index ef6dc14be4b5..d88571202713 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -199,6 +199,12 @@ properties:
               - samsung,exynos7-espresso        # Samsung Exynos7 Espresso
           - const: samsung,exynos7
 
+      - description: Exynos7885 based boards
+        items:
+          - enum:
+              - samsung,jackpotlte              # Samsung Galaxy A8 (2018)
+          - const: samsung,exynos7885
+
       - description: Exynos Auto v9 based boards
         items:
           - enum:
-- 
2.34.1

