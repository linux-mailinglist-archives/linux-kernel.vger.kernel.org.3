Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D435334BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbiEYBco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243234AbiEYBcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:32:42 -0400
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6081353B55;
        Tue, 24 May 2022 18:32:41 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 24P1WIja007424; Wed, 25 May 2022 10:32:18 +0900
X-Iguazu-Qid: 34trLtFNCcr2hTNsYq
X-Iguazu-QSIG: v=2; s=0; t=1653442338; q=34trLtFNCcr2hTNsYq; m=6I5Zp9SHxPfpIAHDdJthesAiltPbzyvTI/Q27BPBxWM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 24P1WHkF020508
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 May 2022 10:32:17 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     yuji2.ishikawa@toshiba.co.jp, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 0/3] Add Visconti5 IOMMU driver
Date:   Wed, 25 May 2022 10:31:44 +0900
X-TSB-HOP2: ON
Message-Id: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is the IOMMU driver for Toshiba's ARM SoC, Visconti5[0].
This provides DT binding documentation, device driver and MAINTAINER files.

Best regards,
  Nobuhiro

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Nobuhiro Iwamatsu (3):
  iommu: Add Visconti5 IOMMU driver
  iommu: bindings: Add binding documentation for Toshiba Visconti5 IOMMU
    device
  MAINTAINERS: Add entries for Toshiba Visconti5 IOMMU

 .../bindings/iommu/toshiba,visconti-atu.yaml  |  62 +++
 MAINTAINERS                                   |   2 +
 drivers/iommu/Kconfig                         |   7 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/visconti-atu.c                  | 426 ++++++++++++++++++
 5 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
 create mode 100644 drivers/iommu/visconti-atu.c

-- 
2.36.0

