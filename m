Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00078518FD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbiECVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbiECVPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:15:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC173A1B2;
        Tue,  3 May 2022 14:11:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 23E1E1F41A29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651612289;
        bh=mA7otPzGgHa0tglo/3X5LMpk0p4zRAjSBL46I5ES5B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4oVUtAJqNan5Xqyyf1UK2A5CbBf5KW9gGiTSWJKhPqQMA+NgjhhTeh6/DoS/YoPN
         cGV/azRfLY1xCcx0YckY2n0Ct/I+ea0LO01IoUoLHTaNXSSMFa0JKBDmD0z+XhvTy1
         WXscXMtcZHcozEVqQ3zU0g0m5QATlaTKFqqFEEnUnb8lTJamgdMA+yVbixowSjrvOL
         f4oXfcG8CHzqYKB5biOUAyLq1i6Dtu32dMmcnfTdTPXk1BGp/FebsXgSHH+tZPeh8v
         4gtRoKkR7QMuJ3pGq8QauUwFIeBVbeRisIjA8dnJmmPQc8PkUfuNIke3bYpcspL0EB
         HZKIVmoLR5qpg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: remoteproc: mediatek: Add optional memory-region to mtk,scp
Date:   Tue,  3 May 2022 17:11:14 -0400
Message-Id: <20220503211114.2656099-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503211114.2656099-1-nfraprado@collabora.com>
References: <20220503211114.2656099-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCP co-processor can optionally be passed a reserved memory region
to use. Add this property in the dt-binding.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>

---

(no changes since v2)

Changes in v2:
- Dropped type and description since it's a well-known property
- Set maxItems to 1

 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index eeea84379a1e..395c80bce713 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -47,6 +47,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  memory-region:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.36.0

