Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011565134C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346966AbiD1NU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346854AbiD1NUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:20:14 -0400
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86415A0BB;
        Thu, 28 Apr 2022 06:16:58 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 23SDGYBv005922; Thu, 28 Apr 2022 22:16:34 +0900
X-Iguazu-Qid: 2wGrSY3sPO1pGNxkIK
X-Iguazu-QSIG: v=2; s=0; t=1651151794; q=2wGrSY3sPO1pGNxkIK; m=bTvy+cUh66mFikFBu1CMUwP46MeZjQTe4nnCWw9Qy4Q=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1112) id 23SDGXQu017419
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Apr 2022 22:16:33 +0900
X-SA-MID: 3363560
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH 0/4] Add Toshiba Visconti DNN image processing accelerator driver
Date:   Thu, 28 Apr 2022 22:11:24 +0900
X-TSB-HOP2: ON
Message-Id: <20220428131128.5053-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the DNN image processing accelerator driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation, device driver, MAINTAINER files.

The second patch "soc: visconti: Add Toshiba Visconti image processing accelerator common source"
and the fourth patch "MAINTAINERS: ..." are the same as the ones in the preceding post for affine driver.

Best regards,
Yuji

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Yuji Ishikawa (4):
  dt-bindings: soc: visconti: Add Toshiba Visconti DNN image processing
    accelerator bindings
  soc: visconti: Add Toshiba Visconti image processing accelerator
    common source
  soc: visconti: Add Toshiba Visconti DNN image processing accelerator
  MAINTAINERS: Add entries for Toshiba Visconti DNN image processing
    accelerator

 .../soc/visconti/toshiba,visconti-dnn.yaml    |  54 ++
 MAINTAINERS                                   |   2 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/visconti/Kconfig                  |   7 +
 drivers/soc/visconti/Makefile                 |   8 +
 drivers/soc/visconti/dnn/Makefile             |   6 +
 drivers/soc/visconti/dnn/dnn.c                | 533 ++++++++++++++++++
 drivers/soc/visconti/dnn/hwd_dnn.c            | 183 ++++++
 drivers/soc/visconti/dnn/hwd_dnn.h            |  68 +++
 drivers/soc/visconti/dnn/hwd_dnn_reg.h        | 228 ++++++++
 drivers/soc/visconti/ipa_common.c             |  55 ++
 drivers/soc/visconti/ipa_common.h             |  18 +
 drivers/soc/visconti/uapi/dnn.h               |  77 +++
 drivers/soc/visconti/uapi/ipa.h               |  88 +++
 15 files changed, 1329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-dnn.yaml
 create mode 100644 drivers/soc/visconti/Kconfig
 create mode 100644 drivers/soc/visconti/Makefile
 create mode 100644 drivers/soc/visconti/dnn/Makefile
 create mode 100644 drivers/soc/visconti/dnn/dnn.c
 create mode 100644 drivers/soc/visconti/dnn/hwd_dnn.c
 create mode 100644 drivers/soc/visconti/dnn/hwd_dnn.h
 create mode 100644 drivers/soc/visconti/dnn/hwd_dnn_reg.h
 create mode 100644 drivers/soc/visconti/ipa_common.c
 create mode 100644 drivers/soc/visconti/ipa_common.h
 create mode 100644 drivers/soc/visconti/uapi/dnn.h
 create mode 100644 drivers/soc/visconti/uapi/ipa.h

-- 
2.17.1


