Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B3D481F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbhL3SGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:06:24 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:33396 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbhL3SGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:06:19 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:a9e6:6f2a:78f1:2f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8F1E028A0E9;
        Thu, 30 Dec 2021 19:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640887577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yr6gchtCX9936GGbILXch7LDeMKywbeBcvVtA1dQaLg=;
        b=ZmOoK1hplli8SCAj11Sf+f/nZyOTivmEzODVVtcbuUuuutqiVqPuvudXLjUtEB7Iu9DVUE
        9WielxOWPJC31EHGuLuqJbetjriY30xPFc3JvjlDEB0g05I4lQseHLuFSrMiMO6f3NnLxr
        3Ll2oB/4BJvlVVsJ9mGMCX1X9RkaGIsdH8ntC9fYmXLcDqFTyeiflgXbtkl4hdsCwmoNFL
        9e+7NMnTLU5tRVggG/5GczCQFoIOBaCfkufzvvwQB/28qdV8jwlyONQ+n2sY0Wjc3p/3zC
        uWot4PMWMJk0RaJqQvk+NGLbjJ8L8eNaRtouqghEJfimbrYDoR/gB6wRvsgTDg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 3/3] dt-bindings: power: reset: gpio-restart: Correct default priority
Date:   Thu, 30 Dec 2021 19:06:03 +0100
Message-Id: <cfcd00257daba5aa30b8d20a62ba542be1a6914c.1640887456.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640887456.git.sander@svanheule.net>
References: <cover.1640887456.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bcd56fe1aa97 ("power: reset: gpio-restart: increase priority
slightly") changed the default restart priority 129, but did not update
the documentation. Correct this, so the driver and documentation have
the same default value.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 Documentation/devicetree/bindings/power/reset/gpio-restart.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
index 13827fe7b395..ab26af93cb39 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
@@ -51,7 +51,7 @@ properties:
   priority:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-      A priority ranging from 0 to 255 (default 128) according to the following
+      A priority ranging from 0 to 255 (default 129) according to the following
       guidelines:
       0:    Restart handler of last resort, with limited restart
             capabilities
-- 
2.33.1

