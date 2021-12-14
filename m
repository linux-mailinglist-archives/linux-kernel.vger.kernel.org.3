Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F94473BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhLNECs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:02:48 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:24015 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhLNECr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:02:47 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BE3bMaT097437;
        Tue, 14 Dec 2021 11:37:22 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from localhost.localdomain (118.99.190.129) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Dec
 2021 12:02:41 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <steven_lee@aspeedtech.com>, <Hongweiz@ami.com>,
        <ryan_chen@aspeedtech.com>, <billy_tsai@aspeedtech.com>
Subject: [PATCH v1 0/1] gpio: gpio-aspeed-sgpio: Fix wrong hwirq base in irq
Date:   Tue, 14 Dec 2021 12:02:37 +0800
Message-ID: <20211214040239.8977-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [118.99.190.129]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BE3bMaT097437
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each aspeed sgpio bank has 64 gpio pins(32 input pins and 32 output pins)
The hwirq base for each sgpio bank should be multiples of 64 rather than
multiples of 32.

This patch series contains a patch for fixing wrong hwirq base in
irq handler.

Please help to review.

Steven Lee (1):
  gpio: gpio-aspeed-sgpio: Fix wrong hwirq base in irq handler

 drivers/gpio/gpio-aspeed-sgpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1

