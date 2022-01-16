Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D623748FD04
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiAPMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:50:05 -0500
Received: from mxwww.masterlogin.de ([95.129.51.170]:41554 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiAPMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:50:03 -0500
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 0A7D72C45A;
        Sun, 16 Jan 2022 12:49:24 +0000 (UTC)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 774175FC6E;
        Sun, 16 Jan 2022 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1642337358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wi1GdqhUl9BI6fG/qKFpAjzCROoto8ipCaIuJxHwcFQ=;
        b=QZkhXW8bD+Q4ABcQ+8JO1x0qWMnbxQkisOG/XkW2k8O9aI/1hWPwZ3ozNQElyAPXRs19AG
        1ZxCdoB9Yv0C2xpDWw1YjGiI99xwjH7IvpuquufZplspZcOnnNxvNUcvNjolRL3Hd1Syvh
        b+BWkpzwdvImxmAst7WbmbbpZNGvUG4=
Received: from localhost.localdomain (fttx-pool-80.245.74.150.bambit.de [80.245.74.150])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id CE73F3602F1;
        Sun, 16 Jan 2022 12:49:17 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Add BananaPi R2 Pro board
Date:   Sun, 16 Jan 2022 13:49:08 +0100
Message-Id: <20220116124911.65203-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 1f677243-544e-41f8-b959-92b394ce1377
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds RK3568 based Bananapi R2 Board.

While testing new dts with dtbs_check we've found an issue with
mainline gmac0 node in rk3568.dtsi which breaks dtbs_check. So first
Patch fixes this problem.

Frank Wunderlich (3):
  dts64: rk3568: drop pclk_xpcs from gmac0
  dt-bindings: rockchip: Add BananaPi R2 Pro Board
  dts64: rockchip: Add Bananapi R2 Pro

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 428 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |   6 +-
 4 files changed, 436 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts

-- 
2.25.1

