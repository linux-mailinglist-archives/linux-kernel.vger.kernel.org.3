Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06898489925
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiAJNCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiAJNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F03BC03400E;
        Mon, 10 Jan 2022 05:00:02 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:59:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oy9woQzeYJqmBLL+hSbva6ZR8FGkR+Bun4Bwa33zV3w=;
        b=kNf274puQ9paQlvg94Jqap8yELITIh8gJnXBnQw8j3f4dHt6gJgK2IF+ScRt3q9Xvg2K7i
        64x8yj1Xf5VMjaej0+BRPxFR758wvfSBmXaFHGrgXiBQlMh7EARQLOJydxWzYyAFFk3/Tl
        nvrniwRAiyHKFYkMi3hqsQKrUjeezgqdtNKzynTKbyU6vqB+t4eqdHJNLrg4Ho3qI7jRJy
        E83rd2tnn7S2CPk4U/H8srzw5/cn/FAKiJ/ejfnGHDZB2X+dSf1s5GYs/0skHmkMqyHrtz
        Jt5oTAOo58ATBvf3gR0NXayodFTSctEvIEbiWZVPYI33fYRXsAaaB11uWrtWZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oy9woQzeYJqmBLL+hSbva6ZR8FGkR+Bun4Bwa33zV3w=;
        b=SA60zky/wF/T+K1TuYiJEPhx6si7V3n6expoWCU7vpm0pumZdB0TZVPH7Zu05rDQ+wRXI+
        EtPYPhtHGmG0A4Dg==
From:   "tip-bot2 for Jacky Bai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: tpm-timer: Add imx8ulp
 compatible string
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126074002.1535696-4-peng.fan@oss.nxp.com>
References: <20211126074002.1535696-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164181959930.16921.12955922537675364828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     453e2cadc97ca52e423852435522eb7d4f4b5b6b
Gitweb:        https://git.kernel.org/tip/453e2cadc97ca52e423852435522eb7d4f4b5b6b
Author:        Jacky Bai <ping.bai@nxp.com>
AuthorDate:    Fri, 26 Nov 2021 15:39:58 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 29 Nov 2021 11:02:02 +01:00

dt-bindings: timer: tpm-timer: Add imx8ulp compatible string

The tpm timer on i.MX8ULP is derived from i.MX7ULP, it use two
compatible strings, so update the compatible string for it.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20211126074002.1535696-4-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
index edd9585..f69773a 100644
--- a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
@@ -19,7 +19,11 @@ description: |
 
 properties:
   compatible:
-    const: fsl,imx7ulp-tpm
+    oneOf:
+      - const: fsl,imx7ulp-tpm
+      - items:
+          - const: fsl,imx8ulp-tpm
+          - const: fsl,imx7ulp-tpm
 
   reg:
     maxItems: 1
