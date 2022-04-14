Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4854B500595
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiDNFnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiDNFnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:43:31 -0400
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D968C4832C;
        Wed, 13 Apr 2022 22:41:04 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 23E5em7f017194; Thu, 14 Apr 2022 14:40:48 +0900
X-Iguazu-Qid: 34trQigfs9xr9iyGU3
X-Iguazu-QSIG: v=2; s=0; t=1649914848; q=34trQigfs9xr9iyGU3; m=6QxjmZsiG7UTivQvdF5fG5AwRycPM6hwoOZ4mSv5Jsg=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1512) id 23E5emnt009582
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:40:48 +0900
X-SA-MID: 2385299
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v2 0/5] Visconti: Add Toshiba Visconti Video Input Interface driver
Date:   Thu, 14 Apr 2022 14:35:23 +0900
X-TSB-HOP2: ON
Message-Id: <20220414053528.31460-1-yuji2.ishikawa@toshiba.co.jp>
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


  dt-bindings: media: platform: visconti: Add Toshiba Visconti Video Input Interface bindings
    v1 -> v2:
      - No update

  media: platform: visconti: Add Toshiba Visconti Video Input Interface driver headers
    v1 -> v2:
      - moved driver headers to an individual patch

  media: platform: visconti: Add Toshiba Visconti Video Input Interface driver body
    v1 -> v2:
      - moved driver sources to an individual patch
   
  media: platform: visconti: Add Toshiba VIIF image signal processor driver
    v1 -> v2:
      - moved image signal processor driver to an individual patch

  MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
    v1 -> v2:
      - No update

Change in V2:
  - moved files into individual patches to decrease patch size

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


