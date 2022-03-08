Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAB44D2460
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350773AbiCHWem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiCHWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:34:41 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 091F758E4A;
        Tue,  8 Mar 2022 14:33:43 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,165,1643641200"; 
   d="scan'208";a="112895803"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Mar 2022 07:33:43 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 32744400F2D7;
        Wed,  9 Mar 2022 07:33:41 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] Renesas RZ/V2L add GPU/OPP/TSU support
Date:   Tue,  8 Mar 2022 22:33:21 +0000
Message-Id: <20220308223324.7456-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds GPU/TSU/OPP support to Renesas RZ/V2L SoC.

patches apply on top of [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
renesas-devel.git/log/?h=renesas-arm-dt-for-v5.19

Lad Prabhakar (3):
  arm64: dts: renesas: r9a07g054: Fillup the GPU node
  arm64: dts: renesas: r9a07g054: Add OPP table
  arm64: dts: renesas: r9a07g054: Add TSU node

 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 132 ++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

-- 
2.17.1

