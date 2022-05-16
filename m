Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C630527DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiEPGua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbiEPGuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:50:25 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B00813D5A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:50:22 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 24G6ZVWc064016;
        Mon, 16 May 2022 14:35:31 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 16 May
 2022 14:49:04 +0800
From:   ryan_chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v3 0/3] Add ASPEED AST2600 I2C new controller driver
Date:   Mon, 16 May 2022 14:48:57 +0800
Message-ID: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 24G6ZVWc064016
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add AST2600 i2c new register set driver. The i2c new
register set have new clock divider option for more flexiable generation.
And also have separate i2c master and slave register set for control.

v3:
-fix i2c global clock divide default value
-remove i2c slave no used dev_dbg info.
 
v2:
-add i2c global ymal file commit
-rename file name from new to ast2600.
 aspeed-i2c-new-global.c -> i2c-ast2600-global.c
 aspeed-i2c-new-global.h -> i2c-ast2600-global.h
 i2c-new-aspeed.c -> i2c-ast2600.c
-rename all driver function name to ast2600

ryan_chen (3):
  dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C global register
    controller
  dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C driver
  i2c:aspeed:support ast2600 i2c new register mode driver

 .../i2c/aspeed,i2c-ast2600-global.ymal        |   44 +
 .../bindings/i2c/aspeed,i2c-ast2600.ymal      |   78 +
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/i2c-ast2600-global.c       |   94 +
 drivers/i2c/busses/i2c-ast2600-global.h       |   19 +
 drivers/i2c/busses/i2c-ast2600.c              | 1703 +++++++++++++++++
 7 files changed, 1950 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
 create mode 100644 drivers/i2c/busses/i2c-ast2600-global.c
 create mode 100644 drivers/i2c/busses/i2c-ast2600-global.h
 create mode 100644 drivers/i2c/busses/i2c-ast2600.c

-- 
2.17.1

