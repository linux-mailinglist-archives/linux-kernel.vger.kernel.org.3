Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E212A559718
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiFXJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiFXJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:56:30 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B097A18E;
        Fri, 24 Jun 2022 02:56:28 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 79B69FF80B;
        Fri, 24 Jun 2022 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656064584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVgqzRvfAvuojl1wIRntTLDYoVESh+j34faXY7UfTU8=;
        b=ZeJRukcZnf1JUcwe7qc+TtenAZN8LaquLH491VJV4j+eXDKhH7e0SOJOLg8ldYi1PSBdmV
        cWrxp/23v3Hx+jN0YX2lT3AIWiWIgC16fXga1pAI6lCUzKg20ly/0UTzgXdtx89NB5J67q
        PDCNHNdvV+LX5VaUKBVsiIpWsrvfyjfjS+WJa5aMyRCGujEPT4aMhKDhETWDTPRS2ZQhTO
        FJ8h2w2cmbOPMtIR29fYqTpQSS8GeRbZFd0Wn5BHCJMmH7f8v0asBCTDmZdRGtov2VT4+l
        iBPQ97+4QfrE4TOECIlEAFi5Mvyj9GvT1Sl/ulOKPP5BWDWxFViSaAwnu9cLew==
From:   Kory Maincent <kory.maincent@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Michael Welling <mwelling@ieee.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: dac: mcp4922: expand for mcp4921 support
Date:   Fri, 24 Jun 2022 11:56:18 +0200
Message-Id: <20220624095619.1415614-2-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624095619.1415614-1-kory.maincent@bootlin.com>
References: <20220624095619.1415614-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the MCP4921 DAC.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
index 12a14b3f36cb..4c430abcdbf9 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - microchip,mcp4902
       - microchip,mcp4912
+      - microchip,mcp4921
       - microchip,mcp4922
 
   reg:
-- 
2.25.1

