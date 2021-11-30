Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7290462C97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbhK3GJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbhK3GJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:09:02 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC1C061574;
        Mon, 29 Nov 2021 22:05:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z5so16825891edd.3;
        Mon, 29 Nov 2021 22:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R+RpsJmrcu4k38lhTMdsmpexqsCYuM9wUkKjY5gg6Jo=;
        b=qiD1IpHxP7Mf33mI31MjOUEvk7ABc1x+tL8Sm0VQsNxWlCoJbMZxwgmcDPEFG93gS9
         ejLO482jkZJ2QLWYeVa5ZrMRxs91jOVjJSucipuGI4zG8Z/4O1TfQjZJ9sqHClvQL8Wt
         Rjl9AYGmhl+ZBr9/7fjU4tR0ukoPHczFajmwGp9Re3hHdUse4H3h8vzUCN7qKPFxHU61
         yg5Eg07G/rSWk8P9pPIH7pE56R1BSHUWAa6Y4fKg08zI6tJBmJAbIUBzTLM5sg0Hqq/i
         OfflVcMdW0TGiyG1hyyY/aOzHBoOOmAEPx84a/EB/X2Z8MsGwRDnjNA7Ja20dW/difmy
         /i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R+RpsJmrcu4k38lhTMdsmpexqsCYuM9wUkKjY5gg6Jo=;
        b=BBPwLLWXcgHFJyWSkDMQgE9QWFh70ou6sVvBV8H8CKrXRnyHlzal2rb7DagjiqBdlJ
         wRKRTwptZ5iLw7wIZskA82xiXIKP+gSaRtxhLQzAd2vEcE7QMNR9RudEEXjkZORwYkW9
         i9rdvvZ5GixphHJox4uHPTrdyAt8hhgBmwkRML3nCCP8giCSY0HmxyVaLcXETVrR6QaM
         LmlvsthIKM7PPzQ+GWlsdeQSNBNnbL4s6QwSzZr/7ZzCV2yn9li568jfm82pvRTMHlqW
         94P+toeyGl9sdmgydtpaZVcOv1eZ/SDxgoCccj3Dk+wYVy3Ho4dDMgYS7iekuoPsEqzi
         py/g==
X-Gm-Message-State: AOAM533QnpdFHrsSkZDK9vOHMJDeHNvrD/lKuS7kUDu+M4OX+bvdM7nB
        42xvdqn2Z2wmYhjAPS15HUk=
X-Google-Smtp-Source: ABdhPJzLCr2WLssFjy8Or/nBn8XHkX05bq96dIJOPfy2DQ45lLge6tR0YnY/NPdpu81rX3BIyHYsww==
X-Received: by 2002:a17:907:7664:: with SMTP id kk4mr63889993ejc.319.1638252342490;
        Mon, 29 Nov 2021 22:05:42 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e1sm10542153edc.27.2021.11.29.22.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:05:42 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: [RFC PATCH 7/9] dt-bindings: vendor-prefixes: add haochuangyi prefix
Date:   Tue, 30 Nov 2021 06:05:21 +0000
Message-Id: <20211130060523.19161-8-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130060523.19161-1-christianshewitt@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Haochuangyi Technology Co.,Ltd are a manufcaturer of Android
Set-Top Box devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f1b4afb2876a..52ff63248892 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -483,6 +483,8 @@ patternProperties:
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

