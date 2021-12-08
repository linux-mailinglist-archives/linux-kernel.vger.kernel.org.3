Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89F546DB6A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhLHSpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:45:30 -0500
Received: from ixit.cz ([94.230.151.217]:33374 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239184AbhLHSp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:45:28 -0500
Received: from localhost.localdomain (unknown [213.151.89.154])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8FB9821F5E;
        Wed,  8 Dec 2021 19:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1638988914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E6CzSTdCYAMGezmnNXmZhiYO0sPrum9WlpA8U6aZ9vQ=;
        b=UF8whN7TTAUxmTTmmrjM3yU86dOvKzKQvQICqnTFAtdcLwKRT9adtLQfCjzULHTLXxtgXq
        DV+lylLpknPYzNnszKlLlIK+LfYvBfSQ7wEbTIibaJneyML5Clwro0l43J8yCcktlp6e2b
        kKWtzCQN7+tMMi533aPKg7oY15MVS20=
From:   David Heidelberg <david@ixit.cz>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Wei Xu <xuwei5@hisilicon.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: reset: document deprecated HiSilicon property
Date:   Wed,  8 Dec 2021 19:41:49 +0100
Message-Id: <20211208184149.99537-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documenting deprecated property prevents dt-schema validation errors.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - document deprecated property instead of changing hi36[67]0.dtsi

.../devicetree/bindings/reset/hisilicon,hi3660-reset.yaml    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
index b0c41ab1a746..cdfcf32c53fa 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
@@ -24,6 +24,11 @@ properties:
           - const: hisilicon,hi3670-reset
           - const: hisilicon,hi3660-reset
 
+  hisi,rst-syscon:
+    deprecated: true
+    description: phandle of the reset's syscon, use hisilicon,rst-syscon instead
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   hisilicon,rst-syscon:
     description: phandle of the reset's syscon.
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.33.0

