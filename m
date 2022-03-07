Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7164D031A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiCGPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiCGPmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:42:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D322BE8;
        Mon,  7 Mar 2022 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646667672; x=1678203672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h0xRMSmKEeEBA5dGXk9zIisvS1APReTBxOvqtE6cP0c=;
  b=ppfzI4gNsSS/2av1i5Bj3lp95IpPpnSJMf6csEgEec+jBH+Ul327LdBx
   x8m0IQflBuoCeSKl9EMhn2xIxToBhTh+eaScvma8QK8UcF4iHAa9dpcOD
   4H+rMHLKhsOIv2XOw7N6Whwb5j+vV85T4E28MEPe+SjUwkMW0YX0qQlHS
   9zEr4pZbUqUeEqBBVsjIuORhOMxS7Oi2+svURJ953GwEHJPCJHQdF00V2
   Voia84539rpf4zTKEcAR+oBtj6NP7L3CBs9GAPofyUxfNc4nguqmzk/KD
   D5OttHCFIcXIHvugYo/zjmP2qdE5af03t4PruRkQmx0Ag6bjvYBpw/Vnn
   g==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155514409"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 08:41:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 08:41:09 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 08:41:03 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <claudiu.beznea@microchip.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v3 0/2] dt-bindings: pwm: convert atmel pwm to json-schema
Date:   Mon, 7 Mar 2022 17:36:54 +0200
Message-ID: <20220307153656.177589-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the conversion of the Atmel PWM DT
binding to the DT Schema format and adds the SAMA7G5 compatible to
the respective converted binding.

Changes since v2:
- Moved `allOf` between `maintainers and `properties`
- Replaced `additionalProperties: true` with
 `unevaluatedProperties: false`
- Used 4 spaces indentation for `examples`
- Modified file path in `MAINTAINERS`

Sergiu Moga (2):
  dt-bindings: pwm: convert atmel pwm to json-schema
  dt-bindings: pwm: at91: Add SAMA7G5 compatible strings list

 .../bindings/pwm/atmel,at91sam-pwm.yaml       | 47 +++++++++++++++++++
 .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 --------------
 MAINTAINERS                                   |  2 +-
 3 files changed, 48 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt

-- 
2.25.1

