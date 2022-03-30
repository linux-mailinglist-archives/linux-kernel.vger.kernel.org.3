Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E35A4EBC28
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbiC3Hxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243969AbiC3HxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:53:24 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56118CD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=IZkMiRw9WhxMQ9/LVXwDXkE/Ak6TV7yqUEA6+QEqUuk=;
        b=dPgdouJivxKjAWUeUPpVm3mLyNQVXtMpGsuLMHJSAZUT5VsQXpUqryN5xWss/F/ztZavFRJ76IUnL
         dsNE63bB8mk1+EgFaNvMTEqU4nDIP5g3UEKfRgkygInIbssczmbk1Uo6A8/yeqvZBapJ1k8vKP1DDn
         yCjTkEHtN9xOupsRtsKE/+3/JRkZaO33rUT6vGX1/T5ysL6TH+d1jvP96GvyoHDQOfV4O0kr2jFYqr
         oNIKKZhdkm9PHD0s3IsenWSF6ReBIiuqIAGFmWxAuJeOg42Gx7Iogrv6RWbl2XKyWOx1RcTLbgbN96
         R5oebrOce5zCednS+ZSRFhTM55NlOWA==
X-MSG-ID: f46e147e-affb-11ec-b450-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH 2/2] dt-bindings: auxdisplay: holtek,ht16k33.yaml: Add holtek,refuse-primary-fb
Date:   Wed, 30 Mar 2022 09:34:40 +0200
Message-Id: <20220330073440.3986724-3-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330073440.3986724-1-david@protonic.nl>
References: <20220330073440.3986724-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DT property that will cause the holtek auxdisplay driver to
back off if it detects that it is the first driver to probe a framebuffer
device.

Signed-off-by: David Jander <david@protonic.nl>
---
 .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
index fc4873deb76f..4de32c3e26ce 100644
--- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
@@ -53,6 +53,9 @@ properties:
     $ref: /schemas/leds/common.yaml#
     unevaluatedProperties: false
 
+  holtek,refuse-primary-fb:
+    description: Refuse to claim the first framebuffer device
+
 required:
   - compatible
   - reg
-- 
2.32.0

