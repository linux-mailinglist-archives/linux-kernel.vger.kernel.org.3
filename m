Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBA464909
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbhLAHsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbhLAHs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:48:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA1C061574;
        Tue, 30 Nov 2021 23:45:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75561B80D60;
        Wed,  1 Dec 2021 07:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5A9C53FCC;
        Wed,  1 Dec 2021 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638344706;
        bh=OH2rEpGPL9jDaE26jPFWGFb1qKd2RjGNeO1dPGYzF9g=;
        h=From:To:Cc:Subject:Date:From;
        b=hg/BrIUBlR2QkSkQzQzzYFobCtPBhuAi5gpAFIRD2oCyDIbXzU+Wi+lz004uSpigF
         xDUOCGio3ydiWV/6j4SwFlNp5XTvVgWX8hyctLD+yh/ufAs/Qgrj45rdhPD4dDOQLn
         L+5VcZ1CPIHY/MJRhjCVRGdpZ0VhSo9SOrHZS9hGb2NbVB/F64kB9oVNwsAnAH3Kxq
         xJH8VxfKtZ+3vlzDhc4FifVYpbLqkmXbtT1Nx4+QckCdpJ8CLJ5h6jM7BKyCLvUAIp
         jAXsv8TXC+ZBupwiuUwz29rBO/gex+m1xu/ykELnVWY7QMJTdq8rKL+BjNshUcyfIn
         GpE0p/M5S9row==
From:   Vinod Koul <vkoul@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] scsi|phy: Add SM8450 UFS & Phy support
Date:   Wed,  1 Dec 2021 13:14:53 +0530
Message-Id: <20211201074456.3969849-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation for ufs SM8450 compatible, phy compatible and
SM8450 UFS QMP Phy support.

Vinod Koul (3):
  scsi: ufs: dt-bindings: Add SM8450 compatible strings
  dt-bindings: phy: qcom,qmp: Add SM8450 UFS phy compatible
  phy: qcom-qmp: Add SM8450 UFS QMP Phy

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  1 +
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 32 +++++++++++++++++++
 3 files changed, 34 insertions(+)

-- 
2.31.1

