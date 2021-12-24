Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B2B47EFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352976AbhLXO55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:57:57 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:52340 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231836AbhLXO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:57:56 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104624977"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 23:57:55 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5010542C25A2;
        Fri, 24 Dec 2021 23:57:54 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] pinctrl: Use platform_get_irq*() variants to fetch IRQ's
Date:   Fri, 24 Dec 2021 14:57:46 +0000
Message-Id: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to drop using platform_get_resource() for IRQ types
in preparation for removal of static setup of IRQ resource from DT core
code.

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  pinctrl: samsung: Use platform_get_irq_optional() to get the interrupt
  pinctrl: at91-pio4: Use platform_get_irq_optional() to get the
    interrupt

 drivers/pinctrl/pinctrl-at91-pio4.c       | 14 ++++++--------
 drivers/pinctrl/samsung/pinctrl-samsung.c |  9 +++++----
 2 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.17.1

