Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F6C4D1C82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbiCHP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348832AbiCHP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:58:41 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FD20F66;
        Tue,  8 Mar 2022 07:57:41 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 255A420007;
        Tue,  8 Mar 2022 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646755060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3BgP3y4Wp+MpBJ8ILVTsKQK/gjfpJQE//ZntTh5TT1o=;
        b=gXEof1UQ3IyZ+hU1QEjgiRt1ohjCnuvVFYQ480fsMsaD2tecN6s7HWOVhSl5ICU+g3pSB0
        Uan1AOlbdMw0dsEh5vhYI/SzbmHzCHrmC5sxBgDiBMla0/shK/P2Q2EjbkmsXSQ00aVCt9
        ZiHK64jAFnt16Dc5588NNNmQcTnn1jN23pzKvWCy8v8FgDagRpKVYW3fuW64kt6VlwG3di
        bbiyW+GkU38GvdpTfCK85xTd15e8Tcd1fIuIv/EFJ2dtUkcADLj8w5JzRykCR6AjQS7dCa
        vuKZD637NLckzCmmJKotF/ZyFsLJD6s3gJkQnGucIn3+09WCa6NfCvl2I65jrQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: rtc: at91: rename rtt bindings file
Date:   Tue,  8 Mar 2022 16:57:35 +0100
Message-Id: <20220308155735.54146-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atmel,at91sam9-rtc is a confuing name for this file as it is documenting
the RTT used as an RTC and not the other regular RTC (atmel,at91rm9200-rtc
and atmel,at91sam9x5-rtc)

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml}   | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
rename to Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
-- 
2.35.1

