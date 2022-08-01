Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3840B586407
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiHAGWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiHAGWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:22:48 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5CD13FB4;
        Sun, 31 Jul 2022 23:22:47 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIOpB-0006YE-Mj; Mon, 01 Aug 2022 08:22:45 +0200
Message-ID: <c17f79c7-40ba-ab10-dd0a-0f6e2634717a@birger-koblitz.de>
Date:   Mon, 1 Aug 2022 08:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
From:   Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH 7/7] spi: realtek-rtl: update devicetree documentation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659334967;7b32f370;
X-HE-SMSGID: 1oIOpB-0006YE-Mj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation to include the optional clocks and
spi-max-frequency properties in the devicetree node.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
  .../devicetree/bindings/spi/realtek,rtl-spi.yaml       | 10 ++++++++++
  1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
index 2f938c293f70..e790a85067d3 100644
--- a/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
@@ -21,9 +21,17 @@ properties:
        - realtek,rtl8391-spi
        - realtek,rtl8392-spi
        - realtek,rtl8393-spi
+      - realtek,rtl9300-spi
+      - realtek,rtl9310-spi

    reg:
      maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  spi-max-frequency: 1
+    maxItems: 1

  required:
    - compatible
@@ -36,6 +44,8 @@ examples:
      spi: spi@1200 {
          compatible = "realtek,rtl8382-spi";
          reg = <0x1200 0x100>;
+        clocks = <&lx_clk>
+        spi-max-requency = <25000000>;
          #address-cells = <1>;
          #size-cells = <0>;
      };
-- 
2.25.1

