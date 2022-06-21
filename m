Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE41255324E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350494AbiFUMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350483AbiFUMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:39:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9127FDA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:39:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mf9so6879737ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TyZtZSd5cTSSlPOn3/pu61X0lFqS8ubq/VPK6S5b8ro=;
        b=Rv/Yqt5L/Omcx8Z4jk+PLWm3p+qCYYlTOiWU4H928xtWMMWnYe6lWQGl6vwZeL3eSF
         KtmmQP8JAslPyl/TNLCcj2Orv7v4qSudY/6USovJIjwqxi3U/KYIWpD4nVwvfXcnGzxg
         R6r+aLDpNBtUmmj5Vc2IqoiHL5nwxJLzwBdL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TyZtZSd5cTSSlPOn3/pu61X0lFqS8ubq/VPK6S5b8ro=;
        b=7NxnzGxT80zVlJtHQ4zJgnGitWi+KyTyWK1B8jNzK40tJSx81oKbJdgofB7qsI5Z5t
         sKcFgHNocpETlv8u0kvgmYD2ftY0yQlgaWAHVQRWLQESjod5fik2FcumPN7LPKIB1xEK
         LLDdElaHqLMQPDqOgQq8mbtomKuqjlNr/cjXZc38Lf9+YuGHHhhdFBtFBjBaeX+wVNW4
         kQBk3QvoHH30/EqrzNAzU/9RWORoYNO+WUevk4qEnlc0M+/rd4Hd7X+0Cvri/dNQurML
         M/Oqs3v9XW7NbASoPITRzcpx0jMZU6Y29Z1PawO15MeyCyqm69Z7GMvkvLO5VRDpUhju
         CCTw==
X-Gm-Message-State: AJIora/oEwGwoN8W1Py4Q5TgYYTsdPkqUz1d0yehzJP9AgaC8qCl0yTH
        3VHp+YaQ51YqMv4VLmVJDuWeyotp98YIwA==
X-Google-Smtp-Source: AGRyM1tico6RHxSTDuKq8TfoYMOplNp3NnDhWLGZr7I0mOs1ETwvU6g+HB4Sv95AsVv1Cdv+3MFF0g==
X-Received: by 2002:a17:906:7953:b0:722:e8e3:ef67 with SMTP id l19-20020a170906795300b00722e8e3ef67mr49309ejo.199.1655815182051;
        Tue, 21 Jun 2022 05:39:42 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7c753000000b004357063bf60sm8003945eds.41.2022.06.21.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:39:41 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [RESEND PATCH v4 1/6] dt-bindings: input: touchscreen: edt-ft5x06: add report-rate-hz
Date:   Tue, 21 Jun 2022 14:39:32 +0200
Message-Id: <20220621123937.1330389-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
References: <20220621123937.1330389-1-dario.binacchi@amarulasolutions.com>
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

