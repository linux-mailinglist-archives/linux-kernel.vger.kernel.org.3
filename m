Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C7D4FF3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiDMJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiDMJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:46:03 -0400
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D73955755;
        Wed, 13 Apr 2022 02:43:42 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 23D9hM8m029340; Wed, 13 Apr 2022 18:43:22 +0900
X-Iguazu-Qid: 2wHHcjJI23W94K8XRp
X-Iguazu-QSIG: v=2; s=0; t=1649843001; q=2wHHcjJI23W94K8XRp; m=7GmIC7vHKUkgQ9s4B63XWJryMl2VZPBa/PaV4pvEob8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1111) id 23D9hLZA011011
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 18:43:21 +0900
X-SA-MID: 35962689
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 0/3] Visconti: Add Toshiba Visconti Video Input Interface driver
Date:   Wed, 13 Apr 2022 18:41:58 +0900
X-TSB-HOP2: ON
Message-Id: <20220413094203.25714-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the Video Input Interface driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation, device driver, MAINTAINER fiels.

Best regards,
Yuji

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Yuji Ishikawa (5):
  dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
    Input Interface bindings
  media: platform: visconti: Add Toshiba Visconti Video Input Interface
    driver headers
  media: platform: visconti: Add Toshiba Visconti Video Input Interface
    driver body
  media: platform: visconti: Add Toshiba VIIF image signal processor
    driver
  MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface

 .../bindings/media/toshiba,visconti-viif.yaml |  103 +
 MAINTAINERS                                   |    2 +
 drivers/media/platform/Kconfig                |    2 +
 drivers/media/platform/Makefile               |    4 +
 drivers/media/platform/visconti/Kconfig       |    9 +
 drivers/media/platform/visconti/Makefile      |    9 +
 drivers/media/platform/visconti/hwd_viif.c    | 2233 ++++++++++
 drivers/media/platform/visconti/hwd_viif.h    | 1776 ++++++++
 .../media/platform/visconti/hwd_viif_csi2rx.c |  767 ++++
 .../platform/visconti/hwd_viif_internal.h     |  361 ++
 .../media/platform/visconti/hwd_viif_l1isp.c  | 3769 +++++++++++++++++
 .../media/platform/visconti/hwd_viif_reg.h    | 2802 ++++++++++++
 drivers/media/platform/visconti/viif.c        | 2384 +++++++++++
 drivers/media/platform/visconti/viif.h        |  134 +
 include/uapi/linux/visconti_viif.h            | 1683 ++++++++
 15 files changed, 16038 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 create mode 100644 drivers/media/platform/visconti/Kconfig
 create mode 100644 drivers/media/platform/visconti/Makefile
 create mode 100644 drivers/media/platform/visconti/hwd_viif.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
 create mode 100644 drivers/media/platform/visconti/viif.c
 create mode 100644 drivers/media/platform/visconti/viif.h
 create mode 100644 include/uapi/linux/visconti_viif.h

-- 
2.17.1


