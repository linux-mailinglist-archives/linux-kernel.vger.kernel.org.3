Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1749C739
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbiAZKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiAZKOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:14:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEC0C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:14:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z19so25380302lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=oT7VXAYr1RlKcC98jWVV1AYCja1UpLRPiR4q3wejxVA=;
        b=NvRuai8lXax1U7sBNU4VPS/k14T3EaNJRElshLx90nevrt12JEU4w7LNjtgaGeHU/U
         7If6Ltrt2sE4Umo+ltVazzcWnstLrrUR6Qk3X0glvqP9W3nJdDvZUjD6H1FBM/bHh+CR
         0tGbiigcM7H9yKqJFxQlapVNQgiL9RBGzcW69ZoHx0EHAIFZxvJfbb1t1wFEz38pm6JI
         qRLKHLYs0Nt3xKcs27kEXlm1bJeWeM5ZVj4bIveXRIIkLnpQjaGTa/cL489ujko/V8gi
         ANQmeKzNzp31vXxfxzcssYFcSsFaXiht+4wIBAZde9Yqovz5jF6A1lPFYfP8tVpv3MzU
         fQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=oT7VXAYr1RlKcC98jWVV1AYCja1UpLRPiR4q3wejxVA=;
        b=eQ6HZh//O9qu3dNJex69xhkRn/ZWjnAF+xUONMYZE/TWgBUEjTPBaxHvGSii3xRR5u
         aJtYvd02MESWFtcm6AvAKlcBbI8LpVoS9/ykun5V0SYIiWPskkgzCaUlwHP3wSM5V3KU
         askLuZFhOeXV19hPKRigZ6YDNxy+Ja2K0bD/R9WPcQ0MemwaX+rzZBguN3207kADxnL1
         DaMeHuhSo+jOADfVCZueOarBFAYh0M54f2mmXtDErfz/dvBxGH6CiBpY8lNKrGvLblCX
         kxA2dXHeBm1SQKPKhw8IWDcqxsr81Y+nshEa4JpwUA8vK3FB3kwbzslv7P/P0XS9lapD
         KL0w==
X-Gm-Message-State: AOAM530P+10e6dBPSB9JpVeGZJ6D8MV2lH1uV06PkWukBK61SMXB5lh5
        Cf3W2I59wBMk4C0rvImwgY3etg==
X-Google-Smtp-Source: ABdhPJyfKp3pZx4gkqPihioKFMszACC2nq5auF0qwUCkwVvR4ZEvusm7VaGL+LurbX6E5VROm45fjw==
X-Received: by 2002:ac2:596a:: with SMTP id h10mr14507077lfp.528.1643192089053;
        Wed, 26 Jan 2022 02:14:49 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id h13sm1351906lfv.100.2022.01.26.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 02:14:48 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shaohui Xie <Shaohui.Xie@freescale.com>,
        Scott Wood <scottwood@freescale.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] dt-bindings: net: xgmac_mdio: Remove unsupported "bus-frequency"
Date:   Wed, 26 Jan 2022 11:14:28 +0100
Message-Id: <20220126101432.822818-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126101432.822818-1-tobias@waldekranz.com>
References: <20220126101432.822818-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property has never been supported by the driver. The kernel has
settled on "clock-frequency" as the standard name for this binding, so
once that is supported we will document that instead.

Fixes: 7f93c9d90f4d ("power/fsl: add MDIO dt binding for FMan")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 Documentation/devicetree/bindings/net/fsl-fman.txt | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-fman.txt b/Documentation/devicetree/bindings/net/fsl-fman.txt
index 020337f3c05f..cd5288fb4318 100644
--- a/Documentation/devicetree/bindings/net/fsl-fman.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fman.txt
@@ -388,15 +388,6 @@ PROPERTIES
 		Value type: <prop-encoded-array>
 		Definition: A standard property.
 
-- bus-frequency
-		Usage: optional
-		Value type: <u32>
-		Definition: Specifies the external MDIO bus clock speed to
-		be used, if different from the standard 2.5 MHz.
-		This may be due to the standard speed being unsupported (e.g.
-		due to a hardware problem), or to advertise that all relevant
-		components in the system support a faster speed.
-
 - interrupts
 		Usage: required for external MDIO
 		Value type: <prop-encoded-array>
-- 
2.25.1

