Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013024A9845
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357909AbiBDLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiBDLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:15:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17EDC061714;
        Fri,  4 Feb 2022 03:15:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ECBEB836BA;
        Fri,  4 Feb 2022 11:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB3EC004E1;
        Fri,  4 Feb 2022 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643973340;
        bh=oxgqI3IVFPQ+Mlwl/t1AxW8C+42LEd2DOxmXs2QQj+8=;
        h=From:To:Cc:Subject:Date:From;
        b=k2TPJ/5VwlCCm/pcYcim2LXhkFUervHpsDmCyRTI+BwiNGLkQDD+8EHvjwlI0STFs
         TQ0K9owx6PAskoYvg95+LGDnrUz8drZgxiYdAraNulqgrcu4sriVDbL0KQjPOrUIVU
         MgJWdDuLGU3ZTCKY6Wa4E6lfYB/5Ce7o06sPWktAs09BQrrWDr6v3qJnEcfJ6WRjrr
         oBBETtUas8mtYJSV7PCkRcdxMDDR/PG86sqN28Nx4DMwhqukiy8gtCQaaim3uzTEzC
         NjgZ8g4iKbGY0VYCA87mGCprt7u3nvmh4IBKKtqFuw2FNj/6Q0pjKOcjiJUM7uHZAS
         8eGFbecjmSxVg==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Date:   Fri,  4 Feb 2022 13:15:31 +0200
Message-Id: <20220204111533.10787-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

This series adds GPMC and ELM controller device tree nodes to
AM64 SoC's dtsi file.

Changelog:
v3
- Rebased to v5.17-rc1

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

