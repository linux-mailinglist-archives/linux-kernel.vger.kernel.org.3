Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930634D76DE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiCMQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiCMQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:36:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071B39152
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:35:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qa43so28983289ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyIELtQTCl+VPY6+JbFB6MkwcDo+lB1ZIE+4K4ki9U8=;
        b=VKH47+HpvvdnNGuyxMKR+SRsFItKVu02Ns44CVytgr1FywMPrSNnQAYZSarHRkGtjj
         Y9vhyumZvigyQNsl3IZ4SmNU+wAqd59VSf8oXFcd2l3IIHP2zyJ8drrFtQFj3HLggpH7
         TUvNzaMdh0i+q4W7ef0Go3qVCKMUzaGOXRy+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyIELtQTCl+VPY6+JbFB6MkwcDo+lB1ZIE+4K4ki9U8=;
        b=WOhTdfwTFEyQA1/kmdzZGwDbXO7YGOFk0yK4oebIPtT7XxzN9TcUijVtQTEIo39kPS
         5VvHP5w1deIQC1ojeEJTncJhI9zkAFo9S0JsH1SLXcKQmsbOUHgSzJE3FwCFnmc17uib
         HljEPtguPIacCj2N6O5FUnubRCGnM05ju9VJ6F6QMLpLztDDMqBWR1oEJRXIcSomwR1C
         Ze1RoQk10wsjtLKerw0yp0Y5zgQmHrJM12CTufUUtzvXJhDUSLXLg3PgEBUXzWtG6hMq
         38XzDgvTniLRlFRtGQI89B8xdz365s/8NB2+zgubYs64eYZQ2LR9Fb4Ri8EFcawHiPq2
         VQ+Q==
X-Gm-Message-State: AOAM530OrE0hmTZG32rbj83IuDQJfoles2dHLR77y9L6SKCLFWwu1TBu
        hAIRopng3h22gPTGr6CiNOKCH7lrq7YhZA==
X-Google-Smtp-Source: ABdhPJxY+k8xdwzX/qU+LdqCnlCbhreG3rRA9h0T/J1qqkNNsgCe/5XhQEbuGfoQMKlnBmjtN/nUOg==
X-Received: by 2002:a17:906:3ec7:b0:6d6:e52b:b with SMTP id d7-20020a1709063ec700b006d6e52b000bmr15473905ejj.521.1647189314941;
        Sun, 13 Mar 2022 09:35:14 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-15-73.retail.telecomitalia.it. [87.0.15.73])
        by smtp.gmail.com with ESMTPSA id qt22-20020a170906ecf600b006da6ef9b820sm5725028ejb.112.2022.03.13.09.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 09:35:14 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz
Date:   Sun, 13 Mar 2022 17:34:58 +0100
Message-Id: <20220313163503.5183-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220313163503.5183-1-dario.binacchi@amarulasolutions.com>
References: <20220313163503.5183-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

---

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

