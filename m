Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD994FF404
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiDMJrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiDMJq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:46:57 -0400
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4844E3B2B9;
        Wed, 13 Apr 2022 02:44:30 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 23D9iDHH014454; Wed, 13 Apr 2022 18:44:13 +0900
X-Iguazu-Qid: 34trMBIs3DXverXhLu
X-Iguazu-QSIG: v=2; s=0; t=1649843053; q=34trMBIs3DXverXhLu; m=Og2oeBoBh1hoZh8oSI6h3l3zIr8QWsoxe2Bjtw+Rt6E=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 23D9iCZY038502
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 18:44:13 +0900
X-SA-MID: 2335256
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 5/5] MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
Date:   Wed, 13 Apr 2022 18:42:03 +0900
X-TSB-HOP2: ON
Message-Id: <20220413094203.25714-6-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd36acc87..62d547008 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2792,12 +2792,14 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
+F:	Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
+F:	drivers/media/platform/visconti/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
 F:	drivers/gpio/gpio-visconti.c
 F:	drivers/pci/controller/dwc/pcie-visconti.c
-- 
2.17.1


