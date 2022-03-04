Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C27D4CD1B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbiCDJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCDJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:55:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568B3B034;
        Fri,  4 Mar 2022 01:55:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B18E11F46483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646387703;
        bh=EfrLQeiJMUy4oMQI58UrAdjbGw+ADzKMI7I2grHoz4M=;
        h=From:To:Cc:Subject:Date:From;
        b=LJuRzerx/ge7QtwE1iuUcucq6QplNy5celhG3oIai0DzzGpXlLqI/R0DQlelkg3nz
         BnbC5PXT2XvUCdjrgyhE3M60uVU85X5rg6GSOLu7MXsCeqFs/QCY7rVhv7geTHc+GF
         c/+2NUH4XSyIeK+TwD8p9u/RWCYMN9246caOp5e1uyU0Oyisba04A5lm/ZFJbTpvXQ
         uWOF09ZcwSVxxoSSkMxgKq9q2oOocWInIhklbyR+S1KvHGntFoiYcEU2hd4kp8AxV/
         y+671YfAqPE5EnJlthsSaUSMnYcgcPZSQX/tw99UorcH1mcAEVOy8Crq9aneJjKxt0
         dj9rPtk84IMiQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        jason-jh.lin@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/3] Fix MediaTek display dt-bindings issues
Date:   Fri,  4 Mar 2022 10:54:55 +0100
Message-Id: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdosys0 series carried a nice dt-bindings conversion of the old
txt documentation for the entire mediatek-drm driver, but some of
the issues in there weren't seen.

This series is fixing all of the issues pointed out by a
`dt_binding_check` run, followed by `dtbs_check`.

AngeloGioacchino Del Regno (3):
  dt-bindings: display: mediatek,mutex: Fix mediatek,gce-events type
  dt-bindings: display: mediatek,ovl: Fix 'iommu' required property typo
  dt-bindings: display: mediatek: Fix examples on new bindings

 .../display/mediatek/mediatek,aal.yaml        | 24 +++--
 .../display/mediatek/mediatek,ccorr.yaml      | 23 +++--
 .../display/mediatek/mediatek,color.yaml      | 23 +++--
 .../display/mediatek/mediatek,dither.yaml     | 23 +++--
 .../display/mediatek/mediatek,dpi.yaml        |  3 +-
 .../display/mediatek/mediatek,dsc.yaml        | 23 +++--
 .../display/mediatek/mediatek,ethdr.yaml      | 99 ++++++++++---------
 .../display/mediatek/mediatek,gamma.yaml      | 23 +++--
 .../display/mediatek/mediatek,merge.yaml      | 49 +++++----
 .../display/mediatek/mediatek,mutex.yaml      | 27 +++--
 .../display/mediatek/mediatek,od.yaml         | 14 ++-
 .../display/mediatek/mediatek,ovl-2l.yaml     | 26 +++--
 .../display/mediatek/mediatek,ovl.yaml        | 28 ++++--
 .../display/mediatek/mediatek,postmask.yaml   | 23 +++--
 .../display/mediatek/mediatek,rdma.yaml       | 28 ++++--
 .../display/mediatek/mediatek,split.yaml      | 17 +++-
 .../display/mediatek/mediatek,ufoe.yaml       | 19 ++--
 .../display/mediatek/mediatek,wdma.yaml       | 26 +++--
 18 files changed, 318 insertions(+), 180 deletions(-)

-- 
2.35.1

