Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8884834E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiACQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiACQkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:40:18 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B21C061784;
        Mon,  3 Jan 2022 08:40:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o6so138069936edc.4;
        Mon, 03 Jan 2022 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q2pienCXnr3sbjoYsVwKnMqiOo690+Zk3T49WvUYDPc=;
        b=eJRD0DBisN7t3pAGm1lnNod3s+twq+23fhijVgFLtr6cJmBvEvdXpFInwQa3pzvhsW
         /vmeCfG1Hkep+8msZUrkh2Yv1HKE8fr2Tm1KeTMuf8hpK1pWJEAX5vK6ZNJXCwsUWIBc
         D2aCBak6QXFCzsINjwmpw5SMB0HPWJhfMFab28PTxV1xFl6kj7bvO2GNsQgqqmcOiv6L
         h/X3hVbCsY0rk/JYxyXXc+7Hbakxa/72tyL4bdmGIw+I7tWAxeYXXe5KGT0CM6r5td+B
         MMQtag/JQ1Un6JzTOF/K/PnZ3wBYD+MPQFytT1QhzwBwud2oRzNET8Sp/gDfB26LUF0a
         soew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q2pienCXnr3sbjoYsVwKnMqiOo690+Zk3T49WvUYDPc=;
        b=ThlwOOMb7i8z8OHKPFK06qlrMfA9+GBfMNZnd7hg0tmKoyg6oBgu0qt6I02utidhbX
         DYjIjzN70pBV/4JxMovLsJOvzYW0Ga2IlIboWRDh67yNJP/3oyUe61vt3kfBVVSkoqUb
         LWTXMKwqW4hQzAByXdq+dGA8VXDveG3U7BSEVdHPPNriSXkdWIJ5nU/khJ+MFAN6UAh8
         yj97T6MuQPgP5W8Zcckwd/QVusQFBpoVR/EKrhaa8g0Ba0hyxSlb3c0+3gaY+IAo7S+Q
         AD1IpLR9Jf4WL7FDAd1VYcL5ZmCbAr1OVKZI58Gfwkv5mVi45zfm4RCe4gFF30SmT65S
         EEWA==
X-Gm-Message-State: AOAM532bqVT7gOjMvvSPoBt0qP8x936YXFdMD7ms8jLHCQXdOrwrTfZb
        T8lehXHByiPWZtqYjuofRkY=
X-Google-Smtp-Source: ABdhPJzVOoXMXBvkqwiDrDSWsZKsxFjSa4a7Xmk9FjrF1EiMgHNhCKVMsNGs0VY4v3wi2hnM6ulxYQ==
X-Received: by 2002:a17:907:1614:: with SMTP id hb20mr39448769ejc.606.1641228016213;
        Mon, 03 Jan 2022 08:40:16 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id oz20sm10724068ejc.60.2022.01.03.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:40:16 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v2 7/9] dt-bindings: vendor-prefixes: add haochuangyi prefix
Date:   Mon,  3 Jan 2022 16:39:54 +0000
Message-Id: <20220103163956.6581-8-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220103163956.6581-1-christianshewitt@gmail.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Haochuangyi Technology Co.,Ltd are a manufacturer of Android
Set-Top Box devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c9202a101d71..f4160ee3b5df 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -485,6 +485,8 @@ patternProperties:
     deprecated: true
   "^hannstar,.*":
     description: HannStar Display Corporation
+  "^haochuangyi,.*":
+    description: Shenzhen Haochuangyi Technology Co.,Ltd
   "^haoyu,.*":
     description: Haoyu Microelectronic Co. Ltd.
   "^hardkernel,.*":
-- 
2.17.1

