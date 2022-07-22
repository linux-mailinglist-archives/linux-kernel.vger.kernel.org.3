Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1357E2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiGVOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:15:20 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9158119C1C;
        Fri, 22 Jul 2022 07:15:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,185,1654527600"; 
   d="scan'208";a="127042264"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jul 2022 23:15:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EF88443279E4;
        Fri, 22 Jul 2022 23:15:12 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] Add support to identify RZ/Five SoC
Date:   Fri, 22 Jul 2022 15:15:04 +0100
Message-Id: <20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds support to identify the Renesas RZ/Five SoC.

Below is the output tested on SMARC EVK based on RZ/Five SoC:

/ # dmesg  | grep Detect
[    0.065230] Detected Renesas RZ/Five r9a07g043 Rev 0
/ # cat /sys/devices/soc0/family
RZ/Five
/ # cat /sys/devices/soc0/machine
Renesas SMARC EVK based on r9a07g043
/ # cat /sys/devices/soc0/revision
0
/ # cat /sys/devices/soc0/soc_id
r9a07g043
/ # 

v1->v2:
* Fixed review comments pointed by Geert

v1:
https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/Five SoC
  soc: renesas: Identify RZ/Five SoC

 .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml    |  4 +---
 drivers/soc/renesas/Kconfig                         | 10 ++++++++++
 drivers/soc/renesas/renesas-soc.c                   | 13 +++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.25.1

