Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B14F0B23
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359346AbiDCQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359336AbiDCQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:12:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C561626566
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:10:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dr20so15279318ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TyZtZSd5cTSSlPOn3/pu61X0lFqS8ubq/VPK6S5b8ro=;
        b=Et0x6Y7F1iuWFq4t2YgWOaDRcl9a4JJq2zpna5IXkXVoauGMD9BJDAwx7udZHy3jTk
         nKToBLqvvTYc3moR/2eKmTGR4nOC+7hwO9l2KArDMRsxbCrElTxr2Jx86nJlPAJDphf7
         41v41IyW9CujMfn5RvHp+YkOV6NlGN1RDupU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TyZtZSd5cTSSlPOn3/pu61X0lFqS8ubq/VPK6S5b8ro=;
        b=CB8xPUzCtR1rnJ6h5rM7qJrFFw7WwLRZnl5nQEV23bGKhPAUEi67qTG9jf9Cx77kOM
         hg+hXKIc3VS+jLW/QZySwgOLbslYJWpNtEFA1itd49pMVszT6q3lR8jGWb/IQXFmZfh8
         NQgeHtaLPCgTx1/Pja22BsBZ17MMr6NoVBINFfEouV9y4c5yIuYQ4T5FcYhGr7BdWW5P
         FRjosLjUS2F70YUOhbPRCK2ED68b7kyawEmVj8jpEPyjnBEI7M5GPGcmA3kJPrapuMru
         ZoUrEx3w1ypntW2RhH8xoXxQM03Ue28YTgGE38VdG/sdg040IhuPpBcDmb5cR1s0ayDb
         DxMg==
X-Gm-Message-State: AOAM533Gp/dXn6Tz0OwHmtiu3oVzANeXWu/7AMt5bQrSXzgls/fc+D8B
        ftoqIYmhBhTz2tjlC0T+GhqUzeWlzeSZrA==
X-Google-Smtp-Source: ABdhPJyboxIs/IjHPPN58voFRnczkg4LSb1oi1jBLbpUgVQlwQVc8XlauFHnkc65mMm4VVsMWKvW9w==
X-Received: by 2002:a17:907:86a3:b0:6da:870c:af44 with SMTP id qa35-20020a17090786a300b006da870caf44mr7318818ejc.445.1649002210058;
        Sun, 03 Apr 2022 09:10:10 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe2af50d8sm3350119ejc.121.2022.04.03.09.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:10:09 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v4 1/6] dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz
Date:   Sun,  3 Apr 2022 18:09:34 +0200
Message-Id: <20220403160939.541621-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403160939.541621-1-dario.binacchi@amarulasolutions.com>
References: <20220403160939.541621-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allows to change the M06/M12 default scan rate.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v4:
- Add Rob Herring 'Acked-by' tag.

Changes in v3:
- Add hz unit suffix.
- Add '|' to description.

 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 2e8da7470513..46bc8c028fe6 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -85,6 +85,14 @@ properties:
     minimum: 0
     maximum: 80
 
+  report-rate-hz:
+    description: |
+                 Allows setting the scan rate in Hertz.
+                  M06 supports range from 30 to 140 Hz.
+                  M12 supports range from 1 to 255 Hz.
+    minimum: 1
+    maximum: 255
+
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-fuzz-x: true
-- 
2.32.0

