Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8314971C1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 14:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiAWNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 08:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiAWNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:51:23 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0283C06173B;
        Sun, 23 Jan 2022 05:51:22 -0800 (PST)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 23EC65FCA4;
        Sun, 23 Jan 2022 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1642945881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RELpic6Ktw2PgGIqUzW23e7A0BzsaqNGBjhG7mrfVSY=;
        b=whIfr0b1wwo9LTMEA1MhHpgGIlYasU678LDIiJ2hw+2uOVfDHmlRIs1EEh+8ZKJrimoDjt
        /YDWcghORi6SSYRUmazSa8ZA240qPHv3EIFYTa1uqaQkd9jAvEhyHyvwMja3lL4iJNvzkF
        W65p6xWXv/gF1HcZHkUpuSqlimXkvwU=
Received: from localhost.localdomain (fttx-pool-80.245.79.232.bambit.de [80.245.79.232])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 51D42400CA;
        Sun, 23 Jan 2022 13:51:20 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add BananaPi R2 Pro board
Date:   Sun, 23 Jan 2022 14:51:14 +0100
Message-Id: <20220123135116.136846-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 58d93621-8614-48a2-a3fd-b693ef9056f8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds RK3568 based Bananapi R2 Board.

changes in v2:
- rebase on 5.17-rc1
- dropped patch for fixing dtbs_check (sent separately)
- verified pins on gpio-header (con2) and changed pinctrl where needed
- changed led part

Frank Wunderlich (2):
  dt-bindings: rockchip: Add BananaPi R2 Pro Board
  arm64: dts: rockchip: Add Bananapi R2 Pro

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 461 ++++++++++++++++++
 3 files changed, 467 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts

-- 
2.25.1

