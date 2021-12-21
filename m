Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8D47C01A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhLUMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:52:07 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:44716 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhLUMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:57 -0500
Received: by mail-qv1-f51.google.com with SMTP id kd9so12247920qvb.11;
        Tue, 21 Dec 2021 04:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CXUVbYOFX+qNt7zC1+Gzh0+PjSFhu0u9+OwdjiLHOzQ=;
        b=WU+JqQJX3dbxavBCwEKmbJDYVB0JKQd3v8u+Euz4ch7Q+grYGb50A8uQsNGPRKCE2P
         mx9x2l9vhld0MLKyx8J1yY4v8e8De/xPJkDrSn81SHv9aMsbMoWdj66jJia0kVQvF7lK
         qlw45LbdSOptkHvax/6j8UJUUEOipa5zf61g+XXCFFoFCEKnYc8gJBInzwQRdO9EhvsK
         GFnN9EIjkqmOrnEgBmS6J1uk7lv7ayO4NWUQLb05u0nEOM/iNoaPPibWw3EewDzbCdvL
         h7ft+te+G0TjN+RNCqm2rMJwxptDpf+pEDpjfM+vCo8dHs/3rFt4ttgyiPy3IGOUC5fn
         auDQ==
X-Gm-Message-State: AOAM530u8Sk4Ptpw5GeoFpDEeXOB0EDei6tw9IUeZ4sWuG5+dWpgtI5w
        rypMfe86KGxlNAyg6NNGPkz1pU/LGxG0
X-Google-Smtp-Source: ABdhPJzo1zRafFgA1Rs/dx78OvoHKnIPrB8GViOOzCeTRGNIK14UPySnci9L369mX/rxt06+xfJBpg==
X-Received: by 2002:a05:6214:20af:: with SMTP id 15mr2236132qvd.95.1640091116951;
        Tue, 21 Dec 2021 04:51:56 -0800 (PST)
Received: from xps15.. ([24.55.105.145])
        by smtp.googlemail.com with ESMTPSA id f21sm16840871qte.52.2021.12.21.04.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:51:56 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: st,stm32-dsi: Fix panel node name in example
Date:   Tue, 21 Dec 2021 08:51:45 -0400
Message-Id: <20211221125145.1195234-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support enabled, the st,stm32-dsi binding
has a new warning:

Documentation/devicetree/bindings/display/st,stm32-dsi.example.dt.yaml: dsi@5a000000: Unevaluated properties are not allowed ('panel-dsi@0' was unexpected)

The documented child node name is 'panel', so update the example.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/st,stm32-dsi.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
index ce1ef93cce93..54f67cb51040 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
@@ -110,7 +110,7 @@ examples:
               };
         };
 
-        panel-dsi@0 {
+        panel@0 {
               compatible = "orisetech,otm8009a";
               reg = <0>;
               reset-gpios = <&gpioe 4 GPIO_ACTIVE_LOW>;
@@ -125,4 +125,3 @@ examples:
     };
 
 ...
-
-- 
2.32.0

