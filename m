Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302658FAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiHKKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:37:30 -0400
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F79019A;
        Thu, 11 Aug 2022 03:37:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FC46A538C;
        Thu, 11 Aug 2022 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1660213894; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=O0SbgWpv9ADCfK8illr/JNc6pF355fL2wbYM6MC/UEs=;
        b=s8bc4b5FXWD8uwS1VSNcw5slDaINjAIcYtH5Ye0lRDdsJ9ezGQv/yNZ2/XtZ/Z7DU3BB29
        DmlhWweRU8UmIRRQHJihaKDXBetBM4giViO5hqpLg+MZGd+DImSWk6/FAMJ78wpQGO0kIl
        KMhbqrNiS1nn0mQdAzIFDno8xUJrIzhYN1TTDGrD3zHgIbtz/JOQ10YMwMuqZuyX/vzAQo
        sE+5D2PL6VMu+ysByVPIxaShLUOfki6m1JdfocLnVXjZd0rzaFkaBOKhHgDjm86AAa0UfW
        dl+b1X/WgJblCfYd/s19Ojifu1+Ti0Tmk68IrbnoGPdoRZwmwpklhKw/S49NbA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: amlogic: add bindings for Jethub D1p (j110)
Date:   Thu, 11 Aug 2022 13:31:13 +0300
Message-Id: <20220811103113.3097868-3-adeep@lexina.in>
In-Reply-To: <20220811103113.3097868-1-adeep@lexina.in>
References: <20220811103113.3097868-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JetHome JetHub D1p is a home automation controller, modification
 of JetHub D1 based on Amlogic A113X

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 61a6cabb375b..9ac73e961146 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -136,6 +136,7 @@ properties:
           - enum:
               - amlogic,s400
               - jethome,jethub-j100
+              - jethome,jethub-j110
           - const: amlogic,a113d
           - const: amlogic,meson-axg
 
-- 
2.30.2

