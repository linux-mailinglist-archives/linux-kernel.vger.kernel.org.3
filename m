Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5700549A85A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbiAYDDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:03:48 -0500
Received: from msg-1.mailo.com ([213.182.54.11]:38836 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3415602AbiAYBsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1643059590; bh=B0piSC9qtUYLnw/vHlf3uG2RVSjyvLZbXc9kETb2dps=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=gfe7PiSufHSaBsOk+YCqIwSZvSARFCUvijL64FrI9oGwOKaUH4EiXZq9TPatU8kKq
         ablfX+nM1oa+XZNE2E4SaRCPuA6FCnHvZCMOq9Yur1MKrHzTD6veYO+rcmlUzYeGmE
         x3SkY0cMPh102JxL5CZ2zH3bzZvV6kav1VKvSkX8=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Mon, 24 Jan 2022 22:26:30 +0100 (CET)
X-EA-Auth: XxMD6+jMWUuyMYNiDJ1/Eaj50WF3RUbsR9ZoRQaZanMZFItAGQf1ZXqB4kpfpysTNLhgScStCAMkwqBzQTJc2DOHWCTytv9uVrm0o4434rk=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     dmitry.torokhov@gmail.com, stephan@gerhold.net
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/5] dt-bindings: input: touchscreen: msg2638: Document msg2138 support
Date:   Mon, 24 Jan 2022 22:26:08 +0100
Message-Id: <20220124212611.752603-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124212611.752603-1-vincent.knecht@mailoo.org>
References: <20220124212611.752603-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document msg2138 support by adding mstar,msg2138 compatible.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
v2:
- picked up Rob's Ack
---
 .../devicetree/bindings/input/touchscreen/mstar,msg2638.yaml  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml b/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
index 3a42c23faf6f..2fb7e01bb65a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/mstar,msg2638.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: mstar,msg2638
+    enum:
+      - mstar,msg2138
+      - mstar,msg2638
 
   reg:
     const: 0x26
-- 
2.34.1



