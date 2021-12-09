Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D63446ED76
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbhLIQwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:52:42 -0500
Received: from out28-194.mail.aliyun.com ([115.124.28.194]:60533 "EHLO
        out28-194.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhLIQwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:52:23 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2773259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0127988-0.00456519-0.982636;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.M7WqoBf_1639068516;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.M7WqoBf_1639068516)
          by smtp.aliyun-inc.com(10.147.44.145);
          Fri, 10 Dec 2021 00:48:47 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add SMP/SMT support for Ingenic sysost driver.
Date:   Fri, 10 Dec 2021 00:48:33 +0800
Message-Id: <1639068516-5577-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.The OST in Ingenic XBurst®2 SoCs has a global timer and
  up to 16 event timers, add support for the event timers.
2.Add dt-bindings and compatible strings for the X1600 SoC,
  the X1830 SoC, the X2000 SoC, and the X2500 SoC.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: timer: Add bindings for new Ingenic SoCs.
  clocksource: Ingenic: Add SMP/SMT support for sysost driver.

 .../devicetree/bindings/timer/ingenic,sysost.yaml  |   7 +-
 drivers/clocksource/ingenic-sysost.c               | 403 ++++++++++++++++-----
 2 files changed, 310 insertions(+), 100 deletions(-)

-- 
2.7.4

