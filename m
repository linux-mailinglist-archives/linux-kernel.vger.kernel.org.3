Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE05746D431
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhLHNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhLHNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:19:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B0EC061746;
        Wed,  8 Dec 2021 05:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DAF3B817AE;
        Wed,  8 Dec 2021 13:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F20AC00446;
        Wed,  8 Dec 2021 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638969342;
        bh=7j6/WAK8oABQYNlxkyS7dkE3o1G6jJuJ6qlAiqs4mD0=;
        h=From:To:Cc:Subject:Date:From;
        b=lDSLDhVKjRcfcYRpiEoKhGhdmSws/3J/8y/Bxk9r84Om+QZEHml/wTEFFq0C6nqTl
         2+g2NSrGxA6/kL1LGG0Ehgv3tzEm3i0OXVpJiJOakxWyG7BRejai0D4JlHT0XpucUL
         d7svhnoDF7uPhTL13YPx6Qftpcy4yr5K6agxr9Pum/PsAvgclJNztDgS+rfxZLthbB
         MXNZkf+950BZXm20GIcndIV6usroi+ju5RXzG2/Gabf3sSqXKe9NKgOvvie5d70vEN
         hhImb1Q2O+YgXFMLwfpPB0x7BMMpHlPDuTf4p25/8wPE73xY44aSt5rmvh7Qtxf5q2
         Gz7zV6Zq8vQMQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Date:   Wed,  8 Dec 2021 15:15:34 +0200
Message-Id: <20211208131536.23667-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

This series adds GPMC and ELM controller device tree nodes to
AM64 SoC's dtsi file.

Changelog:
v2
- Fix register sizes for GPMC node.
- Disable GPMC and ELM nodes in board files. They will be enabled in
NAND card device tree overlay.

cheers,
-roger

Roger Quadros (2):
  arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
  arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  8 +++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  8 +++++++
 3 files changed, 44 insertions(+)

-- 
2.17.1

