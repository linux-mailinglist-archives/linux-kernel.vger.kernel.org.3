Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB42488A29
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiAIPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiAIPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:21:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C3C06173F;
        Sun,  9 Jan 2022 07:21:18 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p18so404833wmg.4;
        Sun, 09 Jan 2022 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=r/pE1ECBkfSNzadNoNYykzwMon5LhyL0GG0vfMrJjtg=;
        b=Wsb+nMKWd2enNkyyKrUbL4DfRLHth/3QbZpJ/KFqka0EygV7ypMOU5GocL6Ls/2ydq
         Z7LT7ReqWrJlPfTRWr6ednzK5QVQX3hPhnNkodooWBpitZklel+ofKjg2AEBvWPMOuvE
         7J3WsJiKCVq18mOVUqQFMFwBYVhFsmPox/OU+GE5fojZykWkpBkgmfleVPo/XGRXyhOz
         gReNLxFY65+d1TplRqZBgaJYy03UNX5CozaRAlnaL9ffgFL12kzKgEBEt9pnQnt97ngW
         pW/dPZjzqMDF2G7Z3hxB8CGVS+R6LFuGq/HQp6/6tO+YClFNlxKbrKmdv2IYvkrTh7nA
         x3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r/pE1ECBkfSNzadNoNYykzwMon5LhyL0GG0vfMrJjtg=;
        b=kUI9iQdpgp68d4Mo2C2DLrXQxsk5fqisuIxyJXCGJ94LcHAqHVoozlOWHW8BqfUoNe
         UP+d8kORxvxuEhOE9LJJ+sKJsA9rVgQ9kK92NfAC6ZlG8PzhOIW1kP1/CzVnlgqbImT6
         iBb112eOUxTVNc5xD5QJzfPpuXYyWVgb9c2ErCC9ytc2OPearquyjdyiBOGMc3W9/aNz
         IHZ0O6Kmrv3aNv1dU355wvmsB4fcFNElmf4qdJrGS30pBQkQC1CuBUNHl5cdEBWyvDnn
         BtxVBHarfNRXNJrDRj8KXy5LI3yr0BI7ZmF9+1F9rBzlEBrKfNLFzVqDZY1/+iJKRLAv
         Sayw==
X-Gm-Message-State: AOAM53115Jk88uyinxD/RAOu52OKbDeLSUdXIBan9vJAX9x5l4ro8dcm
        g+yVFJsSjRUoytNSEkOwH6bxJPf0Mek=
X-Google-Smtp-Source: ABdhPJwdRSy4DpT/59DeBlaG0s/t9MI7vCHvyE7MRtojJWgI/BV2PgKNeofkpXxhMbNnktf6Rz7ffQ==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr1209955wmk.89.1641741676947;
        Sun, 09 Jan 2022 07:21:16 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id g5sm4601786wrd.100.2022.01.09.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 07:21:16 -0800 (PST)
Date:   Sun, 9 Jan 2022 16:21:15 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: vendor-prefixes: add F(x)tec
Message-ID: <20220109152115.GA9102@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for F(x)tec (https://www.fxtec.com/)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a13d6a19c2b4..0a6821f2d1e1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -441,6 +441,8 @@ patternProperties:
     description: Freescale Semiconductor
   "^fujitsu,.*":
     description: Fujitsu Ltd.
+  "^fxtec,.*":
+    description: FX Technology Ltd.
   "^gardena,.*":
     description: GARDENA GmbH
   "^gateworks,.*":
-- 
2.25.1

