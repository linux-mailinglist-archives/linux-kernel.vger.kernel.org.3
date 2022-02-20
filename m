Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31E4BCF59
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiBTPQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244139AbiBTPQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B134BB2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so22917506wra.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ywyf682k4IPGploknsa9+UktKQX+UFNPY0KByqqQCSI=;
        b=o6DIr3PEoz7jjmXRjayAjxTW780wquOUN9ih6DCVxjsayQqPV8fTDjC+i1XWFrj9V6
         bkpDTiPWiGQKxs2GwxzcK1OjSSBR9RBFolfE4NPf8/cfnqxeoqTzbsxuFlg8ziNmmcod
         R8oKKTN0znXBrmp8nvN7ZvgDFJbu8uT/SI/18Hc0oVSp3wKn8DLMoYQUmomJBvrnSB/y
         oIgj5bFOjBMzi406/QclSTHw7qagSNwCLDhwyClm9lmKswDYiarTDeOcvi0HGvSON6OU
         Lj5FK6rMGn6nYl5qxDMKMuI0hvgO+DCTa2msgSD+e97KSfNgvR5G5uTiB6T49v7XAZtk
         mEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ywyf682k4IPGploknsa9+UktKQX+UFNPY0KByqqQCSI=;
        b=7XhuUr5irewndie9tEoxp1WhRn1OXWOvKBvNJotTQ0qcLDpy2Hch+qfw5hNIEP2h2R
         ADM9hsjapsuW5ZQNQrnDlgE9nJpegfLVdYA9ywqkw26DxP3lqG2+SAgWV1wZzpYNS5j7
         r6RPwbKL2wsd/Ig9DV5NdzClvEAvXJN1t+z9VkaoPXFPbfz6tVL31qDl1ImTMt/NNYNP
         prQ9NQrj2W6BKT+NBTpxR7BXVx+bWdj5xbasJBmtC24lpqgWJ02ZYLRE9D/NnibeHRJk
         ohz5THE+MCT1ozc+MFG0bbI6ypAVs/vj8Fiez92CvuEmayvUBYF6up3fxvwB+4iOrVJD
         n6uw==
X-Gm-Message-State: AOAM532qY56kmTB21TF4UzWlQI9KL/irZx9ygT+pmyz9iJT7K5yXUAFu
        FLpahXDf0FZAax0ouCOn3i173A==
X-Google-Smtp-Source: ABdhPJzTxc+CVIjKg2DGLKaRiJ4oA8QkSIXrKXYdvKOmXEPSOM6CUFvBbb+XwyFmW+nsC0ZiQrBcAA==
X-Received: by 2002:a05:6000:18c3:b0:1e5:82d3:e4e2 with SMTP id w3-20020a05600018c300b001e582d3e4e2mr12770894wrq.575.1645370153529;
        Sun, 20 Feb 2022 07:15:53 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/13] dt-bindings: nvmem: SID: Add compatible for D1
Date:   Sun, 20 Feb 2022 15:15:19 +0000
Message-Id: <20220220151527.17216-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

D1 has a SID like other Allwinner SoCs, but with a unique eFuse layout.
Add a new compatible string for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index 6687ab720304..e558587ff885 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -20,6 +20,7 @@ properties:
       - const: allwinner,sun7i-a20-sid
       - const: allwinner,sun8i-a83t-sid
       - const: allwinner,sun8i-h3-sid
+      - const: allwinner,sun20i-d1-sid
       - const: allwinner,sun50i-a64-sid
       - items:
           - const: allwinner,sun50i-a100-sid
-- 
2.21.0

