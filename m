Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B9247E3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbhLWNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:01:01 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:33880 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348429AbhLWNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:01:00 -0500
X-IronPort-AV: E=Sophos;i="5.88,229,1635174000"; 
   d="scan'208";a="104966898"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Dec 2021 22:00:58 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CCD8A4366C26;
        Thu, 23 Dec 2021 22:00:55 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     Xin Tan <tanxin.ctf@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] iommu/arm-smmu: Use platform_irq_count()
Date:   Thu, 23 Dec 2021 13:00:44 +0000
Message-Id: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

While I was at it created patch 2/2 to propagate errors upstream.

Cheers,
Prabhakar

Lad Prabhakar (2):
  iommu/arm-smmu: Use platform_irq_count() to get the interrupt count
  iommu/arm-smmu: Propagate errors from platform_get_irq()

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.1

