Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D704B0499
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiBJErA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:47:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiBJEqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:46:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3125E13E;
        Wed,  9 Feb 2022 20:46:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k18so7319102wrg.11;
        Wed, 09 Feb 2022 20:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BjDFuVI1diXeHGjfeYh1Ru7NnwWu54G5DixYVQkN3LQ=;
        b=Z039O/mT3T2FE/qU1t8Mwr/uL4bTki9Z2yPXpwt87ry32y7atrQ6705/ky6xG5tr3T
         AIHWO4lBhEEUNgg6Sav8x4kGpm2ZCARFvSpeFmUC42idac09HfzntAMKDX2krZcvMOO7
         U7MlgFMRNcknC8WoZl46amBd16Ge5+EX8N9qzPHobxVYe2dwikMlFjXq3kss8mJNC4xX
         8BbR+/xkzvxTkexQDc95DMDy7Bm/Qn0Lcf5z8TskpAPKk4i9GMWLYc6+ByyLw3g6SkfW
         Nx9pUNWXgohSfGTsfKwK52T8HpqEUY5NoXSsxELoblqX/+6cVRdYlTfF0J52jBy5jkg1
         gNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BjDFuVI1diXeHGjfeYh1Ru7NnwWu54G5DixYVQkN3LQ=;
        b=aM3QbAHp1Cv4MgYFmVCi9x+N7ZFa0BRXObgHZWNIW9ikjY1j2gptK/TDM1JHkvfg8i
         lJJYNxj2UFeh6oUfR0YdVzMvyr2TkuUxoHztkYVRq/MZDVYO2p0apwxZdOZXMl0lvTgh
         K59tLojGmbnAJ7+A/Ovo6t9E+txd/eF8SrA3OLgbQv8Te3dXaXQKQtz6VPIayfVcDJNu
         MiDPR4lP4WOg/1aCtjvPA6rJZrFcUXAhbfFHOiSkpWaKq85OhfbnkCXcA+9ss+wCeV93
         768IlRTHsMgeDDF7TjxDTXfnOzjO/iRvDmzwXNODHrMf8nme/02YCBkCiL2qtrG3Ev76
         jc8w==
X-Gm-Message-State: AOAM531/dqOPtBL29Ssbu/hobBQGVCwoP/ods2vcjHjjZVopgLp+/+dp
        wW/gGNnPS/QBs9nMiHUf0i4=
X-Google-Smtp-Source: ABdhPJyfhwJP/OuAqaG/f8JeEci5j9lXhwga9tAVqWh3VfrctxGSoEkAZNw74a62QNHaDsxWat7WWg==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr4583607wrp.557.1644468414830;
        Wed, 09 Feb 2022 20:46:54 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h17sm323089wmm.15.2022.02.09.20.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:46:54 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add osmc prefix
Date:   Thu, 10 Feb 2022 04:46:45 +0000
Message-Id: <20220210044647.14443-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210044647.14443-1-christianshewitt@gmail.com>
References: <20220210044647.14443-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open Source Media Centre (Sam Nazarko Trading Ltd.) are a manufacturer
of Linux Set-Top Box devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 52ff63248892..b97fd8dfe601 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -882,6 +882,8 @@ patternProperties:
     description: Ortus Technology Co., Ltd.
   "^osddisplays,.*":
     description: OSD Displays
+  "^osmc,.*":
+    description: Sam Nazarko Trading Ltd. (Open Source Media Centre)
   "^ouya,.*":
     description: Ouya Inc.
   "^overkiz,.*":
-- 
2.17.1

