Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC96587AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbiHBKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiHBKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0F327154;
        Tue,  2 Aug 2022 03:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB90B61083;
        Tue,  2 Aug 2022 10:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88250C433D6;
        Tue,  2 Aug 2022 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659437102;
        bh=Pq6jAwrvRhf0UN+FRWkLDm4BPw/OYpN065tOarwnClM=;
        h=From:To:Cc:Subject:Date:From;
        b=OTmCzc+3CF+jQ+udwRGVUWp7lrN3RCKjRPNlTK4sTBVE/CLFJpoTVofzCT8Y3khUI
         mvQk0sR7jVhYRZvqeO9f1zR/luMczvqG+qgWhiHSJ+wCQiO6lmJTSjO/pq1KZFOe3V
         ZgwQsXWCTLQ8Pri0fvmlX0T1VyLdZHAzwzx1kXAB/pljLc6c476H9JLkKa1/Yj/5hE
         Ul9TYfD0YLmIsze/lDg2vEggDRpkBMRrfc6Fk0Qctmlz7bPFhnI2USq+y/4qRywjYt
         QwAN7V8kBar11iVw0KMzBK3rezdSxH3IuEn1CDWpc9wqVY/VSXJ9iAYBCR5dDZw8Nl
         pmc9DI0YYHfUg==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Date:   Tue,  2 Aug 2022 13:44:54 +0300
Message-Id: <20220802104456.11069-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

This series adds GPMC and ELM controller device tree nodes to
AM64 SoC's dtsi file.

Changelog:
v4
- Rebased to v5.19
- use 'ti,am64-elm' compatible for ELM node

v3
- Rebased to v5.17-rc1

v2
- Fix register sizes for GPMC node.
- Disable GPMC and ELM nodes in board files. They will be enabled in
NAND card device tree overlay.

Roger Quadros (2):
  arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
  arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  8 +++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  8 +++++++
 3 files changed, 44 insertions(+)

-- 
2.17.1

