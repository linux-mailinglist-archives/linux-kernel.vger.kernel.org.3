Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048E58EE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiHJOTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:19:14 -0400
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1514.securemx.jp [210.130.202.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8C72867;
        Wed, 10 Aug 2022 07:19:12 -0700 (PDT)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 27ADYBu0001630; Wed, 10 Aug 2022 22:34:11 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27ADXWQt004392; Wed, 10 Aug 2022 22:33:32 +0900
X-Iguazu-Qid: 34trbpZOfxdrYAuJt4
X-Iguazu-QSIG: v=2; s=0; t=1660138412; q=34trbpZOfxdrYAuJt4; m=JZGbdTzhMCopwAS/kSRkstYoG19+c9pcH1uvin1I6zQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 27ADXVpQ039291
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 Aug 2022 22:33:31 +0900
X-SA-MID: 43725403
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v3 4/4] MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
Date:   Wed, 10 Aug 2022 22:28:22 +0900
X-TSB-HOP2: ON
Message-Id: <20220810132822.32534-5-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entries for visconti Video Input Interface driver, including;
* device tree bindings
* source files
* documentation files

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v2:
- no change

Changelog v3:
- added entry for driver API documentation
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd36acc87..04423ae9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2792,12 +2792,15 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
+F:	Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
+F:	Documentation/driver-api/media/drivers/visconti-viif.rst
 F:	arch/arm64/boot/dts/toshiba/
+F:	drivers/media/platform/visconti/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
 F:	drivers/gpio/gpio-visconti.c
 F:	drivers/pci/controller/dwc/pcie-visconti.c
-- 
2.17.1


