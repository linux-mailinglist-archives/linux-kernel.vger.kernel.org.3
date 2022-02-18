Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868024BB5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiBRJqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:46:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiBRJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:46:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B9D24092;
        Fri, 18 Feb 2022 01:46:02 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z17so6731829plb.9;
        Fri, 18 Feb 2022 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1rvqCHVtRBiuL9Y54dOZY1q4vVwsKl3F8s+6b7SX10=;
        b=kA8iQUGA3pzeY3mPS+gSBAbw8lUtB4kqJTNiQ4j3kyPWxAixQyNAEY4/1/8iJEmXuA
         v5Qqnk8Ws7cR3V6Qd+6CD3evF5GdaTJfTj5O7HQqXc5XzV1lV6kOWQ2zj3PkNtYbOmAn
         0/pzmY1to6SSXd6XOjcQXBFQFPqLHWW7jvaEVdgZUexwKm+QgTQxnhAxiL4YeFEssdoc
         ruIMdw4V2A57EfgTWdUHMLS74Pi19jhW0x10/P6k9R+JudXs1ecgErg1BBsTYtALDkTT
         YEARe7bXjx+CwSp2r2mtaamPXPZPKMYDpy8eXkW0wIUMcYGP3LywhOkNHRkShrmyKXDm
         eSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1rvqCHVtRBiuL9Y54dOZY1q4vVwsKl3F8s+6b7SX10=;
        b=nvuejdbRryAAsQplf8IRYS6KUo/zpceBLCe56Ybr2cpMdRaC5WZArSo49n0AnWEqaK
         HT+Nb/Z4qn7FXlI2OjReHql2CITTvuAcdoiAHNrieaTm0FvNaK4XAq3lKOOVA07zpLBx
         GRFF+JbhLUGf0p6WJ+WHSPUvj4AiSoBftWdgADE4p1NIKoZMf5SJoAAT5kQOngKaO91E
         QOuB+geuT0WOZFWrcoYbf48mbawDuTxPOcnTyO7EeBoUjgEh0byt5GY4leVRt/LQSAYv
         X2/7lkuwwkRppsTmZEhvGl3uO1YePYhRtPMGIiqPC4v2Zs/yMZoOqw0bgmDKMqqzuYPj
         J8nw==
X-Gm-Message-State: AOAM530ywptAcmT0NCB9GFxNFv//Kehvcr1ZGVare6DWh5G13gKjKszC
        7yBNU5cRlzKuVQevHHQN4FI=
X-Google-Smtp-Source: ABdhPJxQiWDrvZISrqJRZDLKJbKAvehEF9S+UjGB7lwhpbuLIelGs8siUiCxWTlbhl3eam2Q5joT7w==
X-Received: by 2002:a17:90b:1c8f:b0:1b8:c6dc:ca61 with SMTP id oo15-20020a17090b1c8f00b001b8c6dcca61mr7465172pjb.13.1645177561869;
        Fri, 18 Feb 2022 01:46:01 -0800 (PST)
Received: from localhost.localdomain ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id u8sm7675704pgf.83.2022.02.18.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:46:01 -0800 (PST)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daocai Nie <niedaocai@huaqin.corp-partner.google.com>
Subject: [PATCH 2/2] dt-bindings: display: simple: Add InnoLux n140hca-eac panel
Date:   Fri, 18 Feb 2022 17:45:49 +0800
Message-Id: <20220218094549.1631706-1-rexnie3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daocai Nie <niedaocai@huaqin.corp-partner.google.com>

Add support for InnoLux n140hca-eac display panel. It is a 14" eDP panel
with 1920x1080 display resolution.

Signed-off-by: Daocai Nie <niedaocai@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 1eb9dd4f8f58..f8383a8dc3dc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -180,6 +180,8 @@ properties:
       - innolux,n116bge
         # InnoLux 13.3" FHD (1920x1080) eDP TFT LCD panel
       - innolux,n125hce-gn1
+        # InnoLux 14" FHD (1920x1080) eDP TFT LCD panel
+      - innolux,n140hca-eac
         # InnoLux 15.6" WXGA TFT LCD panel
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
-- 
2.25.1

