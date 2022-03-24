Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50E74E6876
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352550AbiCXSPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbiCXSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:15:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006AB6D193
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:13:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c23so5627180plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHPqncxkqirx9UajzpUXlOLkpGtduK2UPDvTzwuMyCs=;
        b=iOtzSX+H9de688dVz/qNPuCWiXSV1D4QI1YkVp7rX5G38Jzz3geU3YB9dCZe/FpLqJ
         zKEU5m8vdHwXvx+Ns0LzB5WzUJgIHmwybUdgFyB3SM/biVNEYi2xmOUy5x1R3+e5bepU
         Brk9DElK3dy4e6ZO2mzmOJl3nYzF8D/3yF35M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHPqncxkqirx9UajzpUXlOLkpGtduK2UPDvTzwuMyCs=;
        b=nUBED3yS/IPDizvNu+P7bDcDr0w7Sfj/pflASFTho8MEC+7iNe/VVaNp4O34is4jmt
         TTrBLX9Ck40AoSK2PSeP31zz4slDsloWGqq0lCOaWOgSRoYgqJ9vEggAigaEUlf6K0wA
         eAj08qUQVNSGsLS554A/UDFxmNlUdOoVbz3ilpUC7gEcyGYSqejSDXakgNfTn5j4rBOx
         AZVloumqY4uGSHrNE9ufA+G41iSvS4/C6DWvFKtENIh6k9P315HmvCKHxygkn6KuQ9rm
         fz0WnOfQC8QJxB3sGEsBozqIzIaKOB79PVS+rdlpndqXOqqGpJeJvo86O2jXEtN85ZI2
         B4Xw==
X-Gm-Message-State: AOAM531DX2gvmhjIitHsB+U/y51c/hvXU5JRQTKocB3UO9CewE5WuBjT
        6OrKDcHI/zYnE6y2i9hpZMDL7g==
X-Google-Smtp-Source: ABdhPJxewwppL8AGwnT6G0Q+WCq1TVWp2U7l0C+hU5Wl0eQUF98UycSVVL480aPn/bAE4kIdTdySnA==
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id n20-20020a17090a929400b001b948e9a030mr19671566pjo.200.1648145637432;
        Thu, 24 Mar 2022 11:13:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:690f:642:3ebe:c89d])
        by smtp.gmail.com with UTF8SMTPSA id w6-20020a17090a460600b001bf355e964fsm9913554pjg.0.2022.03.24.11.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:13:57 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] dt-bindings: display: simple: Add AUO B133UAN01 panel
Date:   Thu, 24 Mar 2022 11:13:51 -0700
Message-Id: <20220324111335.1.I1131d63cbefbfa9ff107a284e2e51f880c5bf7c8@changeid>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the AUO B133UAN01 panel. It is 13.3" TFT LCD panel
with WUXGA (1920x1200) resolution.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 1eb9dd4f8f58..e5cd45c81d02 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -49,6 +49,8 @@ properties:
       - auo,b133han05
         # AU Optronics Corporation 13.3" FHD (1920x1080) color TFT-LCD panel
       - auo,b133htn01
+        # AU Optronics Corporation 13.3" WUXGA (1920x1200) color TFT-LCD panel
+      - auo,b133uan01
         # AU Optronics Corporation 13.3" WXGA (1366x768) TFT LCD panel
       - auo,b133xtn01
         # AU Optronics Corporation 14.0" FHD (1920x1080) color TFT-LCD panel
-- 
2.35.1.1021.g381101b075-goog

