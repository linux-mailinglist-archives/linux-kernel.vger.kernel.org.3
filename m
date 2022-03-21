Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03B24E269F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347449AbiCUMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiCUMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:36:02 -0400
X-Greylist: delayed 1791 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 05:34:36 PDT
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8485::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF7B186E0;
        Mon, 21 Mar 2022 05:34:36 -0700 (PDT)
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nWGmA-0006Qk-Rz; Mon, 21 Mar 2022 13:04:42 +0100
X-Virus-Scanned: by amavisd-new 2.12.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from odroid-x2.fritz.box (pd9e89c2f.dip0.t-ipconnect.de [217.232.156.47])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.16.1/SUSE Linux 0.8) with ESMTPSA id 22LC4fR3009568
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Mar 2022 13:04:41 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] w1: w1_therm: Document Maxim MAX31850 thermoelement IF.
Date:   Mon, 21 Mar 2022 13:04:11 +0100
Message-Id: <20220321120415.27533-1-m.reichl@fivetechno.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1647866077;b779f57f;
X-HE-SMSGID: 1nWGmA-0006Qk-Rz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

w1_therm driver supports now MAX31850, too. Add it to documentation
and fix a small typo.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 Documentation/w1/slaves/w1_therm.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
index c3c9ed7a356c..758dadba84f6 100644
--- a/Documentation/w1/slaves/w1_therm.rst
+++ b/Documentation/w1/slaves/w1_therm.rst
@@ -6,7 +6,8 @@ Supported chips:
 
   * Maxim ds18*20 based temperature sensors.
   * Maxim ds1825 based temperature sensors.
-  * GXCAS GC20MH01 temperature sensor.
+  * GXCAS GX20MH01 temperature sensor.
+  * Maxim MAX31850 thermoelement interface.
 
 Author: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 
@@ -15,7 +16,7 @@ Description
 -----------
 
 w1_therm provides basic temperature conversion for ds18*20, ds28ea00, GX20MH01
-devices.
+and MAX31850 devices.
 
 Supported family codes:
 
@@ -137,3 +138,7 @@ bits in Config register; R2 bit in Config register enabling 13 and 14 bit
 resolutions. The device is powered up in 14-bit resolution mode. The conversion
 times specified in the datasheet are too low and have to be increased. The
 device supports driver features ``1`` and ``2``.
+
+MAX31850 device shares family number 0x3B with DS1825. The device is generally
+compatible with DS1825. The higher 4 bits of Config register read all 1,
+indicating 15, but the device is always operating in 14-bit resolution mode.
-- 
2.30.2

