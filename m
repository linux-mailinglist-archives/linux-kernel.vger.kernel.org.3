Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756A85B05E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIGN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIGN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:58:34 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E6AC256;
        Wed,  7 Sep 2022 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662559113;
  x=1694095113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p4pwoRqjcrypDWv1qomhRQL50yJNPV0RDYOaGGrbH/M=;
  b=TTelaBDOJ1kRMsy+lTHE2ZudSZw4hrJR0AVy+RszmRhQ2jhtxxCdWJbj
   3o823Eyu38XUlPQ92R75DPlFbRUW8CKsqbO1wppWT7iquH/ksY9o73K3f
   oiQtBKcbOOYEAY4orlH8EtIR+wSlccjRge0tpnA56MyL5lDNSxZov6T/3
   QxnzkxkYsbuDRypojPW1g3FINRrKWaRXNgLcfNLCb33A5ckX0eZkbEcyF
   /6NchAT1wKnU+nNbvrbfdNASJFkPFCOoMwSSepcd/PH1x2yVcjgTAGhCi
   9Gg2lD7Z6o60I6xb8y/P0BbjSEHRREBxa+cjcpMFa9b0YO6aBuk9ehVnk
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        Astrid Rost <astrid.rost@axis.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce times
Date:   Wed, 7 Sep 2022 15:58:27 +0200
Message-ID: <20220907135827.16209-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree parameters to control the insertion, release and press
debounce times.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 Documentation/devicetree/bindings/sound/ts3a227e.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ts3a227e.txt b/Documentation/devicetree/bindings/sound/ts3a227e.txt
index 21ab45bc7e8f..a4aa4154c54c 100644
--- a/Documentation/devicetree/bindings/sound/ts3a227e.txt
+++ b/Documentation/devicetree/bindings/sound/ts3a227e.txt
@@ -17,6 +17,15 @@ Optional properies:
       Select 0/1/2/3/4/5/6/7 to specify MICBIAS voltage
       2.1V/2.2V/2.3V/2.4V/2.5V/2.6V/2.7V/2.8V
       Default value is "1" (2.2V).
+ - ti,debounce-release: key release debounce (datasheet section 9.6.7).
+      Select 0/1 to specify the release debounce time 0ms/20ms
+      Default value is "1" (20 ms).
+ - ti,debounce-press: key press debounce (datasheet section 9.6.7).
+      Select 0/1/2/3 to specify the press debounce time 2ms/40ms/80ms/120ms
+      Default value is "2" (80 ms).
+ - ti,debounce-insertion: headset insertion debounce (datasheet section 9.6.5).
+      Select 0/1/2/3/4/5/6/7 to specify the insertion debounce time 2ms/30ms/60ms/90ms/120ms/150ms/1s/2s
+      Default value is "3" (90 ms).
 
 Examples:
 
-- 
2.20.1

