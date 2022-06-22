Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26F5548AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355398AbiFVKn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356400AbiFVKnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:43:43 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4260F17A8D;
        Wed, 22 Jun 2022 03:43:38 -0700 (PDT)
X-QQ-mid: bizesmtp71t1655894543tpupmw1j
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 18:42:19 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000D00A0000000
X-QQ-FEAT: ZOXnxASMPe5VRBWgokSLGXBTaMGzlhJqYKX2egOFszHMTGu2cDh1vfuVNM0/i
        ObP6isGPyykUBTCAg1gRhkvP6BChVZduonyKGas1SOfEearuutvSWSX5x8XsB7agA3cDIfE
        bf0fghZXbno+EP33ipXOdsrEMiW+L+6P1PDI5oWAErHuRNTIkRqqxzDo/GNAek76e1wFoOF
        uiuHFrg22WNrU72lq371buW8mLb26DR+TuVSXSbl/JL9KPHQiR/mwQ+RpPcGqQ3KdfbOjKT
        qoXxAbDRzdN41Ctwqf/yEDdRtyXAN5T84trruwx1DlpkkgP4Dz5IJUMf1cUq4LjVbmWyhuc
        qt6u7NvPZk7BM/ysR8+aLGiPdJCGg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] USB: serial: mos7720: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 18:42:17 +0800
Message-Id: <20220622104217.7934-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/usb/serial/mos7720.c
line: 829

        * the endpoint descriptors here so that the the first and
changed to:
        * the endpoint descriptors here so that the first and

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/usb/serial/mos7720.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 1e12b5f30dcc..23ccbba716c7 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -826,7 +826,7 @@ static int mos77xx_calc_num_ports(struct usb_serial *serial,
 		/*
 		 * The 7715 uses the first bulk in/out endpoint pair for the
 		 * parallel port, and the second for the serial port. We swap
-		 * the endpoint descriptors here so that the the first and
+		 * the endpoint descriptors here so that the first and
 		 * only registered port structure uses the serial-port
 		 * endpoints.
 		 */
-- 
2.17.1

