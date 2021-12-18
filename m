Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83A479D65
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhLRVZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 16:25:17 -0500
Received: from st43p00im-zteg10063501.me.com ([17.58.63.176]:51761 "EHLO
        st43p00im-zteg10063501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhLRVZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 16:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639862716; bh=r2AqSVvsI4gnERwbd/GXYlwpPKfe4HPm19LsZqj9yhg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=TkczeVpF0AoPIlhZIFmYD3I/E09pjBj0l/a102MCLX+r0O4iR0/u7MqvRFsXkG7Xx
         oz+mxYTCYRDgDj8GN3ULgfzNB5RcWU6j8kTB6iRs3kzfRpJ+/+enNjT4Hr7NclnPlP
         lxAghN8/R8+/FxfYD+KVYZ93XLNomRvEu/ldEcuvZu8yrguxtNUxp4iKwHMics/siq
         j9n0/KeQ7oG28uLToYx2xCVD57/+uMQRh3t8SMqnu1HYHwr+uTB1m5SKeA0yDUw2hY
         4vHC+Sg6Duki78pLEKNiEWSM42MLyK2SN7rLUEXZOLsaHDpn12CdMQ244fTjNm86et
         af3i2cSFUZ6uQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id 74AB5C80666;
        Sat, 18 Dec 2021 21:25:15 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH] pinctrl: st: fix comments compilation warnings
Date:   Sat, 18 Dec 2021 22:25:12 +0100
Message-Id: <20211218212512.196866-1-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-18=5F07:2021-12-16=5F01,2021-12-18=5F07,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1011 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=744
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112180129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes 2 compilation warnings due to comment starting with
/** while not being kernel-doc comments.

drivers/pinctrl/pinctrl-st.c:59: warning: This comment starts with '/**',
but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 *  Packed style retime configuration.
drivers/pinctrl/pinctrl-st.c:73: warning: This comment starts with '/**',
but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Dedicated style retime Configuration register

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/pinctrl/pinctrl-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 1482a01dfec7..ae8783b34ed2 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -55,7 +55,7 @@
 #define ST_GPIO_DIRECTION_OUT	0x2
 #define ST_GPIO_DIRECTION_IN	0x4
 
-/**
+/*
  *  Packed style retime configuration.
  *  There are two registers cfg0 and cfg1 in this style for each bank.
  *  Each field in this register is 8 bit corresponding to 8 pins in the bank.
@@ -69,7 +69,7 @@
 #define RT_P_CFG1_CLKNOTDATA_FIELD(reg)		REG_FIELD(reg, 16, 23)
 #define RT_P_CFG1_DOUBLE_EDGE_FIELD(reg)	REG_FIELD(reg, 24, 31)
 
-/**
+/*
  * Dedicated style retime Configuration register
  * each register is dedicated per pin.
  */
-- 
2.25.1

