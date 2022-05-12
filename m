Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3A5255CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358085AbiELTeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358061AbiELTeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:34:11 -0400
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C5233A51;
        Thu, 12 May 2022 12:34:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2024596|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0241831-0.0114817-0.964335;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.NjCS0ji_1652384022;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NjCS0ji_1652384022)
          by smtp.aliyun-inc.com(33.13.195.200);
          Fri, 13 May 2022 03:34:03 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     tsbogend@alpha.franken.de, paul@crapouillou.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com
Subject: [PATCH 0/3] Refresh device tree and defconfig for Ingenic SoCs and boards.
Date:   Fri, 13 May 2022 03:33:38 +0800
Message-Id: <1652384021-46309-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add PWM node for X1830 SoC from Ingenic.
2.Add SSI nodes for X1000 SoC and X1830 SoC from Ingenic.
3.Refresh SSI related nodes in CU1000-Neo and CU1830-Neo.
4.The X1830 SoC used by the CU1830-Neo and the X1000 SoC
  used by the CU1000-Neo are both single-core processors,
  therefore the "OST_CLK_PERCPU_TIMER" ABI should not be
  used in the OST nodes of the CU1830-Neo and CU1000-Neo,
  it is just a coincidence that there is no problem now.
  So replace the misused "OST_CLK_PERCPU_TIMER" ABI with
  the correct "OST_CLK_EVENT_TIMER" ABI.
5.Refresh the defconfig files of the CU1000-Neo board and
  the CU1830-Neo board, remove the selection of SPI-GPIO,
  and add the selection of SSI.

周琰杰 (Zhou Yanjie) (3):
  MIPS: Ingenic: Add PWM nodes for X1830.
  MIPS: Ingenic: Refresh device tree for Ingenic SoCs and boards.
  MIPS: Ingenic: Refresh defconfig for CU1000-Neo and CU1830-Neo.

 arch/mips/boot/dts/ingenic/cu1000-neo.dts | 77 ++++++++++++++++---------------
 arch/mips/boot/dts/ingenic/cu1830-neo.dts | 76 +++++++++++++++---------------
 arch/mips/boot/dts/ingenic/x1000.dtsi     | 20 ++++++++
 arch/mips/boot/dts/ingenic/x1830.dtsi     | 53 +++++++++++++++++++++
 arch/mips/configs/cu1000-neo_defconfig    |  2 +-
 arch/mips/configs/cu1830-neo_defconfig    |  2 +-
 6 files changed, 154 insertions(+), 76 deletions(-)

-- 
2.7.4

