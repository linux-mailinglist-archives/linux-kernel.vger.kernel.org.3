Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3557A810
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiGSUKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiGSUKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0041151
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4FE16193B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE1C341C6;
        Tue, 19 Jul 2022 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658261409;
        bh=MphE1A0MBNfqUHD/G9dXrMp5nuRDZG0BZwbqaZHaQ0o=;
        h=Date:From:To:Cc:Subject:From;
        b=J/4WHpjr+uWqXVMuZGUZSvM9kkV7fLEuwipJv2oKyOCQb79xSgtIGA5an2ldHH6Io
         JU9BxsFmHbC3bgiwsWs0x1h9qV/rgIN+Blceg02VDfU2zwUkOYTRjd+KCEbozQ+uzi
         cw772Xt/UkqwoZZ41MQVwhLAQbk5tTUTPfiOCTQ24W8X18Ayei6P/dZ2mnv5s/RSkf
         Gr4TjgfvdUqKYcMU8fB4UtPXaNlAl0K0LZ3jgMKWFzwoAmXxWDYFuI2Vj87D2J29Ug
         Yq4XsUeelBIgpTdnnZJO7Udu6tbxsIxbnEBruoiZ3kGSEimraRhYrklYp0pwPNUsxk
         SJfsGGWJ3acVA==
Date:   Tue, 19 Jul 2022 21:10:04 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.20
Message-ID: <20220719201004.GA15241@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.20. There's not a lot here and it's
actually all related to the Qualcomm hardware implementations. Summary in
the tag.

Cheers,

Will

--->8

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to a91eb6803c1c715738682fece095145cbd68fe0b:

  iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop (2022-07-19 18:30:32 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.20

- Add even more Qualcomm device-tree compatible strings

- Support dumping of IMP DEF Qualcomm registers on TLB sync timeout

- Fix reference count leak on device tree node in Qualcomm driver

----------------------------------------------------------------
Emma Anholt (1):
      iommu: arm-smmu-impl: Add 8250 display compatible to the client list.

Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add compatible for Qualcomm SM6375
      iommu/arm-smmu-qcom: Add SM6375 SMMU compatible

Liang He (1):
      iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop

Sai Prakash Ranjan (1):
      iommu/arm-smmu-qcom: Add debug support for TLB sync timeouts

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 drivers/iommu/Kconfig                              |  10 ++
 drivers/iommu/arm/arm-smmu/Makefile                |   1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   | 142 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  34 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |  28 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   7 +-
 9 files changed, 219 insertions(+), 11 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
 create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
