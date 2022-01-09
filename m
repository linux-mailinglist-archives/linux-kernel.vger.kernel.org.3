Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814414889B6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiAINxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiAINxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:53:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF42C06173F;
        Sun,  9 Jan 2022 05:53:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e5so7092487wmq.1;
        Sun, 09 Jan 2022 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ex7Zn4g/KLxuIHq6btV1mmIDVP8gvgYQS50c7e6XZCM=;
        b=Y9tFmhjkaVTR1OZ0465bvtWCHKY9ji1L/82QN/Tjr4UWoITPXRz0cc0i2f3QO3PD0u
         MKHW+fX0dF6bdAROMEUn76EgbQ9qj7lellclHw5Aw2CNyHaJh4CvT91vkjVzdI9DfUwP
         rKjyyb4ZIySm1LxdC68fCMj+o8+V/g0RoQhhXCnKUYM5oiERRE1ssHD4EY9kvnPEApWe
         UMv8stcWX2q84qET0/dWS5YAfhxR+Njbm/UwoGcVAyuHoUigeaKQLNlGSMYrYe94yNVA
         i0xEzifgcZ+mATzMyExiKuZNZ2DU0ufZ6rxWsYFk2wQM3a5GfVxFkpeovDQyzdJXwBDG
         w/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ex7Zn4g/KLxuIHq6btV1mmIDVP8gvgYQS50c7e6XZCM=;
        b=U0rLbmPs6PDepALqE8rs7iWCf12GhPvte/r4cABSXWZPT4oWwh/1PhVTMkChbc15cF
         nwXsCnum/i94JSwudec+QKnhogs0tjQzq93pDvyyCNz+S1WrZhzlvlR/i1stRAIRiJA0
         +otpERP1m6BGWgarDkjVU1jSXqy3a5ECmgfPYYkf208MuUkJEQ7yuMcg8rQWiq/zkFXz
         TWMkgCv/wsXhBX2evbH0pLHxKL22CQ6T6T46r29sc8mQqPjS4Nvh7DX0BEK4Qof/8Ab7
         3T7DtkJm0Oe1+iVqLS/XMdbTol256xwvfouSApbjSsxep3WyWVPtxWyR2Stx6/npK80z
         rBFQ==
X-Gm-Message-State: AOAM530xJwWnM+nq8SuYarMeWtM1R6HpCFZorQ5Hs7U+/ogmlKZNRJhJ
        iGDfotdNVZ9Fbswk5tM0Acg=
X-Google-Smtp-Source: ABdhPJwjuFZ0Px0kr8+UVRzj0mPDyiqhL4jgAmnpyETWPUGR+0Zal2yA0RrPW9ky7QqL9Uvws+Qdpg==
X-Received: by 2002:a05:600c:3caa:: with SMTP id bg42mr18434795wmb.106.1641736394985;
        Sun, 09 Jan 2022 05:53:14 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id l14sm4293077wrr.53.2022.01.09.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 05:53:14 -0800 (PST)
Date:   Sun, 9 Jan 2022 14:53:12 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: vendor-prefixes: add Wingtech
Message-ID: <20220109135312.GA4900@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Wingtech (http://www.wingtech.com/en)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a13d6a19c2b4..419c565ba01c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1332,6 +1332,8 @@ patternProperties:
     description: Wiligear, Ltd.
   "^winbond,.*":
     description: Winbond Electronics corp.
+  "^wingtech,.*":
+    description: Wingtech Technology Co., Ltd.
   "^winlink,.*":
     description: WinLink Co., Ltd
   "^winstar,.*":
-- 
2.25.1

