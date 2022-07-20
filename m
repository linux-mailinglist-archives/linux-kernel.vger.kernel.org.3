Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CFD57B56C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbiGTL25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiGTL2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:28:43 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDD0F71BEB;
        Wed, 20 Jul 2022 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TYIgg
        /PlbP29w5F1405EGzWjJvpb6kd30y4NImKnpHs=; b=d/huU6sylnBBJTLL6VeKC
        tjJqbC0bRkhI1A4MBf/Vs+kbW3wVYqmGHkEy93Xf+1wFemNv09aj9Z+j5A/1iy/b
        zG0LfNdmr4YksUcIaCs1oqGLEOczv0I9OB+DliQk0Gb1kbDID159xz3kko49mJYn
        7M7Q6b96VRI1lqCFLXrPKQ=
Received: from localhost.localdomain (unknown [112.97.48.93])
        by smtp1 (Coremail) with SMTP id GdxpCgCHwpa25tdizLSKPQ--.259S2;
        Wed, 20 Jul 2022 19:27:52 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] dt-bindings: arm: msm: Fix typo in comment
Date:   Wed, 20 Jul 2022 19:27:48 +0800
Message-Id: <20220720112748.17752-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgCHwpa25tdizLSKPQ--.259S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7GrWkAF4UAryrJF17WryDKFg_yoW8JrWxpa
        yxCrnrGF97W3W3W397XF18AFW5Cry8C3y0kF1Utr1Dtrn8Ca4SqFySgw1FyF1xAFWkCFy8
        XF40gr4jv3yqkr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnSd9UUUUU=
X-Originating-IP: [112.97.48.93]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJRlEZGAJpI+oUQAAsn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index 94d50a949be1..c0e3c3a42bea 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -10,7 +10,7 @@ system, notifying them when a low power state is entered or exited.
 Multiple revisions of the SAW hardware are supported using these Device Nodes.
 SAW2 revisions differ in the register offset and configuration data. Also, the
 same revision of the SAW in different SoCs may have different configuration
-data due the the differences in hardware capabilities. Hence the SoC name, the
+data due the differences in hardware capabilities. Hence the SoC name, the
 version of the SAW hardware in that SoC and the distinction between cpu (big
 or Little) or cache, may be needed to uniquely identify the SAW register
 configuration and initialization data. The compatible string is used to
-- 
2.25.1

