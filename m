Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2FB46490C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347565AbhLAHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241808AbhLAHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:48:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEFCC061574;
        Tue, 30 Nov 2021 23:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 447BCB81DBD;
        Wed,  1 Dec 2021 07:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D506EC53FCE;
        Wed,  1 Dec 2021 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638344710;
        bh=PhKsrRw9R4/4lBT6Vqg0SK7GxrnEvzF/EvK1ACPean8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DH6vwBrPEsGI5LHMAqUhLvQu/pepqvR/kP6544IoQ4V4h96pQQYr+m4rwKZO0R2sI
         q0sKlM7uhpxTTMm+lPaJVs2qizEOsn444NspzQ9C2Df+0vr4O/cO9Oj4SwxHBBR8/Y
         dkBfiqDtdy2vF41Xg//h+pgyZMIWd3IaIJDl5ha1AJgHlhF2eaPr9kYw4cY+kTOck3
         SnB6hA5tI+OVs2Q9V8lnHS/n8PxW5finVy5T737OZNVtiep5lUTuzl/FBNu+Sj+hcj
         BjgzHkQoa58VQMIdI62eYfjPC9vrBeQW6x374x+nkWvHvoBTYW8zsilJ1kkE3+qIzd
         0GWXpgy4OULTw==
From:   Vinod Koul <vkoul@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] scsi: ufs: dt-bindings: Add SM8450 compatible strings
Date:   Wed,  1 Dec 2021 13:14:54 +0530
Message-Id: <20211201074456.3969849-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201074456.3969849-1-vkoul@kernel.org>
References: <20211201074456.3969849-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document "qcom,sm8450-ufshc" compatible string. "qcom,sm8450-ufshc" is
for UFS HC found in SM8450 SoC.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index d8fd4df81743..d0fee78e6203 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -16,6 +16,7 @@ Required properties:
 			    "qcom,sm8150-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
 			    "qcom,sm8250-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
 			    "qcom,sm8350-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
+			    "qcom,sm8450-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
 - interrupts        : <interrupt mapping for UFS host controller IRQ>
 - reg               : <registers mapping>
 
-- 
2.31.1

