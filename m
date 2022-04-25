Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970FC50E09E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbiDYMpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiDYMpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:45:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3350D891A;
        Mon, 25 Apr 2022 05:42:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A817ED1;
        Mon, 25 Apr 2022 05:42:10 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01FFE3F5A1;
        Mon, 25 Apr 2022 05:42:08 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     baolu.lu@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, iommu@lists.linux-foundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v4 0/4] iommu, thunderbolt: Make iommu_dma_protection more accurate
Date:   Mon, 25 Apr 2022 13:42:01 +0100
Message-Id: <cover.1650878781.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 

As promised, here's the really-actually-final version, cleaning up the
new interface in patch #1 to not introduce the new parameter before it's
ready, and rebased to make sure it correctly applies on -rc3.

Thanks,
Robin.


Mario Limonciello (1):
  iommu/amd: Indicate whether DMA remap support is enabled

Robin Murphy (3):
  iommu: Introduce device_iommu_capable()
  iommu: Add capability for pre-boot DMA protection
  thunderbolt: Make iommu_dma_protection more accurate

 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            |  3 ++
 drivers/iommu/amd/iommu.c           |  2 ++
 drivers/iommu/intel/iommu.c         |  2 ++
 drivers/iommu/iommu.c               | 23 +++++++++++++++
 drivers/thunderbolt/domain.c        | 12 ++------
 drivers/thunderbolt/nhi.c           | 44 +++++++++++++++++++++++++++++
 include/linux/iommu.h               |  8 ++++++
 include/linux/thunderbolt.h         |  2 ++
 9 files changed, 91 insertions(+), 9 deletions(-)

-- 
2.35.3.dirty

