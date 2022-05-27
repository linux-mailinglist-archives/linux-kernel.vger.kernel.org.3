Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00D53670D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354427AbiE0SoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354424AbiE0SoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:44:15 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3076F136A;
        Fri, 27 May 2022 11:44:11 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A8961A1EF9;
        Fri, 27 May 2022 20:44:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3357C1A1EEF;
        Fri, 27 May 2022 20:44:10 +0200 (CEST)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 97CC9180031D;
        Sat, 28 May 2022 02:44:08 +0800 (+08)
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: [PATCH v4 2/3] misc: uwb: Maintainers list for Nxp Uwb SR1XX SOCs family drivers
Date:   Sat, 28 May 2022 00:13:50 +0530
Message-Id: <20220527184351.3829543-3-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
References: <20220527184351.3829543-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ultra-wideband (UWB) is a short-range wireless communication protocol.

NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
are FiRa Compliant. SR1XX SOCs are flash less devices and they need
Firmware Download on every device boot. More details on the SR1XX Family
can be found at https://www.nxp.com/products/:UWB-TRIMENSION

The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
Interface (UCI).  The corresponding details are available in the FiRa
Consortium Website (https://www.firaconsortium.org/).

Message-ID: <20220504171337.3416983-1-manjunatha.venkatesh@nxp.com>
Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41c9c8f2b96d..3d64aa8bac0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14306,6 +14306,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 F:	drivers/nfc/nxp-nci
 
+NXP-SR1XX UWB DRIVER
+M:	Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
+F:	drivers/misc/nxp-sr1xx.c
+
 NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
 M:	Mirela Rabulea <mirela.rabulea@nxp.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
-- 
2.35.1

