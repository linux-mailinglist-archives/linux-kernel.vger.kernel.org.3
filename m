Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5C496B11
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiAVIku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiAVIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:40:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42676C06173B;
        Sat, 22 Jan 2022 00:40:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CBCF6020F;
        Sat, 22 Jan 2022 08:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08149C004E1;
        Sat, 22 Jan 2022 08:40:45 +0000 (UTC)
Message-ID: <7af52d61-47c7-581d-62ed-76a7f8315b16@xs4all.nl>
Date:   Sat, 22 Jan 2022 09:40:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.18] Clean up "mediatek,larb"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

This is the PR of v10 of this series, minus patches 12 and 13 (Matthias will take those
once this is merged for 5.18):

https://patchwork.linuxtv.org/project/linux-media/cover/20220117070510.17642-1-yong.wu@mediatek.com/

The first two patches are from:

https://patchwork.linuxtv.org/project/linux-media/patch/20211206130425.184420-1-hsinyi@chromium.org/
https://patchwork.linuxtv.org/project/linux-media/patch/20211206130425.184420-2-hsinyi@chromium.org/

since the v10 series depends on that yaml conversion.

This series touches on several subsystems. I believe I have all the relevant Acks etc.
It made the most sense to merge this through the media subsystem since that's the main
target for these changes.

Regards,

	Hans


The following changes since commit 216a6d4965287400d40227601abb6cedcd2addd3:

  media: mtk-vcodec: Remove mtk_vcodec_release_enc_pm (2022-01-21 12:23:48 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.18g

for you to fetch changes up to ae04f1335521a2d8b917c0e4708280e9819ed0e9:

  memory: mtk-smi: Get rid of mtk_smi_larb_get/put (2022-01-22 09:20:30 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hsin-Yi Wang (2):
      dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml
      dt-bindings: mediatek: Add mediatek, mt8183-jpgenc compatible

Yong Wu (10):
      dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
      iommu/mediatek-v1: Free the existed fwspec if the master dev already has
      iommu/mediatek: Return ENODEV if the device is NULL
      iommu/mediatek: Add probe_defer for smi-larb
      iommu/mediatek: Add device_link between the consumer and the larb devices
      media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
      media: mtk-mdp: Get rid of mtk_smi_larb_get/put
      drm/mediatek: Get rid of mtk_smi_larb_get/put
      media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
      memory: mtk-smi: Get rid of mtk_smi_larb_get/put

Yongqiang Niu (1):
      drm/mediatek: Add pm runtime support for ovl and rdma

 Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt |  9 ------
 Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml |  7 -----
 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml |  8 ------
 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt    | 38 ------------------------
 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml   | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt    | 35 ----------------------
 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml   | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/media/mediatek-mdp.txt             |  8 ------
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c                              |  8 +++++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c                             |  9 +++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                              | 15 +++++-----
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c                          | 36 ++---------------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h                          |  1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                               |  5 +---
 drivers/iommu/mtk_iommu.c                                            | 34 ++++++++++++++++++++++
 drivers/iommu/mtk_iommu_v1.c                                         | 42 ++++++++++++++++++++++++++-
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c                      | 45 ++---------------------------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h                      |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c                        | 40 --------------------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h                        |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c                        |  1 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c               |  2 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c                |  1 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c                | 41 ++++----------------------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h                   |  3 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c                   |  1 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c               |  2 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c                | 45 ++++-------------------------
 drivers/memory/mtk-smi.c                                             | 14 ---------
 include/soc/mediatek/smi.h                                           | 20 -------------
 30 files changed, 267 insertions(+), 359 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
