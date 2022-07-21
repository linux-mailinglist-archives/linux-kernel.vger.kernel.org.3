Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA457C946
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiGUKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiGUKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:45:44 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783087D789
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:45:42 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0EE32038F8;
        Thu, 21 Jul 2022 12:45:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A5082038F6;
        Thu, 21 Jul 2022 12:45:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F280E180222B;
        Thu, 21 Jul 2022 18:45:38 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 -next 0/5] ASoC: fsl: Fix sparse warning
Date:   Thu, 21 Jul 2022 18:29:48 +0800
Message-Id: <1658399393-28777-1-git-send-email-shengjiu.wang@nxp.com>
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

changes in v2:
- use pcm_format_to_bits
- use u32 asrc_fmt, then convert it to snd_pcm_format_t

Shengjiu Wang (5):
  ASoC: fsl_sai: Don't use plain integer as NULL pointer
  ASoC: fsl_asrc: force cast the asrc_format type
  ASoC: fsl-asoc-card: force cast the asrc_format type
  ASoC: fsl_easrc: use snd_pcm_format_t type for sample_format
  ASoC: imx-card: use snd_pcm_format_t type for asrc_format

 sound/soc/fsl/fsl-asoc-card.c | 5 +++--
 sound/soc/fsl/fsl_asrc.c      | 6 ++++--
 sound/soc/fsl/fsl_easrc.c     | 9 ++++++---
 sound/soc/fsl/fsl_easrc.h     | 2 +-
 sound/soc/fsl/fsl_sai.c       | 2 +-
 sound/soc/fsl/imx-card.c      | 8 +++++---
 6 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.34.1

