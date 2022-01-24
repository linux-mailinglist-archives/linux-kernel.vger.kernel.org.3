Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81880498504
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiAXQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:40:30 -0500
Received: from foss.arm.com ([217.140.110.172]:40046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243789AbiAXQkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:40:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C3CD6E;
        Mon, 24 Jan 2022 08:40:23 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 489923F793;
        Mon, 24 Jan 2022 08:40:22 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, konrad@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tientzu@chromium.org, guozhengkui@vivo.com
Subject: [PATCH 0/3] Some minor SWIOTLB cleanups
Date:   Mon, 24 Jan 2022 16:40:16 +0000
Message-Id: <cover.1643028164.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a little collection of cleanup patches for some annoyances
that have built up while looking at SWIOTLB code recently.

Cheers,
Robin.


Robin Murphy (3):
  swiotlb: Simplify debugfs setup
  swiotlb: Tidy up includes
  swiotlb: Simplify array allocation

 kernel/dma/swiotlb.c | 74 ++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 50 deletions(-)

-- 
2.28.0.dirty

