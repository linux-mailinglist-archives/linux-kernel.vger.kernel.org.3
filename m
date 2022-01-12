Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABAC48BD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348668AbiALC1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348709AbiALC1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:27:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DFCC06175A;
        Tue, 11 Jan 2022 18:27:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u25so4028552edf.1;
        Tue, 11 Jan 2022 18:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q2pienCXnr3sbjoYsVwKnMqiOo690+Zk3T49WvUYDPc=;
        b=c9ItgbbMGthyaKniMKKLCIerAHmSHpaPkxUYIjlFznkg0pePK3WISUTlr4acJuGVJo
         kJ5EAUoLcVbHSOtRr+AIGtxBN+MlW1JNGYbzzsPPGqwtZTcQ2AbcRFOom4vG5Ekis3Cx
         +4KT2B52RQtu7KxPNSQhONEl1xBbYmamIrxQcI7R7p9CllENDH7YlcsDoB2jSnIO2Qah
         AqmsoUwvDTJ9tk2rOF+TumQ/PJP8PHXZRDJFip0ybw74sWkj9cfMqLMjBhkBj0SjlE3O
         e+AcGA+OLwFERa0ZQajJIg5+hLNpIFTQ8iVB/my4h9UQr0rLwuNqN8Ns3AmDGebwYvZU
         Subw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q2pienCXnr3sbjoYsVwKnMqiOo690+Zk3T49WvUYDPc=;
        b=gZ1R6/BYdLBjKIKYztnxMZIq7ljKqMHN006jZBYZ4DVLI+PoSsJwmYQ10x+BmpT2u+
         Xv53qMSKXIPGXyugOa8UUeqXhyhQsyuYRSJ2DLtdizXKk7wvpbCQywoJude1KbFFvKBG
         hfXNpgi5o+eRRXX/ERQPsiJ6aonbV2nr5ZuLxr0R4ruqEMkJch66icpfH9bTfP1X6wPb
         IVKRUul3vPhDaY7DCEI7NTM1llXhr7dOxM+m8LqTFBrj/uyYi5lEnU/CzWmOdfY9Zrzg
         yNfOhyZl387gB1T4aSdpSoDdfcUP/87elpjbj03E9ojKT/tE65FEZpkYWpiwsDElxBiH
         rY3g==
X-Gm-Message-State: AOAM5308uik6vxJmYle+mlTwemXicYMdIPWfpcj0yKYy4MTf8uynr2Q6
        5+tYkSk2yXDuBfsLyrcZXqc=
X-Google-Smtp-Source: ABdhPJzbFTWscIOESqfZXRaEpAeEf2ahlpDikx8qBQLZ7bVaB/3GEAD7t4rj+aY32J8yohsDr9vpxA==
X-Received: by 2002:a17:907:a412:: with SMTP id sg18mr5790174ejc.2.1641954454395;
        Tue, 11 Jan 2022 18:27:34 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ky10sm4041772ejc.151.2022.01.11.18.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:27:34 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [PATCH v3 7/9] dt-bindings: vendor-prefixes: add haochuangyi prefix
Date:   Wed, 12 Jan 2022 02:27:11 +0000
Message-Id: <20220112022713.25962-8-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112022713.25962-1-christianshewitt@gmail.com>
References: <20220112022713.25962-1-christianshewitt@gmail.com>
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

