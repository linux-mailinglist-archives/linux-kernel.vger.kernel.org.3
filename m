Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7A47B3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhLTTd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:33:28 -0500
Received: from aposti.net ([89.234.176.197]:38746 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237942AbhLTTd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:33:26 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 0/2] clk: ingenic: Add MDMA and BDMA clocks
Date:   Mon, 20 Dec 2021 19:33:17 +0000
Message-Id: <20211220193319.114974-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael & Stephen,

Only the first patch (a tree-wide patch to rename include files)
of my v2 was merged, so I thought I'd send the second patch again. Since
checkpatch complained that DT includes must be in their own patch,
I just did that and decided to send a V3 instead of a RESEND.

Changes from v2:
- Previous patch [1/2] was merged
- Split previous patch [2/2] into two patches

Cheers,
-Paul

Paul Cercueil (2):
  dt-bindings: clk/ingenic: Add MDMA and BDMA clocks
  clk: ingenic: Add MDMA and BDMA clocks

 drivers/clk/ingenic/jz4760-cgu.c               | 10 ++++++++++
 drivers/clk/ingenic/jz4770-cgu.c               |  5 +++++
 include/dt-bindings/clock/ingenic,jz4760-cgu.h |  2 ++
 include/dt-bindings/clock/ingenic,jz4770-cgu.h |  1 +
 4 files changed, 18 insertions(+)

-- 
2.34.1

