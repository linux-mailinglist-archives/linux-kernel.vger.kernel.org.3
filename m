Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA05B52B5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiERJKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiERJKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:10:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DDC2BF;
        Wed, 18 May 2022 02:10:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7582D1F44320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652865043;
        bh=LKd4nhweRL3PcJXv3k2/EPSlF7AzYrSo5zfC/TMbjbo=;
        h=From:To:Cc:Subject:Date:From;
        b=g59waOirYWM562xaFzCb669fxfE5fA50a4H99jC2/aoPZwvbIMIJ3SzmCAbpwjAGo
         tZSuqYUG6sMDZSdWVff79EmGogsGDkRUd4h5OsMew9u4nvLNEmBE2JxpDkxU7ZNIZI
         s+zmHaMBJgan6S4SObYPX9w85MLyMYP82BCMS4dkaTVBUZALGcYgpp19/y7jJzFVs0
         dyWQUhtXRusELOI55sXqq+JU6DRkep/JVU9ZfD5tNeWdoaurMOuEQwTGO8W1GpK208
         bAfNS/wlMtEIa+byZrJxtQjWFuw2Iamt13nk8g9atS+AGYg4Z6t/EIpCqiX2LSp+li
         zgjskR8Y7jgsg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/2] MediaTek Helio X10 MT6795 - SMI Support
Date:   Wed, 18 May 2022 11:10:36 +0200
Message-Id: <20220518091038.22380-1-angelogioacchino.delregno@collabora.com>
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

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces support for the SMI common and LARBs, found in
this SoC.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Changes in v3:
 - Applied Yong Wu's review comments (thanks!) on patch [2/2]

Changes in v2:
 - Added forgotten new definitions

AngeloGioacchino Del Regno (2):
  dt-bindings: memory: mtk-smi: Add MT6795 Helio X10 bindings
  memory: mtk-smi: Add support for MT6795 Helio X10

 .../memory-controllers/mediatek,smi-common.yaml |  1 +
 .../memory-controllers/mediatek,smi-larb.yaml   |  1 +
 drivers/memory/mtk-smi.c                        | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

-- 
2.35.1

