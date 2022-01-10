Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7048990F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiAJNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42878 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiAJNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:04 -0500
Date:   Mon, 10 Jan 2022 13:00:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKmFNFmPRnCpKoiJIKtqPlN4FAGbhd2Ydv8GErE1XLA=;
        b=2VldjWK4H2DrXd4QCEmNo9y44kDDU5EFb2bL5/M3jiUtb7VBEbE5wv73dt3cOsOmAuDODK
        IJUKPELp/TKG2/Z2vUmaICPtcctQsaCyvR8fvnto6lMex32eiWIMJDBup6AyDbM0PSii3k
        mWkApFkHOLYkWJBITTXTQRyxp27msKNvbarY6D0ReyIfIO7nEVglbPi+zG6FBebJaGRPWm
        U2TmblLJVfeNbylywroOYeiPBzdppJnhzfNrqMzIaBt08PvtxMnPMaRq0WLCzaLoABwaRv
        FIYPOu6XflaFM7HmSH0tRCElGg6E1V+699kif7qgmAuNV6TfYJRrb/W3S4PvuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKmFNFmPRnCpKoiJIKtqPlN4FAGbhd2Ydv8GErE1XLA=;
        b=cvBDudeLfaR5cvycHLSlYeA5WM4vTVzxCB1ZWCWbbaR1tY1XShPLyNLLY7bpb9lQMa4Elz
        ycgy93NCDuzI1hCg==
From:   "tip-bot2 for Johan Jonker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: remove rockchip,rk3066-timer
 compatible string from rockchip,rk-timer.yaml
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210824095637.2547-1-jbx6244@gmail.com>
References: <20210824095637.2547-1-jbx6244@gmail.com>
MIME-Version: 1.0
Message-ID: <164181960160.16921.4968926594343361131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ad253b3dd79851d926154ef747a69427573233e4
Gitweb:        https://git.kernel.org/tip/ad253b3dd79851d926154ef747a69427573233e4
Author:        Johan Jonker <jbx6244@gmail.com>
AuthorDate:    Tue, 24 Aug 2021 11:56:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Nov 2021 18:40:11 +01:00

dt-bindings: timer: remove rockchip,rk3066-timer compatible string from rockchip,rk-timer.yaml

The Rockchip rk3066 timers have a different register layout then rk3288
with only a 32 vs 64 bits timer channel. The timers in rk3066a.dtsi have
"snps,dw-apb-timer" as compatible string, so remove the
"rockchip,rk3066-timer" from rockchip,rk-timer.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210824095637.2547-1-jbx6244@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index e26ecb5..5d157d8 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -18,7 +18,6 @@ properties:
           - enum:
               - rockchip,rv1108-timer
               - rockchip,rk3036-timer
-              - rockchip,rk3066-timer
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
