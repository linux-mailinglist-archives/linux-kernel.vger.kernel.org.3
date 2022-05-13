Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB3526590
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381654AbiEMPCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381521AbiEMPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:01:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDA2DD76;
        Fri, 13 May 2022 08:01:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3400A1F461F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652454084;
        bh=JTJRUzzWzXgmpr6v9i78ORT3MYTWIiG5v8DAgb0K43g=;
        h=From:To:Cc:Subject:Date:From;
        b=i/GrFceJtgbi+skmA7Of3QY2HtgidBg6a777PTG9/ri2/Hc7r/sdhGumYvdNwTQqf
         EVVLmO9kIXDDTcH30GmjFfHNV25G6zieOwD6rbZvmjQM0ZK1cleVNY65JcDgB5Kv3c
         Ye7rbCtXdO+04hoCtpd5xLnmnyNEIbCKmyrWMZsyTP+EWlLFyIld4xolI26v/mQo1P
         UmaE3+o3in617pq299v7LQ/tCUWa9CaHcSrXhizBxbNv3S4mXxdhGst/3ukW51BGcE
         INwffZmtJq63PPvA9Mg7etMAnx182N2vcLkrd2jhuVE2bs7k0uhvVUFueQWQO0awoR
         J//s1CYHwbngw==
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
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - SMI Support
Date:   Fri, 13 May 2022 17:01:14 +0200
Message-Id: <20220513150116.349744-1-angelogioacchino.delregno@collabora.com>
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

AngeloGioacchino Del Regno (2):
  dt-bindings: memory: mtk-smi: Add MT6795 Helio X10 bindings
  memory: mtk-smi: Add support for MT6795 Helio X10

 .../memory-controllers/mediatek,smi-common.yaml   |  1 +
 .../memory-controllers/mediatek,smi-larb.yaml     |  1 +
 drivers/memory/mtk-smi.c                          | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

-- 
2.35.1

