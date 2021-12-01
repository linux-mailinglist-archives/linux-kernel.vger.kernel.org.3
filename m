Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4B4649B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhLAIeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:34:36 -0500
Received: from mx22.baidu.com ([220.181.50.185]:52478 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230433AbhLAIef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:34:35 -0500
Received: from BC-Mail-Ex19.internal.baidu.com (unknown [172.31.51.13])
        by Forcepoint Email with ESMTPS id 7E66084790FF601DCCD3;
        Wed,  1 Dec 2021 16:31:00 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex19.internal.baidu.com (172.31.51.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 1 Dec 2021 16:31:00 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 1 Dec 2021 16:30:59 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jic23@kernel.org>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <kernel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] MAINTAINERS: Update i.MX 8QXP ADC info
Date:   Wed, 1 Dec 2021 16:31:00 +0800
Message-ID: <20211201083100.1587-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex13.internal.baidu.com (172.31.51.53) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address to use developer mail address,
because the old address will be dropped soon.

And change the status from 'Supported' to 'Maintained' for me
to look after this code without any payment now.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9331225b7162..79b89056ecd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13774,9 +13774,9 @@ F:	Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
 F:	drivers/gpu/drm/imx/dcss/
 
 NXP i.MX 8QXP ADC DRIVER
-M:	Cai Huoqing <caihuoqing@baidu.com>
+M:	Cai Huoqing <cai.huoqing@linux.dev>
 L:	linux-iio@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 F:	drivers/iio/adc/imx8qxp-adc.c
 
-- 
2.25.1

