Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3CD58CFC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiHHVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiHHVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:37:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B41149;
        Mon,  8 Aug 2022 14:37:28 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cr9so4239532qtb.13;
        Mon, 08 Aug 2022 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc;
        bh=lkehkT3MiXzbK7OlrNh0fnuUz1FZoh3RVLHxkOdzZDc=;
        b=igXjAZHhXjbCiAKmX5I0P7mxTmLC1wBQ7rN0UHFcnaYsnUEt+3U0r4RY4ZQ6lm01iN
         b6DSMytpTpzV2x7dbI+vCwIKq8Lmy/exTEAPoO/lNkIL5k8oPiAZWiylal4mTl4WYgst
         Le9YMokZElf6oGSktUDoaaDSxo+17HnSGBrN6LX9/KYsNzyTXRk33Jm15RVv2ur330+V
         gYbNfFE3GySBt7J7VVX3HYr6RpNoJoW24Y1kX+M3yMXWRxhHCofy3PPojdkNRGTGHoC3
         9RlxIDMnqH7zHRIouE0CnXF82N/EBeC1bbo/BQKPMg4vuiMlILDAQfEdMcT+3ezmu8Iw
         bYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=lkehkT3MiXzbK7OlrNh0fnuUz1FZoh3RVLHxkOdzZDc=;
        b=nbkYhjLOF+A4d5QDv7wjx5SFQ6Yb2JkcRL/C46rkMoGj8rLhf51qtQ5Haa/hPijC5e
         6LigdLfFYWg3t0eUdoj0xqsuG1zGEpE+k+df8pFZ+FeuPyLyjBeD8Qr7+DE8grCw0NaM
         9Z73Fh0moSyE86MvtRh518sN5xxbtVPJmqb60Dx9L54QmLNJAIebc4taTKZk1F4qjAX7
         ll52vCDhj9BxvPrQlGNtxzlFGaGXlxFEsK6jXySExR/+SqAurGlIyduj6SCmCdIDbkov
         tkqtUk8Z/5oBanRt0EIFpwkKfut/K7m0I0CfvCOet7M0ukkjIZQsNJy22Lz5yFka+ZxP
         7E9w==
X-Gm-Message-State: ACgBeo0aKRnDNk7EKGaNoUDufhc0OP5T20BB3mJPRfcG0y5ua356QkQt
        FY1Za99pJYzXyqh/NWt5k8IDdcwHUag=
X-Google-Smtp-Source: AA6agR7uWwIjiVLbkCd3o6NMBDR1IVfv7azaRn1+C6M8oKq/QCIHcGTBEY2KCtJUwm83Cn8Hu9lLuw==
X-Received: by 2002:ac8:5c05:0:b0:341:769a:808 with SMTP id i5-20020ac85c05000000b00341769a0808mr18380854qti.237.1659994647694;
        Mon, 08 Aug 2022 14:37:27 -0700 (PDT)
Received: from kubuntu-desktop.. (108-215-65-189.lightspeed.dybhfl.sbcglobal.net. [108.215.65.189])
        by smtp.gmail.com with ESMTPSA id e13-20020a05622a110d00b00339163a06fcsm9146656qty.6.2022.08.08.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 14:37:27 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/2] dt-bindings: panel-simple-dsi: add Tianma TL057FVXP01
Date:   Mon,  8 Aug 2022 17:37:25 -0400
Message-Id: <20220808213726.883003-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the bindings for the Tianma TL057FVXP01 DSI panel,
found on the Motorola Moto G6.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v3:
Fixed kconfig dependencies.

v2:
Fixed accidental whitespace deletion.
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 2c00813f5d20..1b3d5e5acefd 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -57,6 +57,8 @@ properties:
       - samsung,sofef00
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
+        # Tianma Micro-electronics TL057FVXP01 5.7" 2160x1080 LCD panel
+      - tianma,tl057fvxp01

   reg:
     maxItems: 1
--
2.34.1
