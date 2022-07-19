Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4027D579691
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiGSJot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiGSJoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:44:22 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E527FE6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:44:21 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BEF0200C16;
        Tue, 19 Jul 2022 11:44:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 54E22200BFE;
        Tue, 19 Jul 2022 11:44:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F8971802204;
        Tue, 19 Jul 2022 17:44:17 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/5] ASoC: fsl: Fix sparse warning
Date:   Tue, 19 Jul 2022 17:27:39 +0800
Message-Id: <1658222864-25378-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning

Shengjiu Wang (5):
  ASoC: fsl_sai: Don't use plain integer as NULL pointer
  ASoC: fsl_asrc: force cast the asrc_format type
  ASoC: fsl-asoc-card: force cast the asrc_format type
  ASoC: fsl_easrc: use snd_pcm_format_t type for sample_format
  ASoC: imx-card: use snd_pcm_format_t type for asrc_format

 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 sound/soc/fsl/fsl_asrc.c      | 4 ++--
 sound/soc/fsl/fsl_easrc.c     | 7 ++++---
 sound/soc/fsl/fsl_easrc.h     | 2 +-
 sound/soc/fsl/fsl_sai.c       | 2 +-
 sound/soc/fsl/imx-card.c      | 7 ++++---
 6 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.34.1

